package com.mandal.servlet;

import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import com.itextpdf.io.image.ImageDataFactory;

import com.mandal.dao.ClientDAO;
import com.mandal.dao.PaymentDAO;
import com.mandal.model.Client;
import com.mandal.model.OfficeBearer;
import com.mandal.model.Payment;
import com.mandal.util.AppConstants;
import com.mandal.util.WhatsAppSender;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * In production this endpoint is called by your payment gateway's webhook
 * once the UPI/card payment actually clears. For this stage (before the
 * real gateway is wired in) it's exposed as a manual "I've Paid" action so
 * the whole flow - PDF receipt with the 3 signatory names + WhatsApp send -
 * can be tested end-to-end.
 */
@WebServlet("/confirm-payment")
public class ConfirmPaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int paymentId = Integer.parseInt(req.getParameter("paymentId"));
            PaymentDAO paymentDao = new PaymentDAO();
            ClientDAO clientDao = new ClientDAO();

            Payment payment = paymentDao.getById(paymentId);
            Client client = clientDao.getClientById(payment.getClientId());
            List<OfficeBearer> bearers = clientDao.getOfficeBearersByClient(client.getClientId());

            String receiptDirReal = getServletContext().getRealPath("/" + AppConstants.RECEIPT_DIR);
            new File(receiptDirReal).mkdirs();
            String fileName = "receipt_" + paymentId + ".pdf";
            String fullPath = receiptDirReal + File.separator + fileName;

            generateReceiptPdf(fullPath, client, bearers, payment);

            String relativePath = AppConstants.RECEIPT_DIR + "/" + fileName;
            paymentDao.markPaid(paymentId, relativePath);

            WhatsAppSender.sendReceipt(payment.getWhatsappNumber(), fullPath, client.getMandalName());

            resp.sendRedirect(req.getContextPath() + "/invoice/qr-display.jsp?paymentId=" + paymentId + "&paid=1");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void generateReceiptPdf(String path, Client client, List<OfficeBearer> bearers, Payment payment) throws IOException {
        try (PdfWriter writer = new PdfWriter(path);
             PdfDocument pdfDoc = new PdfDocument(writer);
             Document doc = new Document(pdfDoc)) {

            // Mandal symbol + name header
            String symbolReal = getServletContext().getRealPath("/" + client.getSymbolImage());
            if (symbolReal != null && new File(symbolReal).exists()) {
                Image logo = new Image(ImageDataFactory.create(symbolReal));
                logo.setWidth(60);
                logo.setHorizontalAlignment(com.itextpdf.layout.properties.HorizontalAlignment.CENTER);
                doc.add(logo);
            }

            doc.add(new Paragraph(client.getMandalName())
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontSize(20)
                    .setBold());

            doc.add(new Paragraph("Ganesh Vargani Receipt")
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontSize(13)
                    .setFontColor(ColorConstants.DARK_GRAY));

            doc.add(new Paragraph(" "));

            Table table = new Table(UnitValue.createPercentArray(new float[]{1, 1})).useAllAvailableWidth();
            addRow(table, "Receipt No", "#" + payment.getPaymentId());
            addRow(table, "Donor Name", payment.getDonorName());
            addRow(table, "Contact / WhatsApp", payment.getWhatsappNumber());
            addRow(table, "Amount Paid", "Rs. " + payment.getAmount().toPlainString());
            addRow(table, "Payment Time", new SimpleDateFormat("dd-MM-yyyy hh:mm:ss a").format(new java.util.Date()));
            doc.add(table);

            doc.add(new Paragraph(" "));
            doc.add(new Paragraph("Authorized By").setBold().setFontSize(12));

            Table bearerTable = new Table(UnitValue.createPercentArray(new float[]{1, 1})).useAllAvailableWidth();
            for (OfficeBearer ob : bearers) {
                if (ob.getRole().equals("ADHYAKSH") || ob.getRole().equals("UPADHYAKSH") || ob.getRole().equals("KHAJINDAR")) {
                    addRow(bearerTable, prettyRole(ob.getRole()), ob.getName());
                }
            }
            doc.add(bearerTable);

            doc.add(new Paragraph(" "));
            doc.add(new Paragraph("Thank you for your generous contribution to " + client.getMandalName() + "!")
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontSize(10)
                    .setFontColor(ColorConstants.GRAY));
        }
    }

    private void addRow(Table table, String label, String value) {
        table.addCell(new Paragraph(label).setBold());
        table.addCell(new Paragraph(value != null ? value : ""));
    }

    private String prettyRole(String role) {
        switch (role) {
            case "ADHYAKSH": return "Adhyaksh";
            case "UPADHYAKSH": return "Upadhyaksh";
            case "KHAJINDAR": return "Khajindar";
            default: return role;
        }
    }
}
