<%-- 
    Document   : helplayot
    Created on : 23 квіт 2010, 10:14:57
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Help Page</title>
    </head>
    <body>
        <table>
            <tr>
                <td>
                    <html:link href="hvvid.jsp">Ввід</html:link>
                </td>
                <td>
                    <tiles:insert attribute="content"/>
                </td>
            </tr>
        </table>
    </body>
</html>
