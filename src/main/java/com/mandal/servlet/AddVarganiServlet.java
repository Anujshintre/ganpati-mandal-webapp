package com.mandal.servlet;

import com.mandal.dao.VarganiDAO;
import com.mandal.model.VarganiEntry;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.SQLException;

/** Adds one day-wise vargani (donation) entry for the currently selected client. */
@WebServlet("/client/add-vargani")
public class AddVarganiServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("selectedClientId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int clientId = (int) session.getAttribute("selectedClientId");
        try {
            VarganiEntry e = new VarganiEntry();
            e.setClientId(clientId);
            e.setCollectionDate(Date.valueOf(req.getParameter("collectionDate")));
            e.setDonorName(req.getParameter("donorName"));
            e.setAmount(new BigDecimal(req.getParameter("amount")));
            e.setCollectedBy(req.getParameter("collectedBy"));
            new VarganiDAO().addEntry(e);
            resp.sendRedirect(req.getContextPath() + "/client/dashboard");
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
