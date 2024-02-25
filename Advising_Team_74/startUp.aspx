<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="startUp.aspx.cs" Inherits="Advising_Team_74.startUp" %>

<!DOCTYPE html>

<html lang="en" dir="ltr">
  <head runat="server">
    <meta charset="UTF-8">
    <!--<title> Login and Registration Form in HTML & CSS | CodingLab </title>-->
    <link rel="stylesheet" href="style3.css">
    <!-- Fontawesome CDN Link -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   </head>
<body>
    <form runat="server">
  <div class="container" style="width: 150%; margin: 0; padding: 1; overflow-x: hidden; overflow-y: hidden">
      <input type="checkbox" id="flip">
    <div class="cover">
      <div class="front">
        <img src="images/frontImg.jpg" alt="">
        <div class="text">
          <span class="text-1">Welcome to Student<br> Advising system portal</span>
          <span class="text-2">GUC</span>
        </div>
      </div>
        
      <div class="back">
        <img class="backImg" src="images/backImg.jpg" alt="">

        <div class="text">
          <span class="text-1">Welcome to Student <br> Advising system portal</span>
          <span class="text-2">GUC</span>
        </div>
      </div>
    </div>
    <div class="forms">
        <div class="form-content">
          <div class="login-form">
            <div class="title">Login</div>

            <div class="input-boxes">
              <div class="input-box">
                <i class="fas fa-envelope"></i>
                  <br />
                <input type="text" id="username" runat="server" placeholder="Enter your ID" />
              </div>
              <div class="input-box">
                <i class="fas fa-lock"></i>
                <input type="password" id="password" runat="server" placeholder="Enter your password" />
              </div>
                <div class="text">
                    <asp:Label ID="error" runat="server" Text="User ID or Password is not correct" ForeColor="Red" Visible="False"></asp:Label>
                </div>
                
              <div class="button input-box">
                <asp:Button ID="Button1" runat="server" OnClick="login" Text="Login" ValidationGroup="login" />
              </div>
              <asp:Button ID="Advisor" runat="server" CausesValidation="False" OnClick="advisorlog" Text="Advisor" style="position: absolute; top: 10px; left: 10px; padding: 10px 20px; background-color: #3498db; color: #fff; border: none; border-radius: 5px; font-size: 16px; cursor: pointer;"  />
              <div class="text sign-up-text"> <label for="flip">
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="username" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" SetFocusOnError="True" ValidationGroup="login">Id is missing</asp:RequiredFieldValidator>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="password" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" SetFocusOnError="True" ValidationGroup="login">password is missing</asp:RequiredFieldValidator>
                  &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="username" Display="Dynamic" ErrorMessage="RegularExpressionValidator" ForeColor="Red" ValidationExpression="\d+" ValidationGroup="login">ID should be a number</asp:RegularExpressionValidator>
                  <br />
                  </label>Don't have an account? <label for="flip">Sigup now</label></div>
            </div>
      </div>
                <div class="signup-form">
          <div class="title">Signup</div>
          <div class="input-boxes">
            <div class="input-box">
              <i class="fas fa-user"></i>
              <input type="text" id="firstName" placeholder="Enter your first name"  runat="server">
            </div>
            <div class="input-box">
              <i class="fas fa-user"></i>
              <input type="text" id="lastName" placeholder="Enter your last name"  runat="server">
            </div>
            <div class="input-box">
              <i class="fas fa-lock"></i>
              <input type="password" id="pass" placeholder="Enter your password"  runat="server">
            </div>
            
            <div class="input-box">
              <i class="fas fa-envelope"></i>
              <input type="text" id="email" placeholder="Enter your email"  runat="server">
            </div>
            <div class="input-box">
              <i class="fas fa-building"></i>
              <input type="text" id="faculty" placeholder="Enter your faculty"  runat="server">
            </div>
            <div class="input-box">
              <i class="fas fa-book"></i>
              <input type="text" id="major" placeholder="Enter your major"  runat="server">
            </div>
              <div class="input-box">
                <i class="fas fa-bars"></i>
                <input type="text" id="semester" placeholder="Enter your semester"  runat="server">
                </div>
              <div class="button input-box">
                <asp:Button ID="register" runat="server" OnClick="registers" Text="Register" ValidationGroup="reg" />
               </div>
              <div class="text sign-up-text"> 
                  <label for="flip">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>Already have an account? 
                  <label for="flip">
                  Login now<asp:Panel ID="Panel1" runat="server">
                      <label for="flip">
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="firstName" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" SetFocusOnError="True" ValidationGroup="reg">first name is missing</asp:RequiredFieldValidator>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="lastName" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" SetFocusOnError="True" ValidationGroup="reg">last name is missing</asp:RequiredFieldValidator>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="pass" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" SetFocusOnError="True" ValidationGroup="reg">password is missing</asp:RequiredFieldValidator>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="faculty" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" SetFocusOnError="True" ValidationGroup="reg">faculty is missing</asp:RequiredFieldValidator>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="email" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" ValidationGroup="reg">email is missing</asp:RequiredFieldValidator>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="major" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" SetFocusOnError="True" ValidationGroup="reg">major is missing</asp:RequiredFieldValidator>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="semester" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" SetFocusOnError="True" ValidationGroup="reg">semester is missing</asp:RequiredFieldValidator>
                      &nbsp;</label><asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="semester" ErrorMessage="RegularExpressionValidator" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d+" ValidationGroup="reg">Semester should be a number</asp:RegularExpressionValidator>
                  </asp:Panel>
                  </label></div>
            </div>
    </div>
    </div>
    </div>
  </div>
</form>
</body>
</html>
