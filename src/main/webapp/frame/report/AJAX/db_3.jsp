<%-- 
    Document   : index
    Created on : 18 трав 2010, 12:22:46
    Author     : asupv
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
        pstmt = c.prepareStatement("{call dbo.ZvitInfoKilkistVartistPryednanyaPivrichya(?,?)}");
        String FromDate = (String) request.getParameter("FromDate");
        String TillDate = (String) request.getParameter("TillDate");
        pstmt.setString(1, FromDate);
        pstmt.setString(2, TillDate);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();
%>


<table width="76%" border="0" align="center">
    <tr>
        <td width="87%" align="center">Інформація щодо кількості та вартості виданих технічних умов на приєднання за <u><%=request.getParameter("FromDate")%>-<%=request.getParameter("TillDate")%></u> по ВАТ"Прикарпаттяобленерго" по всіх РЕМ<br>
    <div align="center"></div></td>
</tr>
</table>


<table border="1" cellspacing="0" cellpadding="0" align="center" class="tabl" width="76%">
    <tr>
        <td align="center">Категорія споживачів</td>
        <td align="center">Кількість виданих ТУ од.</td>
        <td align="center">Вартість виданих ТУ, грн.(без ПДВ)</td>
    </tr>
    <%
        while (rs.next()) {
    %>
    <tr>
        <td align="center"><%=rs.getString(2)%></td>
        <td align="center"><%=rs.getString(3)%></td>
        <td align="center"><%=rs.getString(4)%></td>
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


