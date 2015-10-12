<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%  
    int year = Integer.parseInt((String) request.getParameter("selectYear"));
    response.setHeader("Content-Disposition", "inline;filename=reportTU_"+year+".xls");
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    HttpSession ses = request.getSession();
    String db = new String();
    if (ses.getAttribute("db_name") != null) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb190");
    try {
        c = ds.getConnection();
        pstmt = c.prepareStatement("{call dbo.ReportForNastya(?)}");
        pstmt.setInt(1, year);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();

%>
<table border="1">
    <thead>
        <tr>
            <td align="center" bgcolor="#CCCCCC">РЕМ</td>
            <td align="center" bgcolor="#CCCCCC">Споживач</td>
            <td align="center" bgcolor="#CCCCCC">Тип приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Дата звернення</td>
            <td align="center" bgcolor="#CCCCCC">Юридична назва замовника</td>
            <td align="center" bgcolor="#CCCCCC">Прізвище І.Б.</td>
            <td align="center" bgcolor="#CCCCCC">Телефон</td>
            <td align="center" bgcolor="#CCCCCC">Ідентифікаційний номер</td>
            <td align="center" bgcolor="#CCCCCC">Номер Договору (ТУ)</td>
            <td align="center" bgcolor="#CCCCCC">Підстава видачі ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Назва об'єкту</td>
            <td align="center" bgcolor="#CCCCCC">Адреса Об'єкта</td>
            <td align="center" bgcolor="#CCCCCC">Точка приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Вихідна дата реєстрації ТУ в РЕМ</td>
            <td align="center" bgcolor="#CCCCCC">Дата укладення договору (приєднання)</td>
            <td align="center" bgcolor="#CCCCCC">Термін виконання робіт по приєднанню</td>
            <td align="center" bgcolor="#CCCCCC">Дата оплати за приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Дата подання проекту на погодження</td>
            <td align="center" bgcolor="#CCCCCC">Дата погодження проекту</td>
            <td align="center" bgcolor="#CCCCCC">Виконавець проекту</td>
            <td align="center" bgcolor="#CCCCCC">Виконавець робіт по проекту</td>
            <td align="center" bgcolor="#CCCCCC">Дата подання напруги</td>
            <td align="center" bgcolor="#CCCCCC">Дата укладення договору про користування/постачання (Основні ТУ)</td>
            <td align="center" bgcolor="#CCCCCC">Дата укладення договору про користування/ постачання (Будмайданчик)</td>
           
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