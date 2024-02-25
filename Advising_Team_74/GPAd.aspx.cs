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
    public partial class GPAd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Insert_Graduation_Plan(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string semester_code = (string)Session["Current_semester"];
            DateTime expected = Calendar1.SelectedDate;
            int credit_hours = int.Parse(comm0.Text);
            int Aid = Convert.ToInt32(Session["AdvisorID"]);
            int sid = int.Parse(comm.Text);
            SqlCommand STDAdvisorCreateGP = new SqlCommand("Procedures_AdvisorCreateGP", conn);
            STDAdvisorCreateGP.CommandType = CommandType.StoredProcedure;
            STDAdvisorCreateGP.Parameters.Add(new SqlParameter("@Semester_code", semester_code));
            STDAdvisorCreateGP.Parameters.Add(new SqlParameter("@expected_graduation_date", expected));
            STDAdvisorCreateGP.Parameters.Add(new SqlParameter("@sem_credit_hours", credit_hours));
            STDAdvisorCreateGP.Parameters.Add(new SqlParameter("@advisor_id", Aid));
            STDAdvisorCreateGP.Parameters.Add(new SqlParameter("@student_id", sid));
            conn.Open();
            try
            {
                STDAdvisorCreateGP.ExecuteNonQuery();
                Label1.Visible = true;
                Label2.Visible = false;
            }
            catch(Exception ex)
            {
                Label1.Visible = false;
                Label2.Visible = true;
            }
            conn.Close();
            comm.Text = string.Empty;
            comm0.Text = string.Empty;
        }

    }
}