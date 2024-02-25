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
    public partial class ReqA : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string func = "SELECT * FROM dbo.FN_Advisors_Requests(@advisorID);";
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int aid = Convert.ToInt32(Session["AdvisorID"]);
            SqlCommand view_requests_func = new SqlCommand(func, conn);
            view_requests_func.Parameters.AddWithValue("@advisorID", aid);
            view_requests_func.CommandType = CommandType.Text;
            conn.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(view_requests_func);
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