<%@ page import="com.myapp.struts.loginActionForm" %>
<%--
    Document   : tund
    Created on : 10 лют 2010, 9:00:03
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
//HttpSession ses=request.getSession();
//loginActionForm login=(loginActionForm)ses.getAttribute("log");
//String id_rem = login.getUREM_ID();
String id_rem = ua.ifr.oe.tc.list.MyCoocie.getCoocie("UREM_ID",request);
String perm = ua.ifr.oe.tc.list.MyCoocie.getCoocie("permisions", request);
%>
<script type="text/javascript" src="detailedview/js/tund.js"></script>
<script type="text/javascript" src="detailedview/js/myscript.js"></script>
<script type="text/javascript">
  $(document).ready(function(){
       permision();
	$(function() {
           	$(".datepicker").datepicker();
                <%--!tundacces("<%=id_rem%>","<bean:write name="DetalViewActionForm" property="date_customer_contract_tc" />");--%>
                enddata();
                $("#term_tc").change(function(){
                   enddata();
                     var b = $( "#date_contract" ).val();
                    if(b!=''){
                        var temp = new Array();
                        temp = b.split('.');
                        var y=parseInt(temp[2])+parseInt($('#term_tc').val());
                        $( "#end_dohovoru_tu" ).val(temp[0]+'.'+temp[1]+'.'+y);
                    }

                });
	});
        
  });

  function enddata(){
if ("2"=="<%=perm%>"){$('#numb_dog').attr('readonly', false)};
  }

</script>
<html:form action="/frame/detailedview/tund">
<table border="0">
    <tr>
        <td><bean:message key="VTS.number" /></td>
        <td><html:text name="DetalViewActionForm" property="number" styleClass="tund" styleId="numb_dog" readonly="true"/></td>
    </tr>
    <tr>
        <td>Вихідна дата реєстрації ТУ в РЕМ</td>
        <td><html:text name="DetalViewActionForm" property="initial_registration_date_rem_tu" size="10" styleClass="datepicker tund"/></td>
    </tr>
    <tr>
        <td><bean:message key="tund.registration_no_contract" /></td>
        <td><html:text name="DetalViewActionForm" property="registration_no_contract" styleClass="tund"/></td>
    </tr>
    <tr>
        <td><bean:message key="tund.date_customer_contract_tc" /></td>
        <td><html:text name="DetalViewActionForm" property="date_customer_contract_tc" size="10" styleClass="datepicker tund"/></td>
    </tr>
    
    
    <%
        HttpSession ses = request.getSession();
        if (!((loginActionForm) ses.getAttribute("log")).getRole().equals("128")) {
    %>
    <tr>
        <td>Дата вхiдної заяви у ВАТ</td>
        <td><html:text name="DetalViewActionForm" property="input_number_application_vat" size="10" styleClass="datepicker tund"/></td>
    </tr>
    <tr>
        <td>Дата передачі у РЕМ</td>
        <td><html:text name="DetalViewActionForm" property="date_transfer_affiliate" size="10" styleClass="datepicker tund"/></td>
    </tr>
    <%}%>
    
    
    <tr>
        <td>Дата повернення підписаного примірника з РЕМ</td>
        <td><html:text name="DetalViewActionForm" property="date_return_from_affiliate" size="10" styleClass="datepicker tund"/></td>
    </tr>
    <tr>
        <td><%--<bean:message key="tund.Otz_no" />--%>Технічні рекомендації</td>
        <td><html:text name="DetalViewActionForm" property="otz_no" styleClass="tund"/></td>
    </tr>
   <tr>
        <td><bean:message key="tund.term_tc" /></td>
        <td><html:select  property="term_tc" styleId="term_tc" styleClass="tund">
                <html:option value="0">Інший термін</html:option>
                <html:optionsCollection name="DetalViewActionForm" property="term_tc_list"
                                        label="name" value="id"/>
            </html:select>

        </td>
    </tr>
   <tr>
        <td><bean:message key="tund.date_contract" /></td>
        <td><html:text name="DetalViewActionForm" property="date_contract" size="10" styleId="date_contract" styleClass="datepicker tund" /></td>
    </tr>
    <tr>
        <td>Закінчення договору.ТУ</td>
        <td><html:text name="DetalViewActionForm" property="end_dohovoru_tu" size="10" styleId="end_dohovoru_tu" styleClass="datepicker tund"/></td>
    </tr>
    <tr>
        <td><bean:message key="tund.state_contract" /></td>
        <td><html:select  property="state_contract" styleClass="tund">
                <html:option value="0">--</html:option>
                <html:optionsCollection name="DetalViewActionForm" property="state_contract_list"
                                        label="name" value="id"/>
            </html:select>
        </td>
    </tr>
    <%--    <tr>
        <td>Дата документу</td>
        <td><html:text name="DetalViewActionForm" property="registration_date" size="10" styleClass="datepicker tund" styleClass="tund"/></td>
</tr>--%>
    <tr>
        <td><bean:message key="tund.performance_data_tc_no" /></td>
        <td><html:text name="DetalViewActionForm" property="performance_data_tc_no" styleClass="tund"/></td>
    </tr>

    <%if (!((loginActionForm) ses.getAttribute("log")).getRole().equals("128")) {%>
    <tr>
        <td>Дата виготовлення</td>
        <td><html:text name="DetalViewActionForm" property="date_manufacture" size="10" styleClass="datepicker tund" /></td>
    </tr>
    <%}%>
    <tr>
        <td>Термін надання послуги з приєднання, днів</td>
        <td><html:text name="DetalViewActionForm" property="term_for_joining" size="10" styleClass="tund" /></td>
    </tr>
    <%--<tr>
        <td>Плата за приеднання грн.</td>
        <td><html:text name="DetalViewActionForm" property="payment_for_join" styleClass="tund"/></td>
</tr>--%>
        <bean:define id="SC_tu_id"  toScope="session" >
          <%=request.getParameter("tu_id")%>
       </bean:define>
</table>
</html:form>