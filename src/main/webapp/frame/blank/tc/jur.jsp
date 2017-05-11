<%-- 
    Document   : jur
    Created on : 16 лют 2011, 16:19:37
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.*"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%  response.setHeader("Content-Disposition", "inline;filename=jur.doc");
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
        String qry = "SELECT "
                + "TC_V2.number as number"
                + ",TC_V2.customer_soc_status as customer_soc_status_1 "
                + ",isnull(TC_V2.performance_data_tc_no,'') as performance_data_tc_no "
                + ",TC_V2.customer_type"
                + ",isnull(TC_V2.no_zvern,'') as no_zvern"
                + ",isnull(convert(varchar,TC_V2.registration_date,104),'') as registration_date"
                + ",isnull(soc_status.full_name,'') as customer_soc_status"
                + ",isnull(TC_V2.projected_year_operation,'') as projected_year_operation"
                + ",CASE WHEN TC_V2.customer_type=1 and TC_V2.customer_soc_status<>15 and TC_V2.customer_soc_status<>11 and TC_V2.customer_soc_status<>9 and TC_V2.customer_soc_status<>12 and TC_V2.customer_soc_status<>8"
                + "THEN  '\"" + "'+isnull(TC_V2.juridical,'')" + "+'\"' "
                + "WHEN TC_V2.customer_type=1 and (TC_V2.customer_soc_status=15 or TC_V2.customer_soc_status=11 or TC_V2.customer_soc_status=9 or TC_V2.customer_soc_status=12 or TC_V2.customer_soc_status=8)"
                + "THEN  isnull(TC_V2.juridical,'')"
                + "WHEN TC_V2.customer_type=0"
                + "THEN isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'')"
                + "ELSE '' end as [name]"
                + ",isnull(TC_V2.constitutive_documents,'') as constitutive_documents"
                + ",isnull(TC_V2.customer_post,'') as customer_post"
                + ",isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'') as PIP"
                + ",isnull(TC_V2.[object_name],'') as object_name"
                + ",case when objadr.type=1 then 'м.'"
                + "     when objadr.type=2 then 'с.'"
                + "     when objadr.type=3 then 'смт.' end as type_o"
                + ",case when nullif(TC_V2.[object_adress],'') is not null then "
                + "         isnull(objadr.name,'')+', вул. '+ isnull(TC_V2.[object_adress],'') "
                + "     else isnull(objadr.name,'') end as object_adress"
                + ",isnull(convert(varchar,TC_V2.date_contract,104),'__.__.____') as date_contract"
                + ",isnull(convert(varchar,TC_V2.date_customer_contract_tc,104),'__.__.____') as date_customer_contract_tc"
                + ",isnull(TC_V2.registration_no_contract,'______') as registration_no_contract"
                + ",case when cusadr.type=1 then 'м.'"
                + "     when cusadr.type=2 then 'с.'"
                + "     when cusadr.type=3 then 'смт.' end as type_c"
                + ",isnull(cusadr.name,'')+', вул. '+ isnull(TC_V2.[customer_adress],'') as customer_adress"
                + ",isnull(TC_V2.[bank_account],'') as [bank_account]"
                + ",isnull(TC_V2.[bank_mfo],'') as [bank_mfo]"
                + ",isnull(TC_V2.[bank_identification_number],'') as [bank_identification_number]"
                + ",isnull(TC_V2.[connection_treaty_number],'') as [connection_treaty_number] "
                + ",isnull(TC_V2.voltage_class,'') as voltage_class "
                + ",case when cast(TC_V2.request_power AS varchar) like '%.00' then cast(cast(TC_V2.request_power AS numeric(10,0)) AS varchar) "
                + "else cast(TC_V2.request_power as varchar) "
                + "end as request_power "
                + ",isnull(TC_V2.[reliabylity_class_1],'') as reliabylity_class_1"
                + ",isnull(TC_V2.[reliabylity_class_2],'') as reliabylity_class_2"
                + ",isnull(TC_V2.[reliabylity_class_3],'') as reliabylity_class_3"
                + ",case when cast(TC_V2.[reliabylity_class_1_val] AS varchar) like '%.00' then cast(cast(TC_V2.[reliabylity_class_1_val] AS numeric(10,0)) AS varchar) "
                + "else cast(TC_V2.[reliabylity_class_1_val] as varchar) "
                + "end as reliabylity_class_1_val"
                + ",case when cast(TC_V2.[reliabylity_class_2_val] AS varchar) like '%.00' then cast(cast(TC_V2.[reliabylity_class_2_val] AS numeric(10,0)) AS varchar) "
                + "else cast(TC_V2.[reliabylity_class_2_val] as varchar) "
                + "end as reliabylity_class_2_val"
                + ",case when cast(TC_V2.[reliabylity_class_3_val] AS varchar) like '%.00' then cast(cast(TC_V2.[reliabylity_class_3_val] AS numeric(10,0)) AS varchar) "
                + "else cast(TC_V2.[reliabylity_class_3_val] as varchar) "
                + "end as reliabylity_class_3_val"
                + ",case when cast(isnull(TC_V2.[power_for_electric_devices],0.00) AS varchar) like '%.00' then cast(cast(isnull(TC_V2.[power_for_electric_devices],0.00) AS numeric(10,0)) AS varchar) "
                + "         else cast(TC_V2.[power_for_electric_devices] as varchar) "
                + "     end as power_for_electric_devices "
                + ",case when cast(isnull(TC_V2.[power_for_environmental_reservation],0.00) AS varchar) like '%.00' then cast(cast(isnull(TC_V2.[power_for_environmental_reservation],0.00) AS numeric(10,0)) AS varchar) "
                + "         else cast(TC_V2.[power_for_environmental_reservation] as varchar) "
                + "     end as power_for_environmental_reservation "
                + ",case when cast(isnull(TC_V2.[power_for_emergency_reservation],0.00) AS varchar) like '%.00' then cast(cast(isnull(TC_V2.[power_for_emergency_reservation],0.00) AS numeric(10,0)) AS varchar) "
                + "         else cast(TC_V2.[power_for_emergency_reservation] as varchar) "
                + "     end as power_for_emergency_reservation "
                + ",case when cast(isnull(TC_V2.[power_for_technology_reservation],0.00) AS varchar) like '%.00' then cast(cast(isnull(TC_V2.[power_for_technology_reservation],0.00) AS numeric(10,0)) AS varchar) "
                + "         else cast(TC_V2.[power_for_technology_reservation] as varchar) "
                + "     end as power_for_technology_reservation "
                + ",case when cast(isnull(TC_V2.[power_boil],0.00) AS varchar) like '%.00' then cast(cast(isnull(TC_V2.[power_boil],0.00) AS numeric(10,0)) AS varchar) "
                + "         else cast(TC_V2.[power_boil] as varchar) "
                + "     end as power_boil "
                + ",case when cast(isnull(TC_V2.[power_plit],0.00) AS varchar) like '%.00' then cast(cast(isnull(TC_V2.[power_plit],0.00) AS numeric(10,0)) AS varchar) "
                + "         else cast(TC_V2.[power_plit] as varchar) "
                + "     end as power_plit"
                + ",isnull(TC_V2.power_old,0.00) as power_old "
                + ",isnull(TC_V2.nom_data_dog,'') as nom_data_dog "
                + ",isnull(nullif(TC_V2.do1,''),'') as do1 "
                + ",isnull(TC_V2.do2,'') as do2 "
                + ",isnull(TC_V2.do3,'') as do3 "
                + ",isnull(TC_V2.do4,'') as do4 "
                + ",isnull(TC_V2.do5,'') as do5 "
                + ",isnull(TC_V2.do6,'') as do6 "
                + ",isnull(TC_V2.do7,'') as do7 "
                + ",isnull(TC_V2.do8,'') as do8 "
                + ",[rem_name] "
                + ",[Director] "
                + ",[director_rod]"
                + ",[director_dav]"
                + ",[dovirenist]"
                + ",[contacts] "
                + ",[rek_bank] "
                + ",[rem_licality]"
                + ",[golovnyi_ingener]"
                + ",isnull(convert(varchar,TC_O.date_contract,104),'__.__.____') as TC_Odate_contract "
                + ",isnull(TC_O.number,'') as TC_Onumber "
                + ",case when SUPPLYCH.join_point=1 then 'C4.1 Напруга кВ 0.4'"
                + "     when SUPPLYCH.join_point=11 then 'C4.1 Напруга кВ 0.23'"
                + "     when SUPPLYCH.join_point=2 then 'C4.0 Напруга кВ 0.4'"
                + "     when SUPPLYCH.join_point=21 then 'C4.0 Напруга кВ 0.23'"
                + "     when SUPPLYCH.join_point=3 then 'C3.1 Напруга кВ 10'"
                + "     when SUPPLYCH.join_point=4 then 'C3.0 Напруга кВ 10'"
                + "     when SUPPLYCH.join_point=5 then 'C2.1 Напруга кВ 35'"
                + "     when SUPPLYCH.join_point=6 then 'C2.0 Напруга кВ 35'"
                + "     when SUPPLYCH.join_point=7 then 'C1.1 Напруга кВ 110'"
                + "    else '' end as joint_point "
                + ",isnull (SUPPLYCH.type_source,'') as type_source"
                + ",case when ps35.ps_name like '' or ps35.ps_name is null "
                + "            then isnull(ps110.ps_name,'') "
                + " else isnull(ps35.ps_name,'') end as ps35110_name "
                + ",case when ps35.max_strum like '' or ps35.max_strum is null "
                + "            then isnull(ps110.max_strum,'') "
                + " else isnull(ps35.max_strum,'') end as max_strum "
                + ",case when ps10.ps_name is not null then isnull(ps10.ps_name,'_____')"
                + "     else isnull(SUPPLYCH.ps_10_disp_name_tmp,'_____') end as ps10_name "
                + ",case when ps35.ps_name like '' or ps35.ps_name is null "
                + "            then isnull(cast(ps35.max_strum as varchar),'') "
                + " else isnull(cast(ps110.max_strum as varchar),'') end as max_strum "
                + ",isnull(SUPPLYCH.selecting_point,'') as selecting_point "
                + ",isnull (cast(ps10.ps_nom_nav as numeric(10,0)),0) as ps10_nom_nav "
                + ",isnull (cast(ps10.ps_nom_nav_2 as numeric (10,0)),0) as ps10_nom_nav_2 "
                + ",case when ps10.ps_nom_nav_2=0 or ps10.ps_nom_nav_2 is null "
                + " then 1 else 2 end as kilkist10 "
                + ",isnull(SUPPLYCH.power,'') as power "
                + ",(select count(*) from SUPPLYCH where tc_id=" + request.getParameter("tu_id") + ") as kilk "
                + "from TC_V2 "
                + " left join [TC_LIST_locality] objadr on objadr.id=TC_V2.name_locality"
                + " left join [TC_LIST_locality] cusadr on cusadr.id=TC_V2.customer_locality"
                + " left join [TUweb].[dbo].[TC_LIST_customer_soc_status] soc_status on soc_status.id=TC_V2.customer_soc_status "
                + " left join [TUweb].[dbo].[rem] rem on TC_V2.department_id=rem.rem_id "
                + " left join TC_V2 TC_O on TC_V2.main_contract=TC_O.id "
                + " left join SUPPLYCH on SUPPLYCH.tc_id=TC_V2.id "
                + " left join [TUweb].[dbo].[ps_tu_web] ps35 on SUPPLYCH.ps_35_disp_name=ps35.ps_id "
                + "	left join [TUweb].[dbo].[ps_tu_web] ps110 on SUPPLYCH.ps_110_disp_name=ps110.ps_id "
                + " left join [TUweb].[dbo].[ps_tu_web] ps10 on SUPPLYCH.ps_10_disp_name=ps10.ps_id"
                + " where TC_V2.id=" + request.getParameter("tu_id");
        pstmt = c.prepareStatement(qry,
                ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCdls = rsmd.getColumnCount();
        String tmp = "";
        int i = 1;
        rs.next();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <%--meta http-equiv="Content-Type" content="text/html; charset=UTF-8"--%>
        <meta http-equiv="Content-Type" content="application/msword; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="../word_page_format_12pt.jsp"/>
    </head>
    <body>
        <div class="Section1">
            <p align="right"><SPAN lang="UK">7.51-ПР-1-ТД-1.4.М</SPAN></p>
            <p align="center">АТ «ПРИКАРПАТТЯОБЛЕНЕРГО»</p>

            <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" style="font-size: 11pt">
                <tr>
                    <td width="70%" valign="top"><p align="left" class="style1"><%=rs.getString("rem_licality")%></p>
                        <p>На № <%=rs.getString("no_zvern")%> від <%=rs.getString("registration_date")%> р. </p>
                        <p>Обов’язковий    додаток до проекту.</p></td>
                    <td valign="top"><p align="right"><strong><%= rs.getString("customer_soc_status")%><br>
                                <%= rs.getString("name")%><br>
                                Директору філії<br>
                                АТ «Прикарпаттяобленерго»<br>
                                <%=rs.getString("rem_name")%> РЕМ<br>
                                п. <%= rs.getString("director_dav")%></strong></p></td>
                </tr>
            </table>
            <p align="center"><strong>ТЕХНІЧНІ УМОВИ № <%= rs.getString("number")%></strong></p>
            <div align="right">Додаток 1<br>
                до договору про надання доступу<br>
                до електричних мереж  від<br>
                <%= rs.getString("date_contract")%> року<br>
                № <%= rs.getString("number")%></div>
            <p>Дата видачі: <%= rs.getString("date_customer_contract_tc")%> року № <%= rs.getString("registration_no_contract")%><br>
            <table style="font-size: 11pt">
                <tr>
                    <td width="149" style="text-align:left">Назва об'єкта:</td>
                    <td width="1129" style="text-align:center"><strong><u><%= rs.getString("object_name")%></u></strong>.</td></tr></table>
            <dl>
                <dt>1 Місцезнаходження об’єкта Замовника: <strong><%= rs.getString("type_o")%> <%= rs.getString("object_adress")%>.</strong></dt>
                <dt>2 Величина розрахункового максимального навантаження: <strong><%= rs.getString("request_power")%> кВт</strong>,</dt>
                    <dt>у тому числі: <%if (rs.getInt("kilk") > 1) {
                            do {%> <%=rs.getString("type_source")%>-<%=rs.getString("ps10_name")%>:<%=rs.getString("power")%> кВт.<%} while (rs.next());
                                        rs.first();
                                    }
                                    if (!rs.getString("power_old").equals("0.00")) {%>
                    існуюча потужність <%=rs.getString("power_old")%> кВт, договір №<%=rs.getString("nom_data_dog")%><%}%></dt></dl>

            <table border="0" cellspacing="0" cellpadding="0" width="651" align="center" style="font-size: 11pt">
                <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%>
                <tr>
                    <td width="310" valign="top">
                        I категорія<br>
                        у тому числі для: </td>
                    <td width="341" valign="top"><p><%= rs.getString("reliabylity_class_1_val")%> кВт,</p></td>
                </tr>
                <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>електронагрівальних установок</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_electric_devices")%> кВт (у разі необхідності),</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_environmental_reservation").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>екологічної броні</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_environmental_reservation")%> кВт,</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_emergency_reservation").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>аварійної броні</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_emergency_reservation")%> кВт,</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_technology_reservation").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>технологічної броні</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_technology_reservation")%> кВт;</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_boil").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>водонагрівальні пристрої</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_boil")%> кВт;</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_plit").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>електроплити</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_plit")%> кВт;</p></td>
                </tr><%}%>
                <%--if (!rs.getString("power_old").equals("0.00")) {%>
                <tr>
                    <td width="310" valign="top"><p>існуюча потужність</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_old")%> кВт;</p></td>
                </tr><%}--%><%}%>
                <%if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE")) {%>
                <tr>
                    <td width="310" valign="top"><p>II категорія<br>
                            у тому числі для:</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("reliabylity_class_2_val")%> кВт,</p></td>
                </tr>
                <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>електронагрівальних установок</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_electric_devices")%> кВт (у разі необхідності),</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_environmental_reservation").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>екологічної броні</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_environmental_reservation")%> кВт,</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_emergency_reservation").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>аварійної броні</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_emergency_reservation")%> кВт,</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_technology_reservation").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>технологічної броні</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_technology_reservation")%> кВт.</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_boil").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>водонагрівальні пристрої</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_boil")%> кВт;</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_plit").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>електроплити</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_plit")%> кВт;</p></td>
                </tr><%}%>
                <%--if (!rs.getString("power_old").equals("0.00")) {%>
                <tr>
                    <td width="310" valign="top"><p>існуюча потужність</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_old")%> кВт;</p></td>
                </tr><%}--%><%}%>
                <%if (rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%>
                <tr>
                    <td width="310" valign="top"><p>III категорія<br>
                            у тому числі для:</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("reliabylity_class_3_val")%> кВт,</p></td>
                </tr>
                <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>електронагрівальних установок</p></td>
                    <td width="341" valign="top"><p><%=rs.getString("power_for_electric_devices")%> кВт (у разі необхідності).</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_boil").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>водонагрівальні пристрої</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_boil")%> кВт;</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_plit").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>електроплити</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_plit")%> кВт;</p></td>
                </tr><%}%><%}%>
                <%if (!rs.getString("power_old").equals("0.00")) {%>
                <tr>
                    <td width="310" valign="top"><p>існуюча потужність</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_old")%> кВт;</p></td>
                </tr><%}%>
            </table>
            <dl style="text-align:justify">
                <dt>3 Джерело електропостачання:<strong>
                        <%do {
                                if ((!rs.getString("ps35110_name").equals(tmp)) || (i == 1)) {%>
                        ПС "<%=rs.getString("ps35110_name")%> кВ"<%i++;
                                }
                                tmp = rs.getString("ps35110_name");
                            } while (rs.next());
                            rs.first();%>,
                        <%i = 1;
                            do {//if ((!rs.getString("ps35110_name").equals(tmp)) || (i==1)) {
                        %>
                        <%=rs.getString("type_source")%>-<%=rs.getString("ps10_name")%>&nbsp;
                        <%if (rs.getInt("ps10_nom_nav") != 0 || rs.getInt("ps10_nom_nav_2") != 0) {
                        %>(<%
                            if (rs.getInt("ps10_nom_nav") == rs.getInt("ps10_nom_nav_2") && rs.getInt("ps10_nom_nav_2") != 0) {
                        %>2x<%=rs.getString("ps10_nom_nav")%><%
                            }%><%
                            if (rs.getInt("ps10_nom_nav") != rs.getInt("ps10_nom_nav_2") && rs.getInt("ps10_nom_nav_2") != 0) {
                        %>1x<%=rs.getString("ps10_nom_nav")%> кВА, 1x<%=rs.getString("ps10_nom_nav_2")%><%
                            }%><%
                            if (rs.getInt("ps10_nom_nav_2") == 0) {
                        %>1x<%=rs.getString("ps10_nom_nav")%><%
                            }%> кВА)<%}
                            } while (rs.next());
                            rs.first();%>.</strong></dt>
                <dt>4 Точка підключення<%do {%><strong> <%=rs.getString("selecting_point")%></strong><%} while (rs.next());
                    rs.first();%>.</dt>
                <dt>5 Розрахункове значення струму короткого замикання в точці  приєднання на шинах 10(6) кВ
                    ПС "<%=rs.getString("ps35110_name")%> кВ" - <%=rs.getString("max_strum")%> А.</dt>
                <dt>6 Прогнозовані межі балансової належності та експлуатаційної  відповідальності встановлюються в точці підключення електроустановки.</dt>
                <dt>7 Для одержання потужності необхідно виконати проектування та  будівництво:</dt>
                <dt>7.1  У електромережах до прогнозованої  межі балансової належності:
                    <%if (!rs.getString("do1").equals("")) {%>
                </dt><dt><strong><%=rs.getString("do1").replaceAll("7.1.", "</dt><dt>7.1.")%></strong></dt><%} else {%>відсутні</dt><%}%>
                <dt>7.2 Від межі балансової належності до  електроустановок Замовника:
                    <%if (!rs.getString("do2").equals("")) {%>
                </dt><dt><strong><%=rs.getString("do2").replaceAll("7.2.", "</dt><dt>7.2.")%></strong></dt><%} else {%>відсутні</dt><%}%>
                <dt>7.3 Вимоги до електромереж резервного живлення, в тому числі виділення відповідного електрообладнання на окремі резервні лінії
                    живлення для збереження електропостачання цього електрообладнання у разі виникнення дефіциту потужності
                    в об’єднаній енергосистемі: <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%>
                    для споживачів першої категорії електропостачання передбачити автономне джерело живлення необхідної потужності. 
                    Тип автономного джерела живлення визначити проектом. <% if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE") || rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%> <%=rs.getString("do4")%><%}%>
                    <%} else {%><%=rs.getString("do4")%><%}%></dt>
                <dt>7.4 Вимоги до розрахункового обліку електричної енергії: <strong><%=rs.getString("do3").replaceAll("7.2.", "</dt><dt>7.4.")%></strong> </dt>
                <dt> - У випадку встановлення багатотарифного приладу обліку та неможливості застосування приладу обліку з функцією обмеження максимального споживання потужності, встановити ПЗР. Номінальний струм ПЗР визначити проектом.</dt>
                <dt>7.5 Вимоги до компенсації реактивної потужності: відсутні.</dt>
                <dt>7.6 Вимоги до автоматичного частотного  розвантаження (АЧР), системної протиаварійної автоматики (СПА): відсутні</dt>
                <dt>7.7 Вимоги до релейного захисту й  автоматики, захисту від коротких замикань та перевантажень, компенсації струмів  однофазного замикання в мережах з ізольованою шиною нейтралі тощо: <%=rs.getString("do6")%></dt>
                <dt>7.8 Вимоги до телемеханіки та зв’язку: <%if (rs.getString("do7").equals("")) {%> <%=rs.getString("do7")%><%} else {%>відсутні<%}%>.</dt>
                <dt>7.9 Вимоги до ізоляції, захисту від  перенапруги: відсутні.</dt>
                <dt>7.10 Специфічні вимоги щодо живлення  електроустановок Замовника, які стосуються резервного живлення, допустимості  паралельної роботи елементів електричної мережі:
                    <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%> <strong>
                        встановити блокуючий пристрій для неможливості подачі генерованої напруги в мережі АТ «Прикарпаттяобленерго». Встановити АВР
                        на напрузі 0,4 кВ (централізовано на вводах в споруду чи децентралізовано у електроприймачів І категорії по надійності 
                        електропостачання). <% if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE") || rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%> <%=rs.getString("do8")%><%}%></strong><%} else {%><%=rs.getString("do8")%><%}%> </dt></dl>
            <dl>
                <%if (!rs.getString("performance_data_tc_no").equals("")) {%> <dt>8 Виконання технічних умов можливе спільно з технічними умовами №<%=rs.getString("performance_data_tc_no")%> </dt><%} else {%>
                8 Додаткові вимоги та умови:<%}%>
                <dt style="text-align: justify">8.1 До початку будівництва винести із зони забудови існуючі ЛЕП. Параметри ліній, що підлягають під винос, отримати в філії “<%=rs.getString("rem_name")%> РЕМ”.</dt>
                <dt style="text-align: justify">8.2 До початку будівництва проект  погодити з філією “<%=rs.getString("rem_name")%> РЕМ”. На стадії проектування траси  ЛЕП погодити із землевласниками (землекористувачами), усіма зацікавленими  організаціями та філією “<%=rs.getString("rem_name")%> РЕМ”.</dt></dl>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="391" valign="top"><p class="style2"><strong>Власник</strong></p></td>
                    <td width="240" valign="top"><p class="style2">Замовник</p></td>
                </tr>
                <tr>
                    <td width="328" valign="top">М.П.
                        <br>Головний інженер філії АТ «Прикарпаттяобленерго»<br>
                        “<%= rs.getString("rem_name")%> РЕМ”<br>
                        <u><%=rs.getString("golovnyi_ingener")%></u>
                    </td>
                    <td width="329" valign="top">М.П.<br>
                        <%if (!rs.getString("customer_soc_status_1").equals("11")
                                && !rs.getString("customer_soc_status_1").equals("15")) {%><%= rs.getString("customer_post")%><%} else {%><%= rs.getString("customer_soc_status")%><%}%><br>
                        <u><%= rs.getString("PIP")%></u><br>
                    </td>
                </tr>
                <tr>
                    <td>________________ <br>
                                (підпис)                              <br></td>
                    <td>_______________   

                        <br>
                                   (підпис)   
                    </td>
                </tr>
            </table>
            <p class="style2">&nbsp;</p>
            <p class="style2">Виконав:

                <bean:write name="log" property="PIP"/>
                <br>
                <bean:write name="log" property="tel_number"/>
            </p>
        </div>
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
