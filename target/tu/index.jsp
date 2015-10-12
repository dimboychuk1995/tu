<%-- 
    Document   : index
    Created on : 24 лист 2009, 10:15:49
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
response.setStatus(301);
response.setHeader( "Location", "frame/login.do?method=view" );
response.setHeader( "Connection", "close" );
%>

<%--<jsp:forward page="frame/login.do">
<jsp:param name="method"  value="view"/>
</jsp:forward>--%>
