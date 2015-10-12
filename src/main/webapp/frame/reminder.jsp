<%-- 
    Document   : reminder
    Created on : 25 черв 2010, 11:55:58
    Author     : AsuSV
--%>
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<style>
    .table1 td{font-size: 10px;padding:1px;     text-align:center;     background-color:#DEF3CA;     border: 2px solid #E7EFE0;     -moz-border-radius:15px;     -webkit-border-radius:15px;     border-radius:15px;     color:#666;     text-shadow:1px 1px 1px #fff; }
    .table1 th{font-size: 11px;padding:15px;     color:#fff;     text-shadow:1px 1px 1px #568F23;     border:1px solid #FFAA00;     border-bottom:3px solid #FFAA00;     background-color:#FF7F00;     background:-webkit-gradient(         linear,         left bottom,         left top,         color-stop(0.02, rgb(255,165,0)),         color-stop(0.51, rgb(255,174,26)),         color-stop(0.87, rgb(255,183,52))         );     background: -moz-linear-gradient(         center bottom,         rgb(255,165,0) 2%,         rgb(255,174,26) 51%,         rgb(255,183,52) 87%         );     -webkit-border-top-left-radius:5px;     -webkit-border-top-right-radius:5px;     -moz-border-radius:5px 5px 0px 0px;     border-top-left-radius:5px;     border-top-right-radius:5px; filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FFA500', endColorstr='#ffb734'); }
</style>
<%
    HttpSession ses = request.getSession();
    String db = new String();
    if (!ses.getAttribute("db_name").equals(null)) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    Connection c = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt1 = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try{
    c = ds.getConnection();
    pstmt1 = c.prepareStatement("{call dbo.state_document}");
    pstmt1.executeUpdate();
%><%
    pstmt = c.prepareStatement("{call dbo.Termin_vuk_rob}");
    rs = pstmt.executeQuery();
    rsmd = rs.getMetaData();
    int numCols = rsmd.getColumnCount();
    int flag = 0;
    while (rs.next()) {
        if (0 == flag++) {
%>
<h2>Термін виконання робіт по стандартному приєднанню:</h2>
<table class="table1">
    <tr>
        <th>&nbsp;</th>
        <th>№ Договору про приєднання</th>
        <th>Назва Замовника</th>
        <th>Адреса об'єкта</th>
        <th>Тип проекту</th>
        <th>Стан договору</th>
        <th>Дата оплати вартості приєднання</th>
        <th>День виконання робіт</th>
        <th>Дата передачі акту прийому-здачі гол.інженеру</th>
        <th>Дата погодження гол.інж. акту прийому-здачі</th>
        <th>Дата допуску споживача</th>
        <th>Дата подання напруги</th>
        <th>Точка забезпечення потужності</th>
    </tr>
    <%}%>
    <tr>
        <td><a href="#"onClick="window.open('tab.do?method=edit&bdname=<%=db%>&tu_id=<%= rs.getString(1)%>', '_parent', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');" ><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></td>
                <%for (int i = 2; i <= numCols; i++) {%>
        <td><%= rs.getString(i)%></td><%}%>
    </tr>
    <%}
        if (0 != flag) {%></table><%}
       
    pstmt = c.prepareStatement("{call dbo.Termin_vuk_rob_ns}");
    rs = pstmt.executeQuery();
    rsmd = rs.getMetaData();
    numCols = rsmd.getColumnCount();
    flag = 0;
    while (rs.next()) {
        if (0 == flag++) {
%>
<h2>Термін виконання робіт по нестандартному приєднанню:</h2>
<table class="table1">
    <tr>
        <th>&nbsp;</th>
        <th>№ Договору про приєднання</th>
        <th>Назва Замовника</th>
        <th>Адреса об'єкта</th>
        <th>Тип проекту</th>
        <th>Стан договору</th>
        <th>Дата оплати вартості приєднання</th>
        <th>День виконання робіт</th>
        <th>Дата передачі акту прийому-здачі гол.інженеру</th>
        <th>Дата погодження гол.інж. акту прийому-здачі</th>
        <th>Дата допуску споживача</th>
        <th>Дата подання напруги</th>
        <th>Точка забезпечення потужності</th>
        <th>Термін надання послуги з приєднання, днів</th>
    </tr>
    <%}%>
    <tr>
        <td><a href="#"onClick="window.open('tab.do?method=edit&bdname=<%=db%>&tu_id=<%= rs.getString(1)%>', '_parent', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');" ><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></td>
                <%for (int i = 2; i <= numCols; i++) {%>
        <td><%= rs.getString(i)%></td><%}%>
    </tr>
    <%}
        if (0 != flag) {%></table><%}
        pstmt = c.prepareStatement("{call dbo.Termin_vydachi_15_rob_dniv}");
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        numCols = rsmd.getColumnCount();
        flag = 0;
        while (rs.next()) {
            if (0 == flag++) {
    %>

<h2>Термін видачі ТУ (залишилось менше 1-го дня):</h2>
<table class="table1" >
    <tr >
        <th>&nbsp;</th>
        <th>№</th>
        <th>П.І.Б.</th>
        <th>призначення</th>
        <th>адреса</th>
        <th>дата звернення</th>
        <th>вихідна дата реестрації</th>
    </tr>
    <%}%>
    <tr>
        <td><a href="#"onClick="window.open('tab.do?method=edit&bdname=<%=db%>&tu_id=<%= rs.getString(1)%>', '_parent', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');" ><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></td>
                <%for (int i = 2; i <= numCols; i++) {%>
        <td><%= rs.getString(i)%></td><%}%>
    </tr>
    <%
        }
        if (0 != flag) {%></table><%}

        pstmt = c.prepareStatement("{call dbo.proterminovani_20_dniv}");
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        numCols = rsmd.getColumnCount();
        flag = 0;
        while (rs.next()) {
            if (0 == flag++) {
    %>
<h2>Протермінування 20-ти денного терміну укладення Договору/ТУ:</h2>
<table class="table1" border="0" >
    <tr>
        <th>&nbsp;</th>
        <th>№</th>
        <th>П.І.Б.</th>
        <th>призначення</th>
        <th>адреcа</th>
        <th>дата укладання договору</th>
        <th>дата видачі ТУ та договору</th>
    </tr>
    <%}%>
    <tr>
        <td><a href="#"onClick="window.open('tab.do?method=edit&bdname=<%=db%>&tu_id=<%= rs.getString(1)%>', '_parent', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');" ><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></a></td>
                <%for (int i = 2; i <= numCols; i++) {%>
        <td><%= rs.getString(i)%></td><%}%>
    </tr>
    <%}
        if (0 != flag) {%></table><%}

        pstmt = c.prepareStatement("{call dbo.Termin_dii_TU}");
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        numCols = rsmd.getColumnCount();
        flag = 0;
        while (rs.next()) {
            if (0 == flag++) {
    %>
<h2>Закінчення терміну дії Договору/ТУ:</h2>
<table class="table1">
    <tr>
        <th>&nbsp;</th>
        <th>№</th>
        <th>П.І.Б.</th>
        <th>призначення</th>
        <th>адреса</th>
        <th>дата реєстрації</th>
        <th>дата видачі ТУ та договору</th>
        <th>дата укладання договору</th>
        <th>дата закінчення дії договору</th>
        <th>Виконавець</th>
    </tr>
    <%}%>
    <tr>
        <td><a href="#"onClick="window.open('tab.do?method=edit&bdname=<%=db%>&tu_id=<%= rs.getString(1)%>', '_parent', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');" ><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></td>
                <%for (int i = 2; i <= numCols; i++) {%>
        <td><%= rs.getString(i)%></td><%}%>
    </tr>
    <%}
        if (0 != flag) {%></table><%}

        pstmt = c.prepareStatement("{call dbo.proterm_10_pay_dog}");
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        numCols = rsmd.getColumnCount();
        flag = 0;
        while (rs.next()) {
            if (0 == flag++) {
    %>
<h2>Протермінування 10-ти денного терміну оплати договору:</h2>
<table class="table1">
    <tr >
        <th>&nbsp;</th>
        <th>№</th>
        <th>П.І.Б.</th>
        <th>призначення</th>
        <th>адреса</th>
        <th>дата звернення</th>
        <th>дата видачі ТУ та договору</th>
        <th>дата укладення договору</th>
    </tr>
    <%}%>
    <tr>
        <td><a href="#"onClick="window.open('tab.do?method=edit&bdname=<%=db%>&tu_id=<%= rs.getString(1)%>', '_parent', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');" ><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></td>
                <%for (int i = 2; i <= numCols; i++) {%>
        <td><%= rs.getString(i)%></td><%}%>
    </tr>
    <%}
        if (0 != flag) {%></table><%}
        pstmt = c.prepareStatement("{call dbo.proterm_15_build_net}");
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        numCols = rsmd.getColumnCount();
        flag = 0;
        while (rs.next()) {
            if (0 == flag++) {
    %>
<h2>Протермінування 15-ти денного терміну будівництва зовнішніх мереж:</h2>
<table class="table1">
    <tr>
        <th>&nbsp;</th>
        <th>№</th>
        <th>П.І.Б.</th>
        <th>призначення</th>
        <th>адреса</th>
        <th>дата звернення</th>
        <th>дата видачі ТУ та договору</th>
        <th>дата оплати за приєднання</th>
    </tr>
    <%}%>
    <tr>
        <td><a href="#"onClick="window.open('tab.do?method=edit&bdname=<%=db%>&tu_id=<%= rs.getString(1)%>', '_parent', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');" ><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></td>
                <%for (int i = 2; i <= numCols; i++) {%>
        <td><%= rs.getString(i)%></td><%}%>
    </tr>
    <%}
        if (0 != flag) {%></table><%}


        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(pstmt1);
            SQLUtils.closeQuietly(c);
            ic.close();
        }

%>