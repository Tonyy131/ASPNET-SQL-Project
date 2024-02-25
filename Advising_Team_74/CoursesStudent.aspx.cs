using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.ComponentModel;

namespace Advising_Team_74
{
    public partial class CoursesStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void viewOptionalCourses(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int n = Convert.ToInt32(Session["studentID"]);
            String c = "s24";
            SqlCommand opCourses = new SqlCommand("Procedures_ViewOptionalCourse", conn);
            opCourses.CommandType = CommandType.StoredProcedure;
            opCourses.Parameters.Add(new SqlParameter("@StudentID", n));
            opCourses.Parameters.Add(new SqlParameter("@current_semester_code", c));
            DataTable dt = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(opCourses);

            conn.Open();
            adapter.Fill(dt);
            conn.Close();
            ViewOptionalCoursesButton.Visible = false;
            ViewAvailableCourses.Visible = false;
            ViewMissingCourses.Visible = false;
            ViewRequiredCourses.Visible = false;

            YourGridView.DataSource = dt; // 'YourGridView' is the ID of your GridView control
            YourGridView.DataBind();
        }

        protected void viewAvailableCourses(object sender, EventArgs e)
        {
            String func = "SELECT * FROM dbo.FN_SemsterAvailableCourses(@semester_code);";
           

            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String co = "s24";

            SqlCommand avalible_courses_func = new SqlCommand(func, conn);
            avalible_courses_func.Parameters.AddWithValue("@semester_code", co);
            avalible_courses_func.CommandType = CommandType.Text;
            conn.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(avalible_courses_func);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            conn.Close();

            YourGridView.DataSource = dt; // YourGridView is the ID of your GridView control
            YourGridView.DataBind();
            ViewOptionalCoursesButton.Visible = false;
            ViewAvailableCourses.Visible = false;
            ViewMissingCourses.Visible = false;
            ViewRequiredCourses.Visible = false;
        }

        protected void viewRequiredCourses(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int id = Convert.ToInt32(Session["studentID"]); 
            String co = "s24";
            SqlCommand STDrequiredcourses = new SqlCommand("Procedures_ViewRequiredCourses", conn);
            STDrequiredcourses.CommandType = CommandType.StoredProcedure;
            STDrequiredcourses.Parameters.Add(new SqlParameter("@StudentID", id));
            STDrequiredcourses.Parameters.Add(new SqlParameter("@current_semester_code", co));
            DataTable dt = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(STDrequiredcourses);

            conn.Open();
            adapter.Fill(dt);
            conn.Close();
            ViewOptionalCoursesButton.Visible = false;
            ViewAvailableCourses.Visible = false;
            ViewMissingCourses.Visible = false;
            ViewRequiredCourses.Visible = false;

            YourGridView.DataSource = dt; // 'YourGridView' is the ID of your GridView control
            YourGridView.DataBind();

        }

        protected void viewMissingCourses(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int id = Convert.ToInt32(Session["studentID"]);
            SqlCommand STDmissingcourses = new SqlCommand("Procedures_ViewMS", conn);
            STDmissingcourses.CommandType = CommandType.StoredProcedure;
            STDmissingcourses.Parameters.Add(new SqlParameter("@StudentID", id));
            DataTable dt = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(STDmissingcourses);

            conn.Open();
            adapter.Fill(dt);
            conn.Close();
            ViewOptionalCoursesButton.Visible = false;
            ViewAvailableCourses.Visible = false;
            ViewMissingCourses.Visible = false;
            ViewRequiredCourses.Visible = false;

            YourGridView.DataSource = dt; // 'YourGridView' is the ID of your GridView control
            YourGridView.DataBind();
        }

        protected void YourGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}