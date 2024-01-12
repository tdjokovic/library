<%@page import="java.util.Date"%>
<%@page import="data.Config"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="socketModels.UserMessage"%>
<%@page import="api.dal.UserDAL"%>
<%@page import="models.UserModel"%>
<%@ page import="java.net.Socket" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.OutputStreamWriter" %>
<%
    if (request.getParameter("login") != null)
    {
%>
<jsp:useBean id="userLogin" class="models.UserModel" />
<jsp:setProperty property="*" name="userLogin"/>
<%

    UserModel user = UserDAL.checkLogin(userLogin.getEmail(), userLogin.getPassword());

    if (user == null)
        response.sendRedirect("../pages/login.jsp?error&email=" +userLogin.getEmail());
    else
    {
        session.setAttribute("auth", true);
        session.setAttribute("role", user.getUserTypeID());
        session.setAttribute("userID", user.getUserID());
        session.setAttribute("firstName", user.getFirstName());

        // prijavi se na server
        if (session.getAttribute("br") == null)
        {
            Socket socket = new Socket(InetAddress.getByName("localhost"), Config.port);
            BufferedReader br = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));

            session.setAttribute("br", br);
            session.setAttribute("bw", bw);

            UserMessage msg = new UserMessage(Integer.parseInt(session.getAttribute("userID").toString()) , 1, "prijava", Config.sdf.format(new Date())); // prijava na server
            bw.write(msg.toString() +"\n");
            bw.flush();
        }

        response.sendRedirect("../index.jsp");
    }
}
else if (request.getParameter("registration") != null)
{
%>
<jsp:useBean id="userReg" class="models.UserModel" />
<jsp:setProperty property="*" name="userReg"/>
<%

    if (userReg.getFirstName() == null || userReg.getLastName() == null || userReg.getEmail() == null || userReg.getPassword() == null || userReg.getPassword2() == null)
        response.sendRedirect("../pages/registration.jsp?dataError&firstName=" +userReg.getFirstName() +"&lastName=" +userReg.getLastName() +"&email=" +userReg.getEmail());
    else if (!userReg.checkPasswords())
        response.sendRedirect("../pages/registration.jsp?passError&firstName=" +userReg.getFirstName() +"&lastName=" +userReg.getLastName() +"&email=" +userReg.getEmail());
    else
    {
        UserDAL.addNewUser(userReg, false);
        response.sendRedirect("../pages/login.jsp");
    }
}
else if (request.getParameter("logout") != null)
{
    if (session.getAttribute("bw") != null)
    {
        UserMessage msg = new UserMessage(Integer.parseInt(session.getAttribute("userID").toString()) , 1, "logout", Config.sdf.format(new Date())); // prijava na server
        BufferedWriter bw = (BufferedWriter)session.getAttribute("bw");
        bw.write(msg.toString() +"\n");
        bw.flush();
    }

    session.removeAttribute("auth");
    session.removeAttribute("role");
    session.removeAttribute("userID");
    session.removeAttribute("firstName");
    session.removeAttribute("br");
    session.removeAttribute("bw");
    response.sendRedirect("../index.jsp");
}
else if (request.getParameter("adminRegistration") != null)
{
%>
<jsp:useBean id="adminReg" class="models.UserModel" />
<jsp:setProperty property="*" name="adminReg"/>
<%

        if (adminReg.getFirstName() == null || adminReg.getLastName() == null || adminReg.getEmail() == null || adminReg.getPassword() == null)
            response.sendRedirect("../pages/profile.jsp?dataError&firstName=" +adminReg.getFirstName() +"&lastName=" +adminReg.getLastName() +"&email=" +adminReg.getEmail());
        else
        {
            UserDAL.addNewUser(adminReg, true);
            response.sendRedirect("../pages/profile.jsp");
        }
    }
    else if (request.getParameter("deleteUser") != null)
    {
        int userID = Integer.parseInt(request.getParameter("deleteUser"));
        UserDAL.removeUser(userID);
        response.sendRedirect("../pages/profile.jsp");
    }
%>