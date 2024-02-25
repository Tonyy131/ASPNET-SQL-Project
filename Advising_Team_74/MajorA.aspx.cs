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
    public partial class MajorA : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Advising_Students_Certain_Major(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string majors = TextBox1.Text;
            int id = Convert.ToInt32(Session["AdvisorID"]);
            SqlCommand STDAdvisorViewAssignedStudents = new SqlCommand("Procedures_AdvisorViewAssignedStudents", conn);
            STDAdvisorViewAssignedStudents.CommandType = CommandType.StoredProcedure;
            STDAdvisorViewAssignedStudents.Parameters.Add(new SqlParameter("@AdvisorID", id));
            STDAdvisorViewAssignedStudents.Parameters.Add(new SqlParameter("@major", majors));
            conn.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(STDAdvisorViewAssignedStudents);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            conn.Close();

            YourGridView.DataSource = dt; // YourGridView is the ID of your GridView control
            YourGridView.DataBind();
            TextBox1.Visible = false;
            Button1.Visible = false;
            Label1.Visible = false;
        }

        protected void YourGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

    }
}