<%-- 
    Document   : reminder
    Created on : 25 черв 2010, 11:55:58
    Author     : AsuSV
--%>
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@ page import="com.google.gson.internal.$Gson$Types" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
    HttpSession ses = request.getSession();
    String db;
    if (ses.getAttribute("db_name") != null) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    pageContext.setAttribute("db", db);
%>
<script>
    
    function showtu(id){
        var	 myurl = 'tab.do?method=edit&bdname=<%=db%>&tu_id='+id;
        window.open(myurl, '_parent', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');
    };
    var tableToExcel = (function() {
  var uri = 'data:application/vnd.ms-excel;base64,'
    , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
    , base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
    , format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
  return function(table, name) {
    if (!table.nodeType) table = document.getElementById(table)
    var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
    window.location.href = uri + base64(format(template, ctx))
  }
})();
</script>
<style>
    .table1 td{font-size: 10px;padding:1px;     text-align:center;     background-color:#DEF3CA;     border: 2px solid #E7EFE0;     -moz-border-radius:15px;     -webkit-border-radius:15px;     border-radius:15px;     color:#666;     text-shadow:1px 1px 1px #fff; }
    .table1 th{font-size: 11px;padding:15px;     color:#fff;     text-shadow:1px 1px 1px #568F23;     border:1px solid #FFAA00;     border-bottom:3px solid #FFAA00;     background-color:#FF7F00;     background:-webkit-gradient(         linear,         left bottom,         left top,         color-stop(0.02, rgb(255,165,0)),         color-stop(0.51, rgb(255,174,26)),         color-stop(0.87, rgb(255,183,52))         );     background: -moz-linear-gradient(         center bottom,         rgb(255,165,0) 2%,         rgb(255,174,26) 51%,         rgb(255,183,52) 87%         );     -webkit-border-top-left-radius:5px;     -webkit-border-top-right-radius:5px;     -moz-border-radius:5px 5px 0px 0px;     border-top-left-radius:5px;     border-top-right-radius:5px; filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FFA500', endColorstr='#ffb734'); }
    .orange td {background-color: wheat}
</style>
<sql:setDataSource
    var="DB"
    driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
    url="jdbc:sqlserver://10.93.104.55:1433;databaseName=${db};charSet=UTF8;"
    user="sa" password="Gjdybq<h'l?55" />
<sql:update dataSource="${DB}" >
    DECLARE	@return_value int
    EXEC	@return_value = [dbo].[state_document]
    SELECT	'Return Value' = @return_value
</sql:update>
<sql:query var="rez1" dataSource="${DB}" >
    DECLARE	@return_value int
    EXEC	@return_value = [dbo].[Termin_vuk_rob]
    SELECT	'Return Value' = @return_value
</sql:query>
<c:if test="${!empty rez1.rows}">
    <h2>Термін виконання робіт по стандартному приєднанню:</h2>
    <input type="button" onclick="tableToExcel('t1', 'Стандартне')" value="Excel">
    <table class="table1" id="t1">
        <tr>
            <th>&nbsp;</th>
            <th>№ Договору про приєднання</th>
            <th>Назва Замовника</th>
            <th>Адреса об'єкта</th>
            <th>Тип проекту</th>
            <th>Стан договору</th>
            <th>Дата оплати вартості приєднання</th>
            <th>Термін надання послуги з приєднання, днів</th>
            <th>Календарна дата  завершення послуги</th>
            <th>День виконання робіт</th>
            <th>Дата розробки проекту</th>
            <th>Дата подання в РЕМ погодженого проекту</th>
            <th>Дата передачі акту прийому-здачі гол.інженеру</th>
            <th>Дата погодження гол.інж. акту прийому-здачі</th>
            <th>Дата допуску споживача</th>
            <th>Дата подання напруги</th>
            <th>Точка забезпечення потужності</th>
        </tr>
        <c:forEach var="row1" items="${rez1.rows}">
            <tr class="<c:if test="${empty row1.date_of_submission}">orange</c:if>">
                <td><a href="#" onClick="showtu('+${row1.id}+');"><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></a></td>
                <td>${row1.number}</td>
                <td>${row1.customer}</td>
                <td>${row1.object_adress}</td>
                <td>${row1.project}</td>
                <td>${row1.status_name}</td>
                <td>${row1.date_pay_join}</td>
                <td>${row1.term_for_joining}</td>
                <td>${row1.date_for_joining}</td>
                <td>${row1.countDays}</td>
                <td>${row1.deadline_providing}</td>
                <td>${row1.deadline_approval}</td>
                <td>${row1.date_giving_akt}</td>
                <td>${row1.date_admission_akt}</td>
                <td>${row1.Date_admission_consumer}</td>
                <td>${row1.date_filling_voltage}</td>
                <td>${row1.point_zab_power}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>
<sql:query var="rez2" dataSource="${DB}" >
    DECLARE	@return_value int
    EXEC	@return_value = [dbo].[Termin_vuk_rob_ns]
    SELECT	'Return Value' = @return_value
</sql:query>
<c:if test="${!empty rez2.rows}">
    <h2>Термін виконання робіт по нестандартному приєднанню:</h2>
    <input type="button" onclick="tableToExcel('t2', 'Нестандартне')" value="Excel">
    <table class="table1" id="t2">
        <tr>
            <th>&nbsp;</th>
            <th>№ Договору про приєднання</th>
            <th>Назва Замовника</th>
            <th>Адреса об'єкта</th>
            <th>Тип проекту</th>
            <th>Стан договору</th>
            <th>Дата оплати вартості приєднання</th>
            <th>День виконання робіт</th>
            <th>Термін надання послуги з приєднання, днів</th>
            <th>Календарна дата  завершення послуги</th>
            <th>Дата передачі акту прийому-здачі гол.інженеру</th>
            <th>Дата погодження гол.інж. акту прийому-здачі</th>
            <th>Дата допуску споживача</th>
            <th>Дата подання напруги</th>
            <th>Точка забезпечення потужності</th>

        </tr>
        <c:forEach var="row2" items="${rez2.rows}">
            <tr>
                <td><a href="#" onClick="showtu('+${row2.id}+');"><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></a></td>
                <td>${row2.number}</td>
                <td>${row2.customer}</td>
                <td>${row2.object_adress}</td>
                <td>${row2.project}</td>
                <td>${row2.status_name}</td>
                <td>${row2.date_pay_ns}</td>
                <td>${row2.countDays}</td>
                <td>${row2.term_for_joining}</td>
                <td>${row2.date_for_joining}</td>
                <td>${row2.date_giving_akt}</td>
                <td>${row2.date_admission_akt}</td>
                <td>${row2.Date_admission_consumer}</td>
                <td>${row2.date_filling_voltage}</td>
                <td>${row2.point_zab_power}</td>

            </tr>
        </c:forEach>
    </table>
</c:if>
<sql:query var="rez31" dataSource="${DB}" >
    DECLARE	@return_value int
    EXEC	@return_value = [dbo].[terms_of_payment]
    SELECT	'Return Value' = @return_value
</sql:query>
<c:if test="${!empty rez31.rows}">
    <h2>Протермінування оплати за нестандартне приєднання:</h2>
    <table class="table1" >
        <tr >
            <th>&nbsp;</th>
            <th>Замовник</th>
            <th>Гранична дата оплати</th>
            <th>Реальна дата оплати</th>
            <th>Дата укладення додаткової угоди</th>
        </tr>
        <c:forEach var="row31" items="${rez31.rows}">
            <tr>
                <td><a href="#" onClick="showtu('+${row31.id}+');"><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></a></td>
                <td>${row31.customer}</td>
                <td>${row31.limit_date}</td>
                <td>${row31.date_pay_ns}</td>
                <td>${row31.change_date_tc}</td>
            </tr>
        </c:forEach>    
    </table>
</c:if>
<sql:query var="rez30" dataSource="${DB}" >
    DECLARE	@return_value int
    EXEC	@return_value = [dbo].[projects_in_progress]
    SELECT	'Return Value' = @return_value
</sql:query>
<c:if test="${!empty rez30.rows}">
    <h2>Проекти у процесі роботи:</h2>
    <table class="table1" >
        <tr >
            <th>&nbsp;</th>
            <th>П.І.Б.</th>
            <th>№ ТУ</th>
            <th>Виконавець проекту</th>
            <th>Дата подання проекту на погодження</th>
            <th>День виконання</th>
        </tr>
        <c:forEach var="row30" items="${rez30.rows}">
            <tr>
                <td><a href="#" onClick="showtu('+${row30.id}+');"><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></a></td>
                <td>${row30.customer}</td>
                <td>${row30.number}</td>
                <td>${row30.executor}</td>
                <td>${row30.date_of_submission}</td>
                <td>${row30.count}</td>
            </tr>
        </c:forEach>    
    </table>
</c:if>
<sql:query var="rez3" dataSource="${DB}" >
    DECLARE	@return_value int
    EXEC	@return_value = [dbo].[Termin_vydachi_15_rob_dniv]
    SELECT	'Return Value' = @return_value
</sql:query>
<c:if test="${!empty rez3.rows}">
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
        <c:forEach var="row3" items="${rez3.rows}">
            <tr>
                <td><a href="#" onClick="showtu('+${row3.id}+');"><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></a></td>
                <td>${row3.number}</td>
                <td>${row3.customer}</td>
                <td>${row3.object_name}</td>
                <td>${row3.object_adress}</td>
                <td>${row3.registration_date}</td>
                <td>${row3.initial_registration_date_rem_tu}</td>
            </tr>
        </c:forEach>    
    </table>
</c:if>
<sql:query var="rez4" dataSource="${DB}" >
    DECLARE	@return_value int
    EXEC	@return_value = [dbo].[proterminovani_20_dniv]
    SELECT	'Return Value' = @return_value
</sql:query>
<c:if test="${!empty rez4.rows}">
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
        <c:forEach var="row4" items="${rez4.rows}">
            <tr>
                <td><a href="#" onClick="showtu('+${row4.id}+');"><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></a></td>
                <td>${row4.number}</td>
                <td>${row4.customer}</td>
                <td>${row4.object_name}</td>
                <td>${row4.object_adress}</td>
                <td>${row4.date_contract}</td>
                <td>${row4.date_customer_contract_tc}</td>
            </tr>
        </c:forEach>    
    </table>
</c:if>
<sql:query var="rez5" dataSource="${DB}" >
    DECLARE	@return_value int
    EXEC	@return_value = [dbo].[Termin_dii_TU]
    SELECT	'Return Value' = @return_value
</sql:query>
<c:if test="${!empty rez5.rows}">
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
        <c:forEach var="row5" items="${rez5.rows}">
            <tr>
                <td><a href="#" onClick="showtu('+${row5.id}+');"><img src="../codebase/imgs/edit3.bmp" alt="books_cat" width="15"/></a></td>
                <td>${row5.number}</td>
                <td>${row5.customer}</td>
                <td>${row5.object_name}</td>
                <td>${row5.object_adress}</td>
                <td>${row5.registration_date}</td>
                <td>${row5.date_customer_contract_tc}</td>
                <td>${row5.date_contract}</td>
                <td>${row5.end_dohovoru_tu}</td>
                <td>${row5.executor_company}</td>
            </tr>
        </c:forEach>    
    </table>
</c:if>
