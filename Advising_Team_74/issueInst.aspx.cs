using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team_74
{
    public partial class issueInst : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Issue_Installments_Certain_Payment(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int pid = int.Parse(TextBox1.Text);

            SqlCommand STDAdminIssueInstallment = new SqlCommand("Procedures_AdminIssueInstallment", conn);
            STDAdminIssueInstallment.CommandType = CommandType.StoredProcedure;
            STDAdminIssueInstallment.Parameters.Add(new SqlParameter("@payment_ID", pid));


            conn.Open();
            try { 
                int n = STDAdminIssueInstallment.ExecuteNonQuery();
                if (n > 0)
                {
                    Label1.Visible = true;
                    Label2.Visible = false;
                }
                else
                {
                    Label2.Visible = true;
                    Label1.Visible = false;
                }
            }
            catch(Exception ex)
            {
                Label2.Visible = true;
                Label1.Visible = false;
            }
            conn.Close();

        }

    }
}