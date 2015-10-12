<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%  
   String FromDate = (String) request.getParameter("fromDate");
   String TillDate = (String) request.getParameter("tillDate");
    response.setHeader("Content-Disposition", "inline;filename=Zvit_perelik_dohovoriv.xls");
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
        pstmt = c.prepareStatement("{call dbo.ReportListOfDeals(?,?)}");
        pstmt.setString(1, FromDate);
        pstmt.setString(2, TillDate);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();

%>
<table border="1">
    <thead>
        <tr>
            <td colspan="10" align="center" style="border:none;">Перелік</td>
        </tr>
        <tr>
            <td colspan="10" align="center" style="border:none;">договорів про постачання (користування) електричною енергією, укладених в період з  "<%=FromDate%>" до "<%=TillDate%>"</td>
        </tr>
        <tr>
            <td colspan="10" align="center" style="border:none;">&nbsp;</td>
        </tr>
        <tr>
            <td align="center" bgcolor="#CCCCCC">РЕМ</td>
            <td align="center" bgcolor="#CCCCCC">Юридична назва замовника</td>
            <td align="center" bgcolor="#CCCCCC">Прізвище І.Б.</td>
            <td align="center" bgcolor="#CCCCCC">Назва об'єкту</td>
            <td align="center" bgcolor="#CCCCCC">Адреса Об'єкта</td>
            <td align="center" bgcolor="#CCCCCC">Ступінь приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Точка приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Точка забезпечення потужності</td>
            <td align="center" bgcolor="#CCCCCC">Номер договору про постачання (користування)</td>
            <td align="center" bgcolor="#CCCCCC">Дата укладання договору про постачання (користування)(основні)</td>
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