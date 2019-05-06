<%@ Page Language="C#" %>
 <%


     if (Request.Form["username"] != null)
     {
                
         string username = Request.Form["username"];
          string password = Request.Form["password"];

         SqlHandle handle = new SqlHandle();

         var data = handle.Select($"select username , id  , name , surname ,utype  from user where username = '{username}' and userpassword='{password}'");

         if(data.Rows.Count == 0)
         {
             Response.Clear();
             Response.StatusCode = 404;
             Response.End();
         }else
         {
             UserInfo user = new UserInfo();


             user.username = data.Rows[0][0] as string;
             user.id = (int)data.Rows[0][1]  ;
             user.name = data.Rows[0][2] as string;
             user.surname = data.Rows[0][3] as string;
             user.userType =(int) data.Rows[0][4]  ;

             Session["User"] = user;
             Response.Write("success");
         
         } 


     }else
     {
         string username = "fatih0";
          string password = "123456";

         SqlHandle handle = new SqlHandle();

         var data = handle.Select($"select username , id  , name , surname ,utype  from user where username = '{username}' and userpassword='{password}'");
 
         if(data.Rows.Count == 0)
         {
             Response.Clear();
             Response.StatusCode = 404;
             Response.End();
         }else
         {
             UserInfo user = new UserInfo();


             user.username = data.Rows[0][0] as string;
             user.id = (int)data.Rows[0][1]  ;
             user.name = data.Rows[0][2] as string;
             user.surname = data.Rows[0][3] as string;
             user.userType =(int) data.Rows[0][4]  ;

             Session["User"] = user;
             //Response.Write(data);
            // Response.Redirect("dashboard.aspx");
         } 
     }




%>