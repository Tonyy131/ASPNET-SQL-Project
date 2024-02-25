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
    public partial class link : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Link_instructor_to_course_on_specific_slot(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int cid = int.Parse(TextBox2.Text);
            int IID = int.Parse(ins.Text);
            int sid = int.Parse(TextBox3.Text);
            SqlCommand addsemester = new SqlCommand("Procedures_AdminLinkInstructor", conn);
            addsemester.CommandType = CommandType.StoredProcedure;
            addsemester.Parameters.Add(new SqlParameter("@courseId", cid));
            addsemester.Parameters.Add(new SqlParameter("@instructorId", IID));
            addsemester.Parameters.Add(new SqlParameter("@slotId", sid));


            conn.Open();
            try { 
                addsemester.ExecuteNonQuery();
                Label1.Visible = true;
                Label2.Visible = false;
            }
            catch(Exception ex)
            {
                Label2.Visible = true;
                Label1.Visible = false;
            }
            conn.Close();
            TextBox2.Text = string.Empty;
            TextBox3.Text = string.Empty;
            ins.Text = string.Empty;
        }

    }
}