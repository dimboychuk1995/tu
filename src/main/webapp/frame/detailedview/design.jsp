<%-- 
    Document   : design
    Created on : 10 лют 2010, 9:05:28
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
%>
<script type="text/javascript" src="detailedview/js/design.js"></script>
<script type="text/javascript" src="detailedview/js/access.js"></script>
<script type="text/javascript">
  $(document).ready(function(){

	$(function() {
		$(".datepicker").datepicker();
	});
        <%--!designacces("<%=id_rem%>","<bean:write name="DetalViewActionForm" property="initial_registration_date_rem_tu" />");--%>
        <%--rem("<%=id_rem%>");--%>
  });
</script>
<html:form action="/frame/detailedview/design" >
<table border="0" id="design" >
    <tr>
        <td>Виконавець проекту</td>
        <td><html:select  property="develloper_company" styleClass="design design rem">
                <html:option value="0">Виберіть виконавця</html:option>
                <html:optionsCollection name="DetalViewActionForm" property="performer_list"
                                        label="name" value="id"/>
            </html:select>
        </td>
    </tr>
    <%--<tr>
        <td><bean:message key="Design.Developer_begin_date" /></td>
        <td><html:text name="DetalViewActionForm" property="developer_begin_date" size="10" styleClass="datepicker design rem"/></td>
    </tr>
    <tr>
        <td><bean:message key="Design.Develloper_end_date" /></td>
        <td><html:text name="DetalViewActionForm" property="develloper_end_date" size="10" styleClass="datepicker design rem"/></td>
    </tr>
    <tr>
        <td><bean:message key="Design.devellopment_price" /> грн.</td>
        <td><html:text name="DetalViewActionForm" property="devellopment_price" size="8" onkeypress ="isDigit()" styleClass="design rem"/>
        <bean:message key="currensy" />
        <bean:message key="Design.pay_date_devellopment" />
        <html:text name="DetalViewActionForm" property="pay_date_devellopment" size="10" styleClass="datepicker design rem"/>
        </td>
    </tr>
    <tr>
        <td><bean:message key="Design.agreement_price" /> грн.</td>
        <td><html:text name="DetalViewActionForm" property="agreement_price" size="8" onkeypress ="isDigit()" styleClass="design rem"/>
        <bean:message key="currensy" />
        <bean:message key="Design.pay_date_devellopment" />
        <html:text name="DetalViewActionForm" property="pay_date_agreement" size="10" styleClass="datepicker design rem" />
    </td>
    </tr>--%>
    <tr>
        <td>Дата погодження проекту</td>
        <td><html:text name="DetalViewActionForm" property="agreement_date" size="10" styleClass="datepicker design rem"/></td>
    </tr>
</table>
</html:form>