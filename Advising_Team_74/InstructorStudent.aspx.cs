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
    public partial class InstructorStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void show(object sender, EventArgs e)
        {
            String func = "SELECT * FROM DBO.FN_StudentViewSlot(@CourseID, @InstructorID);";


            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            

            SqlCommand showSlots = new SqlCommand(func, conn);
            int cID = int.Parse(courseID.Text);
            int inID = int.Parse(inst.Text);
            showSlots.Parameters.AddWithValue("@CourseID", cID);
            showSlots.Parameters.AddWithValue("@InstructorID", inID);
            showSlots.CommandType = CommandType.Text;
            conn.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(showSlots);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            conn.Close();

            YourGridView.DataSource = dt; // YourGridView is the ID of your GridView control
            YourGridView.DataBind();
            courseID.Visible = false;
            inst.Visible = false;
            Label1.Visible = false;
            Label2.Visible = false;
            showss.Visible = false;
        }
        protected void YourGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}