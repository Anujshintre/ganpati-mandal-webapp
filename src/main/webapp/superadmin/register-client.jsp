<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register New Mandal</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-mandal mb-4">
  <div class="container">
    <span class="navbar-brand">🕉️ Register New Mandal</span>
    <a href="${pageContext.request.contextPath}/superadmin/dashboard" class="btn btn-sm btn-light">← Back</a>
  </div>
</nav>
<div class="container pb-5">
  <div class="card card-mandal p-3 p-md-4">
    <form action="${pageContext.request.contextPath}/superadmin/register-client" method="post" enctype="multipart/form-data">

      <h5 class="mb-3 text-danger">Mandal Details</h5>
      <div class="row g-3">
        <div class="col-12 col-md-6">
          <label class="form-label">Mandal Name</label>
          <input type="text" name="mandalName" class="form-control" required>
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Founding Date</label>
          <input type="date" name="foundingDate" class="form-control" required>
        </div>
        <div class="col-6">
          <label class="form-label">Taluka</label>
          <input type="text" name="taluka" class="form-control" required>
        </div>
        <div class="col-6">
          <label class="form-label">District</label>
          <input type="text" name="district" class="form-control" required>
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Leader Name</label>
          <input type="text" name="leaderName" class="form-control" required>
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Mandal Bank / UPI Account Number</label>
          <input type="text" name="accountNumber" class="form-control" required>
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Mandal Symbol / Logo</label>
          <input type="file" name="symbolImage" accept="image/*" class="form-control">
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Ganpati Photo</label>
          <input type="file" name="ganpatiPhoto" accept="image/*" class="form-control">
        </div>
      </div>

      <hr class="my-4">
      <h5 class="mb-3 text-danger">Mandal Admin Login (given to the client)</h5>
      <div class="row g-3">
        <div class="col-12 col-md-6">
          <label class="form-label">Admin Username</label>
          <input type="text" name="adminUsername" class="form-control" required>
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Admin Password</label>
          <input type="text" name="adminPassword" class="form-control" required>
        </div>
      </div>

      <hr class="my-4">
      <h5 class="mb-3 text-danger">Office Bearers (used on the receipt / PDF)</h5>
      <div class="row g-3">
        <div class="col-12 col-md-6">
          <label class="form-label">Adhyaksh Name</label>
          <input type="text" name="adhyaksh" class="form-control" required>
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Adhyaksh Contact</label>
          <input type="text" name="adhyakshContact" class="form-control">
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Upadhyaksh Name</label>
          <input type="text" name="upadhyaksh" class="form-control" required>
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Upadhyaksh Contact</label>
          <input type="text" name="upadhyakshContact" class="form-control">
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Khajindar Name</label>
          <input type="text" name="khajindar" class="form-control" required>
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Khajindar Contact</label>
          <input type="text" name="khajindarContact" class="form-control">
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Member 1 Name</label>
          <input type="text" name="member1" class="form-control">
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Member 1 Contact</label>
          <input type="text" name="member1Contact" class="form-control">
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Member 2 Name</label>
          <input type="text" name="member2" class="form-control">
        </div>
        <div class="col-12 col-md-6">
          <label class="form-label">Member 2 Contact</label>
          <input type="text" name="member2Contact" class="form-control">
        </div>
      </div>

      <button type="submit" class="btn btn-mandal w-100 mt-4">Register Mandal</button>
    </form>
  </div>
</div>
</body>
</html>
