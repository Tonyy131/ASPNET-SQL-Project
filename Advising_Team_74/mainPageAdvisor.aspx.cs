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
    public partial class mainPageAdvisor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["AdvisorID"] != null)
                {
                    int advisorID = Convert.ToInt32(Session["AdvisorID"]);
                    DisplayStudentInformation(advisorID);
                }
                else
                {

                    Response.Redirect("startUpA.aspx");
                }
            }
        }

        private void DisplayStudentInformation(int advisorID)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT * FROM Advisor WHERE advisor_id = @advisorID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@advisorID", advisorID);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    NameLabel.Text = dt.Rows[0]["name"].ToString();
                    IDLabel.Text = dt.Rows[0]["advisor_id"].ToString();
                    studentEmailLabel.Text = dt.Rows[0]["email"].ToString();
                    officeLabel.Text = dt.Rows[0]["office"].ToString();

                    
                }
                else
                {
                    
                }
            }
        }

        protected void logout(object sender, EventArgs e)
        {
            Session["AdvisorID"] = null;
            Response.Redirect("startUpA.aspx");
        }
    }
}