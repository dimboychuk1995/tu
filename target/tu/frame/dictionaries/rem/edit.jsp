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
        <style>
            table.table1{     font-family: "Trebuchet MS", sans-serif;     font-size: 12px;     font-weight: bold;     line-height: 1.4em;     font-style: normal;     border-collapse:separate; }
            .table1 td{     color: #9CD009;     font-size:14px;     text-align:center;     padding:1px 0px; } 
            .table1 th{     color:#666; }
            .table1 td{     padding:1px;     text-align:center;     background-color:#DEF3CA;     border: 2px solid #E7EFE0;     -moz-border-radius:15px;     -webkit-border-radius:15px;     border-radius:15px;     color:#666;     text-shadow:1px 1px 1px #fff; }
            .table1 th{     padding:15px;     color:#fff;     text-shadow:1px 1px 1px #568F23;     border:1px solid #FFAA00;     border-bottom:3px solid #FFAA00;     background-color:#FF7F00;     background:-webkit-gradient(         linear,         left bottom,         left top,         color-stop(0.02, rgb(255,165,0)),         color-stop(0.51, rgb(255,174,26)),         color-stop(0.87, rgb(255,183,52))         );     background: -moz-linear-gradient(         center bottom,         rgb(255,165,0) 2%,         rgb(255,174,26) 51%,         rgb(255,183,52) 87%         );     -webkit-border-top-left-radius:5px;     -webkit-border-top-right-radius:5px;     -moz-border-radius:5px 5px 0px 0px;     border-top-left-radius:5px;     border-top-right-radius:5px; filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FFA500', endColorstr='#ffb734');}
        </style>
    </head>
    <body>
        <form method="post" action="update.jsp">
            <table class="table1" border="0">
                <tr><th>РЕМ</th><th>Директор</th><th>Адреса</th><th>Довіреність</th><th colspan="2"></th></tr>
                <%

                    String id = request.getParameter("rem_id");
                    int no = Integer.parseInt(id);
                    int sumcount = 0;
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
                                + "WHERE rem_id='" + no + "'";
                        pstmt = c.prepareStatement(SQL);
                        rs = pstmt.executeQuery();
                        while (rs.next()) {%>
                <tr>
                    <td><input type="text" name="rem_name" value="<%=rs.getString(2)%>" style="text-align:center;" size="25">> </td>
                    <td><input type="text" name="dir_name" value="<%=rs.getString(3)%>" style="text-align:center;" size="35">></td>
                    <td><input type="text" name="rem_loc" value="<%=rs.getString(4)%>"style="text-align:center;" size="45">></td>
                    <td><input type="text" name="dovirenist" value="<%=rs.getString(5)%>" style="text-align:center;" size="20">></td>
                    <td><input type="Submit" name="edit" value="Зберегти" style="background-color:#49743D; font-weight:bold;color:#ffffff;border-radius:7px;" ></td>
                    <td><input type="button" name="edit" value="Назад" style="background-color:#9999FF;font-weight:bold;color:#ffffff;border-radius:7px;" onclick="history.back();" ></td>
                    <td hidden="true"><input type="hidden" name="rem_id" value="<%=rs.getString(1)%>"></td>
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
        </form>
    </body>
</html>