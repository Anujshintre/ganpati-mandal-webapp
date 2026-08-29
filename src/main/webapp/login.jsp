<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Super Admin Login - Ganpati Mandal Manager</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
</head>
<body class="login-page">
<div class="container">
  <div class="row justify-content-center">
    <div class="col-11 col-sm-8 col-md-5 col-lg-4">
      <div class="card card-mandal p-4" data-aos="fade-up" data-aos-duration="700">
        <h3 class="text-center mb-3" style="color:#af0404;">🕉️ Mandal Manager</h3>
        <p class="text-center text-muted mb-4">Super Admin Login</p>
        <% if (request.getAttribute("error") != null) { %>
          <div class="alert alert-danger py-2"><%= request.getAttribute("error") %></div>
        <% } %>
        <form action="${pageContext.request.contextPath}/login" method="post">
          <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="username" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
          </div>
          <button type="submit" class="btn btn-mandal w-100">Login</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
  AOS.init();
</script>
</body>
</html>