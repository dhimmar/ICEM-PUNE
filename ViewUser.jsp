<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<h4>Employees Registered</h4>
<%@ page import="java.sql.*" %>
<div class="container">
        <TABLE BORDER="2" class="table table-hover">
           
            <TR bgcolor=#00FF00>
               <TH>ID</TH>
               <TH>Name</TH>
               <TH>Department</TH>
               <TH>Age</TH>
               <TH>Salary</TH>
           </TR>
           <%  ResultSet resultset=(ResultSet)request.getAttribute("resultset");
           while(resultset.next()){ %>
           
           <TR bgcolor="#AAABBB">
            <TD> <%= resultset.getString(1) %> </TD>
               <TD> <%= resultset.getString(2) %> </TD>
               <TD> <%= resultset.getString(3) %> </TD>
               <TD> <%= resultset.getString(4) %> </TD>
               <TD> <%= resultset.getString(5) %> </TD>
           </TR>
        <%} %>
       </TABLE>
       <BR>
       <form action="NewUser.jsp">
       <input type="submit" value="Enter new"/>
       </form>
       </div>
</body>
</html>