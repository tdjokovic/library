<%
  if(session.getAttribute("auth") != null)
  {
    response.sendRedirect("../index.jsp");
    return;
  }

  String firstName, lastName, email;

  firstName = request.getParameter("firstName");
  lastName = request.getParameter("lastName");
  email = request.getParameter("email");

  if (firstName == null || firstName.equals("null"))
    firstName = "";
  if (email == null || email.equals("null"))
    email = "";
  if (lastName == null || lastName.equals("null"))
    lastName = "";
%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="ISO-8859-1">
  <title>Registracija</title>
  <link rel="apple-touch-icon" sizes="180x180" href="favicons/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="favicons/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="favicons/favicon-16x16.png">
  <link rel="manifest" href="favicons/manifest.json">
  <link rel="mask-icon" href="favicons/safari-pinned-tab.svg" color="#5bbad5">
  <link rel="shortcut icon" href="favicons/favicon.ico">
  <meta name="msapplication-config" content="favicons/browserconfig.xml">
</head>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/styles.css" rel="stylesheet">
<body>
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="help.jsp"></jsp:include>

<div class="container padding-2x" style="background-color: grey; border-radius: 5px; padding-bottom: 5px;">
  <div class="col-md-4 col-md-offset-4">
    <form method="post" action="../services/userServices.jsp?registration=">
      <table class="table">
        <tr>
          <td style="color: white;">Ime:</td>
          <td><input value="<%= firstName %>" type="text" name="firstName"></td>
        </tr>
        <tr>
          <td style="color: white;">Prezime:</td>
          <td><input value="<%= lastName %>" type="text" name="lastName"></td>
        </tr>
        <tr>
          <td style="color: white;">Email:</td>
          <td><input value="<%= email %>" type="text" name="email"></td>
        </tr>
        <tr>
          <td style="color: white;">Lozinka:</td>
          <td><input type="password" name="password"></td>
        </tr>
        <tr>
          <td style="color: white;">Ponovite lozinku:</td>
          <td><input type="password" name="password2"></td>
        </tr>
        <tr>
          <td></td>
          <td><input type="submit" value="Registracija"></td>
        </tr>
      </table>
    </form>
  </div>
</div>

<div class="col-md-4 col-md-offset-4">
  <%
    if (request.getParameter("dataError") != null)
    {
  %>
  <p style="color: red; font-weight: bold;">Morate uneti sve podatke!</p>
  <%
  }
  else if (request.getParameter("passError") != null)
  {
  %>
  <p style="color: red; font-weight: bold;">Lozinke se ne poklapaju!</p>
  <%
    }
  %>
</div>
</body>
</html>