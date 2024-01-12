<%
    if (request.getParameter("filter") != null)
    {
        String filter = request.getParameter("filter").toString();

        response.sendRedirect("../pages/books.jsp?filter=" +filter);
    }
%>