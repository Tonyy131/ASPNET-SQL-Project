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
    public partial class InCA : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Insert_Courses_GP(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int id = int.Parse(sid.Text);
            string cod = code.Text;
            string cnam = cname.Text;
            SqlCommand STDAdvisorAddCourseGP = new SqlCommand("Procedures_AdvisorAddCourseGP", conn);
            STDAdvisorAddCourseGP.CommandType = CommandType.StoredProcedure;
            STDAdvisorAddCourseGP.Parameters.Add(new SqlParameter("@student_id", id));
            STDAdvisorAddCourseGP.Parameters.Add(new SqlParameter("@Semester_code", cod));
            STDAdvisorAddCourseGP.Parameters.Add(new SqlParameter("@course_name", cnam));
            conn.Open();
            try
            { 
                STDAdvisorAddCourseGP.ExecuteNonQuery();
                Label1.Visible = true;
                Label2.Visible = false;
            }
            catch(Exception ex)
            {
                Label2.Visible = true;
                Label1.Visible = false;
            }
            conn.Close();
            sid.Text = string.Empty;
            code.Text = string.Empty;
            cname.Text = string.Empty;
        }

    }
}