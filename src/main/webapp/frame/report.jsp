<%-- 
    Document   : report
    Created on : 8 квіт 2010, 11:40:00
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<logic:equal value="1" parameter="rep">
    <tiles:insert definition="rep1Layout"/>
</logic:equal>
<logic:equal value="2" parameter="rep">
    <tiles:insert definition="rep2Layout"/>
</logic:equal>
<logic:equal value="3" parameter="rep">
    <tiles:insert definition="rep3Layout"/>
</logic:equal>
<logic:equal value="4" parameter="rep">
    <tiles:insert definition="rep4Layout"/>
</logic:equal>
<logic:equal value="5" parameter="rep">
    <tiles:insert definition="rep5Layout"/>
</logic:equal>
<logic:equal value="6" parameter="rep">
    <tiles:insert definition="rep6Layout"/>
</logic:equal>
<logic:equal value="7" parameter="rep">
    <tiles:insert definition="rep7Layout"/>
</logic:equal>