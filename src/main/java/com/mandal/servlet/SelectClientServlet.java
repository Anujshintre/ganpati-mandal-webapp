package com.mandal.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/** Super admin picks which mandal's data to view - config-style client switch (1, 2, 3 ...). */
@WebServlet("/superadmin/select-client")
public class SelectClientServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"SUPERADMIN".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int clientId = Integer.parseInt(req.getParameter("clientId"));
        session.setAttribute("selectedClientId", clientId);
        resp.sendRedirect(req.getContextPath() + "/client/dashboard");
    }
}
