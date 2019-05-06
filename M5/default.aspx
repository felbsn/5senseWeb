<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="M5._default" %>

<%


    if(Session["User"] != null)
    {
       Response.Redirect("dashboard.aspx");
    }else
    {
      Response.Redirect("login.aspx");
    }
     


%>
