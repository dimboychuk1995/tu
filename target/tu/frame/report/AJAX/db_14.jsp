<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>

<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%
    response.setHeader("Content-Disposition","inline;filename=reportDEH.xls") ;
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    HttpSession ses = request.getSession();
    String db = new String();
    if (ses.getAttribute("db_name")!=null) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
    try {
        c = ds.getConnection();
        pstmt = c.prepareStatement("{call dbo.[reportDEH](?,?,?)}");
        String FromDate = (String) request.getParameter("FromDate");
        String TillDate = (String) request.getParameter("TillDate");
        pstmt.setString(1, FromDate);
        pstmt.setString(2, TillDate);
        pstmt.setString(3, db);
        rs = pstmt.executeQuery();
        String tmp = "";
        int inz = 1;

%>
<style type="text/css">
    <!--
    td.vertical{
        writing-mode:tb-rl;
        filter:flipH flipV;
    }
    -->
</style>

<table border="1" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td align="center" valign="middle">№п/п</td>
        <td align="center" valign="middle">Соціальний статус</td>
        <td align="center" valign="middle">Юридична назва замовника або Прізвище І.П.</td>
        <td align="center" valign="middle">Адреса об'єкта замовника</td>
        <td align="center" valign="middle">Номер договору(ТУ)</td>
        <td align="center" valign="middle">Виконавець проекту</td>
        <td align="center" valign="middle">Виконавець робіт по виконанню ТУ</td>
        <td align="center" valign="middle">Дата допуску споживача</td>
        <td align="center" valign="middle">Номер проектного ТП після допуску</td>
        <td align="center" valign="middle">Номер укладення договору про постачання електроенергії (для ЮС) або відкриття особового рахунку (для ПС) </td>
        <td align="center" valign="middle">Дата укладення договору про постачання електроенергії (для ЮС) або відкриття особового рахунку (для ПС)</td>
    </tr>
   

    <% while (rs.next()) {%>
    <tr>
        <td align="center" valign="middle"> <%out.print(inz++);%></td>
        <td align="center" valign="middle"> <%= rs.getString(1)%></td>
        <td align="center" valign="middle"> <%= rs.getString(2)%></td>
        <td align="center" valign="middle"> <%= rs.getString(3)%></td>
        <td align="center" valign="middle"> <%= rs.getString(4)%></td>
        <td align="center" valign="middle"> <%= rs.getString(5)%></td>
        <td align="center" valign="middle"> <%= rs.getString(6)%></td>
        <td align="center" valign="middle"> <%= rs.getString(7)%></td>
        <td align="center" valign="middle"> <%= rs.getString(8)%></td>
        <td align="center" valign="middle"> <%= rs.getString(9)%></td>
        <td align="center" valign="middle"> <%= rs.getString(10)%></td>
    </tr>
    <%}
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(c);
            ic.close();
        }
    %>
</table>

