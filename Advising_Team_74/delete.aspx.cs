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
    public partial class delete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Delete_Courses_Related_Slots(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int cid = int.Parse(TextBox1.Text);
            SqlCommand STDAdminDeleteCourse = new SqlCommand("Procedures_AdminDeleteCourse", conn);
            STDAdminDeleteCourse.CommandType = CommandType.StoredProcedure;
            STDAdminDeleteCourse.Parameters.Add(new SqlParameter("@courseID", cid));
            conn.Open();
            STDAdminDeleteCourse.ExecuteNonQuery();
            conn.Close();
            Label1.Visible = true;
            TextBox1.Text = string.Empty;
        }

    }
}