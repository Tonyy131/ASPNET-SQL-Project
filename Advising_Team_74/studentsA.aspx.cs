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
    public partial class studentsA : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String func = "SELECT student_id, f_name + ' ' + l_name AS 'Name', major FROM view_Students WHERE advisor_id = @advisorID";


            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int id = Convert.ToInt32(Session["AdvisorID"]);

            SqlCommand grad_plan_func = new SqlCommand(func, conn);
            grad_plan_func.Parameters.AddWithValue("@advisorID", id);
            grad_plan_func.CommandType = CommandType.Text;
            conn.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(grad_plan_func);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            conn.Close();

            YourGridView.DataSource = dt; // YourGridView is the ID of your GridView control
            YourGridView.DataBind();
        }

        protected void YourGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

    }
    
}