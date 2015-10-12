<%-- 
    Document   : vts
    Created on : 10 лют 2010, 8:57:33
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<table border="0">
    <tr>
        <td><bean:message key="VTS.number" /></td>
        <td><html:text name="DetalViewActionForm" property="number"/></td>
    </tr>
    <tr>
        <td><bean:message key="VTS.In_no_application_office" /></td>
        <td><input type="text" name="In_no_application_office" value=""/></td>
    </tr>
    <tr>
        <td><bean:message key="VTS.registration_date" /></td>
        <td><html:text name="DetalViewActionForm" property="registration_date" styleId="calInput3" readonly="true" size="10"/></td>		<!--  -->
    </tr>
   <tr>
        <td><bean:message key="VTS.Date_transfer_affiliate" /></td>
        <td><html:text name="DetalViewActionForm" property="date_transfer_affiliate" styleId="calInput4" readonly="true" size="10"/></td>
   </tr>
   <tr>
        <td><bean:message key="VTS.Date_return_from_affiliate" /></td>
        <td><html:text name="DetalViewActionForm" property="date_return_from_affiliate" styleId="calInput5" readonly="true" size="10"/></td>
    </tr>
</table>
