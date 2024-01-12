<%@page import="com.google.gson.Gson"%>
<%@page import="api.dal.BookDAL"%>
<%@page import="models.BookModel"%>
<%@ page import="api.dal.LoanDAL" %>
<%@ page import="data.UserType" %>
<%@ page import="models.UserModel" %>
<%@ page import="api.dal.UserDAL" %>
<%@ page import="models.LoanModel" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="models.WaitlistModel" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.swing.text.DateFormatter" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%

    int bookID = Integer.parseInt(request.getParameter("bookId").toString());

    BookModel book = BookDAL.getBookByID(bookID);
    boolean auth = true;

    if (session.getAttribute("auth") == null)
        auth = false;

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title><%= book.getName() %></title>
    <link rel="apple-touch-icon" sizes="180x180" href="favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="favicons/favicon-16x16.png">
    <link rel="manifest" href="favicons/manifest.json">
    <link rel="mask-icon" href="favicons/safari-pinned-tab.svg" color="#5bbad5">
    <link rel="shortcut icon" href="favicons/favicon.ico">
    <meta name="msapplication-config" content="favicons/browserconfig.xml">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/styles.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="help.jsp"></jsp:include>

<input type="hidden" id="bookID" value="<%= bookID %>">
<div style="text-align:center; margin-top: 10%" class="container book padding-1x">

    <section class="container padding-1x">
        <h3><%= book.getName() %></h3>

        <img alt="" style="height: 300px; width: auto" src=<%= "../images/books/" +book.getImages().get(0) %>>

        <h4 style="margin-top: 15px">
            <span><%= book.getAuthorFirstName() %></span>
            <span><%= book.getAuthorLastName() %></span>
        </h4>

        <span class="text-center"><%= book.getDescription() %></span>

        <section class="row" style="margin: auto; margin-top: 20px">
            <%-- // TODO add the case where he's already applied, or he's on the waitlist! should not be displayed  --%>
            <%
                if(auth)
                {
                    int userID = Integer.parseInt(session.getAttribute("userID").toString());
                    UserModel user = UserDAL.getUserByID(userID);

                    if(user.getUserTypeID() == UserType.BIBLIOTEKAR.getValue())
                    {
                        // todo prikazi mu ko je zaduzio trenutno kao i tabelu waitliste
                        LoanModel currentLoan = LoanDAL.getCurrentLoaner(bookID);
                        if(currentLoan != null)
                        {
                            String userFullName = currentLoan.getUser().getFirstName() + " " + currentLoan.getUser().getLastName();
                            LocalDate loanDate = currentLoan.getLoanDate();
                            LocalDate returnDate = currentLoan.getReturnDate();
                            Integer loanID = currentLoan.getLoanID();
                        %>
                            <p>Trenutna pozajmica:</p>
                            <table>
                                <tr>
                                    <td><%= userFullName %></td>
                                    <td><%= loanDate %></td>
                                    <td><%= returnDate %></td>
                                    <td><button onclick="resolveLoan(<%= loanID %>, <%= bookID %>)">Razduži zajam</button></td>
                                </tr>
                            </table>
                        <%
                        }

                        List<WaitlistModel> currentWaitlist = LoanDAL.getCurrentWaitlist(bookID);
                        if(!currentWaitlist.isEmpty())
                        {
                        %>
                            <p>Lista čekanja:</p>
                            <table>
                                <thead>
                                    <td>Ime i prezime</td>
                                    <td>Pozicija</td>
                                    <td></td>
                                </thead>
                                <tbody>
                                    <%
                                        for(int i = 0; i < currentWaitlist.size() ; i++)
                                        {
                                            Integer waitID = currentWaitlist.get(i).getWaitlistID();
                                            String fullName = currentWaitlist.get(i).getUser().getFirstName() + " " + currentWaitlist.get(i).getUser().getLastName();
                                            Integer position = currentWaitlist.get(i).getPosition();
                                    %>
                                            <tr>
                                                <td><%= fullName %></td>
                                                <td><%= position %></td>
                                                <td><button onclick="resolveWait(<%= waitID %>, <%= position %>, <%= bookID %>)">Otkaži čekanje</button></td>
                                            </tr>
                                        <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        <%
                        }
                    }
                    else if(user.getUserTypeID() == UserType.CITALAC.getValue())
                    {
                        if(book.getAvailability() && LoanDAL.getWaitlistCount(bookID) == 0)
                        {
                        %>
                            <button onclick="makeLoan(<%= book.getBookID()%>)">
                                Zaduži knjigu
                            </button>
                        <%
                        }
                        else
                        {
                            LocalDate returnDate = LoanDAL.checkIfILoaned(userID, bookID);
                            if(returnDate != null)
                            {
                                Locale locale = new Locale("sr", "RS", "Latn");
                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d. MMMM yyyy.", locale);
                                String formattedDate = returnDate.format(formatter);
                            %>
                                <p style="color: darkred">Trenutno ste iznajmili ovu knjigu.</p>
                                <p>Rok za vraćanje knjige: <%= formattedDate %></p>
                            <%
                            }
                            else
                            {
                                // TODO dodaj ako je nulti na listi cekanja to znaci da knjiga vise nije pozajmljena da
                                // TODO moze sada on da je iznajmi
                                // TODO ako je waitlist 0 tj
                                Integer waitlist = LoanDAL.checkIfImWaiting(userID,bookID);
                                if(waitlist != -1)
                                {
                                    if(waitlist == 0 && LoanDAL.getCurrentLoaner(bookID) == null)
                                    {
                                    %>
                                        <p style="color: darkorange">Došli ste na red za ovu knjigu!</p>
                                        <button onclick="makeLoan(<%= book.getBookID()%>)">
                                            Zaduži knjigu
                                        </button>
                                    <%
                                    }
                                    else
                                    {
                                    %>
                                        <p style="color: darkorange">Vaša rezervacija je trenutno <%=waitlist%>. na listi za ovu knjigu.</p>
                                        <button onclick="withdrawWaitlist(<%= book.getBookID()%>, <%= waitlist %>)">
                                            Odustani od rezervacije
                                        </button>
                                    <%
                                    }
                                }
                                else
                                {
                                    Integer waitlistCount = LoanDAL.getWaitlistCount(bookID);
                                    %>
                                    <p style="color: darkorange">Broj osoba na listi čekanja: <%= waitlistCount %></p>
                                    <button onclick="applyToWaitlist(<%= book.getBookID()%>)">
                                        Rezerviši knjigu
                                    </button>
                                    <%
                                }
                            }
                        }
                    }
                }
            %>
        </section>
    </section>

</div>
<script type="text/javascript">
    console.log(request)
</script>
</body>
<%
    if (request.getParameter("succLoan") != null)
    {
%>
    <script type="text/javascript">
        console.log('aaaa');
        alert("Uspešno ste uzeli na zajam knjigu " + <%= book.getName() %>);
    </script>

<%
    }
    else if(request.getParameter("succWaitlist") != null)
    {
%>
    <script type="text/javascript">
        alert("Uspešno ste se prijavili na red čekanja za knjigu " + <%= book.getName() %>);
    </script>
<%
    }
%>
<script>
    function makeLoan(bookID)
    {
        window.location.href = "../services/bookLoanServices.jsp?loan=&bookID=" +bookID;
    }

    function applyToWaitlist(bookID)
    {
        window.location.href = "../services/bookLoanServices.jsp?waitlist=&bookID=" +bookID;
    }

    function resolveLoan(loanID, bookID)
    {
        window.location.href = "../services/bookLoanServices.jsp?resolveLoan=&loanID=" +loanID + "&bookID=" +bookID;
    }

    function resolveWait(waitID, position, bookID)
    {
        window.location.href = "../services/bookLoanServices.jsp?resolveWait=&waitID=" +waitID + "&position=" + position + "&bookID=" +bookID;
    }

    function withdrawWaitlist(bookID, position) {
        window.location.href = "../services/bookLoanServices.jsp?withdrawWait=&bookID=" + bookID + "&position=" + position;
    }

</script>
</html>