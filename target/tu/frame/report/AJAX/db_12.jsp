<%-- 
    Document   : db_10
    Created on : 19.08.2013, 14:44:58
    Author     : us8610
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
response.setHeader("Content-type","application/xls");
response.setHeader("Content-disposition","inline; filename=Perelik_standartne.xls");%>
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
        pstmt = c.prepareStatement("{call dbo.[RepAdmisAndConnection](?,?,?)}");
        String FromDate = (String) request.getParameter("FromDate");
        String TillDate = (String) request.getParameter("TillDate");
        int type_join = 1;
        pstmt.setString(1, FromDate);
        pstmt.setString(2, TillDate);
        pstmt.setInt(3, type_join);
        rs = pstmt.executeQuery();
        int i = 1;
        String tmp = "";
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();

%>
<table border="1" cellspacing="0" cellpadding="0" align="center" class="tabl">
    <tr>
        <td align="center" style="background-color: #eee">Назва РЕМ </td>
        <td align="center" style="background-color: #eee">№ п/п</td>
        <td align="center" style="background-color: #eee">Перелік споживачів, з якими укладено договори</td>
        <td align="center" style="background-color: #eee">Місце розташування обєкта споживача</td>
        <td align="center" style="background-color: #eee">Дата укладення  договору</td>
        <td align="center" style="background-color: #eee">Заявлена потужність, кВ</td>
        <td align="center" style="background-color: #eee">Потужність будівельних струмоприймачів</td>
        <td align="center" style="background-color: #eee">Потужність за договором про постачання користування, кВт</td>
    </tr>
    <%
        while (rs.next()) {
    %>
    <tr>
        <td><%out.print(tmp = rs.getString(1));%></td>
        <td align="center"><%=i++%></td>
        <td align="center"><%out.print(tmp = rs.getString(2));%></td>
        <td align="center"><%out.print(tmp = rs.getString(3));%></td>
        <td align="center"><%out.print(tmp = rs.getString(4));%></td>
        <td align="center"><%out.print(tmp = rs.getString(5));%></td>
        <td align="center"><%out.print(tmp = rs.getString(6));%></td>
        <td align="center"><%out.print(tmp = rs.getString(7));%></td>
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
