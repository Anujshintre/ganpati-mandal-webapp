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
<html lang="mr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= client != null ? client.getMandalName() : "Mandal" %> - Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
<style>
  :root {
    --primary-gradient: linear-gradient(135deg, #ff4e00, #b30000);
    --gold-accent: #ffd700;
  }

  body {
    background-color: #0d0e12;
    background-image: 
      radial-gradient(circle at top left, rgba(255, 78, 0, 0.15), transparent 40%),
      radial-gradient(circle at bottom right, rgba(179, 0, 0, 0.2), transparent 50%);
    color: #e0e0e0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    min-height: 100vh;
    overflow-x: hidden;
  }

  /* Glass Navbar */
  .navbar-mandal {
    background: rgba(20, 20, 25, 0.85) !important;
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-bottom: 1px solid rgba(255, 215, 0, 0.2);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.4);
  }

  .navbar-brand {
    color: var(--gold-accent) !important;
    font-weight: 700;
    font-size: clamp(1rem, 4vw, 1.25rem);
    white-space: normal;
    word-break: break-word;
  }

  /* Glassmorphism Cards */
  .card-mandal {
    background: rgba(22, 24, 30, 0.75) !important;
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
    border: 1px solid rgba(255, 255, 255, 0.1) !important;
    border-radius: 16px !important;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
    overflow: hidden;
  }

  .text-gold {
    color: var(--gold-accent) !important;
  }

  /* Responsive Mandal Symbol */
  .mandal-symbol {
    width: 80px;
    height: 80px;
    object-fit: cover;
    border-radius: 50%;
    border: 3px solid var(--gold-accent);
    box-shadow: 0 0 15px rgba(255, 215, 0, 0.3);
  }

  @media (min-width: 768px) {
    .mandal-symbol {
      width: 95px;
      height: 95px;
    }
  }

  /* Responsive Ganpati Photo */
  .ganpati-photo-container {
    width: 100%;
    max-height: 220px;
    overflow: hidden;
    border-radius: 12px;
    border: 1px solid rgba(255, 255, 255, 0.15);
  }

  .ganpati-photo {
    width: 100%;
    height: 100%;
    max-height: 220px;
    object-fit: cover;
  }

  /* Responsive Heading Fix */
  .mandal-title {
    word-wrap: break-word;
    word-break: break-word;
    overflow-wrap: break-word;
    hyphens: auto;
    line-height: 1.25;
  }

  /* Stat Cards */
  .stat-card {
    background: rgba(30, 32, 40, 0.6);
    border-radius: 14px;
    padding: 16px;
    border-left: 4px solid var(--gold-accent);
    box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    height: 100%;
  }

  .stat-card.today {
    border-left-color: #ff4e00;
  }

  .stat-card.total {
    border-left-color: #00e676;
  }

  /* Form Elements */
  .form-control {
    background: rgba(255, 255, 255, 0.08) !important;
    border: 1px solid rgba(255, 255, 255, 0.2) !important;
    color: #ffffff !important;
    border-radius: 8px !important;
    padding: 10px 12px;
  }

  .form-control:focus {
    border-color: var(--gold-accent) !important;
    box-shadow: 0 0 8px rgba(255, 215, 0, 0.3) !important;
  }

  .form-control::placeholder {
    color: #aaaaaa;
  }

  /* Gradient Button */
  .btn-mandal {
    background: var(--primary-gradient);
    color: white !important;
    font-weight: 600;
    border: none;
    border-radius: 8px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(255, 78, 0, 0.3);
  }

  .btn-mandal:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(255, 78, 0, 0.5);
  }

  /* Table Customization */
  .table-custom {
    color: #e0e0e0;
    width: 100%;
  }

  .table-custom th {
    background: rgba(255, 255, 255, 0.05);
    color: var(--gold-accent);
    border-bottom: 2px solid rgba(255, 215, 0, 0.2);
    font-weight: 600;
    white-space: nowrap;
  }

  .table-custom td {
    border-bottom: 1px solid rgba(255, 255, 255, 0.08);
    background: transparent !important;
    color: #d1d1d1;
    white-space: nowrap;
  }

  .table-hover tbody tr:hover td {
    background: rgba(255, 255, 255, 0.05) !important;
    color: #fff;
  }

  /* Office Bearer Cards */
  .bearer-chip {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 10px;
    padding: 10px 12px;
    height: 100%;
  }
</style>
</head>
<body>

<!-- Header Navbar -->
<nav class="navbar navbar-mandal sticky-top mb-3 mb-md-4">
  <div class="container px-3">
    <span class="navbar-brand d-flex align-items-center gap-2 me-auto">
      <i class="fas fa-om text-warning"></i> 
      <span>Client #<%= client != null ? client.getClientId() : "" %> — <%= client != null ? client.getMandalName() : "" %></span>
    </span>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-outline-light rounded-pill px-3 ms-2">
      <i class="fas fa-sign-out-alt"></i> <span class="d-none d-sm-inline ms-1">Logout</span>
    </a>
  </div>
</nav>

<div class="container px-3 pb-5">

  <!-- Mandal Info Card -->
  <div class="card card-mandal p-3 p-md-4 mb-3 mb-md-4" data-aos="fade-up">
    <div class="row align-items-center g-3">
      
      <!-- Symbol Image -->
      <div class="col-12 col-sm-auto text-center">
        <img src="${pageContext.request.contextPath}/<%= client != null ? client.getSymbolImage() : "" %>" class="mandal-symbol" alt="symbol">
      </div>
      
      <!-- Mandal Info & Overflow-Proof Title -->
      <div class="col-12 col-sm text-center text-sm-start min-w-0">
        <h3 class="mandal-title text-gold fw-bold mb-2 fs-4 fs-md-3">
          <%= client != null ? client.getMandalName() : "" %>
        </h3>
        <div class="text-light opacity-75 small">
          <div class="mb-1">
            <i class="fas fa-calendar-alt text-gold me-1"></i> Founded: <%= client != null ? client.getFoundingDate() : "" %> 
            &middot; <%= client != null ? client.getTaluka() : "" %>, <%= client != null ? client.getDistrict() : "" %>
          </div>
          <div>
            <i class="fas fa-user-shield text-gold me-1"></i> Leader: <%= client != null ? client.getLeaderName() : "" %> 
            <span class="d-block d-md-inline ms-0 ms-md-2 mt-1 mt-md-0">
              <i class="fas fa-university text-gold me-1"></i> A/C: <%= client != null ? client.getAccountNumber() : "" %>
            </span>
          </div>
        </div>
      </div>
      
      <!-- Ganpati Photo -->
      <div class="col-12 col-md-4 text-center">
        <div class="ganpati-photo-container">
          <img src="${pageContext.request.contextPath}/<%= client != null ? client.getGanpatiPhoto() : "" %>" class="ganpati-photo" alt="ganpati">
        </div>
      </div>

    </div>
  </div>

  <!-- Collection Stats Grid -->
  <div class="row g-3 mb-3 mb-md-4" data-aos="fade-up" data-aos-delay="100">
    <div class="col-6 col-md-6">
      <div class="stat-card today d-flex align-items-center justify-content-between">
        <div>
          <div class="small text-light opacity-75 fw-medium">Today's Collection</div>
          <h3 class="mb-0 fw-bold text-white mt-1 fs-4 fs-md-2">₹ <%= request.getAttribute("todayTotal") != null ? request.getAttribute("todayTotal") : "0" %></h3>
        </div>
        <div class="fs-2 fs-md-1 text-warning opacity-50 d-none d-sm-block"><i class="fas fa-calendar-day"></i></div>
      </div>
    </div>
    
    <div class="col-6 col-md-6">
      <div class="stat-card total d-flex align-items-center justify-content-between">
        <div>
          <div class="small text-light opacity-75 fw-medium">Total Collection</div>
          <h3 class="mb-0 fw-bold text-white mt-1 fs-4 fs-md-2">₹ <%= request.getAttribute("grandTotal") != null ? request.getAttribute("grandTotal") : "0" %></h3>
        </div>
        <div class="fs-2 fs-md-1 text-success opacity-50 d-none d-sm-block"><i class="fas fa-coins"></i></div>
      </div>
    </div>
  </div>

  <!-- Office Bearers Grid -->
  <div class="card card-mandal p-3 p-md-4 mb-3 mb-md-4" data-aos="fade-up" data-aos-delay="150">
    <h6 class="text-gold fw-bold mb-3 d-flex align-items-center gap-2">
      <i class="fas fa-users"></i> Office Bearers
    </h6>
    <div class="row g-2">
      <% if (bearers != null && !bearers.isEmpty()) { %>
        <% for (OfficeBearer ob : bearers) { %>
          <div class="col-6 col-sm-4 col-md-3">
            <div class="bearer-chip">
              <div class="small text-warning opacity-75 fw-semibold text-truncate"><%= ob.getRole() %></div>
              <div class="fw-semibold text-white text-truncate"><%= ob.getName() %></div>
            </div>
          </div>
        <% } %>
      <% } else { %>
        <div class="col-12 text-muted small">No office bearers found.</div>
      <% } %>
    </div>
  </div>

  <!-- Add Day-wise Vargani Entry Form -->
  <div class="card card-mandal p-3 p-md-4 mb-3 mb-md-4" data-aos="fade-up" data-aos-delay="200">
    <h6 class="text-gold fw-bold mb-3 d-flex align-items-center gap-2">
      <i class="fas fa-plus-circle"></i> Add Day-wise Vargani Entry
    </h6>
    <form action="${pageContext.request.contextPath}/client/add-vargani" method="post" class="row g-2">
      <div class="col-12 col-sm-6 col-lg-3">
        <input type="date" name="collectionDate" class="form-control" required>
      </div>
      <div class="col-12 col-sm-6 col-lg-3">
        <input type="text" name="donorName" class="form-control" placeholder="Donor Name" required>
      </div>
      <div class="col-12 col-sm-6 col-lg-2">
        <input type="number" step="0.01" name="amount" class="form-control" placeholder="Amount (₹)" required>
      </div>
      <div class="col-12 col-sm-6 col-lg-3">
        <input type="text" name="collectedBy" class="form-control" placeholder="Collected By">
      </div>
      <div class="col-12 col-lg-1">
        <button type="submit" class="btn btn-mandal w-100 h-100 py-2">Add</button>
      </div>
    </form>
  </div>

  <!-- Day-wise Collections Table -->
  <div class="card card-mandal p-3 p-md-4" data-aos="fade-up" data-aos-delay="250">
    <h6 class="text-gold fw-bold mb-3 d-flex align-items-center gap-2">
      <i class="fas fa-list-alt"></i> Day-wise Collections
    </h6>
    <div class="table-responsive">
      <table class="table table-custom table-hover align-middle mb-0">
        <thead>
          <tr>
            <th>Date</th>
            <th>Donor</th>
            <th>Amount</th>
            <th>Collected By</th>
          </tr>
        </thead>
        <tbody>
        <% if (entries != null && !entries.isEmpty()) { %>
          <% for (VarganiEntry e : entries) { %>
            <tr>
              <td><i class="far fa-calendar text-gold me-2"></i><%= e.getCollectionDate() %></td>
              <td class="fw-semibold"><%= e.getDonorName() %></td>
              <td class="text-success fw-bold">₹ <%= e.getAmount() %></td>
              <td><%= e.getCollectedBy() %></td>
            </tr>
          <% } %>
        <% } else { %>
          <tr>
            <td colspan="4" class="text-center py-3 text-muted">No collections recorded yet.</td>
          </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
  AOS.init({
    duration: 800,
    once: true
  });
</script>
</body>
</html>