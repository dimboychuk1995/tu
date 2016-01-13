<%-- 
    Document   : pswd
    Created on : 13 квіт 2010, 11:52:25
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
Заміна пароля

<html:form action="/frame/pass">
    <input type="hidden" name="user_name" value="<bean:write name="log" property="user"/>">
    <!--<input type="hidden" name="user_id_rem" value="<bean:write name="log" property="id_rem"/>">   -->
    <table>
        <tr>
            <td>Старий пароль</td>
            <td><html:password property="user_pass"/></td>
        </tr>
        <tr>
            <td>Новий пароль</td>
            <td><html:password property="new_user_pass"/></td>
        </tr>
        <tr>
            <td>Повторити новий пароль</td>
            <td><html:password property="rnew_user_pass"/></td>
        </tr>
        <tr>
            <td></td>
            <td><html:submit property="method" value="edit"/></td>
        </tr>
    </table>
</html:form>