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
    public partial class delete1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Delete_Slot_Certain_Course(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string semester = textboxx.Text;

            SqlCommand STDAdminDeleteSlots = new SqlCommand("Procedures_AdminDeleteSlots", conn);
            STDAdminDeleteSlots.CommandType = CommandType.StoredProcedure;
            STDAdminDeleteSlots.Parameters.Add(new SqlParameter("@current_semester", semester));


            conn.Open();
            STDAdminDeleteSlots.ExecuteNonQuery();
            conn.Close();
            Label1.Visible = true;
            textboxx.Text = string.Empty;
        }

    }
}