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
    public partial class students : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand STDAdvisorViewPendingRequests = new SqlCommand("AdminListStudentsWithAdvisors", conn);
            STDAdvisorViewPendingRequests.CommandType = CommandType.StoredProcedure;
            conn.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(STDAdvisorViewPendingRequests);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            conn.Close();

            YourGridView.DataSource = dt;
            YourGridView.DataBind();

        }

        protected void YourGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}