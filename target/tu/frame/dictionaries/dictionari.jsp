<%-- 
    Document   : dictionari
    Created on : 25 лют 2010, 16:07:12
    Author     : AsuSV
--%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-nested" prefix="nested" %>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div style="width:30%;">
            <html:form action="/frame/dictionaries">
                <hr>
                <input type="hidden" name="dic" value="<%=request.getParameter("dic")%>"/>
                Назва:<html:text name="DictionariActionForm" property="name"/>
                <logic:equal parameter="dic" value="locality">
                    <p>
                        Тип населеного пункту:
                        <html:select property="type">
                            <html:option value="1">Місто</html:option>
                            <html:option value="2">Село</html:option>
                            <html:option value="3">CMT</html:option>
                        </html:select>
                    <p>
                        Відношення до РЕМу
                        <select name="parid">
                            <option value="<bean:write name="log" property="id_rem"/>" >належить до РЕМ</option>
                            <option value="0" >НЕ належить до РЕМ</option>
                        </select>
                    </logic:equal>
                <p>
                    <html:submit property="method" value="add" styleClass="button_add"/>
                <hr>
                <html:select property="namelist" size="20">
                    <html:optionsCollection property="list_name" label="name" value="id"/>
                </html:select>
            </html:form>
        </div>
    </body>
</html>
