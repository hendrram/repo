using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using Hyland.Types;
using Hyland.Unity;
using System.IO;
using System.DirectoryServices.AccountManagement;


public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["logoff"] == "true")
            Session.Abandon();



    }

    public void WriteLog(string msg)
    {

        //app.Diagnostics.Write(DateTime.Now.ToString() + "\t[WEBAPP-scriptsearch]\t" + msg);

        System.IO.StreamWriter sw = File.AppendText(Server.MapPath("~/log.txt"));
        sw.WriteLine(DateTime.Now.ToShortDateString() + "\t" + msg);
        sw.Close();
    }


    public void btn_Login(object sender, EventArgs e)
    {

        // override ad authentication for manager
        if (txtUsername.Text.ToUpper() == "MANAGER" && txtPassword.Text.ToUpper() == "ONTHEB@LL")
        {
            Session.Add("Username", txtUsername.Text);

            Response.Redirect("~/search.aspx");
        }



        try
        {
            // create a "principal context" - e.g. your domain (could be machine, too)
            using (PrincipalContext pc = new PrincipalContext(ContextType.Domain, "NEWCLICKS.COM"))
            {
                // validate the credentials
                bool isValid = pc.ValidateCredentials(txtUsername.Text, txtPassword.Text);


                if (isValid)
                {
                    UserPrincipal user = UserPrincipal.FindByIdentity(pc, txtUsername.Text);
                    GroupPrincipal group = GroupPrincipal.FindByIdentity(pc, System.Configuration.ConfigurationManager.AppSettings["AllowedADGroup"].ToString());

                    WriteLog("User: " + user.Name);
                    
                    if (group != null)
                        WriteLog("Group: " + group.Name);

                    if (user != null && group != null)
                    {
                        // check if user is member of that group
                        if (user.IsMemberOf(group))
                        {
                            Session.Add("Username", txtUsername.Text);

                            Response.Redirect("~/search.aspx");
                        }
                        else
                        {
                            lblLoginStatus.Text = "Login failure - insufficient privileges - please request to be added to the correct AD group for pharmacy script viewing";
                            WriteLog("User is not a member of the allowed AD group");
                        }
                    }
                    else
                    {
                        lblLoginStatus.Text = "Login failure, please ensure that you have entered the correct credentials";
                        WriteLog("User and/or Group are null");
                    }




                }
                else
                {
                    // notify of login failure
                    lblLoginStatus.Text = "Login failure, please ensure that you have entered the correct credentials";
                    WriteLog("Unable to validate credentials - bad pwd or username");
                }
            }

        }
        catch (Exception exf)
        {

            WriteLog("Unknown exception: " + exf.Message + "\t" + exf.StackTrace.ToString());
        }

    }

}
