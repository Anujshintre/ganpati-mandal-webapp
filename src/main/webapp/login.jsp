<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="mr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>सुपर ॲडमिन लॉगिन - गणपती मंडळ व्यवस्थापक</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<style>
  /* Background Video Container */
  .bg-video-container {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    overflow: hidden;
    z-index: -3;
    pointer-events: none;
  }

  /* Responsive Video Iframe Positioning - Zoomed 1.35x on mobile to hide YT title header */
  .bg-video-container iframe {
    width: 140vw;
    height: 80vw;
    min-height: 140vh;
    min-width: 245vh;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    filter: brightness(0.9) contrast(1.1);
  }

  /* Desktop and Laptop view - Normal Proportions */
  @media (min-width: 992px) {
    .bg-video-container iframe {
      width: 100vw;
      height: 56.25vw;
      min-height: 100vh;
      min-width: 177.77vh;
    }
  }

  /* Vibrant Color Gradient Overlay */
  .bg-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background: radial-gradient(circle at top left, rgba(255, 122, 0, 0.35), transparent 60%),
                radial-gradient(circle at bottom right, rgba(140, 0, 0, 0.55), transparent 70%),
                linear-gradient(to bottom, rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.6));
    z-index: -2;
  }

  /* Ultra-Modern Glassmorphism Login Card */
  .card-glass {
    background: rgba(18, 18, 20, 0.45) !important;
    backdrop-filter: blur(16px) saturate(190%);
    -webkit-backdrop-filter: blur(16px) saturate(190%);
    border: 1px solid rgba(255, 215, 0, 0.25) !important;
    border-radius: 20px !important;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5), 0 0 20px rgba(255, 140, 0, 0.15);
    color: #ffffff;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
  }

  .card-glass:hover {
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.6), 0 0 25px rgba(255, 140, 0, 0.25);
  }

  /* Header Glow Text */
  .title-glow {
    background: linear-gradient(135deg, #ff4e00, #ff9900, #ffe600);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    font-weight: 800;
    letter-spacing: 0.5px;
    filter: drop-shadow(0 2px 4px rgba(0,0,0,0.5));
  }

  .card-glass label {
    color: #f1f1f1;
    font-weight: 500;
    font-size: 0.95rem;
  }

  /* Custom Input Styling with Icons */
  .input-group-text {
    background: rgba(255, 255, 255, 0.15);
    border: 1px solid rgba(255, 255, 255, 0.3);
    border-right: none;
    color: #ffd700;
    border-top-left-radius: 10px;
    border-bottom-left-radius: 10px;
  }

  .card-glass input.form-control {
    background: rgba(255, 255, 255, 0.15);
    border: 1px solid rgba(255, 255, 255, 0.3);
    border-left: none;
    color: #ffffff;
    border-top-right-radius: 10px;
    border-bottom-right-radius: 10px;
    padding: 10px 14px;
    transition: all 0.3s ease;
  }

  .card-glass input.form-control:focus {
    background: rgba(255, 255, 255, 0.25);
    color: #ffffff;
    border-color: #ffd700;
    box-shadow: none;
  }

  .card-glass input.form-control::placeholder {
    color: #cccccc;
  }

  /* Gradient Action Button */
  .btn-gradient {
    background: linear-gradient(135deg, #ff4e00, #b30000);
    color: white;
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 10px;
    font-weight: 600;
    padding: 12px;
    letter-spacing: 0.5px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(255, 78, 0, 0.4);
  }

  .btn-gradient:hover {
    background: linear-gradient(135deg, #ff661a, #cc0000);
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(255, 78, 0, 0.6);
  }

  body.login-page {
    min-height: 100vh;
    display: flex;
    align-items: center;
    position: relative;
    background: #0a0a0c;
    margin: 0;
    padding: 20px 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
</style>
</head>
<body class="login-page">

<!-- Background Video Container -->
<div class="bg-video-container">
  <div id="yt-player"></div>
</div>
<!-- Saffron & Dark Gradient Overlay -->
<div class="bg-overlay"></div>

<div class="container">
  <div class="row w-100 m-0 align-items-center">
    <!-- Right alignment for Laptop/Tablet, centered for Mobile -->
    <div class="col-11 col-sm-9 col-md-6 col-lg-4 ms-md-auto mx-auto mx-md-0">
      <div class="card card-glass p-4" data-aos="fade-left" data-aos-duration="800">
        <h3 class="text-center mb-1 title-glow">🕉️ मंडळ व्यवस्थापक</h3>
        <p class="text-center text-light mb-4" style="opacity: 0.85; font-size: 0.9rem;">सुपर ॲडमिन लॉगिन</p>
        
        <% if (request.getAttribute("error") != null) { %>
          <div class="alert alert-danger py-2 mb-3" style="background: rgba(220, 53, 69, 0.8); color: white; border: none; border-radius: 8px;"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
          <div class="mb-3">
            <label class="form-label">Username</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fas fa-user"></i></span>
              <input type="text" name="username" class="form-control" required placeholder="Enter Username">
            </div>
          </div>
          
          <div class="mb-4">
            <label class="form-label">Password</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fas fa-lock"></i></span>
              <input type="password" name="password" class="form-control" required placeholder="Enter Password">
            </div>
          </div>
          
          <button type="submit" class="btn btn-gradient w-100">लॉगिन करा</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
  AOS.init();

  // Load YouTube IFrame Player API
  var tag = document.createElement('script');
  tag.src = "https://www.youtube.com/iframe_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

  var player;
  const startTime = 90;  // 1:30
  const endTime = 110;   // 1:50

  function onYouTubeIframeAPIReady() {
    player = new YT.Player('yt-player', {
      videoId: '_jZwOHKUX3g',
      playerVars: {
        'autoplay': 1,
        'controls': 0,
        'showinfo': 0,
        'rel': 0,
        'mute': 1,
        'start': startTime,
        'end': endTime,
        'modestbranding': 1,
        'playsinline': 1
      },
      events: {
        'onReady': onPlayerReady,
        'onStateChange': onPlayerStateChange
      }
    });
  }

  function onPlayerReady(event) {
    event.target.mute();
    event.target.seekTo(startTime);
    event.target.playVideo();

    setInterval(function () {
      if (player && player.getCurrentTime) {
        var currentTime = player.getCurrentTime();
        if (currentTime >= endTime || currentTime < startTime) {
          player.seekTo(startTime);
        }
      }
    }, 500);
  }

  function onPlayerStateChange(event) {
    if (event.data === YT.PlayerState.ENDED) {
      player.seekTo(startTime);
      player.playVideo();
    }
  }
</script>
</body>
</html>