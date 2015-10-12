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
        pstmt = c.prepareStatement("{call dbo.ZvitKilkistNadanuhPoslug(?,?)}");
        String FromDate = (String) request.getParameter("FromDate");
        String TillDate = (String) request.getParameter("TillDate");
        pstmt.setString(1, FromDate);
        pstmt.setString(2, TillDate);
        rs = pstmt.executeQuery();
        String tmp = "", i = "18";
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();
%>

<table width="76%" border="0" align="center">
    <tr>
        <td width="76%" align="center"><font size="5">Інформація</font></td>
    </tr>
    <tr>
        <td width="87%" align="center">про кількість фактично наданих послуг за <u><%=request.getParameter("FromDate")%> - <%=request.getParameter("TillDate")%></u> та <br> з початку <u><%=request.getParameter("FromDate").substring(6)%></u> р. наростаючим підсумком<br>
    <div align="center"></div></td>
</tr>
</table>
<table border="1" cellspacing="0" cellpadding="0" align="center" class="tabl">
    <tr>
        <td width="26" rowspan="3" align="center">№ п/п </td>
        <td width="119" rowspan="3" align="center">Назва РЕМ </td>
        <td colspan="2" align="center">Фактично наданих послуг<br>стандартного приєднання<br>(подана напруга), шт</td>
        <td colspan="2" align="center">Фактично наданих послуг<br>нестандартного приєднання<br>(подана напруга), шт</td>
        <td colspan="2" align="center">Разом  </td>
    </tr>
    <tr>
        <td align="center">за <%=request.getParameter("FromDate")%> -<br> <%=request.getParameter("TillDate")%></td>
        <td align="center">з початку <%=request.getParameter("FromDate").substring(6)%></td>
        <td align="center">за <%=request.getParameter("FromDate")%> -<br><%=request.getParameter("TillDate")%></td>
        <td align="center">з початку <%=request.getParameter("FromDate").substring(6)%></td>
        <td align="center">за <%=request.getParameter("FromDate")%> -<br> <%=request.getParameter("TillDate")%></td>
        <td align="center">з початку <%=request.getParameter("FromDate").substring(6)%></td>
    </tr>
    <tr>
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
        <td align="center"><%out.print(tmp = rs.getString(7));%></td>
        <td align="center"><%out.print(tmp = rs.getString(4));%></td>
        <td align="center"><%out.print(tmp = rs.getString(8));%></td>
        <td align="center"><%out.print(tmp = rs.getString(5));%></td>
        <td align="center"><%out.print(tmp = rs.getString(6));%></td>

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

