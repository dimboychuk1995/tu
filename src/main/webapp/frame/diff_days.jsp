<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%  response.setHeader("Content-Disposition","inline;filename=termin_vukonanya_robit.xls");
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    HttpSession ses = request.getSession();
    String db = new String();
    if (!ses.getAttribute("db_name").equals(null)) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
    try {
        c = ds.getConnection();
        if (request.getParameter("number") == null) {
            pstmt = c.prepareStatement("{call dbo.ZvitDays()}");
        } else {
            pstmt = c.prepareStatement("{call dbo.Find_Customer_excel(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            pstmt.setString(1, (String) request.getParameter("number"));
            pstmt.setString(2, (String) request.getParameter("juridical"));
            pstmt.setString(3, (String) request.getParameter("f_name"));
            pstmt.setString(4, (String) request.getParameter("object_name"));
            pstmt.setString(5, (String) request.getParameter("name_locality"));
            pstmt.setString(6, (String) request.getParameter("object_adress"));
            pstmt.setString(7, (String) request.getParameter("request_power_from"));
            pstmt.setString(8, (String) request.getParameter("request_power_till"));
            pstmt.setString(9, (String) request.getParameter("develloper_company"));
            pstmt.setString(10, (String) request.getParameter("performer_proect_to_point"));
            pstmt.setString(11, (String) request.getParameter("performer_proect_after_point"));
            pstmt.setString(12, (String) request.getParameter("customer_type"));
            pstmt.setString(13, (String) request.getParameter("customer_soc_status"));
            pstmt.setString(14, (String) request.getParameter("initial_registration_date_rem_tu_from"));
            pstmt.setString(15, (String) request.getParameter("initial_registration_date_rem_tu_till"));
            pstmt.setString(16, (String) request.getParameter("date_admission_consumer_from"));
            pstmt.setString(17, (String) request.getParameter("date_admission_consumer_till"));
            pstmt.setString(18, (String) request.getParameter("date_contract_from"));
            pstmt.setString(19, (String) request.getParameter("date_contract_till"));
            pstmt.setString(20, (String) request.getParameter("ps_10_disp_name"));
            pstmt.setString(21, (String) request.getParameter("ps_35_disp_name"));
            pstmt.setString(22, (String) request.getParameter("fid_10_disp_name"));
            pstmt.setString(23, (String) request.getParameter("do1"));
            pstmt.setString(24, (String) request.getParameter("do2"));
            pstmt.setString(25, (String) request.getParameter("do3"));
        }
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();

%>
<%--=request.getParameter("number")%><%=request.getQueryString()--%>
<!DOCTYPE html>
<table border="1" cellspacing="0" cellpadding="0" w>
    <thead>
        <tr>
            <td width="100%" align="center" bgcolor="#CCCCCC">РЕМ</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">№ договору</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">Прізвище І.П.</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">Адреса об'єкту</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">Тип приєднання</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">Типовий/<br/>нетиповий</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">Видача ТУ, днів</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">Виконання БМР, днів</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">Приймання БМР, днів</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">Подання напруги, днів</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">Дата подання напруги</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">Надання послуги згідно договору</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">Надання послуги по факту</td>
            <td width="100%" align="center" bgcolor="#CCCCCC">Пропозиції РЕМ з реконструкцією</td>
        </tr>
    </thead>
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