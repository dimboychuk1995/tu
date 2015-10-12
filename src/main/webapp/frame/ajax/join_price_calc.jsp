<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/json.tld" prefix="json" %>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
    String rate = new String();
    InitialContext ic = null;
    DataSource ds = null;
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        String date = request.getParameter("registration_date");
        String id = request.getParameter("rt_choice");
        ic = new InitialContext();
        ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
        c = ds.getConnection();
        String SQL = "DECLARE @date_registarion DATETIME = '"+date+"'"
                + " SELECT "
                + "CASE  "
                + "	 WHEN YEAR(@date_registarion)=2013 then [rate] "
                + "	 WHEN YEAR(@date_registarion)=2014 and @date_registarion<'29.04.2014' THEN rate2014 "
                + "	 WHEN @date_registarion>='29.04.2014' and "
                + "           @date_registarion<'23.01.2015'  THEN rate2014_2 "
                + "	 WHEN @date_registarion>='23.01.2015' THEN rate2015 "
                + "	 ELSE 0 "
                + "	 END AS rate "
                + "FROM   [TUWeb].[dbo].[rate_of_payment]"
                + "WHERE  id = " + id;
        //System.out.println(SQL);
        pstmt = c.prepareStatement(SQL);
        rs = pstmt.executeQuery();
        rate = "0";
        while (rs.next()) {
            rate = rs.getString("rate");
        }
    } catch (SQLException ex) {
        System.out.println("Помилка БД");
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    }
    pageContext.setAttribute("rate", rate);
%>
<json:object >
    <json:property name="rate" > ${rate}</json:property>
</json:object>

