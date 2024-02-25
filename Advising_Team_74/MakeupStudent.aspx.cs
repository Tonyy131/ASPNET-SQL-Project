using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.NetworkInformation;
using System.Reflection.Emit;
using System.Security.Cryptography;

namespace Advising_Team_74
{
    public partial class MakeupStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void firstMake(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand firstMak = new SqlCommand("Procedures_StudentRegisterFirstMakeup", conn);
            firstMak.CommandType = CommandType.StoredProcedure;
            int id1 = Convert.ToInt32(Session["studentID"]);
            int cid1 = int.Parse(courseID.Text);
            string sem1 = (string)Session["Current_semester"];
            firstMak.Parameters.Add(new SqlParameter("@StudentID", id1));
            firstMak.Parameters.Add(new SqlParameter("@courseID", cid1));
            firstMak.Parameters.Add(new SqlParameter("@studentCurr_sem", sem1));

            conn.Open();           
            int rowsAffected = firstMak.ExecuteNonQuery();
            if (rowsAffected > 0)
            {
                Label1.Visible = true;
            }
            else
            {
                Label3.Visible = true;
            }
            conn.Close();
            courseID.Text = string.Empty;
        }

        protected void secondMake(object sender, EventArgs e)
        {
            string func = "SELECT dbo.FN_StudentCheckSMEligibility(@CourseID,@StudentID)";       
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand secndReg = new SqlCommand("Procedures_StudentRegisterSecondMakeup", conn);
            secndReg.CommandType = CommandType.StoredProcedure;
            int id = Convert.ToInt32(Session["studentID"]);
            int cid = int.Parse(scid.Text);
            string sem = (string)Session["Current_semester"];
            secndReg.Parameters.Add(new SqlParameter("@StudentID", id));
            secndReg.Parameters.Add(new SqlParameter("@courseID", cid));
            secndReg.Parameters.Add(new SqlParameter("@studentCurr_sem", sem));
            SqlCommand secndMak = new SqlCommand(func, conn);
            secndMak.Parameters.AddWithValue("@CourseID", cid);
            secndMak.Parameters.AddWithValue("@StudentID",id);
            secndMak.CommandType = CommandType.Text;
            conn.Open();
            bool lg = (bool)secndMak.ExecuteScalar();
            if (lg)
            {
                secndReg.ExecuteNonQuery();
                Label2.Visible = true;
            }
            else
            {
                Label4.Visible = true;
            }
            conn.Close();
            scid.Text = string.Empty;
        }
    }
}