package com.mandal.servlet;

import com.mandal.dao.ClientDAO;
import com.mandal.dao.VarganiDAO;
import com.mandal.model.Client;
import com.mandal.model.OfficeBearer;
import com.mandal.model.VarganiEntry;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

/**
 * The "actual working website" dashboard for one mandal, shown after the
 * super admin selects a client OR after the mandal's own admin logs in.
 * Everything here is scoped to selectedClientId from the session.
 */
@WebServlet("/client/dashboard")
public class ClientDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("selectedClientId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int clientId = (int) session.getAttribute("selectedClientId");
        try {
            ClientDAO clientDao = new ClientDAO();
            VarganiDAO varganiDao = new VarganiDAO();

            Client client = clientDao.getClientById(clientId);
            List<OfficeBearer> bearers = clientDao.getOfficeBearersByClient(clientId);
            List<VarganiEntry> entries = varganiDao.getEntriesByClient(clientId);
            BigDecimal todayTotal = varganiDao.getTodayTotal(clientId);
            BigDecimal grandTotal = varganiDao.getGrandTotal(clientId);

            req.setAttribute("client", client);
            req.setAttribute("bearers", bearers);
            req.setAttribute("entries", entries);
            req.setAttribute("todayTotal", todayTotal);
            req.setAttribute("grandTotal", grandTotal);

            req.getRequestDispatcher("/client/dashboard.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
