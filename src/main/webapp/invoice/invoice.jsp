<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.mandal.model.Client" %>
<%
  Client client = (Client) request.getAttribute("client");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= client.getMandalName() %> - Ganpati Vargani</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
  <div class="card card-mandal p-4 mx-auto" style="max-width:460px;">

    <div class="text-center mb-3">
      <img src="${pageContext.request.contextPath}/<%= client.getSymbolImage() %>" class="mandal-symbol mb-2" alt="symbol">
      <h4 class="mb-0" style="color:#af0404;"><%= client.getMandalName() %></h4>
      <div class="text-muted small">Ganpati Bappa Morya! 🙏 Contribute your vargani below</div>
    </div>

    <img src="${pageContext.request.contextPath}/<%= client.getGanpatiPhoto() %>" class="ganpati-photo mb-3" alt="ganpati">

    <form action="${pageContext.request.contextPath}/generate-qr" method="post">
      <input type="hidden" name="clientId" value="<%= client.getClientId() %>">

      <div class="mb-3">
        <label class="form-label">Your Name</label>
        <input type="text" name="donorName" class="form-control" placeholder="Enter your full name" required>
      </div>

      <div class="mb-3">
        <label class="form-label">WhatsApp / Contact Number</label>
        <input type="tel" name="whatsappNumber" class="form-control" placeholder="10-digit mobile number" pattern="[0-9]{10}" required>
      </div>

      <div class="mb-4">
        <label class="form-label">Select Amount</label>
        <select name="amount" class="form-select" required>
          <option value="" selected disabled>Choose amount</option>
          <option value="51">₹51</option>
          <option value="101">₹101</option>
          <option value="251">₹251</option>
          <option value="501">₹501</option>
          <option value="1001">₹1001</option>
          <option value="2100">₹2100</option>
        </select>
      </div>

      <button type="submit" class="btn btn-mandal w-100 py-2">Generate QR & Pay</button>
    </form>
  </div>
</div>
</body>
</html>
