<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SlotsStudent.aspx.cs" Inherits="Advising_Team_74.SlotsStudent" %>

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
						<form action="#" class="subscribe-form">
	            
	          </form>
					</div>

	        <div class="footer">
	        </div>

	      </div>
    	</nav>

        <div id="content" class="p-4 p-md-5 pt-5">
    <h2 class="mb-4">Courses&#39; slots &amp; instructors</h2>
						<br />
			<br />
				<form id="form1" runat="server">
	<asp:GridView ID="YourGridView" CssClass="grid-container" runat="server" ClientIDMode="Static" AutoGenerateColumns="true" OnSelectedIndexChanged="YourGridView_SelectedIndexChanged"></asp:GridView>
</form>
		</div>

    <script src="js/jquery.min.js"></script>
    <script src="js/popper.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
  </body>
</html>