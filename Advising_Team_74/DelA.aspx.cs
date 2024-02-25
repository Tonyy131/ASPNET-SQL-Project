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
    public partial class DelA : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Delete_Course_Graduation(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int id = int.Parse(sid.Text);
            string s_code = code.Text;
            int coid = int.Parse(cid.Text);
            SqlCommand STDAdvisorDeleteFromGP = new SqlCommand("Procedures_AdvisorDeleteFromGP", conn);
            STDAdvisorDeleteFromGP.CommandType = CommandType.StoredProcedure;
            STDAdvisorDeleteFromGP.Parameters.Add(new SqlParameter("@studentID", id));
            STDAdvisorDeleteFromGP.Parameters.Add(new SqlParameter("@sem_code", s_code));
            STDAdvisorDeleteFromGP.Parameters.Add(new SqlParameter("@courseID", coid));
            conn.Open();
            int n = STDAdvisorDeleteFromGP.ExecuteNonQuery();
            conn.Close();
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
            sid.Text = string.Empty;
            code.Text = string.Empty;
            cid.Text = string.Empty;
        }

    }
}