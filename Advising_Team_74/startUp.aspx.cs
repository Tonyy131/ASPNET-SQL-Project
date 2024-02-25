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
    public partial class startUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void login(object sender, EventArgs e)
        {
            
            String func = "select dbo.FN_StudentLogin(@studentID,@password)";
            String p = "@studentID";
           
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int id = Int32.Parse(username.Value);
            String pass = password.Value;

            SqlCommand loginfunc = new SqlCommand(func, conn);
            loginfunc.Parameters.AddWithValue(p, id);
            loginfunc.Parameters.AddWithValue("@password", pass);
            loginfunc.CommandType = CommandType.Text;


            SqlCommand getSemester = new SqlCommand("Select semester_code  From Semester", conn);
            conn.Open();
            bool success = (bool)loginfunc.ExecuteScalar();
            string sem = (string)getSemester.ExecuteScalar();
            conn.Close();
            if (success)
            {
                Session["StudentID"] = id;
                Session["Current_semester"] = "s24";
                Response.Redirect("mainPageStudent.aspx");
            }
            else
                error.Visible = true;


        }
        protected void advisorlog(object sender, EventArgs e)
        {
            Response.Redirect("startUpA.aspx");
        }
        protected void registers(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String fName = firstName.Value;
            String lName = lastName.Value;
            String fac = faculty.Value;
            String em = email.Value;
            String ma = major.Value;
            String pas = pass.Value;
            int sem = Int16.Parse(semester.Value);
            SqlCommand StdRegister = new SqlCommand("Procedures_StudentRegistration", conn);
            StdRegister.CommandType = CommandType.StoredProcedure;
            StdRegister.Parameters.Add(new SqlParameter("@first_name", fName));
            StdRegister.Parameters.Add(new SqlParameter("@last_name", lName));
            StdRegister.Parameters.Add(new SqlParameter("@password", pas));
            StdRegister.Parameters.Add(new SqlParameter("@faculty",fac));
            StdRegister.Parameters.Add(new SqlParameter("@email", em));
            StdRegister.Parameters.Add(new SqlParameter("@major", ma));
            StdRegister.Parameters.Add(new SqlParameter("@semester", sem));

            SqlParameter id1 = StdRegister.Parameters.Add("@Student_id", SqlDbType.Int);
            id1.Direction = ParameterDirection.Output;
            SqlCommand getSemester = new SqlCommand("Select semester_code from Semester", conn);
            conn.Open();
            string sems = (string)getSemester.ExecuteScalar();
            StdRegister.ExecuteNonQuery();
            conn.Close();
            Session["StudentID"] = id1.Value;
            Session["Current_semester"] = "s24";
            Response.Redirect("mainPageStudent.aspx");       
        }
    }
    
}
