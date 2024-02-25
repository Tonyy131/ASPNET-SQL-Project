<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MakeupStudent.aspx.cs" Inherits="Advising_Team_74.MakeupStudent" %>

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
    <h2 class="mb-4">Makeup exam registeration</h2>
			
			<div style="font-family: 'Sitka Heading'; font-size: xx-large; font-weight: bolder; text-transform: uppercase; color: #000080;">
				 register for first makeup:<br />

 Course ID:
<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="courseID" Display="Dynamic" ErrorMessage="RegularExpressionValidator" ForeColor="Red" ValidationExpression="\d+" ValidationGroup="course">*</asp:RegularExpressionValidator>
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="courseID" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="course">*</asp:RequiredFieldValidator>
<br /> <asp:TextBox ID="courseID" class="custom-textbox" runat="server"></asp:TextBox>
<br />
<asp:Label ID="Label1" runat="server" Font-Size="Small" ForeColor="#66FF33" Text="You have successfully registerd for the first makeup exam" Visible="False"></asp:Label>
&nbsp;<asp:Label ID="Label3" runat="server" Font-Size="Small" ForeColor="Red" Text="you can't register for this course first makeup" Visible="False"></asp:Label>
<br />
<asp:Button ID="RequestCourse" class="small-button" runat="server" Text="Register" OnClick="firstMake" ValidationGroup="course" />


<br />
register for second makeup:<br />
Course id: <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="scid" Display="Dynamic" ErrorMessage="RegularExpressionValidator" ForeColor="Red" ValidationExpression="\d+" ValidationGroup="credit">*</asp:RegularExpressionValidator>
<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="scid" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="credit">*</asp:RequiredFieldValidator>
<br /> <asp:TextBox ID="scid" class="custom-textbox" runat="server"></asp:TextBox>
<br />
<asp:Label ID="Label2" runat="server" Font-Size="Small" ForeColor="#66FF33" Text="You have successfully registerd for the second makeup exam" Visible="False"></asp:Label>
&nbsp;<asp:Label ID="Label4" runat="server" Font-Size="Small" ForeColor="Red" Text="you can't register for this course second makeup" Visible="False"></asp:Label>
<br />
<asp:Button ID="RequestCreditHours" class="small-button" runat="server" Text="Register" OnClick="secondMake" ValidationGroup="credit" />


</div>
		</div>

    <script src="js/jquery.min.js"></script>
    <script src="js/popper.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
            </div>
    
       
       
       
    <!-- Additional content or formatting here -->
		
		

        </form>
  </body>
</html>