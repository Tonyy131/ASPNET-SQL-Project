using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace Advising_Team_74
{
    public partial class mainPageStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["studentID"] != null)
                {
                    int studentID = Convert.ToInt16(Session["studentID"]);
                    DisplayStudentInformation(studentID);
                }
                else
                {
                    
                    Response.Redirect("startUp.aspx");
                }
            }
        }

        private void DisplayStudentInformation(int studentID)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString(); 
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT * FROM Student WHERE student_id = @studentID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@studentID", studentID);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    // Display student information on the page
                    studentNameLabel.Text = dt.Rows[0]["f_name"].ToString();
                    studentLNameLabel.Text = dt.Rows[0]["l_name"].ToString();
                    studentIDLabel.Text = dt.Rows[0]["student_id"].ToString();
                    studentGPALabel.Text = dt.Rows[0]["gpa"].ToString();
                    studentFacultyLabel.Text = dt.Rows[0]["faculty"].ToString();
                    studentEmailLabel.Text = dt.Rows[0]["email"].ToString();
                    studentMajorLabel.Text = dt.Rows[0]["major"].ToString();
                    studentSemesterLabel.Text = dt.Rows[0]["semester"].ToString();

                    // Add more labels or controls and populate them with other student info
                }
                else
                {
                    // Handle case where student information is not found
                }
            }
        }

        protected void addPhone(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int n = Convert.ToInt32(Session["studentID"]); ;
            String num = TextBox1.Text;
            SqlCommand addphone = new SqlCommand("Procedures_StudentaddMobile", conn);
            addphone.CommandType = CommandType.StoredProcedure;
            addphone.Parameters.Add(new SqlParameter("@StudentID", n));
            addphone.Parameters.Add(new SqlParameter("@mobile_number", num));


            conn.Open();
            try
            {
                addphone.ExecuteNonQuery();
                Label2.Visible = false;
                Label1.Visible = true;
            }
            catch(Exception ex)
            {
                Label2.Visible = true;
                Label1.Visible = false;
            }
            conn.Close();
            TextBox1.Text = string.Empty;
        }

        protected void logout(object sender, EventArgs e)
        {
            Session["studentID"] = null;
            Response.Redirect("startUp.aspx");
        }
    }
}
