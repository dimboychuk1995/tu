<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<% response.setHeader("Content-Disposition", "inline;filename=address.xls");
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    String city = request.getParameter("city");
    String address = request.getParameter("address");
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
    try {
        c = ds.getConnection();
        pstmt = c.prepareStatement("{call findTuByAddress(?,?)}");
        pstmt.setString(1, city);
        pstmt.setString(2, address);

    rs = pstmt.executeQuery();
    rsmd = rs.getMetaData();
    int numCols = rsmd.getColumnCount();

%>
<!DOCTYPE html>
<table border="1">
    <thead>
        <tr>
            <td align="center" bgcolor="#CCCCCC">РЕМ</td>
            <td align="center" bgcolor="#CCCCCC">Тип приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Дата звернення (реєстрації в РЕМ)</td>
            <td align="center" bgcolor="#CCCCCC">Юрид. назва замовника</td>
            <td align="center" bgcolor="#CCCCCC">Прізвище І.П.</td>
            <td align="center" bgcolor="#CCCCCC">Підстава видачі ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Назва</td>
            <td align="center" bgcolor="#CCCCCC">Адреса Об'єкта</td>
            <td align="center" bgcolor="#CCCCCC">Розробник ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Заявлена потужність кВт.</td>
            <td align="center" bgcolor="#CCCCCC">Номер Договору (ТУ)</td>
            <td align="center" bgcolor="#CCCCCC">Вихідна дата реєстрації ТУ в РЕМ</td>
            <td align="center" bgcolor="#CCCCCC">Дата укладення договору</td>
            <td align="center" bgcolor="#CCCCCC">Стан договору</td>
            <td align="center" bgcolor="#CCCCCC">Дата допуску споживача</td>
            <td align="center" bgcolor="#CCCCCC">Підстанція ТП 10/0,4</td>
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
