<%--
    Document   : xls
    Created on : 29 черв 2010, 15:49:21
    Author     : AsuSV//"text/html" 
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%
    HttpSession ses = request.getSession();
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    String db = new String();
    if (!ses.getAttribute("db_name").equals(null)) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try {
        c = ds.getConnection();
        pstmt = c.prepareCall("{call dbo.Zavantagenist(?)}");
        pstmt.setString(1, (String) request.getParameter("ps_10_disp_name"));
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();

%>
<%--=request.getParameter("number")%><%=request.getQueryString()--%>
<table border="1">
    <thead>
        <tr>
            <td align="center" bgcolor="#CCCCCC">Соц. Статус</td>
            <td align="center" bgcolor="#CCCCCC">Споживач</td>
            <td align="center" bgcolor="#CCCCCC">Тип договору</td>
            <td align="center" bgcolor="#CCCCCC">Юрид. назва замовника</td>
            <td align="center" bgcolor="#CCCCCC">Прізвище І.П.</td>
            <td align="center" bgcolor="#CCCCCC">Заявлена потужність кВт.</td>
            <td align="center" bgcolor="#CCCCCC">Потужність по ТП</td>
            <td align="center" bgcolor="#CCCCCC">Номер Договору (ТУ)</td>
            <td align="center" bgcolor="#CCCCCC">Стан договору</td>
            <td align="center" bgcolor="#CCCCCC">Дата допуску споживача</td>
            <td align="center" bgcolor="#CCCCCC">Підстанція ТП 10/0,4</td>
            <td align="center" bgcolor="#CCCCCC">Тип джерела</td>
            <td align="center" bgcolor="#CCCCCC">Назва ЛЕП 10кВ (диспет. назва)</td>
            <td align="center" bgcolor="#CCCCCC">Підстанція ПС 35/10 </td>
            <td align="center" bgcolor="#CCCCCC">Назва ЛЕП 35кВ (диспет. назва)</td>
            <td align="center" bgcolor="#CCCCCC">Підстанція 110/35/10</td>
            <td align="center" bgcolor="#CCCCCC">Назва ЛЕП 110кВ (диспет. назва)</td>

        </tr>
    </thead>
    <% while (rs.next()) {
    %><tr>
        <%for (int i = 1; i <= numCols; i++) {%>
        <td><%= rs.getString(i)%></td><%}%>
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