<%
    if(session.getAttribute("auth") != null)
    {
        response.sendRedirect("../index.jsp");
        return;
    }

    String email = "";

    if (request.getParameter("email") != null)
        email = request.getParameter("email");

    if (email.equals("null"))
        email = "";
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Prijava</title>
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

<div class="container padding-2x" style="background-color: gray; border-radius: 5px; padding-bottom: 5px;">
    <div class="col-md-4 col-md-offset-4">
        <form method="post" action="../services/userServices.jsp?login=">
            <table class="table">
                <tr>
                    <td style="color: white;">Email:</td>
                    <td><input type="text" value="<%= email %>" name="email"></td>
                </tr>
                <tr>
                    <td style="color: white;">Lozinka:</td>
                    <td><input type="password" name="password"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Prijavi me"></td>
                </tr>
            </table>
        </form>
    </div>
</div>


<div class="col-md-4 col-md-offset-4">
    <%
        if (request.getParameter("error") != null)
        {
    %>
    <p style="color: red; font-weight: bold;">Pogrešna kombinacija email/lozinka!</p>
    <%
        }
    %>
</div>
</body>
</html>