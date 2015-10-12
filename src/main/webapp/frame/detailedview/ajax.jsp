<%@ page contentType="text/xml;charset=UTF-8" language="java"%><?xml version="1.0" encoding="UTF-8"?>
<%--
    Document   : xmlmaingrid
    Created on : 10 березня 2009, 9:41:24
    Author     : AsuSV
--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
    HttpSession ses=request.getSession();
    String db=(String)ses.getAttribute("db_name");
      //String  db="fb300";
      String tp_id;
      tp_id=request.getParameter("tp_id");
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/"+db);
    Connection c = ds.getConnection();
    PreparedStatement pstmt = c.prepareStatement("select aktnebalansu.ptr ,dovidnikps110kv.ptr  from fiderdani  join aktnebalansu on fiderdani.name=aktnebalansu.fider10kv  join dovidnikps110kv on dovidnikps110kv.ptr=aktnebalansu.kodps where tp=(?) group by aktnebalansu.ptr, dovidnikps110kv.ptr");
    pstmt.setString(1,tp_id);
    ResultSet rs = pstmt.executeQuery();
%>
<rows>
<%   int  j=1;
     while(rs.next()){
%>
<cell1><%= rs.getString(1)%></cell1>
<cell2><%= rs.getString(2)%></cell2>
<%} rs.close();
    pstmt.close();
    c.close();
    ic.close();
%>
</rows>
