<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" href="css/bootstrap.min.css">
    
    <style>
          .form-control{
                border-radius:0 !important;
        }
        .row.res{
            border-top: 1px solid #005baa;
        }
        .row.search{
            background-color:#f5f5f5;
            padding:1%;
        }
        .footer{
            background-color:#005baa !important;
            color:#ffffff;
            padding:3%;
        }
        .btn-link{
            color:#fff !important;
        }
        .card-body{
            border: 1px solid #005baa;
        }
        .accordion{
            width:100% !important;
        }
        .row.heading{
            border:1px solid #f5f5f5;
        }
        .row.loginF{
            padding:2%;
            background-color:#f5f5f5;
        }


        #overlay {
    position: fixed;
    z-index: 99;
    top: 0px;
    left: 0px;
    background-color: #f8f8f8;
    width: 100%;
    height: 100%;
    filter: Alpha(Opacity=90);
    opacity: 0.9;
    -moz-opacity: 0.9;
}            
#theprogress {
    background-color: #fff;
    border:1px solid #ccc;
    padding:10px;
    width: 300px;
    height: 30px;
    line-height:30px;
    text-align: center;
    filter: Alpha(Opacity=100);
    opacity: 1;
    -moz-opacity: 1;
}
#modalprogress {
    position: absolute;
    top: 40%;
    left: 50%;
    margin: -11px 0 0 -150px;
    color: #990000;
    font-weight:bold;
    font-size:14px;
}
    </style>
   
</head>
<body>
    <form id="form1" class="" runat="server">
    
        <div class="container">   
                     
            <div class="row heading">
                  <div class="col-md-4 "> 
                        <img src="img/cliksLogocroppedNew.png" />
                    </div>
                    <div class="col-md-4 offset-md-2">
                        <img src="img/logo.png" /><asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
&nbsp;</div>
            </div>
        
        
                
                <div class="row loginF">
                    <div class="col-md-6 offset-md-3">
                        
                       
                       <div class="form-group">
                            <asp:TextBox ID="txtUsername" class="form-control" runat="server" required ="" PlaceHolder="Username"></asp:TextBox>
                       </div>
                  
                        
               <div class="form-group">
                    <asp:TextBox ID="txtPassword" type="password" class="form-control" runat="server" required PlaceHolder="Password"></asp:TextBox>
                  </div>
                   <div class="form-group">
                    <asp:Button ID="btnLogin" class="btn btn-success" runat="server" Text="Login" onclick="btn_Login" />&nbsp;
                   
                       <asp:Label ID="lblLoginStatus" runat="server" Text=""></asp:Label>
             </div>


                    </div>

                </div>
          
               <div class="row footer">
                   Please enter your AD Credentials above.
               </div>  
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            </asp:UpdatePanel>
        <asp:UpdateProgress ID="prgLoadingStatus" runat="server" DynamicLayout="true">
    <ProgressTemplate>
        <div id="overlay">
            <div id="modalprogress">
                <div id="theprogress">
                    <asp:Image ID="imgWaitIcon" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/img/wait.gif" />
                    Please wait...
                </div>
            </div>
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>  
         
    </div>
    </form>
    <script src="script/jquery.js" type="text/javascript"></script>
    <script src="script/bootstrap.js" type="text/jscript"></script>
</body>
</html>
