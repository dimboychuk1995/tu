<%-- 
    Document   : ins_tu_in_sc
    Created on : 1 вер 2010, 11:24:53
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.Connection"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%
          InitialContext ic = new InitialContext();
          DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/TUWeb240");
          Connection Conn = ds.getConnection();
          String SQL = "INSERT TC_V2 (version,department_id)values (1,"+"240"+")";
          Statement stmt = Conn.createStatement();
          int count = stmt.executeUpdate(SQL, Statement.RETURN_GENERATED_KEYS);
          ResultSet rs = stmt.getGeneratedKeys();
          if (rs.next()) {
            //String key = rs.getString(1);
            %><%= rs.getString(1)%><%
          }
          else {%>
             Запис нестворено !!!!
         <% }
          rs.close();
          stmt.close();
          Conn.close();
          ic.close();
%></body>
</html>