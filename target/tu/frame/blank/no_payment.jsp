<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<% response.setHeader("Content-Disposition", "inline;filename=no_payment.xls");
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
    try {
        c = ds.getConnection();
        pstmt = c.prepareStatement("{call NO_PAYMENT()}");
    rs = pstmt.executeQuery();
    rsmd = rs.getMetaData();
    int numCols = rsmd.getColumnCount();

%>
<!DOCTYPE html>
<table border="1">
    <thead>
        <tr>
            <td align="center" bgcolor="#CCCCCC">РЕМ</td>
            <td align="center" bgcolor="#CCCCCC">Замовник</td>
            <td align="center" bgcolor="#CCCCCC">Адреса Об'єкта</td>
            <td align="center" bgcolor="#CCCCCC">Номер Договору (ТУ)</td>
            <td align="center" bgcolor="#CCCCCC">Вихідна дата реєстрації ТУ в РЕМ</td>
            <td align="center" bgcolor="#CCCCCC">Дата укладення договору</td>
            <td align="center" bgcolor="#CCCCCC">Стан договору</td>
            <td align="center" bgcolor="#CCCCCC">Кількість календарних днів протермінування оплати </td>
        </tr>
    </thead>
    <% while (rs.next()) {%>
    <tr>
        <%for(int i=1;i<=numCols;i++){%>
        <td><%= rs.getString(i)%></td>
        <%}%>
    </tr><%}
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
