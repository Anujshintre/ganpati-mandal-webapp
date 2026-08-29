<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String paymentId = request.getParameter("paymentId");
  boolean paid = "1".equals(request.getParameter("paid"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Scan & Pay</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
  <div class="card card-mandal p-4 mx-auto text-center" style="max-width:420px;">

  <% if (!paid) { %>
    <h5 class="mb-3">Scan this QR to pay</h5>
    <img src="${pageContext.request.contextPath}/generate-qr?paymentId=<%= paymentId %>"
         alt="Payment QR" class="img-fluid mb-3" style="max-width:260px; margin:0 auto;">
    <p class="text-muted small">Open any UPI app (GPay / PhonePe / Paytm) and scan this code.</p>

    <hr>
    <p class="small text-muted">
      This demo build doesn't have a live payment gateway connected yet, so once you've
      actually paid via the QR, tap below to confirm and generate your receipt.
      (In production this step happens automatically via the gateway's webhook.)
    </p>
    <a href="${pageContext.request.contextPath}/confirm-payment?paymentId=<%= paymentId %>"
       class="btn btn-mandal w-100">✅ I've Paid — Confirm</a>
  <% } else { %>
    <div class="mb-3" style="font-size:3rem;">🎉</div>
    <h5 class="text-success mb-2">Payment Confirmed!</h5>
    <p class="text-muted">Your receipt has been generated and (once WhatsApp API is connected) will be sent to your WhatsApp number.</p>
    <a href="${pageContext.request.contextPath}/receipts/receipt_<%= paymentId %>.pdf"
       target="_blank" class="btn btn-mandal w-100">Download Receipt PDF</a>
  <% } %>

  </div>
</div>
</body>
</html>
