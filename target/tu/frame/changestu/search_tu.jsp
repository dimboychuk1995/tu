<%-- 
    Document   : search_tu
    Created on : 30 серп 2011, 9:01:40
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <a href="changestuxp.jsp?tu_id=-1"><h1>Вернутись до змін</h1></a>
        <form action="rez_serch.jsp"> 
            <table>
                <tr>
                    <td>
                        Введіть прізвище:
                    </td>
                    <td>
                        <input type="text" name="pip"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" name="Знайти" />
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
