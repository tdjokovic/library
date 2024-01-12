<%@page import="data.Config"%>
<%@page import="api.dal.BookDAL"%>
<%@page import="models.BookModel"%>
<%@page import="java.util.List"%>
<%@ page import="api.dal.LoanDAL" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
    String filter = "";
    if (request.getParameter("filter") != null)
        filter = request.getParameter("filter").toString();

    boolean auth = true;
    if (session.getAttribute("auth") == null)
        auth = false;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Pretraži naslove</title>
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
<body onload="<%= "filterBooks(" + auth + ");" %>">
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="help.jsp"></jsp:include>

<input type="hidden" id="imagePath" value="<%= Config.imagesPath %>">
<input type="hidden" id="booksImagesPath" value="<%= Config.booksImagesPath %>">
<div class="container padding-2x">
    <div class="row" style="text-align: center; padding-top: 10px">
        <input style="margin-bottom: 2%" type="search" id="filterInput" onkeyup="<%= "filterBooks(" + auth + ");" %>" placeholder="Pretražite knjige">
    </div>
    <div id="books"></div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

</body>
<script>

    function filterOnKeyUp()
    {
        var text = document.getElementById('filterInput').value;
        window.location.href = "../services/bookServices.jsp?filter=" +text;
    }

    function filterBooks(auth)
    {
        var imagesPerRow = 4;
        var imagesPerPage = 12;
        var x = new XMLHttpRequest();
        x.onreadystatechange = function()
        {
            // TODO optimizuj pretrazivanje i dodaj paginaciju
            if (x.readyState == 4 && x.status == 200)
            {
                var books = JSON.parse(x.responseText);
                var str = "";
                var waitlistPromises = [];
                var globalIndex, book;

                for (i = 0; i < books.length / imagesPerRow; i++)
                {
                    str += "<div class='row book'>";

                    for (j = 0; j < imagesPerRow && (i * imagesPerRow + j) < books.length; j++)
                    {
                        globalIndex = i * imagesPerRow + j;
                        book = books[globalIndex];

                        str += "<div class='col-lg-3 col-md-3 col-xs-3 thumb'>";
                        str += "<a class='thumbnail' style='margin-bottom: 0px;' href='book.jsp?bookId=" +book.bookID +"'>";
                        str += "<img class='img-responsive' src='../" +document.getElementById('imagePath').value + document.getElementById('booksImagesPath').value + book.images[0] +"'  alt=''>";
                        str += "</a>";
                        str += "<h4 class='muted' style='text-align: center;'>" + book.name +"</h4>";
                        str += "<h5 style='text-align: center;'>" + book.authorFirstName + " "+ book.authorLastName +"</h5>";
                        if (auth) {
                            // Make a separate request to fetch waitlist count
                            waitlistPromises.push(getWaitlistCount(book.bookID));
                            str += "<div id='book-" + book.bookID +"' ></div>";
                        }
                        str += "</div>";
                    }
                    str += "</div>";
                }

                Promise.all(waitlistPromises)
                    .then(function (waitlistCounts) {
                        // Iterate through waitlistCounts and update the UI
                        waitlistCounts.forEach(({bookID, count}, index) => {
                            var av = "<h6 style='text-align: center;'>" + checkAvailability(books[index].availability, count) + "</h6>";
                            document.getElementById("book-" + bookID).innerHTML = av;
                        });

                        // Update the UI after all asynchronous operations are done
                    });

                function getWaitlistCount(bookID) {
                    return new Promise((resolve, reject) => {
                        var waitlistRequest = new XMLHttpRequest();
                        waitlistRequest.onreadystatechange = function() {
                            if (waitlistRequest.readyState == 4 && waitlistRequest.status == 200) {
                                var waitlistCount = parseInt(waitlistRequest.responseText);
                                resolve({
                                    'bookID': bookID,
                                    'count': waitlistCount
                                });
                            }
                        };

                        // Adjust the URL and method based on your server-side implementation
                        waitlistRequest.open("GET", "../waitlistCount?bookID=" + bookID, true);
                        waitlistRequest.send();
                    })
                }

                document.getElementById("books").innerHTML = str;
            }
        };

        var filterText = document.getElementById("filterInput").value;
        x.open("get", "../filterBooks?filter=" +filterText, true);
        x.send();
    }

    function checkAvailability(available, waitlistCount)
    {
        if(available)
        {
            if(waitlistCount)
            {
                return "<span style='color:darkorange'>Dostupno za rezervaciju</span>"
            }
            return "<span style='color:green'>Dostupno</span>"
        }
        else
        {
            return "<span style='color:darkorange'>Dostupno za rezervaciju</span>"
        }
    }
</script>
</html>