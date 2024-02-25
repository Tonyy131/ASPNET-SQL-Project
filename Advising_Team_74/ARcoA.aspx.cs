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
    public partial class ARcoA : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Extra_Co_Request(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int Rid = int.Parse(TextBox1.Text);
            string sems = (string)Session["Current_semester"];
            SqlCommand STDStudentSendingCoRequest = new SqlCommand("Procedures_AdvisorApproveRejectCourseRequest", conn);
            STDStudentSendingCoRequest.CommandType = CommandType.StoredProcedure;
            STDStudentSendingCoRequest.Parameters.Add(new SqlParameter("@requestID", Rid));
            STDStudentSendingCoRequest.Parameters.Add(new SqlParameter("@current_semester_code", sems));
            conn.Open();
            int n = STDStudentSendingCoRequest.ExecuteNonQuery();
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