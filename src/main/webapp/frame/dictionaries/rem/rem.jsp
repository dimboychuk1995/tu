    <%--
    Document   : rem
    Created on : Mar 13, 2013, 11:42:45 AM
    Author     : us8610
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script language="javascript">
            function editRecord(rem_id){
                var f=document.form;
                f.method="post";
                f.action='dictionaries/rem/edit.jsp?rem_id='+rem_id;
                f.submit();
            }
            function deleteRecord(id){
                var f=document.form;
                f.method="post";
                f.action='delete.jsp?rem='+id;
                f.submit();
            }
        </script>
        <style>
            table.table1{     font-family: "Trebuchet MS", sans-serif;     font-size: 12px;     font-weight: bold;     line-height: 1.4em;     font-style: normal;     border-collapse:separate; width: 1001px}
            .table1 td{     color: #FF7F00;     font-size:14px;     text-align:center;     padding:1px 0px; } 
            .table1 th{     color:#FF8C00; }
            .table1 td{     padding:1px;     text-align:center;     background-color:#EBEBEB;     border: 1px solid #ffca69;     -moz-border-radius:15px;     -webkit-border-radius:15px;     border-radius:15px;     color:#666;     text-shadow:1px 1px 1px #fff; }
            .table1 th{     padding:15px;     color:#fff;     text-shadow:1px 1px 1px #568F23;     border:1px solid #FFAA00;     border-bottom:3px solid #FFAA00;     background-color:#FF7F00;     background:-webkit-gradient(         linear,         left bottom,         left top,         color-stop(0.02, rgb(255,165,0)),         color-stop(0.51, rgb(255,174,26)),         color-stop(0.87, rgb(255,183,52))         );     background: -moz-linear-gradient(         center bottom,         rgb(255,165,0) 2%,         rgb(255,174,26) 51%,         rgb(255,183,52) 87%         );     -webkit-border-top-left-radius:5px;     -webkit-border-top-right-radius:5px;     -moz-border-radius:5px 5px 0px 0px;     border-top-left-radius:5px;     border-top-right-radius:5px; filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FFA500', endColorstr='#ffb734');}
        </style>
    </head>
    <body>
        <form method="post" name="form">
            <table class="table1" border="0" >
                <tr><th>РЕМ</th><th>Директор</th><th>Адреса</th><th>Довіреність</th><th></th></tr>
                <%
                    Connection c = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    InitialContext ic = new InitialContext();
                    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
                    try {
                        c = ds.getConnection();
                        String SQL = ""
                                + "SELECT [rem_id], "
                                + "       [rem_name], "
                                + "       [Director], "
                                + "       [rem_licality], "
                                + "       [dovirenist] "
                                + "FROM   [TUWeb].[dbo].[rem] "
                                + "WHERE rem_id BETWEEN 190 AND 350";
                        pstmt = c.prepareStatement(SQL);
                        rs = pstmt.executeQuery();
                        while (rs.next()) {%>
                <tr>
                    <td><%=rs.getString(2)%></td>
                    <td><%=rs.getString(3)%></td>
                    <td><%=rs.getString(4)%></td>
                    <td><%=rs.getString(5)%></td>
                    <td><input type="button" name="edit" value="Редагувати" style="background-color:#49743D;font-weight:bold;color:#ffffff;border-radius:7px;" onclick="editRecord(<%=rs.getString(1)%>);" ></td>
                        <%--<td><input type="button" name="delete" value="Видалити" style="background-color:#D64937; font-weight:bold;color: #444;border-radius:7px;" onclick="deleteRecord(<%=rs.getString(1)%>);" ></td>--%>
                </tr>
                <%}
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        SQLUtils.closeQuietly(rs);
                        SQLUtils.closeQuietly(pstmt);
                        SQLUtils.closeQuietly(c);
                        ic.close();
                    }
                %>
            </table>
    </body>
</html>
