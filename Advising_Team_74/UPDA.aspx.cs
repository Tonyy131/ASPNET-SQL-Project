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
    public partial class UPDA : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Update_Graduation_Date(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            DateTime grad_date = grad.SelectedDate;
            int id = int.Parse(sid.Text);
            SqlCommand STDAdvisorUpdateGP = new SqlCommand("Procedures_AdvisorUpdateGP", conn);
            STDAdvisorUpdateGP.CommandType = CommandType.StoredProcedure;
            STDAdvisorUpdateGP.Parameters.Add(new SqlParameter("@expected_grad_date", grad_date));
            STDAdvisorUpdateGP.Parameters.Add(new SqlParameter("@studentID", id));
            conn.Open();
            try
            {
                int n = STDAdvisorUpdateGP.ExecuteNonQuery();
                if (n > 0) { 
                    Label1.Visible = true;
                    Label2.Visible = false;
                }
                else
                {
                    Label2.Visible = true;
                    Label1.Visible = false;
                }
            }
            catch (Exception ex)
            {
                Label2.Visible = true;
                Label1.Visible = false;
            }

            conn.Close();
            sid.Text = string.Empty;
        }

    }
}