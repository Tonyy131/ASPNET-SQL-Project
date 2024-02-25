using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Advising_Team_74
{
    public partial class ChooseStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Choose(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int studentID = Convert.ToInt32(Session["studentID"]);
            int cid = int.Parse(comm.Text);
            int inID = int.Parse(courseID.Text);
            string sems = (string)Session["Current_semester"];
            SqlCommand chos = new SqlCommand("Procedures_ChooseInstructor", conn);
            chos.CommandType = CommandType.StoredProcedure;
            chos.Parameters.Add(new SqlParameter("@StudentID", studentID));
            chos.Parameters.Add(new SqlParameter("@InstructorID", inID));
            chos.Parameters.Add(new SqlParameter("@CourseID", cid));
            chos.Parameters.Add(new SqlParameter("@current_semester_code", sems));

            conn.Open();
            int n = chos.ExecuteNonQuery();
            conn.Close();

            comm.Text = string.Empty;
            courseID.Text = string.Empty;
            if (n > 0) { 
                Label1.Visible = true;
                Label2.Visible = false;
            }
            else
            {
                Label1.Visible = false;
                Label2.Visible = true;
            }
        }
    }
}