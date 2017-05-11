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
        String stage_join = request.getParameter("stage_join");//Ступінь приєднання, доданий у 2016, ставки за стандартне приєднання залежні також від цього поля
        System.out.println("date = " + date);
        System.out.println("id = " + id);
        System.out.println("join = " + stage_join);
        ic = new InitialContext();
        ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
        c = ds.getConnection();

        String SQL = "DECLARE \n" +
                "@date_registarion DATETIME = '"+date+"'," +
                "@stage_join INTEGER = '"+stage_join+"'" +
                "\n" +
                "SELECT \n" +
                "CASE  \t \n" +
                "WHEN YEAR(@date_registarion)=2013 then [rate] \t \n" +
                "WHEN YEAR(@date_registarion)=2014 and @date_registarion<'29.04.2014' THEN rate2014 \t \n" +
                "WHEN @date_registarion>='29.04.2014' and            @date_registarion<'23.01.2015'  THEN rate2014_2 \t \n" +
                "WHEN @date_registarion>='23.01.2015' and            @date_registarion < '26.02.2016'  THEN rate2015   \n" +
                "WHEN @stage_join = 1 and @date_registarion >= '26.02.2016' and @date_registarion < '06.03.2017' THEN rate2016_Ist  \n" +
                "WHEN @stage_join = 2 and @date_registarion >= '26.02.2016' and @date_registarion < '06.05.2017' THEN rate2016_IIst  \n" +
                "WHEN @stage_join = 1 and @date_registarion >= '06.03.2017' THEN rate2017_Ist  \n" +
                "WHEN @stage_join = 2 and @date_registarion >= '06.05.2017' THEN rate2017_IIst\t\n" +
                "WHEN @stage_join = 3 \t" +
                "THEN rate2017_IIIst\t \n" +
                "ELSE 0 \t \n" +
                "END AS rate \n" +
                "FROM   [TUWeb].[dbo].[rate_of_payment]\n" +
                "WHERE  id = " + id;
        System.out.println(SQL);
        pstmt = c.prepareStatement(SQL);
        rs = pstmt.executeQuery();
        //rate = "0";
        while (rs.next()) {
            rate = rs.getString("rate");
        }
    } catch (SQLException ex) {
        System.out.println("error db in servlet join_price_calc.jsp");
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

