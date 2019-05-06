<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="M5.dashboard" %>


<%     
    if (Session["User"] == null)
    {
        Response.Redirect("login.aspx");
    }

    UserInfo U = (UserInfo)Session["User"];

    SqlHandle handle = new SqlHandle();




    var statistics = handle.Select($"SELECT count(*) , mediachannel.name from event , mediachannel WHERE event.channel = mediachannel.id and event.uid ='{U.id}' GROUP by event.channel");
    int sumEvents = 1;
    for (int i = 0; i < statistics.Rows.Count; i++)
    {
 
        sumEvents += (int)(Int64)(statistics.Rows[i][0]);
    }

    var monthly =  handle.Select($"select MONTH (eventdate), COUNT(mediachannel.name) ,mediachannel.name from event , mediachannel where event.uid = '{U.id}' and mediachannel.id = event.channel group by  MONTH (eventdate), event.channel order by 3");


    // maxMonthly


    int maxMonthly = 1;
    var mdata = new  Dictionary< string,  int[] >  ();
    for (int i = 0; i < monthly.Rows.Count; i++)
    {
        var cname = (string)monthly.Rows[i][2];
        if(!mdata.ContainsKey(cname))
        {
            mdata.Add(cname, new int[12]);

        }

        int month = (int)monthly.Rows[i][0];

        Int64 count = (Int64)monthly.Rows[i][1];
        int c = (int)count;

        maxMonthly = Math.Max(c, maxMonthly);

        mdata[cname][month - 1] = c;
    }

    var table = handle.Select($"select eventname  ,  modality ,eventdate, mediachannel.name from event , mediachannel where uid = '{U.id}' and  mediachannel.id = channel limit 10");














%>


<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>5 Duyu Medya</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="web/template/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="web/template/vendors/css/vendor.bundle.base.css">


  <!-- endinject -->
  <!-- inject:css -->
  <link rel="stylesheet" href="web/template/css/style.css">

    <style>

        .dropdown-item
        {
            background-color:whitesmoke;
        }
 
    </style>
  <!-- endinject -->
  <link rel="shortcut icon" href="web/template/images/favicon.png" />
</head>
<body>
  <div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <nav class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
      <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
        <a class="navbar-brand brand-logo" href="dashboard.aspx"><img src="web/template/images/logo.svg" alt="logo"/></a>
        <a class="navbar-brand brand-logo-mini" href="dashboard.aspx"><img src="web/template/images/logo-mini.svg" alt="logo"/></a>
      </div>
      <div class="navbar-menu-wrapper d-flex align-items-stretch">
<%--        <div class="search-field d-none d-md-block">
          <form class="d-flex align-items-center h-100" action="#">
            <div class="input-group">
              <div class="input-group-prepend bg-transparent">
                  <i class="input-group-text border-0 mdi mdi-magnify"></i>                
              </div>
              <input type="text" class="form-control bg-transparent border-0" placeholder="Search projects">
            </div>
          </form>
        </div>--%>
        <ul class="navbar-nav navbar-nav-right">
          <li class="nav-item nav-profile dropdown">
            <a class="nav-link dropdown-toggle" id="profileDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
              <div class="nav-profile-img">
                <img src="web/template/images/faces/face1.jpg" alt="image">
                <span class="availability-status online"></span>             
              </div>
              <div class="nav-profile-text">
                <p class="mb-1 text-black"><%=U.name + " "+ U.surname %></p>
              </div>
            </a>
            <div class="dropdown-menu navbar-dropdown" aria-labelledby="profileDropdown">
              <a class="dropdown-item" href="#">
                <i class="mdi mdi-cached mr-2 text-success"></i>
                Activity Log
              </a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="#">
                <i class="mdi mdi-logout mr-2 text-primary"></i>
                Signout
              </a>
            </div>
          </li>
          <li class="nav-item d-none d-lg-block full-screen-link">
            <a class="nav-link">
              <i class="mdi mdi-fullscreen" id="fullscreen-button"></i>
            </a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link count-indicator dropdown-toggle" id="messageDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
              <i class="mdi mdi-email-outline"></i>
              <span class="count-symbol bg-warning"></span>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="messageDropdown">
              <h6 class="p-3 mb-0">Messages</h6>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                    <img src="web/template/images/faces/face4.jpg" alt="image" class="profile-pic">
                </div>
                <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                  <h6 class="preview-subject ellipsis mb-1 font-weight-normal">Mark send you a message</h6>
                  <p class="text-gray mb-0">
                    1 Minutes ago
                  </p>
                </div>
              </a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                    <img src="web/template/images/faces/face2.jpg" alt="image" class="profile-pic">
                </div>
                <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                  <h6 class="preview-subject ellipsis mb-1 font-weight-normal">Cregh send you a message</h6>
                  <p class="text-gray mb-0">
                    15 Minutes ago
                  </p>
                </div>
              </a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                    <img src="web/template/images/faces/face3.jpg" alt="image" class="profile-pic">
                </div>
                <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                  <h6 class="preview-subject ellipsis mb-1 font-weight-normal">Profile picture updated</h6>
                  <p class="text-gray mb-0">
                    18 Minutes ago
                  </p>
                </div>
              </a>
              <div class="dropdown-divider"></div>
              <h6 class="p-3 mb-0 text-center">4 new messages</h6>
            </div>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-toggle="dropdown">
              <i class="mdi mdi-bell-outline"></i>
              <span class="count-symbol bg-danger"></span>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
              <h6 class="p-3 mb-0">Notifications</h6>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                  <div class="preview-icon bg-success">
                    <i class="mdi mdi-calendar"></i>
                  </div>
                </div>
                <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                  <h6 class="preview-subject font-weight-normal mb-1">Event today</h6>
                  <p class="text-gray ellipsis mb-0">
                    Just a reminder that you have an event today
                  </p>
                </div>
              </a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                  <div class="preview-icon bg-warning">
                    <i class="mdi mdi-settings"></i>
                  </div>
                </div>
                <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                  <h6 class="preview-subject font-weight-normal mb-1">Settings</h6>
                  <p class="text-gray ellipsis mb-0">
                    Update dashboard
                  </p>
                </div>
              </a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                  <div class="preview-icon bg-info">
                    <i class="mdi mdi-link-variant"></i>
                  </div>
                </div>
                <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                  <h6 class="preview-subject font-weight-normal mb-1">Launch Admin</h6>
                  <p class="text-gray ellipsis mb-0">
                    New admin wow!
                  </p>
                </div>
              </a>
              <div class="dropdown-divider"></div>
              <h6 class="p-3 mb-0 text-center">See all notifications</h6>
            </div>
          </li>
          <li class="nav-item nav-logout d-none d-lg-block">
            <a class="nav-link" href="#">
              <i class="mdi mdi-power"></i>
            </a>
          </li>
          <li class="nav-item nav-settings d-none d-lg-block">
            <a class="nav-link" href="#">
              <i class="mdi mdi-format-line-spacing"></i>
            </a>
          </li>
        </ul>
        <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
          <span class="mdi mdi-menu"></span>
        </button>
      </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- partial:partials/_sidebar.html -->
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">


            <!--
          <li class="nav-item nav-profile">
            <a href="#" class="nav-link">
              <div class="nav-profile-image">
                <img src="web/template/images/faces/face1.jpg" alt="profile">
                <span class="login-status online"></span>               
              </div>
              <div class="nav-profile-text d-flex flex-column">
                <span class="font-weight-bold mb-2">David Grey. H</span>
                <span class="text-secondary text-small">Project Manager</span>
              </div>
              <i class="mdi mdi-bookmark-check text-success nav-profile-badge"></i>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="dashboard.aspx">
              <span class="menu-title">Dashboard</span>
              <i class="mdi mdi-home menu-icon"></i>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
              <span class="menu-title">UI Elements</span>
              <i class="menu-arrow"></i>
              <i class="mdi mdi-crosshairs-gps menu-icon"></i>
            </a>
            <div class="collapse" id="ui-basic">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="web/template/pages/ui-features/buttons.html">Buttons</a></li>
                <li class="nav-item"> <a class="nav-link" href="web/template/pages/ui-features/typography.html">Typography</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="pages/icons/mdi.html">
              <span class="menu-title">Icons</span>
              <i class="mdi mdi-contacts menu-icon"></i>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="pages/forms/basic_elements.html">
              <span class="menu-title">Forms</span>
              <i class="mdi mdi-format-list-bulleted menu-icon"></i>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="pages/charts/chartjs.html">
              <span class="menu-title">Charts</span>
              <i class="mdi mdi-chart-bar menu-icon"></i>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="pages/tables/basic-table.html">
              <span class="menu-title">Tables</span>
              <i class="mdi mdi-table-large menu-icon"></i>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#general-pages" aria-expanded="false" aria-controls="general-pages">
              <span class="menu-title">Sample Pages</span>
              <i class="menu-arrow"></i>
              <i class="mdi mdi-medical-bag menu-icon"></i>
            </a>
            <div class="collapse" id="general-pages">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="web/template/pages/samples/blank-page.html"> Blank Page </a></li>
                <li class="nav-item"> <a class="nav-link" href="web/template/pages/samples/login.html"> Login </a></li>
                <li class="nav-item"> <a class="nav-link" href="web/template/pages/samples/register.html"> Register </a></li>
                <li class="nav-item"> <a class="nav-link" href="web/template/pages/samples/error-404.html"> 404 </a></li>
                <li class="nav-item"> <a class="nav-link" href="web/template/pages/samples/error-500.html"> 500 </a></li>
              </ul>
              </div>
          </li>
          <li class="nav-item sidebar-actions">
            <span class="nav-link">
              <div class="border-bottom">
                <h6 class="font-weight-normal mb-3">Projects</h6>                
              </div>
              <button class="btn btn-block btn-lg btn-gradient-primary mt-4">+ Add a project</button>
              <div class="mt-4">
                <div class="border-bottom">
                  <p class="text-secondary">Categories</p>                  
                </div>
                <ul class="gradient-bullet-list mt-4">
                  <li>Free</li>
                  <li>Pro</li>
                </ul>
              </div>
            </span>
          </li>
            -->

        </ul>
      </nav>
      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
       <!--   <div class="row">
            <div class="col-12">
              <span class="d-flex align-items-center purchase-popup">
                <p>Like what you see? Check out our premium version for more.</p>
                <a href="https://github.com/BootstrapDash/PurpleAdmin-Free-Admin-Template" target="_blank" class="btn ml-auto download-button">Download Free Version</a>
                <a href="https://www.bootstrapdash.com/product/purple-bootstrap-4-admin-template/" target="_blank" class="btn purchase-button">Upgrade To Pro</a>
                <i class="mdi mdi-close popup-dismiss"></i>
              </span>
            </div>
          </div> -->
 
          <div class="page-header">
            <h3 class="page-title">
              <span class="page-title-icon bg-gradient-primary text-white mr-2">
                <i class="mdi mdi-home"></i>                 
              </span>
               Aktiviteler
            </h3>
            <nav aria-label="breadcrumb">
              <ul class="breadcrumb">
                <li class="breadcrumb-item active" aria-current="page">
                  <span></span>Görünüm
                  <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
                </li>
              </ul>
            </nav>
          </div>
          <div class="row">
            <div class="col-md-4 stretch-card grid-margin">
              <div class="card bg-gradient-danger card-img-holder text-white">
                <div class="card-body">
                  <img src="web/template/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image"/>
                  <h4 class="font-weight-normal mb-3">Haftalık Rapor
                    <i class="mdi mdi-chart-line mdi-24px float-right"></i>
                  </h4>
                  <h2 class="mb-5"> 0 </h2> <%--------------------------------------------------------------------------%>
                  <h6 class="card-text"> </h6>
                </div>
              </div>
            </div>
            <div class="col-md-4 stretch-card grid-margin">
              <div class="card bg-gradient-info card-img-holder text-white">
                <div class="card-body">
                  <img src="web/template/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image"/>                  
                  <h4 class="font-weight-normal mb-3"> Toplam Rapor
                    <i class="mdi mdi-bookmark-outline mdi-24px float-right"></i>
                  </h4>
                  <h2 class="mb-5"> <%=sumEvents  %></h2> <%--------------------------------------------------------------------------%>
                  <h6 class="card-text">bütün raporlar </h6>
                </div>
              </div>
            </div>
            <div class="col-md-4 stretch-card grid-margin">
              <div class="card bg-gradient-success card-img-holder text-white">
                <div class="card-body">
                  <img src="web/template/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image"/>                                    
                  <h4 class="font-weight-normal mb-3"> Toplam Haberler
                    <i class="mdi mdi-diamond mdi-24px float-right"></i>
                  </h4>
                  <h2 class="mb-5"><%=sumEvents  %></h2>
                  <h6 class="card-text"></h6><%-- Increased by 5%--%>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-7 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <div class="clearfix">
                    <h4 class="card-title float-left">Aylık Takip Tablosu 2019</h4>
                    <div id="visit-sale-chart-legend" class="rounded-legend legend-horizontal legend-top-right float-right"></div>                                     
                  </div>
                  <canvas id="visit-sale-chart" class="mt-4"></canvas>
                </div>
              </div>
            </div>
            <div class="col-md-5 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title">Haber Kanal Dağılımı</h4>
                  <canvas id="traffic-chart"></canvas>
                  <div id="traffic-chart-legend" class="rounded-legend legend-vertical legend-bottom-left pt-4"></div>                                                      
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 grid-margin">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title">Son oluşturulan haberler</h4>
                  <div class="table-responsive">
                    <table class="table">
                      <thead>
                        <tr>
                          <th>
                            Medya Kanalı
                          </th>
                          <th>
                            Olay
                          </th>
                          <th>
                            Tip
                          </th>
                          <th>
                            Tarih
                          </th>
                          <th>
                            Git
                          </th>
                        </tr>
                      </thead>
                      <tbody>

                          <%
                              for (int i = 0; i < table.Rows.Count; i++)
                              {
                        %>

                        <tr>
                          <td>
                         <%--   <img src="web/template/images/faces/face1.jpg" class="mr-2" alt="image">--%>
                           <%=table.Rows[i][3] %>
                          </td>
                          <td>
                          <%=table.Rows[i][0] %>
                          </td>
                          <td>
                            <label class="badge badge-gradient-success">   <%=table.Rows[i][1] %></label>
                          </td>
                          <td>
                               <%=table.Rows[i][2] %>
                          </td>
                          <td>
                             <label class="badge badge-gradient-danger">?</label>
                          </td>
                        </tr>

                          <%} %>
                              




                           


 
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row d-none">
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title">Recent Updates</h4>
                  <div class="d-flex">
                    <div class="d-flex align-items-center mr-4 text-muted font-weight-light">
                      <i class="mdi mdi-account-outline icon-sm mr-2"></i>
                      <span>jack Menqu</span>
                    </div>
                    <div class="d-flex align-items-center text-muted font-weight-light">
                      <i class="mdi mdi-clock icon-sm mr-2"></i>
                      <span>October 3rd, 2018</span>
                    </div>
                  </div>
                  <div class="row mt-3">
                    <div class="col-6 pr-1">
                      <img src="web/template/images/dashboard/img_1.jpg" class="mb-2 mw-100 w-100 rounded" alt="image">
                      <img src="web/template/images/dashboard/img_4.jpg" class="mw-100 w-100 rounded" alt="image">
                    </div>
                    <div class="col-6 pl-1">
                      <img src="web/template/images/dashboard/img_2.jpg" class="mb-2 mw-100 w-100 rounded" alt="image">
                      <img src="web/template/images/dashboard/img_3.jpg" class="mw-100 w-100 rounded" alt="image">
                    </div>
                  </div>
                  <div class="d-flex mt-5 align-items-top">
                    <img src="web/template/images/faces/face3.jpg" class="img-sm rounded-circle mr-3" alt="image">
                    <div class="mb-0 flex-grow">
                      <h5 class="mr-2 mb-2">School Website - Authentication Module.</h5>
                      <p class="mb-0 font-weight-light">It is a long established fact that a reader will be distracted by the readable
                        content of a page.</p>
                    </div>
                    <div class="ml-auto">
                      <i class="mdi mdi-heart-outline text-muted"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row d-none">
            <div class="col-md-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title">Project Status</h4>
                  <div class="table-responsive">
                    <table class="table">
                      <thead>
                        <tr>
                          <th>
                            #
                          </th>
                          <th>
                            Name
                          </th>
                          <th>
                            Due Date
                          </th>
                          <th>
                            Progress
                          </th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            1
                          </td>
                          <td>
                            Herman Beck
                          </td>
                          <td>
                            May 15, 2015
                          </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-gradient-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            2
                          </td>
                          <td>
                            Messsy Adam
                          </td>
                          <td>
                            Jul 01, 2015
                          </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-gradient-danger" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            3
                          </td>
                          <td>
                            John Richards
                          </td>
                          <td>
                            Apr 12, 2015
                          </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-gradient-warning" role="progressbar" style="width: 90%" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            4
                          </td>
                          <td>
                            Peter Meggik
                          </td>
                          <td>
                            May 15, 2015
                          </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-gradient-primary" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            5
                          </td>
                          <td>
                            Edward
                          </td>
                          <td>
                            May 03, 2015
                          </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-gradient-danger" role="progressbar" style="width: 35%" aria-valuenow="35" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            5
                          </td>
                          <td>
                            Ronald
                          </td>
                          <td>
                            Jun 05, 2015
                          </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-gradient-info" role="progressbar" style="width: 65%" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
        <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2019  5Duyu Medya.  All rights reserved.</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center"> </i></span>
          </div>
        </footer>
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->

  <!-- plugins:js -->
  <script src="web/template/vendors/js/vendor.bundle.base.js"></script>
  <script src="web/template/vendors/js/vendor.bundle.addons.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page-->
  <!-- End plugin js for this page-->
  <!-- inject:js -->
  <script src="web/template/js/off-canvas.js"></script>
  <script src="web/template/js/misc.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="web/template/js/dashboard.js"></script>
  <!-- End custom js for this page-->

    <script>
         var ctxi = document.getElementById('visit-sale-chart').getContext("2d");
        function simpleGradient( cbegin, cend) {
            var col = ctxi.createLinearGradient(0, 0, 0, 181);
            col.addColorStop(0, cbegin);
            col.addColorStop(1, cend);
            return {
                normal: col,
                legend: 'linear-gradient(to right, ' + cbegin + ' , '+cend+')'
            }
        }

        

        var colors = [
            simpleGradient('rgba(218, 140, 255, 1)', 'rgba(154, 85, 255, 1)'),
            simpleGradient('rgba(54, 215, 232, 1)', 'rgba(177, 148, 250, 1)'),
            simpleGradient('#606033' ,'#f0f069'),
            simpleGradient('#000000', '#ffffff'),
            simpleGradient('#ababab' ,'#faafaf'),
        ]


            if ($("#visit-sale-chart").length) {
      Chart.defaults.global.legend.labels.usePointStyle = true;
                var ctx = document.getElementById('visit-sale-chart').getContext("2d");


      var gradientStrokeViolet = ctx.createLinearGradient(0, 0, 0, 181);
      gradientStrokeViolet.addColorStop(0, 'rgba(218, 140, 255, 1)');
      gradientStrokeViolet.addColorStop(1, 'rgba(154, 85, 255, 1)');
      var gradientLegendViolet = 'linear-gradient(to right, rgba(218, 140, 255, 1), rgba(154, 85, 255, 1))';
      
      var gradientStrokeBlue = ctx.createLinearGradient(0, 0, 0, 360);
      gradientStrokeBlue.addColorStop(0, 'rgba(54, 215, 232, 1)');
      gradientStrokeBlue.addColorStop(1, 'rgba(177, 148, 250, 1)');
      var gradientLegendBlue = 'linear-gradient(to right, rgba(54, 215, 232, 1), rgba(177, 148, 250, 1))';

      var gradientStrokeRed = ctx.createLinearGradient(0, 0, 0, 300);
      gradientStrokeRed.addColorStop(0, 'rgba(255, 191, 150, 1)');
      gradientStrokeRed.addColorStop(1, 'rgba(254, 112, 150, 1)');
      var gradientLegendRed = 'linear-gradient(to right, rgba(255, 191, 150, 1), rgba(254, 112, 150, 1))';

      var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran', 'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'],

            datasets: [
                
                <%
        int num = 0;
        foreach (var item in mdata) 
        {
             if (num != 0) Response.Write(",");
                %>
                {
                    label: '<%=item.Key%>',
                    borderColor: colors[<%=num%>].normal,
                backgroundColor: colors[<%=num%>].normal,
                    hoverBackgroundColor: colors[<%=num%>].normal,
                    legendColor: colors[<%=num%>].legend,
                pointRadius: 0,
                fill: false,
                borderWidth: 1,
                fill: 'origin',
                    data: [
                    <%=item.Value[0]%>,
                    <%=item.Value[1]%>,
                    <%=item.Value[2]%>,
                    <%=item.Value[3]%>,
                    <%=item.Value[4]%>,
                    <%=item.Value[5]%>,
                    <%=item.Value[6]%>,
                    <%=item.Value[7]%>,
                    <%=item.Value[8]%>,
                    <%=item.Value[9]%>,
                    <%=item.Value[10]%>,
                    <%=item.Value[11]%>]
                }
                 <%  num++; }; %>

                ]

        },
        options: {
          responsive: true,
          legend: false,
          legendCallback: function(chart) {
            var text = []; 
            text.push('<ul>'); 
            for (var i = 0; i < chart.data.datasets.length; i++) { 
                text.push('<li><span class="legend-dots" style="background:' + 
                           chart.data.datasets[i].legendColor + 
                           '"></span>'); 
                if (chart.data.datasets[i].label) { 
                    text.push(chart.data.datasets[i].label); 
                } 
                text.push('</li>'); 
            } 
            text.push('</ul>'); 
            return text.join('');
          },
          scales: {
              yAxes: [{
                  ticks: {
                      display: false,
                      min: 0,
                      stepSize: <%=maxMonthly/5 %>,
                      max: <%=maxMonthly %>
                  },
                  gridLines: {
                    drawBorder: false,
                    color: 'rgba(235,237,242,1)',
                    zeroLineColor: 'rgba(235,237,242,1)'
                  }
              }],
              xAxes: [{
                  gridLines: {
                    display:false,
                    drawBorder: false,
                    color: 'rgba(0,0,0,1)',
                    zeroLineColor: 'rgba(235,237,242,1)'
                  },
                  ticks: {
                      padding: 20,
                      fontColor: "#9c9fa6",
                      autoSkip: true,
                  },
                  categoryPercentage: 0.5,
                  barPercentage: 0.5
              }]
            }
          },
          elements: {
            point: {
              radius: 0
            }
          }
      })
      $("#visit-sale-chart-legend").html(myChart.generateLegend());
    }
    if ($("#traffic-chart").length) {
      var gradientStrokeBlue = ctx.createLinearGradient(0, 0, 0, 181);
      gradientStrokeBlue.addColorStop(0, 'rgba(54, 215, 232, 1)');
      gradientStrokeBlue.addColorStop(1, 'rgba(177, 148, 250, 1)');
      var gradientLegendBlue = 'linear-gradient(to right, rgba(54, 215, 232, 1), rgba(177, 148, 250, 1))';

      var gradientStrokeRed = ctx.createLinearGradient(0, 0, 0, 50);
      gradientStrokeRed.addColorStop(0, 'rgba(255, 191, 150, 1)');
      gradientStrokeRed.addColorStop(1, 'rgba(254, 112, 150, 1)');
      var gradientLegendRed = 'linear-gradient(to right, rgba(255, 191, 150, 1), rgba(254, 112, 150, 1))';

      var gradientStrokeGreen = ctx.createLinearGradient(0, 0, 0, 300);
      gradientStrokeGreen.addColorStop(0, 'rgba(6, 185, 157, 1)');
      gradientStrokeGreen.addColorStop(1, 'rgba(132, 217, 210, 1)');
      var gradientLegendGreen = 'linear-gradient(to right, rgba(6, 185, 157, 1), rgba(132, 217, 210, 1))';      




        var trafficChartData = {

                    labels: [
          'İnternet',
          'Tv',
          'Radyo',
        ],
          datasets: [{

                      // These labels appear in the legend and in the tooltips when hovering different arcs
              data: [
        <%
        for (int i = 0; i < statistics.Rows.Count; i++)
        {
            if (i != 0) Response.Write(",");
            float value = ((int)((Int64)statistics.Rows[i][0])) / (float)sumEvents*100;
            Response.Write(value.ToString("0."));
        }
        %>
              ],



          backgroundColor: [
        <% for (int i = 0; i < statistics.Rows.Count; i++){if (i != 0) Response.Write(",");Response.Write(" colors["+i+"].normal");}%>

          ],
          hoverBackgroundColor: [
        <% for (int i = 0; i < statistics.Rows.Count; i++){if (i != 0) Response.Write(",");Response.Write(" colors["+i+"].normal");}%>

          ],
          borderColor: [
        <% for (int i = 0; i < statistics.Rows.Count; i++){if (i != 0) Response.Write(",");Response.Write(" colors["+i+"].normal");}%>

          ],
          legendColor: [
        <% for (int i = 0; i < statistics.Rows.Count; i++){if (i != 0) Response.Write(",");Response.Write(" colors["+i+"].legend");}%>

          ]
        }]
    

      };
      var trafficChartOptions = {
        responsive: true,
        animation: {
          animateScale: true,
          animateRotate: true
        },
        legend: false,
        legendCallback: function(chart) {
          var text = []; 
          text.push('<ul>'); 
          for (var i = 0; i < trafficChartData.datasets[0].data.length; i++) { 
              text.push('<li><span class="legend-dots" style="background:' + 
              trafficChartData.datasets[0].legendColor[i] + 
                          '"></span>'); 
              if (trafficChartData.labels[i]) { 
                  text.push(trafficChartData.labels[i]); 
              }
              text.push('<span class="float-right">'+trafficChartData.datasets[0].data[i]+"%"+'</span>')
              text.push('</li>'); 
          } 
          text.push('</ul>'); 
          return text.join('');
        }
      };
      var trafficChartCanvas = $("#traffic-chart").get(0).getContext("2d");
      var trafficChart = new Chart(trafficChartCanvas, {
        type: 'doughnut',
        data: trafficChartData,
        options: trafficChartOptions
      });
      $("#traffic-chart-legend").html(trafficChart.generateLegend());      
    }










    </script>
</body>

</html>
