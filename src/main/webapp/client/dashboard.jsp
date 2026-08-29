<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.mandal.model.Client" %>
<%@ page import="com.mandal.model.OfficeBearer" %>
<%@ page import="com.mandal.model.VarganiEntry" %>
<%@ page import="java.util.List" %>
<%
  Client client = (Client) request.getAttribute("client");
  List<OfficeBearer> bearers = (List<OfficeBearer>) request.getAttribute("bearers");
  List<VarganiEntry> entries = (List<VarganiEntry>) request.getAttribute("entries");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= client.getMandalName() %> - Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-mandal mb-4">
  <div class="container">
    <span class="navbar-brand">🕉️ Client #<%= client.getClientId() %> — <%= client.getMandalName() %></span>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-light">Logout</a>
  </div>
</nav>

<div class="container pb-5">

  <!-- Mandal info card -->
  <div class="card card-mandal p-3 mb-4">
    <div class="row align-items-center g-3">
      <div class="col-auto">
        <img src="${pageContext.request.contextPath}/<%= client.getSymbolImage() %>" class="mandal-symbol" alt="symbol">
      </div>
      <div class="col">
        <h4 class="mb-1"><%= client.getMandalName() %></h4>
        <div class="text-muted small">
          Founded: <%= client.getFoundingDate() %> &middot;
          <%= client.getTaluka() %>, <%= client.getDistrict() %><br>
          Leader: <%= client.getLeaderName() %> &middot; A/C: <%= client.getAccountNumber() %>
        </div>
      </div>
      <div class="col-12 col-md-4">
        <img src="${pageContext.request.contextPath}/<%= client.getGanpatiPhoto() %>" class="ganpati-photo" alt="ganpati">
      </div>
    </div>
  </div>

  <!-- Stats -->
  <div class="row mb-4">
    <div class="col-6">
      <div class="stat-box today">
        <div class="small">Today's Collection</div>
        <h3 class="mb-0">₹ <%= request.getAttribute("todayTotal") %></h3>
      </div>
    </div>
    <div class="col-6">
      <div class="stat-box total">
        <div class="small">Total Collection</div>
        <h3 class="mb-0">₹ <%= request.getAttribute("grandTotal") %></h3>
      </div>
    </div>
  </div>

  <!-- Office bearers -->
  <div class="card card-mandal p-3 mb-4">
    <h6 class="text-danger">Office Bearers</h6>
    <div class="row">
      <% for (OfficeBearer ob : bearers) { %>
        <div class="col-6 col-md-4 mb-2">
          <div class="small text-muted"><%= ob.getRole() %></div>
          <div class="fw-semibold"><%= ob.getName() %></div>
        </div>
      <% } %>
    </div>
  </div>

  <!-- Add vargani entry -->
  <div class="card card-mandal p-3 mb-4">
    <h6 class="text-danger mb-3">Add Day-wise Vargani Entry</h6>
    <form action="${pageContext.request.contextPath}/client/add-vargani" method="post" class="row g-2">
      <div class="col-6 col-md-3">
        <input type="date" name="collectionDate" class="form-control" required>
      </div>
      <div class="col-6 col-md-3">
        <input type="text" name="donorName" class="form-control" placeholder="Donor Name" required>
      </div>
      <div class="col-6 col-md-2">
        <input type="number" step="0.01" name="amount" class="form-control" placeholder="Amount" required>
      </div>
      <div class="col-6 col-md-3">
        <input type="text" name="collectedBy" class="form-control" placeholder="Collected By">
      </div>
      <div class="col-12 col-md-1">
        <button type="submit" class="btn btn-mandal w-100">Add</button>
      </div>
    </form>
  </div>

  <!-- Day-wise collection table -->
  <div class="card card-mandal p-2 p-md-3">
    <h6 class="text-danger mb-2">Day-wise Collections</h6>
    <div class="table-responsive">
      <table class="table table-sm table-hover align-middle mb-0">
        <thead>
          <tr><th>Date</th><th>Donor</th><th>Amount</th><th>Collected By</th></tr>
        </thead>
        <tbody>
        <% for (VarganiEntry e : entries) { %>
          <tr>
            <td><%= e.getCollectionDate() %></td>
            <td><%= e.getDonorName() %></td>
            <td>₹ <%= e.getAmount() %></td>
            <td><%= e.getCollectedBy() %></td>
          </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>

</div>
</body>
</html>
