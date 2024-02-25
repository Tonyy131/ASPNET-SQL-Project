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

namespace Advising_Team_74
{
    public partial class addCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ADD_COURSE(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String MAJOR = TextBox1.Text;
            int SEM = int.Parse(TextBox2.Text);
            int CH = int.Parse(TextBox3.Text);
            String NAME = TextBox4.Text;
            bool ISOFFERED = CheckBox1.Checked;
            SqlCommand addcourse = new SqlCommand("Procedures_AdminAddingCourse", conn);
            addcourse.CommandType = CommandType.StoredProcedure;
            addcourse.Parameters.Add(new SqlParameter("@major", MAJOR));
            addcourse.Parameters.Add(new SqlParameter("@semester", SEM));
            addcourse.Parameters.Add(new SqlParameter("@credit_hours", CH));
            addcourse.Parameters.Add(new SqlParameter("@course_name", NAME));
            addcourse.Parameters.Add(new SqlParameter("@offered", ISOFFERED));

            conn.Open();
            addcourse.ExecuteNonQuery();
            conn.Close();
            Label1.Visible = true;
            TextBox1.Text = string.Empty;
            TextBox2.Text = string.Empty;
            TextBox3.Text = string.Empty;
            TextBox4.Text = string.Empty;
            CheckBox1.Checked = false;
        }

    }
}