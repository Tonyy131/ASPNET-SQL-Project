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
    public partial class ARchA : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Extra_CH_Request(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int Rid = int.Parse(TextBox1.Text);
            string sems = (string)Session["Current_semester"];         
            SqlCommand STDStudentSendingCHRequest = new SqlCommand("Procedures_AdvisorApproveRejectCHRequest", conn);
            STDStudentSendingCHRequest.CommandType = CommandType.StoredProcedure;
            STDStudentSendingCHRequest.Parameters.Add(new SqlParameter("@requestID", Rid));
            STDStudentSendingCHRequest.Parameters.Add(new SqlParameter("@current_sem_code", sems));
            conn.Open();
            int n = STDStudentSendingCHRequest.ExecuteNonQuery();
            conn.Close();
            if (n > 0)
            {
                Label2.Visible = true;
                Label3.Visible = false;
            }
            else
            {
                Label3.Visible = true;
                Label2.Visible = false;
            }

            TextBox1.Text = string.Empty;
        }

    }
}