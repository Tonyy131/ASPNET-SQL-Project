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
    public partial class addSem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void add_semester(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            DateTime sd = Calendar1.SelectedDate;
            DateTime ed = Calendar2.SelectedDate;
            String sc = TextBox1.Text;
            if (sd >= ed)
            {

                Label2.Visible = true;
                Label1.Visible = false;
            }
            else
            {
                SqlCommand addsemester = new SqlCommand("AdminAddingSemester", conn);
                addsemester.CommandType = CommandType.StoredProcedure;
                addsemester.Parameters.Add(new SqlParameter("@start_date", sd));
                addsemester.Parameters.Add(new SqlParameter("@end_date", ed));
                addsemester.Parameters.Add(new SqlParameter("@semester_code", sc));

                conn.Open();
                try
                {
                    addsemester.ExecuteNonQuery();
                }
                catch(Exception ex) { }
                conn.Close();
                Label1.Visible = true;
                Label2.Visible = false;
                TextBox1.Text = string.Empty;

            }
        }

    }
}