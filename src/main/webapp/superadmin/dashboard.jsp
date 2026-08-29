<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.mandal.model.Client" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Super Admin Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-mandal navbar-expand-lg mb-4">
  <div class="container">
    <span class="navbar-brand">🕉️ Super Admin</span>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-light">Logout</a>
  </div>
</nav>
<div class="container pb-5">

  <% if (request.getParameter("registered") != null) { %>
    <div class="alert alert-success">New mandal registered successfully! (Client #<%= request.getParameter("registered") %>)</div>
  <% } %>

  <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
    <h4 class="mb-0">All Registered Mandals</h4>
    <a href="${pageContext.request.contextPath}/superadmin/register-client" class="btn btn-mandal">+ Register New Mandal</a>
  </div>

  <div class="card card-mandal p-2 p-md-3">
    <div class="table-responsive">
      <table class="table table-hover align-middle mb-0">
        <thead>
          <tr>
            <th>Client #</th>
            <th>Mandal Name</th>
            <th>Leader</th>
            <th>Taluka / District</th>
            <th>Status</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
        <%
          List<Client> clients = (List<Client>) request.getAttribute("clients");
          if (clients != null) {
            for (Client c : clients) {
        %>
          <tr>
            <td><span class="badge bg-danger">#<%= c.getClientId() %></span></td>
            <td><%= c.getMandalName() %></td>
            <td><%= c.getLeaderName() %></td>
            <td><%= c.getTaluka() %>, <%= c.getDistrict() %></td>
            <td><span class="badge bg-success"><%= c.getStatus() %></span></td>
            <td>
              <a class="btn btn-sm btn-outline-danger"
                 href="${pageContext.request.contextPath}/superadmin/select-client?clientId=<%= c.getClientId() %>">
                 Open Dashboard →
              </a>
            </td>
          </tr>
        <% } } %>
        </tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>
