<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="link2.aspx.cs" Inherits="Advising_Team_74.link2" %>


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
	          <li>
	            <a href="mainPageAdmin.aspx"><span class="fa fa-address-book-o mr-3"></span> All advisors</a>
	          </li>
	          <li>
	              <a href="students.aspx"><span class="fa fa-address-book mr-3"></span> All Students</a>
	          </li>
	          <li>
              <a href="pending.aspx"><span class="fa fa-bookmark mr-3"></span> All pending requests</a>
	          </li>
	          <li>
              <a href="addSem.aspx"><span class="fa fa-plus mr-3"></span> Add new semester</a>
	          </li>
	          <li>
              <a href="addCourse.aspx"><span class="fa fa-plus mr-3"></span> Add new course</a>
	          </li>
	          <li>
              <a href="link.aspx"><span class="fa fa-link mr-3"></span> Link instructor</a>
	          </li>
				<li>
				<a href="link1.aspx"><span class="fa fa-link mr-3"></span> Link student to advisor</a>
				</li>
				<li class="active">
				<a href="link2.aspx"><span class="fa fa-link mr-3"></span> Link student to course</a>
				</li>
	          <li>
              <a href="viewIns.aspx"><span class="fa fa-binoculars mr-3"></span> View Instructos' courses</a>
	          </li>
			  <li>
              <a href="viewSem.aspx"><span class="fa fa-binoculars mr-3"></span>View semesters' courses</a>
	          </li>
	          <li>
              <a href="delete.aspx"><span class="fa fa-ban mr-3"></span> Delete</a>
	          </li>
								<li>
				<a href="delete1.aspx"><span class="fa fa-ban mr-3"></span> Delete slots</a>
				</li>
	          <li>
              <a href="addExam.aspx"><span class="fa fa-plus mr-3"></span>Add Exam</a>
	          </li>
	          <li>
              <a href="viewPay.aspx"><span class="fa fa-arrows mr-3"></span> View payments</a>
	          </li>
			  <li>
			  <a href="issueInst.aspx"><span class="fa fa-plus mr-3"></span> Issue Installments</a>
			  </li>
			  <li>
			  <a href="updateStd.aspx"><span class="fa fa-bolt mr-3"></span> Update Student Status</a>
			  </li>
											  <li>
			  <a href="viewSTD.aspx"><span class="fa fa-binoculars mr-3"></span> View All students</a>
			  </li>
			  <li>
			  <a href="viewGP.aspx"><span class="fa fa-binoculars mr-3"></span> View Graduation Plans</a>
			  </li>
			  <li>
			  <a href="viewTran.aspx"><span class="fa fa-binoculars mr-3"></span> View transcripts</a>
			  </li>				
			</ul>

	        <div class="mb-5">
						<form action="#" class="subscribe-form">
	            
	          </form>
					</div>

	        <div class="footer">
	        </div>

	      </div>
    	</nav>

        <div id="content" class="p-4 p-md-5 pt-5">
    <h2 class="mb-4">Link student to course & instructor :</h2>
    <div style="font-family: 'Sitka Heading'; font-size: xx-large; font-weight: bolder; text-transform: uppercase; color: #000080;">
        <form id="form1" runat="server">
		    course id:<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ins" ErrorMessage="RequiredFieldValidator" ForeColor="Red">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="ins" ErrorMessage="RegularExpressionValidator" ForeColor="Red" ValidationExpression="\d+">*</asp:RegularExpressionValidator>
            <br />
            <asp:TextBox ID="ins" runat="server" class="custom-textbox"></asp:TextBox>
		    <br />
            instructor id:<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" ErrorMessage="RequiredFieldValidator" ForeColor="Red">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox2" ErrorMessage="RegularExpressionValidator" ForeColor="Red" ValidationExpression="\d+">*</asp:RegularExpressionValidator>
            <br />
            <asp:TextBox ID="TextBox2" runat="server" class="custom-textbox"></asp:TextBox>
            <br />
		    student id:<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox3" ErrorMessage="RequiredFieldValidator" ForeColor="Red">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox3" ErrorMessage="RegularExpressionValidator" ForeColor="Red" ValidationExpression="\d+">*</asp:RegularExpressionValidator>
            <br />
            <asp:TextBox ID="TextBox3" runat="server" class="custom-textbox"></asp:TextBox>
            <br />
            semester code:<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox4" ErrorMessage="RequiredFieldValidator" ForeColor="Red">*</asp:RequiredFieldValidator>
            <br />
            <asp:TextBox ID="TextBox4" runat="server" class="custom-textbox"></asp:TextBox>
            <br />
		    <asp:Label ID="Label1" runat="server" ForeColor="#66FF33" Text="DONE" Visible="False" Font-Size="Small"></asp:Label>
            <asp:Label ID="Label2" runat="server" Font-Size="Small" ForeColor="Red" Text="Can not link the student" Visible="False"></asp:Label>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Link" class="small-button" OnClick="Link_student_to_course_and_instructor" Height="74px"/>
		</form>
       
    <!-- Additional content or formatting here -->
</div>
		</div>

    <script src="js/jquery.min.js"></script>
    <script src="js/popper.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
  </body>
</html>