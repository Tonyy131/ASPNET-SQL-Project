<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mainPageAdvisor.aspx.cs" Inherits="Advising_Team_74.mainPageAdvisor" %>

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
    <h2 class="mb-4">Home</h2>
    <div style="font-family: 'Sitka Heading'; font-size: xx-large; font-weight: bolder; text-transform: uppercase; color: #000080;">
       
        Name:
       
        <asp:Label ID="NameLabel" runat="server" Text="Name: " ForeColor="#CC6600"></asp:Label>
        <br />
		id:
		<asp:Label ID="IDLabel" runat="server" Text="ID: " ForeColor="#CC6600"></asp:Label>
		<br />
		email:
		<asp:Label ID="studentEmailLabel" runat="server" Text="Email: " ForeColor="#CC6600"></asp:Label>
		<br />
		Office:
		<asp:Label ID="officeLabel" runat="server" Text="office: " ForeColor="#CC6600"></asp:Label>
		<br />
        <!-- Add more labels or controls to display other student info -->
        <asp:Button ID="Button1" runat="server" BackColor="Red" class="small-button" OnClick="logout" Text="Logout" />
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