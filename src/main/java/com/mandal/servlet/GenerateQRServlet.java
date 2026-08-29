package com.mandal.servlet;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import com.mandal.dao.ClientDAO;
import com.mandal.dao.PaymentDAO;
import com.mandal.model.Client;
import com.mandal.model.Payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;

/**
 * Two responsibilities based on the query params:
 *  1) action=create  -> creates a PENDING payment row for the donor + amount
 *                        entered on the invoice page, then redirects to the
 *                        QR display page with that paymentId.
 *  2) action=image    -> streams the actual QR PNG for a given paymentId
 *                        (a UPI-intent QR built from the mandal's account
 *                        details - swap this for your real payment
 *                        aggregator's QR/order API when you add one).
 */
@WebServlet("/generate-qr")
public class GenerateQRServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int clientId = Integer.parseInt(req.getParameter("clientId"));
            String donorName = req.getParameter("donorName");
            String whatsappNumber = req.getParameter("whatsappNumber");
            BigDecimal amount = new BigDecimal(req.getParameter("amount"));

            Payment p = new Payment();
            p.setClientId(clientId);
            p.setDonorName(donorName);
            p.setWhatsappNumber(whatsappNumber);
            p.setAmount(amount);
            int paymentId = new PaymentDAO().createPending(p);

            resp.sendRedirect(req.getContextPath() + "/invoice/qr-display.jsp?paymentId=" + paymentId);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int paymentId = Integer.parseInt(req.getParameter("paymentId"));
            Payment payment = new PaymentDAO().getById(paymentId);
            if (payment == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            Client client = new ClientDAO().getClientById(payment.getClientId());

            // Build a UPI payment-intent string using the mandal's account number.
            // Replace with your real UPI VPA / payment gateway order link when integrated.
            String upiString = "upi://pay?pa=" + client.getAccountNumber()
                    + "@upi&pn=" + URLEncoder.encode(client.getMandalName(), StandardCharsets.UTF_8)
                    + "&am=" + payment.getAmount().toPlainString()
                    + "&cu=INR&tn=" + URLEncoder.encode("Ganpati Vargani #" + paymentId, StandardCharsets.UTF_8);

            QRCodeWriter writer = new QRCodeWriter();
            BitMatrix matrix = writer.encode(upiString, BarcodeFormat.QR_CODE, 300, 300);

            resp.setContentType("image/png");
            try (OutputStream os = resp.getOutputStream()) {
                MatrixToImageWriter.writeToStream(matrix, "PNG", os);
            }
        } catch (SQLException | WriterException e) {
            throw new ServletException(e);
        }
    }
}
