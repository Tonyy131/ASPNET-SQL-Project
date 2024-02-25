<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mainPageStudent.aspx.cs" Inherits="Advising_Team_74.mainPageStudent" %>
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
	            <a href="mainPageStudent.aspx"><span class="fa fa-home mr-3"></span> Home</a>
	          </li>
	          <li>
	              <a href="CoursesStudent.aspx"><span class="fa fa-book mr-3"></span> Courses</a>
	          </li>
	          <li>
              <a href="RequestStudent.aspx"><span class="fa fa-briefcase mr-3"></span> Request</a>
	          </li>
	          <li>
              <a href="GradStudent.aspx"><span class="fa fa-calendar-plus-o mr-3"></span> Graduation Plan</a>
	          </li>
	          <li>
              <a href="InstallmentStudent.aspx"><span class="fa fa-bank mr-3"></span> Installment</a>
	          </li>
	          <li>
              <a href="ExamsStudent.aspx"><span class="fa fa-sticky-note mr-3"></span> Exams</a>
	          </li>
	          <li>
              <a href="MakeupStudent.aspx"><span class="fa fa-plus mr-3"></span> Makeup register</a>
	          </li>
			  <li>
              <a href="SlotsStudent.aspx"><span class="fa fa-binoculars mr-3"></span>Courses' slots & instructors</a>
	          </li>
	          <li>
              <a href="InstructorStudent.aspx"><span class="fa fa-calendar mr-3"></span> Instructor's slots</a>
	          </li>
	          <li>
              <a href="ChooseStudent.aspx"><span class="fa fa-address-book-o mr-3"></span>Choose instructor</a>
	          </li>
	          <li>
              <a href="PreStudent.aspx"><span class="fa fa-bookmark mr-3"></span> Prerequiste courses</a>
	          </li>
	        </ul>

	        <div class="mb-5">
					</div>

	        <div class="footer">
	        </div>

	      </div>
    	</nav>

        <div id="content" class="p-4 p-md-5 pt-5">
    <h2 class="mb-4">Home</h2>
    <div style="font-family: 'Sitka Heading'; font-size: xx-large; font-weight: bolder; text-transform: uppercase; color: #000080;">
       
        First name:
       
        <asp:Label ID="studentNameLabel" runat="server" Text="First name: " ForeColor="#CC6600"></asp:Label>
        <br />
        Last name:
        <asp:Label ID="studentLNameLabel" runat="server" Text="Last name: " ForeColor="#CC6600"></asp:Label>
		<br />
		id:
		<asp:Label ID="studentIDLabel" runat="server" Text="ID: " ForeColor="#CC6600"></asp:Label>
		<br />
		gpa:
		<asp:Label ID="studentGPALabel" runat="server" Text="GPA: " ForeColor="#CC6600"></asp:Label>
		<br />
		faculty:
		<asp:Label ID="studentFacultyLabel" runat="server" Text="Faculty: " ForeColor="#CC6600"></asp:Label>
		<br />
		email:
		<asp:Label ID="studentEmailLabel" runat="server" Text="Email: " ForeColor="#CC6600"></asp:Label>
		<br />
		major:
		<asp:Label ID="studentMajorLabel" runat="server" Text="Major: " ForeColor="#CC6600"></asp:Label>
		<br />
		semester:
		<asp:Label ID="studentSemesterLabel" runat="server" Text="Semester: " ForeColor="#CC6600"></asp:Label>
		<br />
        Add phone number :<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="RegularExpressionValidator" ForeColor="Red" ValidationExpression="^\d{11}$">*</asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="RequiredFieldValidator" ForeColor="Red">*</asp:RequiredFieldValidator>
        <br />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;<br />
        <br />
        <asp:Label ID="Label1" runat="server" Font-Size="Small" ForeColor="#66FF33" Text="Done" Visible="False"></asp:Label>
        <asp:Label ID="Label2" runat="server" Font-Size="Small" ForeColor="Red" Text="Can not add phone number" Visible="False"></asp:Label>
        <asp:Button ID="Button1" runat="server" Text="ADD" class="small-button" OnClick="addPhone"/>
		<br />
        <asp:Button ID="Button2" runat="server" BackColor="Red" CausesValidation="False" class="small-button" OnClick="logout" Text="Logout" />
		<br />
        <!-- Add more labels or controls to display other student info -->
        <br />
       
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