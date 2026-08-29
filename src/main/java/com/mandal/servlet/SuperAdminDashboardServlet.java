package com.mandal.servlet;

import com.mandal.dao.ClientDAO;
import com.mandal.model.Client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/** Super admin landing page - lists every registered mandal (client 1, 2, 3 ...). */
@WebServlet("/superadmin/dashboard")
public class SuperAdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"SUPERADMIN".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        try {
            List<Client> clients = new ClientDAO().getAllClients();
            req.setAttribute("clients", clients);
            req.getRequestDispatcher("/superadmin/dashboard.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
