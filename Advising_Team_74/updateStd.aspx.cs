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
    public partial class updateStd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Update_Student_Status(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int sid = int.Parse(TextBox1.Text);

            SqlCommand STDAdminUpdateStudentStatus = new SqlCommand("Procedure_AdminUpdateStudentStatus", conn);
            STDAdminUpdateStudentStatus.CommandType = CommandType.StoredProcedure;
            STDAdminUpdateStudentStatus.Parameters.Add(new SqlParameter("@Student_ID", sid));


            conn.Open();
            int n = STDAdminUpdateStudentStatus.ExecuteNonQuery();
            conn.Close();
            if (n > 0) {
                Label1.Visible = true;
                Label2.Visible = false;
            }
            else
            {
                Label1.Visible = false;
                Label2.Visible = true;
            }

        }

    }
}