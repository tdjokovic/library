<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="data.UserType"%>
<%@page import="java.util.List"%>
<%@page import="api.dal.UserDAL"%>
<%@page import="models.UserModel"%>
<%@ page import="api.dal.LoanDAL" %>
<%@ page import="models.LoanModel" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="models.WaitlistModel" %>

<%
    if(session.getAttribute("auth") == null)
    {
        response.sendRedirect("../index.jsp");
        return;
    }
    UserModel user = UserDAL.getUserByID(Integer.parseInt(session.getAttribute("userID").toString()));
    List<LoanModel> loans = LoanDAL.getLoansForUser(user.getUserID());
    List<WaitlistModel> waits = LoanDAL.getWaitsForUser(user.getUserID());
    List<UserModel> users = null;

    if (user.getUserTypeID() == UserType.BIBLIOTEKAR.getValue())
        users = UserDAL.getUsers(UserType.CITALAC.getValue(), user.getUserID());

    // --------------- za formu -----------------
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
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Profil</title>
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
<jsp:include page="help.jsp"></jsp:include>

<div class="container" style="margin-top: 9%">
    <div class="col-md-6">
        <h5 class="gold">Lični podaci:</h5>
        <form method="post" action="">
            <table>
                <tr>
                    <td><strong>Ime:</strong></td>
                    <td><div style="width: 25px"></div></td>
                    <td><%= user.getFirstName() %></td>
                </tr>
                <tr>
                    <td><strong>Prezime:</strong></td>
                    <td><div style="width: 25px"></div></td>
                    <td><%= user.getLastName() %></td>
                </tr>
                <tr>
                    <td><strong>Email:</strong></td>
                    <td><div style="width: 25px"></div></td>
                    <td><%= user.getEmail() %></td>
                </tr>
            </table>
        </form>
        <br>
        <a style="margin: 1px" href="inbox.jsp" class="btn">Moje poruke</a>
    </div>
</div>
<hr>
<br>

<%
    if(user.getUserTypeID() == UserType.CITALAC.getValue())
    {
        %>
        <div class="container">
            <div class="col-md-6">
                <h5 class="gold">Istorija zaduženja:</h5>
                <table class="table">
                    <tr>
                        <th>Naslov</th>
                        <th>Autor</th>
                        <th>Datum iznajmljivanja</th>
                        <th>Datum vraćanja</th>
                    </tr>
                    <%
                        if(loans.size() == 0)
                        {
                    %>
                    <tr>
                        <td colspan="4" class="text-center">Još uvek nemate zaduženih knjiga</td>
                    </tr>
                    <%
                        }
                        for (int i = 0; i < loans.size(); i++)
                        {
                            String bookName = loans.get(i).getBook().getName();
                            String author = loans.get(i).getAuthor().getFirstName() + " " + loans.get(i).getAuthor().getLastName();
                            LocalDate loanDate = loans.get(i).getLoanDate();
                            LocalDate returnData = loans.get(i).getReturnDate();
                    %>
                    <tr>
                        <td><%= bookName %></td>
                        <td><%= author %></td>
                        <td><%= loanDate %></td>
                        <td><%= returnData %></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
        </div>

        <div class="container">
            <div class="col-md-6">
                <h5 class="gold">Na čekanju:</h5>
                <table class="table">
                    <tr>
                        <th>Naslov</th>
                        <th>Autor</th>
                        <th>Pozicija</th>
                        <th></th>
                    </tr>
                    <%
                        if(waits.size() == 0)
                        {
                    %>
                    <tr>
                        <td colspan="4" class="text-center">Nemate aktivnih rezervacija.</td>
                    </tr>
                    <%
                        }
                        for (int i = 0; i < waits.size(); i++)
                        {
                            Integer bookID = waits.get(i).getBook().getBookID();
                            String bookName = waits.get(i).getBook().getName();
                            String author = waits.get(i).getAuthor().getFirstName() + " " + waits.get(i).getAuthor().getLastName();
                            Integer position = waits.get(i).getPosition();
                    %>
                    <tr>
                        <td><%= bookName %></td>
                        <td><%= author %></td>
                        <%
                            if(position == 0)
                            {
                            %>
                                <td>Došli ste na red!</td>
                                <td>
                                    <button onclick="makeLoan(<%= bookID %>)">
                                        Zaduži knjigu
                                    </button>
                                </td>
                            <%
                            }
                            else
                            {
                            %>
                                <td>
                                    <%=position%>
                                </td>
                            <%
                            }
                        %>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
        </div>
        <%
    }
    else if(user.getUserTypeID() == UserType.BIBLIOTEKAR.getValue())
    {
%>
<div class="container">
    <div class="col-md-6">
        <h5 class="gold">Korisnici:</h5>
        <table class="table">
            <tr>
                <th>Ime</th>
                <th>Prezime</th>
                <th>Email</th>
                <th></th>
            </tr>
            <%
                for (int i = 0; i < users.size(); i++)
                {
            %>
            <tr>
                <td><%= users.get(i).getFirstName() %></td>
                <td><%= users.get(i).getLastName() %></td>
                <td><%= users.get(i).getEmail() %></td>
                <td><a href=<%= "../services/userServices.jsp?deleteUser=" +users.get(i).getUserID() %>><i class="material-icons">delete</i></a></td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</div>
<%
    }
%>
</body>

<script>
    function makeLoan(bookID)
    {
        window.location.href = "../services/bookLoanServices.jsp?loan=&bookID=" +bookID;
    }
</script>
</html>