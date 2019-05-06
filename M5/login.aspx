<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="M5.login" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Purple Admin</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="web/template/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="web/template/vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- plugin css for this page -->
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="web/template/css/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="web/template/images/favicon.png" />
</head>

<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-center auth">
        <div class="row w-100">
          <div class="col-lg-4 mx-auto">
            <div class="auth-form-light text-left p-5">
              <div class="brand-logo">
                <img src="web/template/images/logo.svg">
              </div>
              <h4>Hello! let's get started</h4>
              <h6 class="font-weight-light">Sign in to continue.</h6>
              <form class="pt-3" id="login-form">
                <div class="form-group">
                  <input type="text" class="form-control form-control-lg" id="exampleInputEmail1" minlength="6" placeholder="Username" name ="username" required>
                </div>
                <div class="form-group">
                  <input type="password" class="form-control form-control-lg" id="exampleInputPassword1" minlength="6" placeholder="Password" name ="password" required>
                </div>
                <div class="mt-3">
                  <a id="loginButton" class="btn btn-block btn-gradient-primary btn-lg font-weight-medium auth-form-btn" href="#">SIGN IN</a>
                </div>
                <div class="my-2 d-flex justify-content-between align-items-center">
                  <div class="form-check">
                    <label class="form-check-label text-muted">
                      <input type="checkbox" class="form-check-input">
                      Keep me signed in
                    </label>
                  </div>
                  <a href="#" class="auth-link text-black">Forgot password?</a>
                </div>
                <div class="mb-2">
                  <button type="button" class="btn btn-block btn-facebook auth-form-btn">
                    <i class="mdi mdi-facebook mr-2"></i>Connect using facebook
                  </button>
                </div>
                <div class="text-center mt-4 font-weight-light">
                  Don't have an account? <a href="register.html" class="text-primary">Create</a>
                </div>

                <div id="invalid-user" class="text-center mt-4 font-weight-light text-danger d-none">
                   Şifre ve ya kullanıcı adı hatalı!
                </div>

 
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
  <!-- plugins:js -->
  <script src="web/template/vendors/js/vendor.bundle.base.js"></script>
  <script src="web/template/vendors/js/vendor.bundle.addons.js"></script>
  <!-- endinject -->
  <!-- inject:js -->
  <script src="web/template/js/off-canvas.js"></script>
  <script src="web/template/js/misc.js"></script>
  <!-- endinject -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>
    <script>


        $("#loginButton").click(function (e) {
            e.preventDefault();

            var form = $("#login-form");
            form.validate();

            if (form.valid()) {
                $.ajax({
                    type: 'POST',
                    url: 'response.aspx',
                    data: $('#login-form').serialize(),
                    success: function (data) {

                        $('#invalid-user').addClass("d-none");
                        console.log("login was successful " + data);

                        window.location = "dashboard.aspx"
 
                    },
                    error: function () {


                        $('#invalid-user').removeClass("d-none");
                        console.log("login was unsuccessful "  );
                    }
                });
            }


        });





    </script>
</body>



</html>
