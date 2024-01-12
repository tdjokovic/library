<meta charset="utf-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp#banner"><span class="gold">NBKG</span> Vuk Karadžić</a>
      <%
        if (session.getAttribute("auth") != null)
        {
      %>
      <div style="color: white">Dobrodošli,&nbsp; <strong class="gold"><%= session.getAttribute("firstName") %></strong></div>
      <%
        }
      %>
    </div>
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="${pageContext.request.contextPath}/pages/books.jsp">Baza knjiga</a></li>
        <li><a href="${pageContext.request.contextPath }/index.jsp#about">O nama</a></li>
        <li><a href="${pageContext.request.contextPath }/index.jsp#contact">Kontakt</a></li>

        <%
          if (session.getAttribute("auth") == null)
          {
        %>
        <li><a href="${pageContext.request.contextPath }/pages/login.jsp">Prijava</a></li>
        <li><a href="${pageContext.request.contextPath }/pages/registration.jsp">Registracija</a></li>
        <%
        }
        else
        {
        %>
        <li><a href="${pageContext.request.contextPath}/pages/users.jsp">Korisnici</a></li>
        <li><a href="${pageContext.request.contextPath }/pages/profile.jsp">Profil</a></li>
        <li><a href="${pageContext.request.contextPath }/pages/inbox.jsp">
          <i class="material-icons">message</i>
        </a></li>
        <li><a href="${pageContext.request.contextPath }/services/userServices.jsp?logout">Odjava</a></li>
        <%
          }
        %>
      </ul>
    </div>
  </div>
</nav>