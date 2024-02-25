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
    public partial class InstallmentStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_Team_74"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int studentID = Convert.ToInt32(Session["studentID"]);
            String func = "SELECT dbo.FN_StudentUpcoming_installment(@student_ID)";
            String func2 = "Select top 1 Installment.amount from Installment inner join Payment\r\non Payment.payment_id = Installment.payment_id and Payment.student_id = @student_ID and Installment.status='notpaid'\r\nwhere Installment.deadline > CURRENT_TIMESTAMP\r\n \r\nOrder by Installment.deadline ASC";
            SqlCommand instal = new SqlCommand(func, conn);
            SqlCommand ins = new SqlCommand(func2, conn);
            instal.Parameters.AddWithValue("@student_ID", studentID);
            instal.CommandType = CommandType.Text;
            ins.Parameters.AddWithValue("@student_ID", studentID);
            ins.CommandType = CommandType.Text;
            conn.Open();
            DateTime deadline = (DateTime)instal.ExecuteScalar();
            deadlineLabel.Text = deadline.ToString("yyyy-MM-dd");
            int amount = (int)ins.ExecuteScalar();
            amountLabel.Text = amount.ToString() + " EGP";
            conn.Close();
        }
       
    }
}