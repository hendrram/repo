using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cb_paymentsuccess : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string GetVerificationCode(string licensecode)
    {
        string verificationcode = string.Empty;
        char d = 'X';

        foreach (char c in licensecode)
        {
            if (c == 'A' || c == 'a')
                d = 'Z';

            if (c == 'B' || c == 'b')
                d = 'Y';


            if (c == 'C' || c == 'c')
                d = 'X';


            if (c == 'D' || c == 'd')
                d = 'W';


            if (c == 'E' || c == 'e')
                d = 'V';


            if (c == 'F' || c == 'f')
                d = 'U';


            if (c == 'G' || c == 'g')
                d = 'T';


            if (c == 'H' || c == 'h')
                d = 'S';


            if (c == 'I' || c == 'i')
                d = 'R';


            if (c == 'J' || c == 'j')
                d = 'Q';


            if (c == 'K' || c == 'k')
                d = 'P';

            if (c == 'L' || c == 'l')
                d = 'O';


            if (c == 'M' || c == 'm')
                d = 'N';


            if (c == 'N' || c == 'n')
                d = 'M';


            if (c == 'O' || c == 'o')
                d = 'L';


            if (c == 'P' || c == 'p')
                d = 'K';


            if (c == 'Q' || c == 'q')
                d = 'J';

            if (c == 'R' || c == 'r')
                d = 'I';


            if (c == 'S' || c == 's')
                d = 'H';

            if (c == 'T' || c == 't')
                d = 'G';


            if (c == 'U' || c == 'u')
                d = 'F';


            if (c == 'V' || c == 'v')
                d = 'E';


            if (c == 'W' || c == 'w')
                d = 'D';


            if (c == 'X' || c == 'x')
                d = 'C';


            if (c == 'Y' || c == 'y')
                d = 'B';

            if (c == 'Z' || c == 'z')
                d = 'a';


            if (c == '1')
                d = '9';


            if (c == '2')
                d = '8';


            if (c == '3')
                d = '7';


            if (c == '4')
                d = '6';


            if (c == '5')
                d = '4';

            if (c == '4')
                d = '5';


            if (c == '3')
                d = '2';


            if (c == '2')
                d = '1';


            if (c == '1')
                d = '0';


            if (c == '0')
                d = '9';





            verificationcode += d;


        }

        verificationcode = ReverseString(verificationcode);
        return verificationcode;
    }

    public static string ReverseString(string str)
    {
        char[] chars = str.ToCharArray();
        char[] result = new char[chars.Length];
        for (int i = 0, j = str.Length - 1; i < str.Length; i++, j--)
        {
            result[i] = chars[j];
        }
        return new string(result);
    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        if (txtLicenseCode.Text == string.Empty)
        {
            lblVerifyCode.Text = ("Please enter license code");
            return;
        }
        string licensecode = txtLicenseCode.Text;
        // eg. AC2B6E2C82B0  -- stripped mac address
        string verificationcode = GetVerificationCode(licensecode);

        lblVerifyCode.Text = verificationcode;
    }
}