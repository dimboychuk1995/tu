<%-- 
    Document   : db_10
    Created on : 19.08.2013, 14:44:58
    Author     : us8610
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
        pstmt = c.prepareStatement("{call dbo.[CostsBMRNotDefaultJoin](?,?)}");
        String FromDate = (String) request.getParameter("FromDate");
        String TillDate = (String) request.getParameter("TillDate");
        pstmt.setString(1, FromDate);
        pstmt.setString(2, TillDate);
        rs = pstmt.executeQuery();
        int i = 1;
        String tmp = "";
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();

%>
<table width="76%" border="0" align="center">
    <tr>
        <td width="87%" align="center">Витрати згідно акту БМР (нестандартне) з початку <u><%=request.getParameter("FromDate").substring(6)%></u> року та за період <u><%=request.getParameter("FromDate")%> - <%=request.getParameter("TillDate")%></u><br>
            <div align="center"></div></td>
    </tr>
</table>
<table border="1" cellspacing="0" cellpadding="0" align="center" class="tabl">
    <tr>
        <td width="26" rowspan="3" align="center">№ <br/>п/п </td>
        <td width="170" rowspan="3" align="center">Назва РЕМ </td>
        <td colspan="4" align="center">Виконання робіт нестандартного приєднання, грн</td>
        <td colspan="4" align="center">Дохід по виконаних роботах, грн</td>
    </tr>
    <tr>
        <td colspan="2" align="center">отримані за період <br/><u><%=request.getParameter("FromDate")%> - <%=request.getParameter("TillDate")%></u> </td>
        <td colspan="2" align="center">з початку <%=request.getParameter("FromDate").substring(6)%> року </td>
        <td colspan="2" align="center">отримані за період <br/><u><%=request.getParameter("FromDate")%> - <%=request.getParameter("TillDate")%></u> </td>
        <td colspan="2" align="center">з початку <%=request.getParameter("FromDate").substring(6)%> року </td>
    </tr>
    <tr>
        <td width="90" align="center">к-сть, шт.</td>
        <td width="90" align="center">сума, грн.</td>
        <td width="90" align="center">к-сть, шт.</td>
        <td width="90" align="center">сума, грн.</td>
        <td width="90" align="center">к-сть, шт.</td>
        <td width="90" align="center">сума, грн.</td>
        <td width="90" align="center">к-сть, шт.</td>
        <td width="90" align="center">сума, грн.</td>
    </tr>
    <%
        while (rs.next()) {
    %>
    <tr>
        <td align="center"><%=i++%></td>
        <td style="padding-left: 10px;"><%out.print(tmp = rs.getString(1));%></td>
        <td align="center"><%out.print(tmp = rs.getString(2));%></td>
        <td align="center"><%out.print(tmp = rs.getString(3));%></td>
        <td align="center"><%out.print(tmp = rs.getString(4));%></td>
        <td align="center"><%out.print(tmp = rs.getString(5));%></td>
        <td align="center"><%out.print(tmp = rs.getString(6));%></td>
        <td align="center"><%out.print(tmp = rs.getString(7));%></td>
        <td align="center"><%out.print(tmp = rs.getString(8));%></td>
        <td align="center"><%out.print(tmp = rs.getString(9));%></td>
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
