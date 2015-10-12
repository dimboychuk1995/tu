<%-- 
    Document   : db_5
    Created on : 11 лют 2011, 10:21:46
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>

<%
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
    try {
        c = ds.getConnection();
        pstmt = c.prepareStatement("{call dbo.ZvitKilkistVydanyhTU(?,?)}");
        String FromDate = (String) request.getParameter("FromDate");
        String TillDate = (String) request.getParameter("TillDate");
        pstmt.setString(1, FromDate);
        pstmt.setString(2, TillDate);
        rs = pstmt.executeQuery();
        String tmp = "", i = "18";
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();

%>
<%--
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>--%>
<table width="76%" border="0" align="center">
    <tr>
        <td width="87%" align="center">Кількість виданих ТУ по філіях з початку <u><%=request.getParameter("FromDate").substring(6)%></u> року та за період <u><%=request.getParameter("FromDate")%> - <%=request.getParameter("TillDate")%></u>><br>
            <div align="center"></div></td>
    </tr>
</table>
<table border="1" cellspacing="0" cellpadding="0" align="center" class="tabl">
    <tr>
        <td width="26" rowspan="3" align="center">№ п/п </td>
        <td width="119" rowspan="3" align="center">Назва РЕМ </td>
        <td colspan="6" align="center">Видані <u><%=request.getParameter("FromDate")%> - <%=request.getParameter("TillDate")%></u> </td>
        <td colspan="6" align="center">Видані з початку <%=request.getParameter("FromDate").substring(6)%> року </td>
    </tr>
    <tr>
        <td colspan="2" align="center">РЕМ</td>
        <td colspan="2" align="center">ВТП</td>
        <td colspan="2" align="center">Разом</td>
        <td colspan="2" align="center">Разом</td>
    </tr>
    <tr>
        <td width="50" align="center">шт.</td>
        <td width="49" align="center">грн.</td>
        <td width="43" align="center">шт.</td>
        <td width="36" align="center">грн.</td>
        <td width="45" align="center">шт.</td>
        <td width="45" align="center">грн.</td>
        <td width="47" align="center">шт.</td>
        <td width="51" align="center">грн.</td>
    </tr>
    <%
        while (rs.next()) {
    %>
    <tr>
        <td align="center"><%
            tmp = rs.getString(1);
            if (!tmp.equals("18")) {
                out.print(tmp = rs.getString(1));
            }%>
        </td>
        <td><%out.print(tmp = rs.getString(2));%></td>
        <td align="center"><%out.print(tmp = rs.getString(3));%></td>
        <td align="center"><%out.print(tmp = rs.getString(4));%></td>
        <td align="center"><%out.print(tmp = rs.getString(5));%></td>
        <td align="center"><%out.print(tmp = rs.getString(6));%></td>
        <td align="center"><%out.print(tmp = rs.getString(7));%></td>
        <td align="center"><%out.print(tmp = rs.getString(8));%></td>
        <td align="center"><%out.print(tmp = rs.getString(9));%></td>
        <td align="center"><%out.print(tmp = rs.getString(10));%></td>
        <%--	<td align="center"><%out.print(tmp= rs.getString(11));%></td>
                <td align="center"><%out.print(tmp= rs.getString(12));%></td>
                <td align="center"><%out.print(tmp= rs.getString(13));%></td>
                <td align="center"><%out.print(tmp= rs.getString(14));%></td>--%>

    </tr>
    <%}%>
</table>
<%} catch (SQLException e) {
        e.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    }
%>