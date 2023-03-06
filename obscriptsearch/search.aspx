<%@ Page Language="C#" AutoEventWireup="true" CodeFile="search.aspx.cs" Inherits="Search"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>OnBase - Script Search</title>
     <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="jquery-ui/jquery-ui.min.css">
    <style type="text/css">
        .style1
        {
            width: 174px;
        }
        .style2
        {
            width: 594px;
        }
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
        .card-header{
            background-color:#005baa !important;
            
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


    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
         <div class="container">
            <div class="row heading">
                  <div class="col-md-4 "> 
                        <img src="img/cliksLogocroppedNew.png" />
                        <br /><br />
                        <asp:HyperLink ID="hlLogout" runat="server" 
                            NavigateUrl="~/login.aspx?logoff=true">Logout</asp:HyperLink>
                    </div>
                    <div class="col-md-4 offset-md-2">
                        <img src="img/logo.png" />
                        
                    </div>
            </div>

        
    
             <div class="row search">
               <div class="col-md-4 ">
                        <div class="form-group">
                            <asp:TextBox ID="txtRXNO" runat="server" class="form-control" autocomplete="off" PlaceHolder="RX No" data-required="false"></asp:TextBox>
                        </div>
        
                        <div class="form-group">
                            <asp:TextBox ID="txtName" runat="server" class="form-control" autocomplete="off" PlaceHolder="Name" data-required="false"></asp:TextBox>
                        </div>

                         <div class="form-group">
                            <asp:TextBox ID="txtSurname" runat="server" class="form-control" autocomplete="off" PlaceHolder="Surname" data-required="false"></asp:TextBox>
                            <br /><br />
                              <asp:Button ID="btnSearch" runat="server" Text="Search" onclick="btnSearch_Click" class="btn btn-success"  />
                              
                          

                            <asp:Button ID="btnClear" runat="server" Text="Clear" class="btn btn-default" 
                                 onclick="btnClear_Click"  />
                        <asp:Label ID="lblSearchStatus" runat="server" Text=""></asp:Label>

                        </div>
                         
                </div>
                <div class="col-md-4 ">
                    <div class="form-group">
                            <asp:TextBox ID="txtProfileNo" runat="server" class="form-control" autocomplete="off" PlaceHolder="Profile Number" data-required="false"></asp:TextBox>
                     </div>
        
                         <div class="form-group">
                            <asp:TextBox ID="txtDate" runat="server" class="form-control datepicker" autocomplete="off" PlaceHolder="Date" data-required="false"></asp:TextBox>
                        </div>
            
                    <div class="form-group">
                    <asp:TextBox ID="txtIDNo" runat="server" class="form-control" autocomplete="off" PlaceHolder="ID Number" data-required="false"></asp:TextBox>
                    
                    </div>
                </div>
            </div>
             
              <div class="row">
                  
                  <div class="accordion" id="accordionExample">
                  <div class="card">
                    <div class="card-header" id="headingOne">
                      <h5 class="mb-0">
                          <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            Search Results
                          </button>&nbsp;<asp:Label ID="lblHitCount" runat="server" Text=""></asp:Label>
                      </h5>
                    </div>
                      </div>
                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                      <div class="card-body">
                          
                          

                        

                                

                            

                            <asp:Repeater ID="Repeater1" runat="server" 
                                onitemcommand="Repeater1_ItemCommand">
                           <ItemTemplate>
                               <li>
                                 <div>

                                   <asp:HyperLink ID="quickLink" runat="server" NavigateUrl='<%# Eval("DocumentURL") %>' Target="_blank" CssClass="quickllook inline"><%# Eval("DocumentID") %></asp:HyperLink>
                                   
                              </div>
                             </li>
                           </ItemTemplate>
                                
                            </asp:Repeater>
                         
                         </div>
                    </div> 
                      </div>
                        
            </div>          
 </div>
    </form>
    
    <script src="script/jquery.js" type="text/javascript"></script>
    <script src="script/bootstrap.js" type="text/jscript"></script>
    <script src="jquery-ui/jquery-ui.min.js" type="text/jscript"></script>
     <script type="text/javascript">

         $(function () {
             $(".datepicker").datepicker();
         });

    </script>
</body>
</html>
