    <%--
    Document   : fiz
    Created on : 16 лют 2011, 16:18:59
    Author     : AsuSV
--%>
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.*,java.text.NumberFormat"%>
<%  response.setHeader("Content-Disposition", "inline;filename=jur.doc");
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
        String qry = "SELECT "
                + "TC_V2.number as number"
                + ",isnull(TC_V2.performance_data_tc_no,'') as performance_data_tc_no "
                + ",TC_V2.customer_type"
                + ",TC_V2.customer_soc_status as customer_soc_status_1 "
                + ",isnull(TC_V2.no_zvern,'') as no_zvern"
                + ",isnull(TC_V2.registration_no_contract,'_____') as registration_no_contract "
                + ",isnull(convert(varchar,TC_V2.registration_date,104),'') as registration_date"
                + ",isnull(soc_status.full_name,'') as customer_soc_status"
                + ",isnull(soc_status.name,'') as customer_soc_status0"
                + ",isnull(TC_V2.projected_year_operation,'') as projected_year_operation"
                + ",CASE WHEN TC_V2.customer_type=1 and TC_V2.customer_soc_status<>15 and TC_V2.customer_soc_status<>11 and TC_V2.customer_soc_status<>9 and  TC_V2.customer_soc_status<>12 and  TC_V2.customer_soc_status<>8"
                + "THEN  '\"" + "'+isnull(TC_V2.juridical,'')" + "+'\"' "
                + "WHEN TC_V2.customer_type=1 and (TC_V2.customer_soc_status=15 or TC_V2.customer_soc_status=11 or TC_V2.customer_soc_status=12 or TC_V2.customer_soc_status=9 or TC_V2.customer_soc_status=8)"
                + "THEN  isnull(TC_V2.juridical,'')"
                + "WHEN TC_V2.customer_type=0"
                + "THEN isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'')"
                + "ELSE '' end as [name]"
                + ",isnull(TC_V2.constitutive_documents,'') as constitutive_documents"
                + ",isnull(TC_V2.customer_post,'') as customer_post"
                + ",isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'') as PIP"
                + ",isnull(TC_V2.[object_name],'') as [object_name]"
                + ",case when objadr.type=1 then 'м.'"
                + "     when objadr.type=2 then 'с.'"
                + "     when objadr.type=3 then 'смт.' end as type_o"
                + ",case when nullif(TC_V2.[object_adress],'') is not null then "
                + "         isnull(objadr.name,'')+', вул. '+ isnull(TC_V2.[object_adress],'') "
                + "     else isnull(objadr.name,'') end as object_adress"
                + ",isnull(convert(varchar,TC_V2.date_contract,104),'__.__.____') as date_contract"
                + ",isnull(convert(varchar,TC_V2.initial_registration_date_rem_tu,104),'__.__.____') as initial_registration_date_rem_tu"
                + ",case when cusadr.type=1 then 'м.'"
                + "     when cusadr.type=2 then 'с.'"
                + "     when cusadr.type=3 then 'смт.' end as type_c"
                + ",isnull(cusadr.name,'')+', вул. '+ isnull(TC_V2.[customer_adress],'') as customer_adress"
                + ",isnull(TC_V2.[bank_account],'') as [bank_account]"
                + ",isnull(TC_V2.[bank_mfo],'') as [bank_mfo]"
                + ",isnull(TC_V2.[bank_identification_number],'') as [bank_identification_number]"
                + ",isnull(TC_V2.[connection_treaty_number],'') as [connection_treaty_number] "
                + ",isnull(TC_V2.voltage_class,'') as voltage_class "
                + ",CAST(ISNULL(CAST(TC_V2.request_power AS FLOAT),'') AS VARCHAR) as request_power"
                + ",CAST(ISNULL(CAST(TC_V2.build_strum_power AS FLOAT),'') AS VARCHAR) as build_strum_power"
                + ",isnull(TC_V2.[reliabylity_class_1],'') as reliabylity_class_1"
                + ",isnull(TC_V2.[reliabylity_class_2],'') as reliabylity_class_2"
                + ",isnull(TC_V2.[reliabylity_class_3],'') as reliabylity_class_3"
                + ",CAST(ISNULL(CAST(TC_V2.reliabylity_class_1_val AS FLOAT),'') AS VARCHAR) as reliabylity_class_1_val"
                + ",CAST(ISNULL(CAST(TC_V2.reliabylity_class_2_val AS FLOAT),'') AS VARCHAR) as reliabylity_class_2_val"
                + ",CAST(ISNULL(CAST(TC_V2.reliabylity_class_3_val AS FLOAT),'') AS VARCHAR) as reliabylity_class_3_val"
                + ",isnull(TC_V2.[reliabylity_class_1_old],'') as reliabylity_class_1_old"
                + ",isnull(TC_V2.[reliabylity_class_2_old],'') as reliabylity_class_2_old"
                + ",isnull(TC_V2.[reliabylity_class_3_old],'') as reliabylity_class_3_old"
                + ",CAST(ISNULL(CAST(TC_V2.reliabylity_class_1_val_old AS FLOAT),'') AS VARCHAR) as reliabylity_class_1_val_old"
                + ",CAST(ISNULL(CAST(TC_V2.reliabylity_class_2_val_old AS FLOAT),'') AS VARCHAR) as reliabylity_class_2_val_old"
                + ",CAST(ISNULL(CAST(TC_V2.reliabylity_class_3_val_old AS FLOAT),'') AS VARCHAR) as reliabylity_class_3_val_old"
                + ",isnull(TC_V2.[reliabylity_class_1_build],'') as reliabylity_class_1_build"
                + ",isnull(TC_V2.[reliabylity_class_2_build],'') as reliabylity_class_2_build"
                + ",isnull(TC_V2.[reliabylity_class_3_build],'') as reliabylity_class_3_build"
                + ",CAST(ISNULL(CAST(TC_V2.reliabylity_class_1_val_build AS FLOAT),'') AS VARCHAR) as reliabylity_class_1_val_build"
                + ",CAST(ISNULL(CAST(TC_V2.reliabylity_class_2_val_build AS FLOAT),'') AS VARCHAR) as reliabylity_class_2_val_build"
                + ",CAST(ISNULL(CAST(TC_V2.reliabylity_class_3_val_build AS FLOAT),'') AS VARCHAR) as reliabylity_class_3_val_build"
                + ",isnull(cast(TC_V2.[power_for_electric_devices] as varchar),'0.00') as power_for_electric_devices"
                + ",isnull(TC_V2.[power_for_environmental_reservation],0.00) as power_for_environmental_reservation"
                + ",isnull(TC_V2.[power_for_emergency_reservation],0.00) as power_for_emergency_reservation"
                + ",isnull(cast(TC_V2.[power_for_technology_reservation] as varchar),'____________') as power_for_technology_reservation"
                + ",isnull(TC_V2.power_old,0.00) as power_old "
                + ",isnull(TC_V2.nom_data_dog,'') as nom_data_dog "
                + ",isnull(TC_V2.do1,'') as do1 "
                + ",isnull(TC_V2.do2,'') as do2 "
                + ",isnull(TC_V2.do3,'') as do3 "
                + ",isnull(TC_V2.do4,'') as do4 "
                + ",isnull(TC_V2.do5,'') as do5 "
                + ",isnull(TC_V2.do6,'') as do6 "
                + ",isnull(TC_V2.do7,'') as do7 "
                + ",isnull(TC_V2.do8,'') as do8 "
                + ",isnull(TC_V2.do9,'') as do9 "
                + ",isnull(TC_V2.do10,'') as do10 "
                + ",isnull(TC_V2.do11,'') as do11 "
                + ",isnull(TC_V2.do13,'') as do13 "
                + ",isnull(TC_V2.do14,'') as do14 "
                + ",isnull(TC_V2.do15,'') as do15 "
                + ",isnull(TC_V2.do16,'') as do16 "
                + ",isnull(TC_V2.do17,'') as do17 "
                + ",isnull(TC_V2.do18,'') as do18 "
                + ",isnull(TC_V2.do19,'') as do19 "
                + ",isnull(res.name,'') as reason_tc "
                + ",isnull(cast(TC_V2.power_plit as varchar),'0.00') as power_plit "
                + ",isnull(cast(TC_V2.power_boil as varchar),'0.00') as power_boil "
                + ",isnull(cast(TC_V2.power_old as varchar),'0.00') as power_old "
                + ",[rem_name] "
                + ",[Director] "
                + ",[director_rod]"
                + ",[director_dav]"
                + ",[dovirenist]"
                + ",[contacts] "
                + ",[rek_bank] "
                + ",[rem_licality]"
                + ",[golovnyi_ingener]"
                + ",isnull(convert(varchar,TC_O.date_contract,104),'') as TC_Odate_contract "
                + ",isnull(TC_O.number,'') as TC_Onumber "
                + ",case when SUPPLYCH.join_point=1 then 'C4.1 Напруга кВ 0.4'"
                + "     when SUPPLYCH.join_point=11 then 'C4.1 Напруга кВ 0.23'"
                + "     when SUPPLYCH.join_point=2 then 'C4.0 Напруга кВ 0.4'"
                + "     when SUPPLYCH.join_point=21 then 'C4.0 Напруга кВ 0.23'"
                + "     when SUPPLYCH.join_point=3 then 'C3.1 Напруга кВ 10'"
                + "     when SUPPLYCH.join_point=4 then 'C3.0 Напруга кВ 10'"
                + "     when SUPPLYCH.join_point=5 then 'C2.1 Напруга кВ 35'"
                + "     when SUPPLYCH.join_point=6 then 'C2.0 Напруга кВ 35'"
                + "     when SUPPLYCH.join_point=1 then 'C1.1 Напруга кВ 110'"
                + "    else '___________________' end as join_point "
                + ",case when ps35.max_strum like '' or ps35.max_strum is null "
                + "            then isnull(ps110.max_strum,'') "
                + " else isnull(ps35.max_strum,'') end as max_strum "
                + ",case when ps10.ps_name is not null then isnull(ps10.ps_name,'_____')"
                + "     else isnull(SUPPLYCH.ps_10_disp_name_tmp,'_____') end as ps10_name "
                + ",case when ps35.ps_name like '' or ps35.ps_name is null "
                + "            then isnull(cast(ps35.max_strum as varchar),'') "
                + " else isnull(cast(ps110.max_strum as varchar),'') end as max_strum "
                + ",isnull (SUPPLYCH.type_source,'') as type_source"
                + ",ltrim (case when ps35.ps_name not like '' or ps35.ps_name is not null "
                + "            then isnull(ps35.ps_name,'') "
                + "     when ps110.ps_name not like '' or ps110.ps_name is not null "
                + "             then isnull(ps110.ps_name,'') "
                + "     else '________ ___' end) as ps35110_name "
                + ",case when ps10.ps_name not like '' and ps10.ps_name is not null then "
                + "isnull (ps10.ps_name,'_____') "
                + "    when SUPPLYCH.ps_10_disp_name_tmp not like '' and SUPPLYCH.ps_10_disp_name_tmp is not null "
                + "         then isnull (SUPPLYCH.ps_10_disp_name_tmp,'_____') "
                + "else '_________________' end as ps10_name "
                + ",isnull(SUPPLYCH.selecting_point,'') as selecting_point "
                + ",isnull(SUPPLYCH.fid_04_disp_name,'') as fid04_name "
                + ",isnull(SUPPLYCH.opor_nom_04,'_____') as opor_nom_04 "
                + ",isnull (ps10.ps_nom_nav,'') as ps10_nom_nav "
                + ",isnull (ps10.ps_nom_nav_2,'') as ps10_nom_nav_2 "
                + ",case when ps10.ps_nom_nav_2=0 or ps10.ps_nom_nav_2 is null "
                + " then 1 else 2 end as kilkist10 "
                + ",isnull(SUPPLYCH.power,'') as power "
                + ",YEAR(isnull(convert(varchar,TC_V2.date_intro_eksp,104),'')) as date_intro_eksp"
                + ",isnull( dbo.TC_V2.point_zab_power,'') as point_zab_power"
                + ",isnull( dbo.TC_V2.functional_target,'') as functional_target"
                + ",isnull(convert(varchar, dbo.TC_V2.end_dohovoru_tu,104),'') as end_dohovoru_tu"
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
                + " left join [TUweb].[dbo].[ps_tu_web] ps10 on SUPPLYCH.ps_10_disp_name=ps10.ps_id "
                + " left join [TUweb].[dbo].[TC_LIST_reason_tc] res on res.id=TC_V2.reason_tc "
                + " where TC_V2.id=" + request.getParameter("tu_id");
        pstmt = c.prepareStatement(qry);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCdls = rsmd.getColumnCount();
        String tmp = "";
        int i = 1;
        int k = 2;
        rs.next();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="../word_page_format_12pt.jsp"/>
        <style type="text/css">
            <!--
            body,td,th {
                font-size: 11pt;
            }
            .style1 {
                font-size: 11pt;
                font-weight: bold;

            }
            .style2 {
                font-size: 11pt;
                font-weight: bold;
                margin-top: 0; /* Отступ сверху */
                margin-bottom: 0; /* Отступ снизу */
            }
            li {
                margin-top: 0; /* Отступ сверху */
                margin-bottom: 0; /* Отступ снизу */
            }
            .style11 {        font-size: 12pt;
                              font-weight: bold;
            }
            .style11 {            font-size: 11pt;
                                  font-weight: bold;
            }
            -->
        </style>
    </head>
    <body>
        <div class="Section1">
            <p align="right" class="style1">ОП 4.1-Ж</p>
            <p align="center"><span class="style1"><span class="style11">ПАТ «ПРИКАРПАТТЯОБЛЕНЕРГО»</span><br>
            </span></p>
            <table border="0" cellspacing="0" cellpadding="0" align="center" width="100%">
                <tr>
                    <td width="60%" valign="top"><p>76014, м. Івано-Франківськ,<br>
                        вул. Індустріальна, 34<br>
                        тел./факс. 2-39-38 </p>
                        <p align="left">На № <%=rs.getString("no_zvern")%> від <%=rs.getString("registration_date")%> р.</p></td>
                    <td valign="top"><p align="right"><strong><%if (!rs.getString("customer_soc_status_1").equals("7") && !rs.getString("customer_soc_status_1").equals("8") && !rs.getString("customer_soc_status_1").equals("9") && !rs.getString("customer_soc_status_1").equals("10") && !rs.getString("customer_soc_status_1").equals("12") && !rs.getString("customer_soc_status_1").equals("15") && !rs.getString("customer_soc_status_1").equals("13")) {%><%= rs.getString("customer_soc_status0")%>
                            <%= rs.getString("name")%><br><%} else if (rs.getString("customer_soc_status_1").equals("15")) {%><%= rs.getString("customer_soc_status0")%><br/><%= rs.getString("PIP")%><br><%} else {%><%=rs.getString("name")%><br><%}%>
                        Директору філії<br>
                        ПАТ «Прикарпаттяобленерго»<br>
                            <%=rs.getString("rem_name")%> РЕМ<br>
                        п. <%= rs.getString("director_dav")%></strong></p></td>
                </tr>
            </table>
            <p align="center">&nbsp;</p>
            <p align="center"><strong>ТЕХНІЧНІ УМОВИ НЕСТАНДАРТНОГО ПРИЄДНАННЯ № <%= rs.getString("number")%><br>
            </strong><br>
            </p>
            <p align="center"><span class="style1"><br></span></p>
            <p align="right" class="style1">Додаток 1<br>
                до договору про  приєднання<br>
                до електричних мереж  від<br>
                    <%= rs.getString("date_contract")%> року<br>
                № <%= rs.getString("number")%></p>
            <div align="justify" style="text-align:justify">
                <dl>
                    <dt>Дата видачі <%= rs.getString("initial_registration_date_rem_tu")%> року № <%=rs.getString("registration_no_contract")%> </dt>
                    <dt>Назва об'єкту: <strong><%= rs.getString("object_name")%></strong>.</dt>
                    <dt>1. Місцезнаходження об’єкта Замовника: <strong><%=rs.getString("type_o")%> <%= rs.getString("object_adress")%>.</strong></dt>
                    <dt>Функціональне призначення об'єкта: <strong><%= rs.getString("functional_target")%>.</strong></dt>
                    <dt>Прогнозований рік уведення  об’єкта в експлуатацію:  <strong><%= rs.getString("date_intro_eksp").replaceAll("1900", "_____")%>.</strong></dt>
                    <%if (!rs.getString("power_old").equals("0.00")) {%><%=k++%>. Існуюча дозволена потужність згідно з договором про постачання/користування електричною енергією <strong>№ <%=rs.getString("nom_data_dog")%></strong> року <strong><%=nf.format(rs.getFloat(("power_old")))%></strong> кВт, у тому числі:</dt>
                <table width="180" border="0" cellpadding="0" cellspacing="0">
                    <%if (rs.getString("reliabylity_class_1_old").toUpperCase().equals("TRUE")) {%>
                    <tr>
                        <td width="110">I категорія</td>
                        <td width="70"><strong><%=rs.getString("reliabylity_class_1_val_old")%></strong> кВт</td>
                    </tr>
                    <%}%>
                    <%if (rs.getString("reliabylity_class_2_old").toUpperCase().equals("TRUE")) {%>
                    <tr>
                        <td>II категорія</td>
                        <td><strong><%=rs.getString("reliabylity_class_2_val_old")%></strong> кВт</td>
                    </tr>
                    <%}%>
                    <%if (rs.getString("reliabylity_class_3_old").toUpperCase().equals("TRUE")) {%>
                    <tr>
                        <td>III категорія</td>
                        <td><strong><%=rs.getString("reliabylity_class_3_val_old")%></strong> кВт</td>
                    </tr>
                    <%}%>
                </table>
                <%}%>
                    <%=k++%> Величина максимального розрахункового  (прогнозованого) навантаження з  урахуванням існуючої дозволеної (приєднаної) потужності: <strong><%= rs.getString("request_power").replace(".", ",")%></strong> кВт, у тому числі:
                <table width="180" border="0" cellpadding="0" cellspacing="0">
                    <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%><tr><td width="110">I категорія</td>
                    <td width="70"><strong><%=rs.getString("reliabylity_class_1_val").replace(".", ",")%></strong> кВт</td></tr><%}%>
                    <%if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE")) {%><tr><td>II категорія</td><td><strong><%=rs.getString("reliabylity_class_2_val").replace(".", ",")%></strong> кВт</td></tr><%}%>
                    <%if (rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%><tr><td>III категорія</td><td><strong><%=rs.getString("reliabylity_class_3_val").replace(".", ",")%></strong> кВт</td></tr><%}%>
                </table>
                <%if (!rs.getString("build_strum_power").equals("0")) {%><%=k++%> Потужніть будівельних струмоприймачів: <strong><%= rs.getString("build_strum_power").replace(".", ",")%></strong> кВт, у тому числі:
                <table width="180" border="0" cellpadding="0" cellspacing="0">
                    <%if (rs.getString("reliabylity_class_1_build").toUpperCase().equals("TRUE")) {%><tr><td width="110">I категорія</td>
                    <td width="70"><strong><%=rs.getString("reliabylity_class_1_val_build").replace(".", ",")%></strong> кВт</td></tr><%}%>
                    <%if (rs.getString("reliabylity_class_2_build").toUpperCase().equals("TRUE")) {%><tr><td>II категорія</td><td><strong><%=rs.getString("reliabylity_class_2_val_build").replace(".", ",")%></strong> кВт</td></tr><%}%>
                    <%if (rs.getString("reliabylity_class_3_build").toUpperCase().equals("TRUE")) {%><tr><td>III категорія</td><td><strong><%=rs.getString("reliabylity_class_3_val_build").replace(".", ",")%></strong> кВт</td></tr><%}%>
                </table><%}%>
                <%if (!rs.getString("power_for_electric_devices").equals("0.00") || !rs.getString("power_plit").equals("0.00") || !rs.getString("power_boil").equals("0.00")) {%>Встановлена потужність електронагрівальних установок:
                <table width="180" border="0" cellpadding="0" cellspacing="0">
                    <%if (!rs.getString("power_for_electric_devices").equals("0.00")) {%><tr><td width="110">електроопалення</td><td width="70"><strong><%=nf.format(rs.getFloat(("power_for_electric_devices")))%></strong> кВт</td></tr><%}%>
                    <%if (!rs.getString("power_plit").equals("0.00")) {%><tr><td>електроплити</td><td><strong><%=nf.format(rs.getFloat(("power_plit")))%></strong>  кВт</td></tr><%}%>
                    <%if (!rs.getString("power_boil").equals("0.00")) {%><tr><td>гаряче водопостачання</td><td><strong><%=nf.format(rs.getFloat(("power_boil")))%></strong> кВт</td></tr><%}%>
                </table><%}%>
                <dt><%=k++%>. Джерело електропостачання:<strong>
                    <%//do {
                        if ((!rs.getString("ps35110_name").equals(tmp)) || (i == 1)) {%>
                    ПС "<%=rs.getString("ps35110_name")%> кВ"<%i++;
                }
                    tmp = rs.getString("ps35110_name");
                    //}//while (rs.next());
                    //rs.first();%>,
                    <%i = 1;
                        //do{//if ((!rs.getString("ps35110_name").equals(tmp)) || (i==1)) {
                    %>
                        <%=rs.getString("type_source")%>-<%=rs.getString("ps10_name")%>&nbsp;
                    <%if (rs.getFloat("ps10_nom_nav") != 0.00 || rs.getFloat("ps10_nom_nav_2") != 0.00) {
                    %>(<%
                    if (rs.getFloat("ps10_nom_nav") == rs.getFloat("ps10_nom_nav_2") && rs.getFloat("ps10_nom_nav_2") != 0.00) {
                %>2x<%=nf.format(rs.getFloat(("ps10_nom_nav")))%><%
                    }%><%
                    if (rs.getFloat("ps10_nom_nav") != rs.getFloat("ps10_nom_nav_2") && rs.getFloat("ps10_nom_nav_2") != 0.00) {
                %>1x<%=nf.format(rs.getFloat("ps10_nom_nav"))%>1x<%=nf.format(rs.getFloat(("ps10_nom_nav_2")))%><%
                    }%><%
                    if (rs.getFloat("ps10_nom_nav_2") == 0.00) {
                %>1x<%=nf.format(rs.getFloat("ps10_nom_nav"))%><%
                    }%> кВА)
                    <%}
                        //}//while(rs.next());
                        //rs.first();%>
                    .</strong></dt>
                <dt><%=k++%>. Точка забезпечення потужності: <strong><%= rs.getString("point_zab_power")%></strong></dt>
                <dt><%=k++%>. Точка приєднання: <strong><%= rs.getString("connection_treaty_number")%></strong></dt>
                <dt><%=k++%>. Розрахункове значення струму короткого замикання в точці приєднання на шинах  10(6) кВ ПС "<%=rs.getString("ps35110_name")%> кВ" - <%=rs.getString("max_strum")%> А.</dt>
                <dt><%=k++%>. Прогнозовані межі балансової належності та експлуатаційної відповідальності встановлюються в точці приєднання електроустановки.</dt>
            </dl>
        </div>
        <div align="center"><strong>І. Вимоги до електроустановок Замовника</strong></div
        <div align="justify" style="text-align:justify">
            <dl>
                <dt>1 Для  одержання потужності на об&rsquo;єкті Замовника від точки приєднання до об&rsquo;єкта Замовника необхідно виконати:</dt>
                <dt>1.1. Вимоги до електричних мереж основного живлення: <strong> до початку виконання робіт електропередавальною організацією по наданню послуг приєднання забезпечити місце для встановлення приладу обліку (цегляна стіна висотою 1,8 м, термостійка огорожа...) та письмово
                    повідомити ЕО про готовність такого місця для встановлення приладу обліку електроенергії на ньому</strong></dt>
                <dt>1.2.Вимоги до  електромереж резервного живлення, в тому числі виділення відповідного  електрообладнання на окремі резервні лінії живлення для збереження  електропостачання цього електрообладнання у разі виникнення дефіциту потужності  в об&rsquo;єднаній енергосистемі: <strong><%= rs.getString("do4")%></strong></dt>
                <dt>1.3 Вимоги  до розрахункового обліку електричної енергії: <strong>відсутні.</strong></dt>
                <dt>1.4 Вимоги  до компенсації реактивної потужності: <strong><%= rs.getString("do17")%></strong></dt>
                <dt>1.5 Вимоги до ізоляції, захисту від перенапруги: <strong><%= rs.getString("do11")%></strong></dt>
                <dt>1.6 Вимоги до електропостачання приладів та пристроїв,  які використовуються для будівництва та реконструкції об&rsquo;єктів електромереж: <strong><%= rs.getString("do10")%></strong></dt>
                <dt>1.7. Рекомендації щодо використання типових проектів  електрозабезпечення електроустановок: <strong><%= rs.getString("do14")%></strong></dt>
                <dt>1.8. Рекомендації щодо регулювання добового графіка  навантаження: <strong><%= rs.getString("do15")%></strong></dt>
                <dt>2 Додаткові вимоги та умови:</dt>
                <dt>2.1 Встановлення засобів вимірювальної техніки для  контролю якості електричної енергії: <strong><%= rs.getString("do16")%></strong></dt>
                <dt>2.2 Вимоги до автоматичного частотного  розвантаження (АЧР), системної протиаварійної автоматики (СПА): необхідність  визначити проектом.</dt>
                <dt>2.3 Вимоги  до релейного захисту й автоматики, компенсації струмів однофазного замикання в  мережах з ізольованою шиною нейтралі тощо: <strong><%= rs.getString("do6")%></strong></dt>
                <dt>2.4 Вимоги  до телемеханіки та зв&rsquo;язку: <strong><%= rs.getString("do7")%></strong></dt>
                <dt>2.5 Специфічні вимоги щодо  живлення електроустановок замовника, які стосуються резервного живлення,  допустимості паралельної роботи елементів електричної мережі: <strong><%= rs.getString("do8")%></strong></dt>
            </dl>
        </div>
        <div align="center"><strong>ІІ. Вимоги до електроустановок інженерного забезпечення</strong></div>
        <div align="justify" style="text-align:justify">
            <dl>
                <dt >1 Для одержання потужності в точці приєднання проектна  документація від точки забезпечення потужності до точки приєднання має  передбачати:</dt>
                <dt>1.1 Вимоги до електромереж основного та резервного  живлення: <strong><%= rs.getString("do1").replace("7.1", "<dt>1.1")%></strong></dt>
                <dt>1.2 Вимоги до розрахункового обліку електричної енергії: <strong><%= rs.getString("do3").replace("7.2", "<dt> 1.2")%></strong></dt>
                <dt>1.3 Вимоги до релейного захисту й автоматики, компенсації струмів однофазного замикання в  мережах з ізольованою шиною нейтралі тощо: <strong><%= rs.getString("do6")%></strong></dt>
                <dt>1.4 Вимоги до телемеханіки та зв&rsquo;язку: <strong><%= rs.getString("do7")%></strong></dt>
                <dt>1.5 Вимоги до ізоляції, захисту від перенапруги: <strong><%= rs.getString("do11")%></strong></dt>
                <dt>1.6 Вимоги до кошторисної частини проекту: <strong>проектно-кошторисну документацію розробляється відповідно до вимог ДСТУ Б Д.1.1-1:2013 Правила визначення вартості будівництва.</strong></dt>
                <dt>1.7 Вимоги до оформлення проектно-кошторисної документації: <strong>визначити терміни будівництва мереж від точки забезпечення потужності до точки приєднання.</strong></dt>
                <dt>2 До початку будівництва проект погодити з ПАТ «Прикарпаттяобленерго». На стадії проектування траси ЛЕП погодити із  землевласниками (землекористувачами), усіма зацікавленими організаціями та ПАТ «Прикарпаттяобленерго».</dt>
                <dt>3 У випадку наявності існуючих ЛЕП в зоні забудови, винести їх з даної зони відповідно до технічного завдання, отриманого в філії «______________»</dt>
            </dl>
        </div>
    </p>
    <p><br>
    </p>
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="391" valign="top"><p class="style2"><strong>Електропередавальна організація</strong></p></td>
            <td width="240" valign="top"><p class="style2">замовник</p></td>
        </tr>
        <tr>
            <td width="328" valign="top"><p><strong>ПАТ «Прикарпаттяобленерго»</strong><br>
                Технічний директор <br>
                Сеник Олег Степанович</p>
                М.П.
            </td>
            <td width="329" valign="top"><p><%if (!rs.getString("customer_soc_status_1").equals("11")
                    && !rs.getString("customer_soc_status_1").equals("7")
                    && !rs.getString("customer_soc_status_1").equals("8")
                    && !rs.getString("customer_soc_status_1").equals("9")
                    && !rs.getString("customer_soc_status_1").equals("10")
                    && !rs.getString("customer_soc_status_1").equals("12")
                    && !rs.getString("customer_soc_status_1").equals("13")
                    && !rs.getString("customer_soc_status_1").equals("15")) {%><strong><%= rs.getString("customer_soc_status0")%> <%= rs.getString("name")%></strong><br/><%= rs.getString("customer_post")%><br/><%} else if (rs.getString("customer_soc_status_1").equals("15")) {%><%= rs.getString("customer_soc_status0")%><br/><br/><%} else {%><strong><%= rs.getString("name")%></strong><br/><%= rs.getString("customer_post")%><br/><%}%>
                    <%= rs.getString("PIP")%>
            </p>
                М.П.
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

    <p>Примітка: Обґрунтованість вимог технічних умов може  бути оскаржена до Держенергонагляду.</p>
    <p>Технічний керівник ____________________________.<br>
        Виконав інженер ВТП <bean:write name="log" property="PIP"/> тел. <bean:write name="log" property="tel_number"/></p>
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
