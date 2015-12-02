<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<script type="text/javascript">
    document.getElementById("img").style.visibility="hidden";
</script>

<%-- 
    Document   : index
    Created on : 18 трав 2010, 12:22:46
    Author     : asupv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%  Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
    try {
        c = ds.getConnection();
        pstmt = c.prepareStatement("{call dbo.ZvitSchokvartalnyiPoVydanyhTU(?,?)}");
        String FromDate = (String) request.getParameter("FromDate");
        String TillDate = (String) request.getParameter("TillDate");
        pstmt.setString(1, FromDate);
        pstmt.setString(2, TillDate);
        rs = pstmt.executeQuery();
        int i = 0;
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();
%>




<table width="76%" border="0" align="center">
    <tr>
        <td width="87%" align="center">Щоквартальний звіт по виданих технічних умовах за <u><%=request.getParameter("FromDate")%> - <%=request.getParameter("TillDate")%></u> (період)<br>
    </tr>
</table>
<table border="1" cellspacing="0" cellpadding="0" align="center" class="tabl">
    <tr>
        <td width="35"  align="center">№ п/п </td>
        <%--td width="150" align="center" bgcolor="#CCCCCC"><strong>Назва джерела електро постачання</strong> </td--%>
        <td width="150" align="center">Назва ПС 110 кВ (до якої привязані ТУ) </td>
        <td width="150"  align="center">Потужність по виданих ТУ, кВт</td>
        <td width="150"  align="center">Потужність реалізованих ТУ кВт</td>
        <td width="150"  align="center">Фактичне навантаження ПС 110 кВ(дані зимового максимального заміру). кВт</td>
        <td width="150"  align="center">Резерв, кВт</td>
        <td width="150"  align="center">ТУ, що набули чинності</td>
    </tr>
    <%
        while (rs.next()) {
            i++;
    %>  
    <tr>
    <td align="center"><% out.print(i);%></td>
    <%--td bgcolor="#CCCCCC">&nbsp;</td--%>
    <td align="center">&nbsp;<%=rs.getString("ps110")%></td>
    <td align="center">&nbsp;<%= rs.getString("vydani")%></td>
    <td align="center">&nbsp;<%= rs.getString("dopuscheni")%></td>
    <td align="center">&nbsp;<%= rs.getString("ps_nav")%></td>
    <td align="center">&nbsp;<%= rs.getString("ps_rez")%></td>
</tr>
    <%}%>
    <%} catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(c);
            ic.close();
        }
    %>
</table>

