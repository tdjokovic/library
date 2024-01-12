<%@ page import="api.dal.MessageDAL" %><%
    if (request.getParameter("addChat") != null)
    {
        Integer userID = Integer.parseInt(request.getParameter("userID").toString());
        Integer newChatUserID = Integer.parseInt(request.getParameter("otherUserID").toString());
        MessageDAL.addNewChat(userID, newChatUserID);
        MessageDAL.addNewChat(newChatUserID, userID);
        response.sendRedirect("../pages/inbox.jsp");
    }
%>