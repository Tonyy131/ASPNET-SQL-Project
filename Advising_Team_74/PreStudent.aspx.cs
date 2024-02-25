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
    public partial class PreStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String func = "SELECT * FROM view_Course_prerequisites";


            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand VIEW = new SqlCommand(func, conn);
            VIEW.CommandType = CommandType.Text;
            conn.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(VIEW);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            conn.Close();

            YourGridView.DataSource = dt; // YourGridView is the ID of your GridView control
            YourGridView.DataBind();
        }

        protected void YourGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}