package com.mandal.servlet;

import com.mandal.dao.ClientDAO;
import com.mandal.model.Client;
import com.mandal.model.OfficeBearer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Public-facing donation/invoice page. For now always shows the FIRST
 * registered mandal's data (client_id = 1) as requested; once client-wise
 * routing is wired in a later step this becomes /invoice/{clientId}.
 */
@WebServlet("/invoice")
public class InvoiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            ClientDAO dao = new ClientDAO();
            String clientIdParam = req.getParameter("clientId");
            Client client = (clientIdParam != null)
                    ? dao.getClientById(Integer.parseInt(clientIdParam))
                    : dao.getFirstClient();

            if (client == null) {
                resp.getWriter().println("No mandal registered yet.");
                return;
            }
            List<OfficeBearer> bearers = dao.getOfficeBearersByClient(client.getClientId());

            req.setAttribute("client", client);
            req.setAttribute("bearers", bearers);
            req.getRequestDispatcher("/invoice/invoice.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
