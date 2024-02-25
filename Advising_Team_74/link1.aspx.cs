using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection.Emit;

namespace Advising_Team_74
{
    public partial class link1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Link_student_to_advisor(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String sid = ins.Text;
            String AID = TextBox2.Text;

            SqlCommand linkstad = new SqlCommand("Procedures_AdminLinkStudentToAdvisor", conn);
            linkstad.CommandType = CommandType.StoredProcedure;
            linkstad.Parameters.Add(new SqlParameter("@studentID", sid));
            linkstad.Parameters.Add(new SqlParameter("@advisorID", AID));



            conn.Open();
            try
            {
                int n = linkstad.ExecuteNonQuery();
                if (n > 0)
                {
                    Label1.Visible = true;
                    Label2.Visible = false;
                }
                else
                {
                    Label1.Visible = false;
                    Label2.Visible = true;
                }
            }
            catch(Exception ex)
            {
                Label1.Visible = false;
                Label2.Visible = true;
            }
            conn.Close();
            ins.Text = string.Empty;
            TextBox2.Text = string.Empty;
        }

    }
}