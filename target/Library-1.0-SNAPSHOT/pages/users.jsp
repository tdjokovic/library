<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="data.UserType"%>
<%@page import="java.util.List"%>
<%@page import="api.dal.UserDAL"%>
<%@page import="models.UserModel"%>

<%
    if(session.getAttribute("auth") == null)
    {
        response.sendRedirect("../index.jsp");
        return;
    }
    UserModel user = UserDAL.getUserByID(Integer.parseInt(session.getAttribute("userID").toString()));
    List<UserModel> users = null;

    if (user.getUserTypeID() == UserType.BIBLIOTEKAR.getValue())
        users = UserDAL.getUsers(UserType.BIBLIOTEKAR.getValue(), user.getUserID());
    else
        users = UserDAL.getUsers(UserType.CITALAC.getValue(), user.getUserID());

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Korisnici</title>
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
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<body>
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="help.jsp"></jsp:include>+

<div class="container" style="margin-top: 9%">
    <div class="col-md-6">
        <h5 class="gold">Korisnici</h5>
        <table class="table">
            <tr>
                <th>Ime</th>
                <th>Prezime</th>
                <th>Email</th>
                <th></th>
            </tr>
            <%
                for(int i = 0 ; i < users.size(); i++)
                {
                    Integer userID = user.getUserID();
                    Integer otherUserID = users.get(i).getUserID();
            %>
            <tr>
                <td><%= users.get(i).getFirstName() %></td>
                <td><%= users.get(i).getLastName() %></td>
                <td><%= users.get(i).getEmail() %></td>
                <td>
                    <button onclick="sendMessage(<%= userID %>, <%= otherUserID%>)">Pošalji poruku</button>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

</div>

</body>

<script>
    function sendMessage(userID, otherUserID)
    {
        window.location.href = "../services/chatServices.jsp?addChat=&userID=" + userID + "&otherUserID=" + otherUserID;
    }

    function getTodaysDate()
    {
        const date = new Date();
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0'); // Months are zero-based
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        const seconds = String(date.getSeconds()).padStart(2, '0');

        return year+"-"+month+"-"+day+"-"+hours+"-"+minutes+"-"+seconds;
    }

</script>
</html>