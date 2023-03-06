using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using Hyland.Types;
using Hyland.Unity;
using System.IO;
using System.Data;


public partial class Search : System.Web.UI.Page
{

    // 
    protected void Page_Load(object sender, EventArgs e)
    {
        

        // do session check here
        if (Session["Username"] == null)
            Response.Redirect("~/login.aspx"); 


    }


    protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {

    }

    public void WriteLog(Hyland.Unity.Application app, string msg)
    {

        //app.Diagnostics.Write(DateTime.Now.ToString() + "\t[WEBAPP-scriptsearch]\t" + msg);

        System.IO.StreamWriter sw = File.AppendText(Server.MapPath("~/log.txt"));
        sw.WriteLine(DateTime.Now.ToShortDateString() + "\t" + msg);
        sw.Close();
    }


    public void DeleteOldFiles(Hyland.Unity.Application app)
    {

        string[] files = Directory.GetFiles(Server.MapPath("~/ScriptDocuments/"));
       

        foreach (string file in files)
        {
           

            FileInfo info = new FileInfo(file);

            info.Refresh();

            if (info.LastWriteTime <= DateTime.Now.AddDays(-1))
            {

                try
                {

                    info.Delete();
                }
                catch
                {
                    WriteLog(app, "Unable to delete temp file: " + info.Name);
                }
                
            }

            
        }

    }

    public bool KeysOK()
    {
        bool ok = false;

        if (txtRXNO.Text.Length > 0)
            ok = true;

        if (txtProfileNo.Text.Length > 0)
            ok = true;

        if (txtName.Text.Length > 0)
            ok = true;

        if (txtSurname.Text.Length > 0)
            ok = true;

        if (txtIDNo.Text.Length > 0)
            ok = true;

        if (txtDate.Text.Length > 0)
            ok = true;


        return ok;

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        
         
         string ConnectionString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];

         string appserver = System.Configuration.ConfigurationManager.AppSettings["Appserver"].ToString(); //"http://172.16.27.75/appserver/Service.asmx";
           string username = System.Configuration.ConfigurationManager.AppSettings["APIUsername"].ToString();
           string password = System.Configuration.ConfigurationManager.AppSettings["APIPassword"].ToString();
           string datasource = System.Configuration.ConfigurationManager.AppSettings["Datasource"].ToString();
           string ImagePath = System.Configuration.ConfigurationManager.AppSettings["ImagePath"].ToString();

           // keyword values
           string PatientName = txtName.Text;
           string PatientSurname = txtSurname.Text;
           string ScriptNumber = txtRXNO.Text;
           string Script_Date = txtDate.Text;
           
           string IDNo = txtIDNo.Text;
           string ProfileNo = txtProfileNo.Text;

           AuthenticationProperties authProps = Hyland.Unity.Application.CreateOnBaseAuthenticationProperties(appserver, username, password, datasource);
           authProps.LicenseType = LicenseType.QueryMetering;
           
       

        Hyland.Unity.Application app = null;
        try
        {
            app = Hyland.Unity.Application.Connect(authProps);

            WriteLog(app, "Connection Successful");

            // now read doctypes and keywords
            string Script_documentTypeName = System.Configuration.ConfigurationManager.AppSettings["ScriptDocType"].ToString(); 



            DocumentType udocumentType = app.Core.DocumentTypes.Find(Script_documentTypeName);
            if (udocumentType == null)
            {
                WriteLog(app, "Unable to find script document type: " + Script_documentTypeName);
            }
            else
            {

                // do document query based on keyword values supplied

                if (!KeysOK())
                {
                    // notify user - enter search criteria
                    lblSearchStatus.Text = "Please enter search criteria";
                    return;
                }
                

                DocumentQuery docQuery = app.Core.CreateDocumentQuery();
                docQuery.AddDocumentType(udocumentType);

                if (PatientName.Length > 0)
                 docQuery.AddKeyword("Patient Name", PatientName);

                if (PatientSurname.Length > 0)
                 docQuery.AddKeyword("Patient Surname", PatientSurname);

                if (ScriptNumber.Length > 0)
                    docQuery.AddKeyword("Script-Number", ScriptNumber);

                if (IDNo.Length > 0)
                    docQuery.AddKeyword("ID Number", IDNo);

                if (Script_Date.Length > 0)
                    docQuery.AddKeyword("Script Date", Script_Date);

                if (ProfileNo.Length > 0)
                    docQuery.AddKeyword("CDB Profile No", ProfileNo);
                
                docQuery.RetrievalOptions = DocumentRetrievalOptions.LoadKeywords;
               

                docQuery.AddSort(DocumentQuery.SortAttribute.DocumentDate, false);

                DocumentList docList = docQuery.Execute(50);
                if (docList.Count == 0)
                {
                    WriteLog(app, "No documents found");
                    lblHitCount.Text = "No documents found";
                    //CLEAR REPEATER HERE

                    DataTable dtx = null;
                    Repeater1.DataSource = dtx;
                    Repeater1.DataBind();
                    return;
                }
                else
                {
                    lblHitCount.Text = docList.Count.ToString() + " documents found";

                    WriteLog(app, "Got results");
                    WriteLog(app, "Script Document Type found: " + udocumentType.Name + " " + udocumentType.ID.ToString());


                    DataTable dt = new DataTable();
                    dt.Columns.Add("DocumentID");
                    dt.Columns.Add("DocumentURL");

                    // Clear temp folder (delete documents older than 1 day)

                    try
                    {
                        DeleteOldFiles(app);
                    }
                    catch { }

                    foreach (Document doc in docList)
                    {

                        string DocFileName = doc.ID.ToString() + "." + doc.DefaultRenditionOfLatestRevision.FileType.Extension;
                        string DocPath = Path.Combine(Server.MapPath("~/ScriptDocuments/"), DocFileName);

                        Utility.WriteStreamToFile(app.Core.Retrieval.Default.GetDocument(doc.DefaultRenditionOfLatestRevision).Stream, DocPath);


                        dt.Rows.Add(DocFileName + " " + doc.Name, "~/ScriptDocuments/" + DocFileName);

                    }


                    
                    

                    
                    // bind results to repeater

                    Repeater1.DataSource = dt;
                    Repeater1.DataBind();

                }
            }
        }
        catch (Exception ex)
        {
            
            WriteLog(app, ex.Message);

        }


    }

    //private object toString()
    //{
    //    throw new NotImplementedException();
    //}
    protected void btnClear_Click(object sender, EventArgs e)
    {
       
        
        txtDate.Text = string.Empty;
        txtIDNo.Text = string.Empty;
        txtName.Text = string.Empty;
        txtProfileNo.Text = string.Empty;
        txtRXNO.Text = string.Empty;
        txtSurname.Text = string.Empty;

        lblHitCount.Text = string.Empty;

        // clear repeater
        DataTable dtx = null;
        Repeater1.DataSource = dtx;
        Repeater1.DataBind();
    }
}