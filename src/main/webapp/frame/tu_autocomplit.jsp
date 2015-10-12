<%@page contentType="text/html" pageEncoding="UTF-8"%><%@ page import="javax.naming.InitialContext"%><%@ page import="javax.sql.DataSource,java.sql.Connection,java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>
<%
    HttpSession ses=request.getSession();
    String db=new String();
    if(!ses.getAttribute("db_name").equals(null)){ db=(String)ses.getAttribute("db_name");}
    else{db=ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name",request);}
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/"+db);
    Connection c = ds.getConnection();
    PreparedStatement pstmt;
    pstmt = c.prepareStatement("select t.id, t.name from "
            + "(SELECT [id] as id , isnull([number],'')+'|"
            + " '+isnull([juridical],'')+'"
            + " '+isnull([f_name],'')+'"
            + " '+isnull([s_name],'')+'"
            + " '+isnull([t_name],'') as name FROM [TC_V2]) t "
            + "where name like '"
            + request.getParameter("q")
            + "%'");
    ResultSet rs = pstmt.executeQuery();
    while (rs.next()){%><%= rs.getString(1)%>|<%= rs.getString(2)%><%}
           ic.close();
           c.close();
           rs.close();
    %>