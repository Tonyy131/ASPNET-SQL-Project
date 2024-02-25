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
    public partial class startUpA : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {
            String func = "";
            String p = "";
            
            func = "select dbo.FN_AdvisorLogin(@ID,@password)";
            p = "@ID";
            
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int id = Int32.Parse(username.Value);
            String pass = password.Value;

            SqlCommand loginfunc = new SqlCommand(func, conn);
            SqlCommand getSemester = new SqlCommand("Select semester_code  From Semester", conn);
            loginfunc.Parameters.AddWithValue(p, id);
            loginfunc.Parameters.AddWithValue("@password", pass);
            loginfunc.CommandType = CommandType.Text;
            conn.Open();
            bool success = (bool)loginfunc.ExecuteScalar();
            string sem = (string)getSemester.ExecuteScalar();            
            conn.Close();
            if (success)
            {
                Session["AdvisorID"] = id;
                Session["Current_semester"] = sem;
                Response.Redirect("mainPageAdvisor.aspx");
            }
            else
                if (id == 1952003 && pass == "team74")
                    Response.Redirect("mainPageAdmin.aspx");
                else    
                    error.Visible = true;


        }
        protected void studentlog(object sender, EventArgs e)
        {
            Response.Redirect("startUp.aspx");
        }
        protected void registers(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String n = name.Value;
            String em = email.Value;
            String of = office.Value;
            String pas = pass.Value;
            SqlCommand StdRegister = new SqlCommand("Procedures_AdvisorRegistration", conn);
            StdRegister.CommandType = CommandType.StoredProcedure;
            StdRegister.Parameters.Add(new SqlParameter("@advisor_name", n));
            StdRegister.Parameters.Add(new SqlParameter("@password", pas));
            StdRegister.Parameters.Add(new SqlParameter("@email", em));
            StdRegister.Parameters.Add(new SqlParameter("@office", of));
            SqlParameter id1 = StdRegister.Parameters.Add("@Advisor_id", SqlDbType.Int);
            id1.Direction = ParameterDirection.Output;
            SqlCommand getSemester = new SqlCommand("Select semester_code  From Semester", conn);
            conn.Open();
            string sems = (string)getSemester.ExecuteScalar();
            StdRegister.ExecuteNonQuery();
            conn.Close();
            Session["AdvisorID"] = id1.Value;
            Session["Current_semester"] = sems;
            Response.Redirect("mainPageAdvisor.aspx");
        }
    }
}
