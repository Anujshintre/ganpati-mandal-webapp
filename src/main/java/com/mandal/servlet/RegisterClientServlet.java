package com.mandal.servlet;

import com.mandal.dao.ClientDAO;
import com.mandal.model.Client;
import com.mandal.model.OfficeBearer;
import com.mandal.util.AppConstants;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.SQLException;
import java.util.UUID;

/**
 * Super admin uses this to onboard a new mandal (a new client).
 * Captures mandal profile + the 5 UPI/receipt "signatory" names:
 * Adhyaksh, Upadhyaksh, Khajindar + 2 other members.
 */
@WebServlet("/superadmin/register-client")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB per file
public class RegisterClientServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"SUPERADMIN".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/superadmin/register-client.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"SUPERADMIN".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        try {
            Client c = new Client();
            c.setMandalName(req.getParameter("mandalName"));
            c.setFoundingDate(Date.valueOf(req.getParameter("foundingDate")));
            c.setTaluka(req.getParameter("taluka"));
            c.setDistrict(req.getParameter("district"));
            c.setLeaderName(req.getParameter("leaderName"));
            c.setAccountNumber(req.getParameter("accountNumber"));
            c.setAdminUsername(req.getParameter("adminUsername"));
            c.setAdminPassword(req.getParameter("adminPassword"));

            String uploadRealPath = getServletContext().getRealPath("/" + AppConstants.UPLOAD_DIR);
            new File(uploadRealPath).mkdirs();

            String symbolPath = saveUploadedFile(req.getPart("symbolImage"), uploadRealPath);
            String ganpatiPath = saveUploadedFile(req.getPart("ganpatiPhoto"), uploadRealPath);
            c.setSymbolImage(symbolPath != null ? AppConstants.UPLOAD_DIR + "/" + symbolPath : "uploads/default-symbol.png");
            c.setGanpatiPhoto(ganpatiPath != null ? AppConstants.UPLOAD_DIR + "/" + ganpatiPath : "uploads/default-ganpati.jpg");

            ClientDAO dao = new ClientDAO();
            int newClientId = dao.insertClient(c);

            // 5 UPI/receipt names
            saveBearer(dao, newClientId, "ADHYAKSH", req.getParameter("adhyaksh"), req.getParameter("adhyakshContact"));
            saveBearer(dao, newClientId, "UPADHYAKSH", req.getParameter("upadhyaksh"), req.getParameter("upadhyakshContact"));
            saveBearer(dao, newClientId, "KHAJINDAR", req.getParameter("khajindar"), req.getParameter("khajindarContact"));
            saveBearer(dao, newClientId, "MEMBER1", req.getParameter("member1"), req.getParameter("member1Contact"));
            saveBearer(dao, newClientId, "MEMBER2", req.getParameter("member2"), req.getParameter("member2Contact"));

            resp.sendRedirect(req.getContextPath() + "/superadmin/dashboard?registered=" + newClientId);
        } catch (SQLException e) {
            throw new ServletException(e);
        } catch (jakarta.servlet.ServletException e) {
            throw e;
        }
    }

    private void saveBearer(ClientDAO dao, int clientId, String role, String name, String contact) throws SQLException {
        OfficeBearer ob = new OfficeBearer();
        ob.setClientId(clientId);
        ob.setRole(role);
        ob.setName(name);
        ob.setContactNo(contact);
        dao.insertOfficeBearer(ob);
    }

    private String saveUploadedFile(jakarta.servlet.http.Part part, String uploadRealPath) throws IOException {
        if (part == null || part.getSize() == 0) return null;
        String submittedName = part.getSubmittedFileName();
        if (submittedName == null || submittedName.isBlank()) return null;
        String ext = submittedName.contains(".") ? submittedName.substring(submittedName.lastIndexOf('.')) : "";
        String newName = UUID.randomUUID() + ext;
        Path target = Paths.get(uploadRealPath, newName);
        try (InputStream in = part.getInputStream()) {
            Files.copy(in, target);
        }
        return newName;
    }
}
