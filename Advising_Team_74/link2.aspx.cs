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
    public partial class link2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Link_student_to_course_and_instructor(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int cid = int.Parse(ins.Text);
            int IID = int.Parse(TextBox2.Text);
            int sid = int.Parse(TextBox3.Text);
            String sc = (TextBox4.Text);



            SqlCommand linkstci = new SqlCommand("Procedures_AdminLinkStudent", conn);
            linkstci.CommandType = CommandType.StoredProcedure;

            linkstci.Parameters.Add(new SqlParameter("@courseId", cid));
            linkstci.Parameters.Add(new SqlParameter("@InstructorId", IID));
            linkstci.Parameters.Add(new SqlParameter("@studentId", sid));
            linkstci.Parameters.Add(new SqlParameter("@semester_code", sc));



            conn.Open();
            try
            {
                int n = linkstci.ExecuteNonQuery();
                if (n > 0) { 
                    Label1.Visible = true;
                    Label2.Visible = false;
                }
                else
                {
                    Label2.Visible = true;
                    Label1.Visible = false;
                }
            }
            catch(Exception ex)
            {
                Label2.Visible = true;
                Label1.Visible = false;
            }
            conn.Close();
            ins.Text = string.Empty;
            TextBox2.Text = string.Empty;
            TextBox3.Text = string.Empty;
            TextBox4.Text = string.Empty;
        }

    }
}