<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cb_paymentsuccess.aspx.cs" Inherits="cb_paymentsuccess" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Payment Success - CuteBOT</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css" />

    <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<form id="form1" runat="server">
<div class="container">

<div class="page-header">
    <h1>Payment Successful</small></h1>
</div>

<!-- Credit Card Payment Form - START -->

<div class="container">
    <div class="row">
        <div class="col-xs-12 col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <h3 class="text-center">Payment Details</h3>
                        <img class="img-responsive cc-img" src="paymeth.png">
                    </div>
                </div>
                <div class="panel-body">
                    <form role="form">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>Annual licensing</label>
                                    <div class="input-group">
                                        <!--<input type="tel" class="form-control" placeholder="Valid Card Number" />-->
                                        <span class="input-group-addon"><span class="fa fa-credit-card">Thank you for your payment.<br /><br />  Please enter your license code below:
                                        <br />
                                        <asp:TextBox ID="txtLicenseCode" runat="server"></asp:TextBox>
                                        <br />
                                        <asp:Button ID="btnGenerate" runat="server" Text="Generate" 
                                            onclick="btnGenerate_Click" />
                                            <br /><br />
                                        <asp:Label ID="lblVerifyCode" runat="server" Text="- Verification code -" 
                                            Font-Bold="True"></asp:Label></span></span>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-7 col-md-7">
                                <div class="form-group">
                                    <!--<label><span class="hidden-xs">EXPIRATION</span><span class="visible-xs-inline">EXP</span> DATE</label>-->
                                    <!--<input type="tel" class="form-control" placeholder="MM / YY" />-->
                                </div>
                            </div>
                            <div class="col-xs-5 col-md-5 pull-right">
                                <div class="form-group">
                                    <!--<label>CV CODE</label>
                                    <input type="tel" class="form-control" placeholder="CVC" />-->
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <!--<label>CARD OWNER</label>
                                    <input type="text" class="form-control" placeholder="Card Owner Names" />-->
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="panel-footer">
                    <div class="row">
                        <div class="col-xs-12">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .cc-img {
        margin: 0 auto;
    }
</style>
<!-- Credit Card Payment Form - END -->

</div>

</form>
</body>
</html>
