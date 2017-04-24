<%--
  Created by IntelliJ IDEA.
  User: us9522
  Date: 24.04.2017
  Time: 8:27
  To change this template use File | Settings | File Templates.
--%>
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.*,java.text.NumberFormat"%>

<%  response.setHeader("Content-Disposition", "inline;filename=fiz.doc");
    NumberFormat nf = NumberFormat.getInstance();
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    HttpSession ses = request.getSession();
    String db = new String();
    if (!ses.getAttribute("db_name").equals(null)) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try {
        c = ds.getConnection();
        String qry = "select \n" +
                "\tTC_V2.id,\n" +
                "\tcustomer_soc_status,\n" +
                "\tcase \n" +
                "\t\twhen customer_soc_status in ('1','6') then 'Громадянин (ка)'\n" +
                "\t\twhen customer_soc_status in ('15','11') then 'Приватний підприємець'\n" +
                "\t\twhen customer_soc_status in ('8','9','13','10','7','12') then (select customer_post from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ")\n" +
                "\t\twhen customer_soc_status in ('19','20','2','3','4','5','14','16') then (select customer_post from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ")\n" +
                "\tend as customer_soc_status,\n" +
                "\n" +
                "\tcase \n" +
                "\t\twhen customer_soc_status in ('1','6') then ''\n" +
                "\t\twhen customer_soc_status in ('15','11') then (select juridical from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ") \n" +
                "\t\twhen customer_soc_status in ('8','9','13','10','7','12') then (select juridical from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ") \n" +
                "\t\twhen customer_soc_status in ('19','20','2','3','4','5','14','16') then \n" +
                "\t\t\t(select  (TUWeb.dbo.TC_LIST_customer_soc_status.name collate cyrillic_general_ci_as + ' ' + dbo.TC_V2.juridical) as customer_soc_status_and_uridical_name\n" +
                "\t\t\t\tfrom dbo.TC_V2 join TUWeb.dbo.TC_LIST_customer_soc_status on dbo.TC_V2.customer_soc_status = TUWeb.dbo.TC_LIST_customer_soc_status.id\n" +
                "\t\t\twhere TC_V2.id = " + request.getParameter("tu_id") + ")\n" +
                "\tend as customer_soc_status_and_uridical_name,\n" +
                "\n" +
                "\tcase \n" +
                "\t\twhen customer_soc_status in ('1','6') then (select f_name + ' ' + s_name + ' ' + t_name from dbo.TC_V2 where id = " + request.getParameter("tu_id") +")\n" +
                "\t\twhen customer_soc_status in ('15','11') then ''\n" +
                "\t\twhen customer_soc_status in ('8','9','13','10','7','12') then (select f_name + ' ' + s_name + ' ' + t_name from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ")\n" +
                "\t\twhen customer_soc_status in ('19','20','2','3','4','5','14','16') then (select f_name + ' ' + s_name + ' ' + t_name from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ")\n" +
                "\tend as customer_full_name,\n" +
                "\n" +
                "\tcase \n" +
                "\t\twhen cus.type = 3 then 'смт. '\n" +
                "\t\twhen cus.type = 1 then 'м. '\n" +
                "\t\twhen cus.type = 2 then 'с. '\n" +
                "\tend as customer_locality_type,\n" +
                "\n" +
                "\tcus.name as customer_locality,\n" +
                "\n" +
                "\tisnull('вул. ' + customer_adress, '') as customer_adress,\n" +
                "\n" +
                "\tTUWeb.dbo.rem.rem_name as rem_name,\n" +
                "\n" +
                "\t'п. ' + TUWeb.dbo.rem.director_dav as director_dav,\n" +
                "\n" +
                "\t'№ ' + number as number_rec,\n" +
                "\n" +
                "\tTUWeb.dbo.TC_LIST_customer_soc_status.name collate cyrillic_general_ci_as + ' ' + juridical + ' ' + (select f_name + ' ' + s_name + ' ' + t_name from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ") \n" +
                "\t\t+ ' ' + '(' + isnull(object_name, '') + ')' as customer_name,\n" +
                "\n" +
                "\n" +
                "\tcase \n" +
                "\t\twhen ob.type = 3 then 'смт. '\n" +
                "\t\twhen ob.type = 1 then 'м. '\n" +
                "\t\twhen ob.type = 2 then 'с. '\n" +
                "\tend as customer_object_type,\n" +
                "\n" +
                "\tob.name as object_locality,\n" +
                "\n" +
                "\tisnull(object_adress, '') as object_adress\n" +
                "\t\n" +
                "from dbo.TC_V2 \n" +
                "\tjoin dbo.TC_LIST_locality cus on convert(varchar, cus.id) = convert(varchar, TC_V2.customer_locality)\n" +
                "\tjoin TUWeb.dbo.rem on TUWeb.dbo.rem.rem_id = TC_V2.department_id \n" +
                "\tjoin TUWeb.dbo.TC_LIST_customer_soc_status on TUWeb.dbo.TC_LIST_customer_soc_status.id = TC_V2.customer_soc_status\n" +
                "\tjoin dbo.TC_LIST_locality ob on convert(varchar, ob.id) = convert(varchar, TC_V2.name_locality)\n" +
                "where TC_V2.id = " + request.getParameter("tu_id");



        pstmt = c.prepareStatement(qry);
        rs = pstmt.executeQuery();
        System.out.println(qry);
        rs.next();
%>

<html>
<head>
    <title>Title</title>
</head>
<body>
    <%} catch (SQLException e) {
        e.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    }
    %>
</body>
</html>
