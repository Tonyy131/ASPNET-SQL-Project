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
    public partial class addExam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Add_Makeup_Exam(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string type = DropDownList1.SelectedValue;
            DateTime date = Calendar1.SelectedDate;
            int cid = int.Parse(TextBox1.Text);

            SqlCommand STDAdminAddExam = new SqlCommand("Procedures_AdminAddExam", conn);
            STDAdminAddExam.CommandType = CommandType.StoredProcedure;
            STDAdminAddExam.Parameters.Add(new SqlParameter("@Type", type));
            STDAdminAddExam.Parameters.Add(new SqlParameter("@date", date));
            STDAdminAddExam.Parameters.Add(new SqlParameter("@courseID", cid));


            conn.Open();
            STDAdminAddExam.ExecuteNonQuery();
            conn.Close();
            Label1.Visible = true;
        }

    }
}