<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UPDA.aspx.cs" Inherits="Advising_Team_74.UPDA" %>

<!doctype html>
<html lang="en">
  <head>
  	<title>Sidebar 05</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
		
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="css/style.css">
  </head>
  <body>
		
		<form id="form1" runat="server">
		
		<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar">
				<div class="custom-menu">
					<button type="button" id="sidebarCollapse" class="btn btn-primary">
	          <i class="fa fa-bars"></i>
	          <span class="sr-only">Toggle Menu</span>
	        </button>
        </div>
				<div class="p-4">
		  		<h1><a href="index.html" class="logo">GUC <span>Advising Portal</span></a></h1>
	        <ul class="list-unstyled components mb-5">
	          <li class="active">
	            <a href="mainPageAdvisor.aspx"><span class="fa fa-home mr-3"></span> Home</a>
	          </li>
	          <li>
	              <a href="studentsA.aspx"><span class="fa fa-user mr-3"></span> Students</a>
	          </li>
	          <li>
              <a href="GPAd.aspx"><span class="fa fa-calendar-plus-o mr-3"></span> Insert Graduation plan</a>
	          </li>
	          <li>
              <a href="InCA.aspx"><span class="fa fa-plus mr-3"></span> Insert course in GP</a>
	          </li>
	          <li>
              <a href="UPDA.aspx"><span class="fa fa-calendar mr-3"></span> Update GP date</a>
	          </li>
	          <li>
              <a href="DelA.aspx"><span class="fa fa-ban mr-3"></span> Delete course from GP</a>
	          </li>
	          <li>
              <a href="MajorA.aspx"><span class="fa fa-binoculars mr-3"></span> Major's students</a>
	          </li>
			  <li>
              <a href="ReqA.aspx"><span class="fa fa-bookmark-o mr-3"></span>ALL Requests</a>
	          </li>
	          <li>
              <a href="PenReqA.aspx"><span class="fa fa-bookmark mr-3"></span> Pending Requests</a>
	          </li>
	          <li>
              <a href="ARchA.aspx"><span class="fa fa-arrows mr-3"></span>Approve/reject CH requests</a>
	          </li>
	          <li>
              <a href="ARcoA.aspx"><span class="fa fa-arrows mr-3"></span> Approve/reject course requests</a>
	          </li>
	        </ul>

	        <div class="mb-5">
					</div>

	        <div class="footer">
	        </div>

	      </div>
    	</nav>

        <div id="content" class="p-4 p-md-5 pt-5">
    <h2 class="mb-4">Update expected Graduation plan date</h2>
    <div style="font-family: 'Sitka Heading'; font-size: xx-large; font-weight: bolder; text-transform: uppercase; color: #000080;">
       
        student id : <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="sid" Display="Dynamic" ErrorMessage="RegularExpressionValidator" ForeColor="Red" ValidationExpression="\d+" ValidationGroup="course">*</asp:RegularExpressionValidator>
		<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="sid" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="course">*</asp:RequiredFieldValidator>
		<br /> <asp:TextBox ID="sid" class="custom-textbox" runat="server"></asp:TextBox> <br />
		NEw expected date :<asp:Calendar ID="grad" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="523px">
            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
            <WeekendDayStyle BackColor="#CCCCFF" />
        </asp:Calendar>
		<asp:Label ID="Label1" runat="server" Font-Size="Small" ForeColor="#66FF33" Text="Date updated successfully" Visible="False"></asp:Label>
		&nbsp;<asp:Label ID="Label2" runat="server" Font-Size="Small" ForeColor="Red" Text="Date can not be updated" Visible="False"></asp:Label>
		<br />
		<asp:Button ID="RequestCourse" class="small-button" runat="server" Text="update" OnClick="Update_Graduation_Date" ValidationGroup="course" />
       
    <!-- Additional content or formatting here -->
</div>
		</div>

    <script src="js/jquery.min.js"></script>
    <script src="js/popper.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
        </form>
  </body>
</html>