<%-- 
    Document   : show
    Created on : 14 лют 2011, 10:37:48
    Author     : AsuSV
--%>

<%@page import="com.myapp.struts.loginActionForm"%>
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
    HttpSession ses = request.getSession();
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    String db = (String) ses.getAttribute("db_name");
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try {
        c = ds.getConnection();
        pstmt = c.prepareStatement("select "
                + "id"
                + ",tc_id"
                + ",case when join_point=1 then 'C4.1 Напруга 0.4 кВ 2 клас' "
                + "         when join_point=11 then 'C4.1 Напруга 0.23 кВ 2 клас' "
                + "         when join_point=2 then 'C4.0 Напруга 0.4 кВ 2 клас' "
                + "         when join_point=21 then 'C4.0 Напруга 0.23 кВ 2 клас' "
                + "         when join_point=3 then 'C3.1 Напруга 10 кВ 2 клас' "
                + "         when join_point=4 then 'C3.0 Напруга 10 кВ 2 клас' "
                + "         when join_point=5 then 'C2.1 Напруга 35 кВ 1 клас' "
                + "         when join_point=6 then 'C2.0 Напруга 35 кВ 1 клас' "
                + "         when join_point=7 then 'C1.1 Напруга 110 кВ 1 клас' "
                + "else '' end as join_point   "
                + ",isnull(selecting_point,'') as selecting_point"
                + ",isnull(opor_nom_04,'') as opor_nom_04"
                + ",isnull(fid_04_disp_name,'') as fid_04_disp_name"
                + ",isnull(cast(fid_04_leng as varchar),'') as fid_04_leng"
                + ",isnull(type_source,'') as type_source"
                + ",isnull(ps10.ps_name,'') as ps_10_disp_name"
                + ",isnull(ps_10_disp_name_tmp,'') as ps_10_disp_name_tmp"
                + ",isnull(cast(ps_10_u_rez as varchar),'') as ps_10_u_rez"
                + ",isnull(opor_nom_10,'') as opor_nom_10"
                + ",isnull(fid10.feed_name,'') as fid_10_disp_name"
                + ",isnull(cast(fid_10_leng as varchar),'') as fid_10_leng"
                + ",isnull(ps35.ps_name,'') as ps_35_disp_name"
                + ",isnull(cast(ps_35_u_rez as varchar),'') as ps_35_u_rez"
                + ",isnull(opor_nom_35,'') as opor_nom_35"
                + ",isnull(fid35.feed_name,'') as fid_35_disp_name"
                + ",isnull(cast(fid_35_leng as varchar),'') as fid_35_leng"
                + ",isnull(ps110.ps_name,'') as ps_110_disp_name"
                + ",isnull(cast(ps_110_u_rez as varchar),'') as ps_110_u_rez"
                + ",isnull(fid110.feed_name,'') as fid_110_disp_name"
                + ",isnull(cast(fid_110_leng as varchar),'') as fid_110_leng "
                + "from [SUPPLYCH]"
                + " left join [TUweb].[dbo].[ps_tu_web] ps10 on SUPPLYCH.ps_10_disp_name=ps10.ps_id"
                + " left join [TUweb].[dbo].[feed_35_110_tu_web] fid10 on SUPPLYCH.fid_10_disp_name=fid10.feed_id"
                + " left join [TUweb].[dbo].[ps_tu_web] ps35 on SUPPLYCH.ps_35_disp_name=ps35.ps_id"
                + " left join [TUweb].[dbo].[feed_35_110_tu_web] fid35 on SUPPLYCH.fid_35_disp_name=fid35.feed_id"
                + " left join [TUweb].[dbo].[ps_tu_web] ps110 on SUPPLYCH.ps_110_disp_name=ps110.ps_id"
                + " left join [TUweb].[dbo].[feed_35_110_tu_web] fid110 on SUPPLYCH.fid_110_disp_name=fid110.feed_id"
                + " where tc_id=" + request.getParameter("tu_id")
                + " order by tc_id");
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="../../js/jquery-1.4.min.js"></script>
        <script  type="text/javascript" src="../../codebase/jquery.cookie.js"></script>
        <script type="text/javascript" src="../detailedview/js/myscript.js"></script>
        <script  type="text/javascript" >
            $(document).ready(function(){
                permision();
                $('.del').click(function(){
                    if ($.cookie("permisions")=="-1") return false;
                    return window.confirm('Ви дійсно бажаєте видалити схему?'); 
                });
            });
        </script>
        <title>JSP Page</title>
    </head>
    <body>
        <%
            if (!((loginActionForm) ses.getAttribute("log")).getRole().equals("128")) {
        %>
        <a href="new.do?method=sd&tu_id=<%=request.getParameter("tu_id")%>&req_paw=<%=request.getParameter("req_paw")%>" id="new">Додати новий</a>
        <%}%>
        <table border="1" cellspacing="0" cellpadding="0" align="center" class="tabl">
            <tr>
                <%
                    if (!((loginActionForm) ses.getAttribute("log")).getRole().equals("128")) {
                %>
                <td align="center" width="40px">Дії</td>
                <%}%>
                <td align="center" width="10px">Точка приєднання</td>
                <td align="center" width="40px">Точка приєднання</td>
                <td align="center" width="40px">Номер опори</td>
                <td align="center" width="40px">Назва ЛЕП(диспет. назва)</td>
                <td align="center" width="10px">Довжина (будівництва/ реконстукції)</td>
                <td align="center" width="40px">Тип джерела</td>
                <td align="center" width="40px">П/С 10/0.4 Назв.</td>
                <td align="center" width="40px">Кілька П/С 10/0.4</td>
                <td align="center" width="40px">Резерв П/С 10/0.4</td>
                <td align="center" width="40px">№ опора 10 кВ.</td>
                <td align="center" width="40px">Назва ЛЕП(диспет. назва) 10 кВ.</td>
                <td align="center" width="10px">Довжина (будівництва/ реконстукції) 10 кВ.</td>
                <td align="center" width="40px">П/С назв. 35 кВ.</td>
                <td align="center" width="40px">Резерв 35 кВ.</td>
                <td align="center" width="40px">№ опора 35 кВ.</td>
                <td align="center" width="10px">Назва ЛЕП (диспет. назва) 35 кВ.</td>
                <td align="center" width="40px">Довжина (будівництва/ реконстукції) 35 кВ.</td>
                <td align="center" width="40px">П/С назв. 110 кВ.</td>
                <td align="center" width="40px">Резерв 110 кВ.</td>
                <td align="center" width="10px">Назва ЛЕП (диспет. назва) 110 кВ.</td>
                <td align="center" width="40px">Довжина (будівництва/ реконстукції) 110 кВ.</td>
                <%--<td align="center" width="40px">Номер опори</td>
                <td align="center" width="40px">Дії</td>
                <td align="center" width="10px">Точка приєднання</td>--%>



            </tr>
            <% while (rs.next()) {%>
            <tr>

                <%
                    if (!((loginActionForm) ses.getAttribute("log")).getRole().equals("128")) {
                %>
                <td align="center">
                    <a id="edit" href="new.do?method=edit&id=<%= rs.getString("id")%>&tu_id=<%=request.getParameter("tu_id")%>&req_paw=<%=request.getParameter("req_paw")%>">Редагувати</a>
                    <a class="del"href="new.do?method=delete&id=<%= rs.getString("id")%>&tu_id=<%=request.getParameter("tu_id")%>">Видалити</a>
                </td>
                <%}%>

                <td align="center"><%= rs.getString(3)%></td>
                <td align="center"><%= rs.getString(4)%></td>
                <td align="center"><%= rs.getString(5)%></td>
                <td align="center"><%= rs.getString(6)%></td>
                <td align="center"><%= rs.getString(7)%></td>
                <td align="center"><%= rs.getString(8)%></td>
                <td align="center"><%= rs.getString(9)%></td>
                <td align="center"><%= rs.getString(10)%></td>
                <td align="center"><%= rs.getString(11)%></td>
                <td align="center"><%= rs.getString(12)%></td>
                <td align="center"><%= rs.getString(13)%></td>
                <td align="center"><%= rs.getString(14)%></td>
                <td align="center"><%= rs.getString(15)%></td>
                <td align="center"><%= rs.getString(16)%></td>
                <td align="center"><%= rs.getString(17)%></td>
                <td align="center"><%= rs.getString(18)%></td>
                <td align="center"><%= rs.getString(19)%></td>
                <td align="center"><%= rs.getString(20)%></td>
                <td align="center"><%= rs.getString(21)%></td>
                <td align="center"><%= rs.getString(22)%></td>
                <td align="center"><%= rs.getString(23)%></td>
            </tr>
            <%}%>
        </table>
    </body>
    <%} catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(c);
            ic.close();
        }
    %>
</html>
