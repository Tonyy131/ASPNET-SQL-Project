<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InCA.aspx.cs" Inherits="Advising_Team_74.InCA" %>

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
    <h2 class="mb-4">Insert courses: </h2>
    <div style="font-family: 'Sitka Heading'; font-size: xx-large; font-weight: bolder; text-transform: uppercase; color: #000080;">
       
       student id : <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="sid" Display="Dynamic" ErrorMessage="RegularExpressionValidator" ForeColor="Red" ValidationExpression="\d+" ValidationGroup="course">*</asp:RegularExpressionValidator>
		<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="sid" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="course">*</asp:RequiredFieldValidator>
		<br /> <asp:TextBox ID="sid" class="custom-textbox" runat="server"></asp:TextBox> <br />
		semester code :
		<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="code" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="course">*</asp:RequiredFieldValidator>
		<br /> <asp:TextBox ID="code" class="custom-textbox" runat="server"></asp:TextBox> 
        <br />
        course name :
		<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cname" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="course">*</asp:RequiredFieldValidator>
		<br /> <asp:TextBox ID="cname" class="custom-textbox" runat="server"></asp:TextBox> <br />
		<asp:Label ID="Label1" runat="server" Font-Size="Small" ForeColor="#66FF33" Text="Course is added successfully" Visible="False"></asp:Label>
		&nbsp;<asp:Label ID="Label2" runat="server" Font-Size="Small" ForeColor="Red" Text="Course Can not be added" Visible="False"></asp:Label>
		<br />
		<asp:Button ID="RequestCourse" class="small-button" runat="server" Text="add" OnClick="Insert_Courses_GP" ValidationGroup="course" />
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
