<%-- 
    Document   : savecustomer
    Created on : 21 трав 2010, 11:24:09
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@page import="java.util.*" %>
Дані успішно збережені !
<html:textarea name="DetalViewActionForm" property="do1" cols="100" styleClass="edit dataobjects"/>
<%-- = ua.ifr.oe.tc.list.MyCoocie.getCoocie("val1", request)--%>
<%
    Map par =new HashMap();
    par =request.getParameterMap();
    Set s=par.entrySet();

    Iterator it=s.iterator();

%>
<%--
<%
    String ParameterNames = "";
    for(Enumeration e = request.getParameterNames();e.hasMoreElements(); ){
            ParameterNames = (String)e.nextElement();
            out.print(ParameterNames + "=");
            out.println(request.getParameter(ParameterNames));
    }
%>
--%>
    