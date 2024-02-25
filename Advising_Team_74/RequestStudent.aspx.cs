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
    public partial class RequestStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RequestCr(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int cid = int.Parse(courseID.Text);
            int sid = Convert.ToInt32(Session["studentID"]);
            String type = "course";
            String comment = comm.Text;
            SqlCommand STDrequestcourses = new SqlCommand("Procedures_StudentSendingCourseRequest", conn);
            STDrequestcourses.CommandType = CommandType.StoredProcedure;
            STDrequestcourses.Parameters.Add(new SqlParameter("@course_ID", cid));
            STDrequestcourses.Parameters.Add(new SqlParameter("@Student_ID", sid));
            STDrequestcourses.Parameters.Add(new SqlParameter("@type", type));
            STDrequestcourses.Parameters.Add(new SqlParameter("@comment", comment));

            conn.Open();
            try { 
                STDrequestcourses.ExecuteNonQuery();
                Label1.Visible = true;
                Label3.Visible = false;
            }
            catch(Exception ex)
            {
                Label3.Visible = true;
                Label1.Visible = false;
            }
            conn.Close();
            courseID.Text = string.Empty;
            comm.Text = string.Empty;
        }

        protected void RequestCH(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int ch = int.Parse(creditH.Text);
            int sid = Convert.ToInt32(Session["studentID"]);
            String type = "credit_hours";
            String comment = comm0.Text;
            SqlCommand STDCHrequest = new SqlCommand("Procedures_StudentSendingCHRequest", conn);
            STDCHrequest.CommandType = CommandType.StoredProcedure;
            STDCHrequest.Parameters.Add(new SqlParameter("@credit_hours", ch));
            STDCHrequest.Parameters.Add(new SqlParameter("@Student_ID", sid));
            STDCHrequest.Parameters.Add(new SqlParameter("@type", type));
            STDCHrequest.Parameters.Add(new SqlParameter("@comment", comment));

            conn.Open();
            STDCHrequest.ExecuteNonQuery();
            conn.Close();
            Label2.Visible = true;
            creditH.Text = string.Empty;
            comm0.Text = string.Empty;
        }
    }
}