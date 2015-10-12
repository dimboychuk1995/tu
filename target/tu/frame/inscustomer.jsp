<%-- 
    Document   : test
    Created on : 15 черв 2010, 11:07:03
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%@ page import="com.myapp.struts.loginActionForm"%>
<%
            HttpSession ses=request.getSession();
            //String db=new String();
            //if(!ses.getAttribute("db_name").equals(null)){ db=(String)ses.getAttribute("db_name");}
            //else{db=ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name",request);}
            loginActionForm log =  (loginActionForm)ses.getAttribute("log");
            %>
            <jsp:forward page="tab.do">
                <jsp:param name="method" value="new"/>
                <jsp:param name="tu_id" value="-1" />
                <jsp:param name="bdname" value='<%=log.getDb_name()%>'/>
            </jsp:forward>
    </body>
</html>
