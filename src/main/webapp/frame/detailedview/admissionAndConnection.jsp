<%-- 
    Document   : admission
    Created on : 10 лют 2010, 9:03:06
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
//HttpSession ses=request.getSession();
//loginActionForm login=(loginActionForm)ses.getAttribute("log");
//String id_rem = login.getUREM_ID();
    String id_rem = ua.ifr.oe.tc.list.MyCoocie.getCoocie("UREM_ID", request);
    String perm = ua.ifr.oe.tc.list.MyCoocie.getCoocie("permisions", request);
%>
<script type="text/javascript" src="detailedview/js/admission.js"></script>
<script type="text/javascript" src="detailedview/js/access.js"></script>



<script type="text/javascript">
    $(document).ready(function(){
        $(".datepicker").datepicker();
        $(".time").timepicker();
    });
</script>
<html:form action="/frame/detailedview/admissionAndConnection">
    <table border="0">
        <% HttpSession ses = request.getSession();%>
        <tr>
            <td>Номер договору про постачання (користування)</td>
            <td><html:text name="DetalViewActionForm" property="number_adm" size="14" styleClass="admAndCon"/></td>
        </tr>
        <tr>
            <td>Тип об'єкту:</td>
            <td><html:select  property="type_object">
                    <html:option value="0">&nbsp;</html:option>
                    <html:option value="1">побутовий</html:option>
                    <html:option value="2">юридичний</html:option>
                </html:select>
            </td>
        </tr>
        <tr>
            <td>Дата подання подання заявки на відключення</td>
            <td><html:text name="DetalViewActionForm" property="date_kill_voltage" size="10" styleClass="datepicker admAndCon"/></td>
        </tr>
        <tr>
            <td><bean:message key="Admission.Date_admission_consumer" /></td>
            <td><html:text name="DetalViewActionForm" property="date_admission_consumer" size="10" styleClass="datepicker admAndCon"/></td>
        </tr>
        <tr>
            <td>Дата подання напруги</td>
            <td><html:text name="DetalViewActionForm" property="date_filling_voltage" size="10" styleClass="datepicker admAndCon"/></td>
        </tr>
        <tr>
            <td>Час закриття наряду на подачу напруги</td>
            <td><html:text name="DetalViewActionForm" property="time_close_nar" size="10" styleClass="time admAndCon"/></td>
        </tr>
        <tr>
            <td>Дата завершення БМР</td>
            <td><html:text name="DetalViewActionForm" property="date_start_bmr" size="10" styleClass="datepicker admAndCon"/></td>
        </tr>
        <tr>
            <td>Дата передачі акту прийому-здачі гол.інженеру</td>
            <td><html:text name="DetalViewActionForm" property="date_giving_akt" size="10" styleClass="datepicker admAndCon"/></td>
        </tr>
        <tr>
            <td>Дата погодження гол.інж. акту прийому-здачі</td>
            <td><html:text name="DetalViewActionForm" property="date_admission_akt" size="10" styleClass="datepicker admAndCon"/></td>
        </tr>
        <tr><td colspan="2"><hr/></td></tr>
        <tr style="color: red;font-weight: bold;"><td colspan="2">Основні ТУ</td></tr>
        <tr><td colspan="2"><hr/></td></tr>
       
            <tr>
                <td>Дата видачі договору про постачання (користування)</td>
                <td><html:text name="DetalViewActionForm" property="date_issue_contract_o" size="10" styleClass="datepicker admAndCon"/></td>
            </tr>
            <tr>
                <td>Дата укладання договору про постачання (користування)</td>
                <td><html:text name="DetalViewActionForm" property="date_contract_o" size="10" styleClass="datepicker admAndCon"/></td>
            </tr>
            <tr>
                <td>Дата підключення об’єкту</td>
                <td><html:text name="DetalViewActionForm" property="date_connect_object_o" size="10" styleClass="datepicker admAndCon"/></td>
            </tr>
            <tr>
                <td>Потужність за договором про постачання користування, кВт</td>
                <td><html:text name="DetalViewActionForm" property="power_contract_o" size="10" styleClass="admAndCon" /></td>
            </tr>
        <tr><td colspan="2"><hr/></td></tr>
        <tr style="color: red;font-weight: bold;"><td colspan="2">Будівельний майданчик</td></tr>
        <tr><td colspan="2"><hr/></td></tr>
       
            <tr>
                <td>Дата видачі договору про постачання (користування)</td>
                <td><html:text name="DetalViewActionForm" property="date_issue_contract_bm" size="10" styleClass="datepicker admAndCon"/></td>
            </tr>
            <tr>
                <td>Дата укладання договору про постачання (користування)</td>
                <td><html:text name="DetalViewActionForm" property="date_contract_bm" size="10" styleClass="datepicker admAndCon"/></td>
            </tr>
            <tr>
                <td>Дата підключення об’єкту</td>
                <td><html:text name="DetalViewActionForm" property="date_connect_object_bm" size="10" styleClass="datepicker admAndCon"/></td>
            </tr>
            <tr>
                <td>Потужність за договором про постачання користування, кВт</td>
                <td><html:text name="DetalViewActionForm" property="power_contract_bm" size="10" styleClass="admAndCon"/></td>
            </tr>
        </table>

</html:form>