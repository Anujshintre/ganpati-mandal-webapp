package com.mandal.servlet;

import com.mandal.dao.ClientDAO;
import com.mandal.model.Client;
import com.mandal.util.AppConstants;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Single login form serves two roles:
 *  1) Super Admin - hardcoded credentials (AppConstants) -> superadmin dashboard.
 *  2) Mandal Admin - checked against clients.admin_username / admin_password
 *     (set per-mandal at registration time) -> straight into that mandal's
 *     own client dashboard, skipping the super-admin client picker.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // 1) Super Admin check (unchanged)
        if (AppConstants.SUPERADMIN_USERNAME.equals(username) && AppConstants.SUPERADMIN_PASSWORD.equals(password)) {
            HttpSession session = req.getSession(true);
            session.setAttribute("role", "SUPERADMIN");
            session.setAttribute("username", username);
            resp.sendRedirect(req.getContextPath() + "/superadmin/dashboard");
            return;
        }

        // 2) Mandal Admin check - looks up clients table by admin_username/admin_password
        try {
            Client client = new ClientDAO().getClientByAdminCredentials(username, password);
            if (client != null) {
                HttpSession session = req.getSession(true);
                session.setAttribute("role", "CLIENT_ADMIN");
                session.setAttribute("username", username);
                session.setAttribute("selectedClientId", client.getClientId());
                resp.sendRedirect(req.getContextPath() + "/client/dashboard");
                return;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        // 3) Neither matched
        req.setAttribute("error", "Invalid username or password");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}