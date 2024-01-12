<%@ page import="api.dal.LoanDAL" %>
<%
    int userID = Integer.parseInt(session.getAttribute("userID").toString());
    int bookID = Integer.parseInt(request.getParameter("bookID").toString());

    if (request.getParameter("loan") != null)
    {
        LoanDAL.addLoan(userID, bookID);
        response.sendRedirect("../pages/book.jsp?bookId=" +bookID +"&succLoan=");
    }
    else if (request.getParameter("waitlist") != null)
    {
        LoanDAL.addWait(userID, bookID);
        response.sendRedirect("../pages/book.jsp?bookId=" +bookID +"&succWaitlist=");
    }
    else if (request.getParameter("resolveLoan") != null)
    {
        int loanID = Integer.parseInt(request.getParameter("loanID").toString());
        LoanDAL.resolveLoan(loanID, bookID);
        response.sendRedirect("../pages/book.jsp?bookId=" +bookID +"&succRemoveLoan=");
    }
    else if (request.getParameter("resolveWait") != null)
    {
        int waitID = Integer.parseInt(request.getParameter("waitID").toString());
        int position = Integer.parseInt(request.getParameter("position").toString());
        LoanDAL.resolveWait(bookID, waitID, position);
        response.sendRedirect("../pages/book.jsp?bookId=" +bookID +"&succRemoveWait=");
    }
    else if (request.getParameter("withdrawWait") != null)
    {
        int position = Integer.parseInt(request.getParameter("position").toString());
        LoanDAL.withdrawWaitlist(bookID, userID, position);
        response.sendRedirect("../pages/book.jsp?bookId=" +bookID +"&succWithdrawWait=");
    }
    else if ( request.getParameter("waitlistCount") != null)
    {

    }
%>