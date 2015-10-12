<%-- 
    Document   : fiz
    Created on : 16 лют 2011, 16:18:59
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.*,java.text.NumberFormat"%>
<% NumberFormat nf = NumberFormat.getInstance();
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
                + ",isnull(TC_V2.no_zvern,'') as no_zvern"
                + ",TC_V2.customer_soc_status as customer_soc_status_1 "
                + ",isnull(TC_V2.registration_no_contract,'') as registration_no_contract "
                + ",isnull(convert(varchar,TC_V2.registration_date,104),'') as registration_date"
                + ",isnull(soc_status.full_name,'') as customer_soc_status"
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
                + ",isnull(TC_V2.customer_telephone,'') as customer_telephone"
                + ",isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'') as PIP"
                + ",isnull(TC_V2.[object_name],'') as [object_name]"
                + ",case when objadr.type=1 then 'м.'"
                + "     when objadr.type=2 then 'с.'"
                + "     when objadr.type=3 then 'смт.' end as type_o"
                + ",case when nullif(TC_V2.[object_adress],'') is not null then "
                + "         isnull(objadr.name,'')+', вул. '+ isnull(TC_V2.[object_adress],'') "
                + "     else isnull(objadr.name,'') end as object_adress"
                + ",isnull(convert(varchar,TC_V2.date_contract,104),'__.__.____') as date_contract"
                + ",isnull(convert(varchar,TC_V2.date_customer_contract_tc,104),'__.__.____') as date_customer_contract_tc"
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
                + ",isnull(TC_V2.[reliabylity_class_1],'') as reliabylity_class_1"
                + ",isnull(TC_V2.[reliabylity_class_2],'') as reliabylity_class_2"
                + ",isnull(TC_V2.[reliabylity_class_3],'') as reliabylity_class_3"
                + ",isnull(TC_V2.[reliabylity_class_1_val],0.00) as reliabylity_class_1_val"
                + ",isnull(TC_V2.[reliabylity_class_2_val],0.00) as reliabylity_class_2_val"
                + ",isnull(TC_V2.[reliabylity_class_3_val],0.00) as reliabylity_class_3_val"
                + ",isnull(cast(TC_V2.[power_for_electric_devices] as varchar),'_________') as power_for_electric_devices"
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
                + ",isnull(SUPPLYCH.inv_num_tp,'') AS inv_num_tp"
                + ",isnull(SUPPLYCH.inv_num_rec_10,'') AS inv_num_rec_10"
                + ",isnull(SUPPLYCH.inv_num_04,'') AS inv_num_04 "
                + ",isnull(res.name,'') as reason_tc "
                + ",isnull(cast(TC_V2.power_plit as varchar),'_____') as power_plit "
                + ",isnull(cast(TC_V2.power_boil as varchar),'_____') as power_boil "
                + ",isnull(cast(TC_V2.power_old as varchar),'_____') as power_old "
                + ",[rem_name] "
                + ",[Director] "
                + ",[director_rod]"
                + ",[dovirenist]"
                + ",[contacts] "
                + ",[rek_bank] "
                + ",[rem_licality]"
                + ",[golovnyi_ingener]"
                + ",isnull(convert(varchar,TC_O.date_contract,104),'') as TC_Odate_contract "
                + ",isnull(TC_O.number,'') as TC_Onumber "
                + " ,case when SUPPLYCH.join_point=1 then '0,4' "
                + "     when SUPPLYCH.join_point=11 then '0,23' "
                + "     when SUPPLYCH.join_point=2 then '0,4' "
                + "     when SUPPLYCH.join_point=21 then '0,23' "
                + "     when SUPPLYCH.join_point=3 then '10' "
                + "     when SUPPLYCH.join_point=4 then '10' "
                + "     when SUPPLYCH.join_point=5 then '35'"
                + "     when SUPPLYCH.join_point=6 then '35' "
                + "     when SUPPLYCH.join_point=7 then '110' "
                + "    else '___' end as joint_point "
                + " ,case when SUPPLYCH.join_point=1 then '2'"
                + "  when SUPPLYCH.join_point=11 then '2'"
                + "  when SUPPLYCH.join_point=2 then '2'"
                + " when SUPPLYCH.join_point=21 then '2'"
                + "  when SUPPLYCH.join_point=3 then '2'"
                + " when SUPPLYCH.join_point=4 then '2'"
                + " when SUPPLYCH.join_point=5 then '1'"
                + " when SUPPLYCH.join_point=6 then '1'"
                + " when SUPPLYCH.join_point=7 then '1'"
                + " else '____' end as class_joint_point  "
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
                + ",isnull(dbo.TC_V2.do1,'') as do1 "
                + ",isnull(dbo.TC_V2.do2,'') as do2 "
                + ",YEAR(isnull(convert(varchar,TC_V2.date_intro_eksp,104),'')) as date_intro_eksp"
                + ",isnull( dbo.TC_V2.point_zab_power,'') as point_zab_power"
                + ",isnull( dbo.TC_V2.functional_target,'') as functional_target"
                + ",isnull(convert(varchar, dbo.TC_V2.end_dohovoru_tu,104),'') as end_dohovoru_tu"
                + ",cast(isnull( (cast(dbo.TC_V2.price_join as float)),'') as varchar) as price_join"
                + ",isnull(convert (varchar(15),dbo.TC_V2.sum_other_price),'______') as sum_other_price "
                + ",isnull(convert (varchar(15),dbo.TC_V2.date_pay_ns,104),'___.___.____') as date_pay_ns"
                + ",case when TC_V2.sum_other_price is null then cast(isnull( (cast(dbo.TC_V2.price_join as float)),'') as varchar)"
                + " else (TC_V2.sum_other_price*1000) end as endprice "
                + ",(select count(*) from SUPPLYCH where tc_id=" + request.getParameter("tu_id") + ") as kilk "
                + ",isnull(rp.code,'_______________________') as code"
                + ",CASE TC_V2.type_project"
                + "    WHEN 1 THEN 'Так'"
                + "    WHEN 2 THEN 'Ні'"
                + "    WHEN 3 THEN 'Так'"
                + "    ELSE 'так / ні'"
                + " END AS yes_no "
                + " ,ISNULL(cast(TC_V2.term_for_joining AS VARCHAR(20)),'_______') AS term_for_joining"
                + " from TC_V2 "
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
                + " LEFT JOIN TUWeb.dbo.Reusable_project rp ON TC_V2.reusable_project=rp.id  "
                + " where TC_V2.id=" + request.getParameter("tu_id");
        pstmt = c.prepareStatement(qry);
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
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>JSP Page</title>
        <jsp:include page="../newtemplate.jsp"/>
    </head>
    <body>
        <p align="center"><strong>Заявка на будівництво  згідно</strong><br>
            <strong> договору про приєднання №<%= rs.getString("number")%> &nbsp;від   <span class="style1"><%= rs.getString("date_contract")%></span> року</strong></p>
        <div align="justify" style="text-align:justify">
            <dt align="justify"><strong>1.Найменування філії: </strong> <span class="style1"><%=rs.getString("rem_name")%></span> РЕМ</dt>
            <dt align="justify">Найменування,  місцезнаходження, телефон замовника: <span class="style1"><%if (!rs.getString("customer_soc_status_1").equals("9")
                        && !rs.getString("customer_soc_status_1").equals("12")) {%> <%= rs.getString("customer_soc_status")%><%}%> 
                    <%= rs.getString("name")%>, <span class="style1"><%= rs.getString("type_o")%><%= rs.getString("customer_adress")%>, тел. <%= rs.getString("customer_telephone")%>.</span></dt>
            <dt><strong>2.</strong> <strong>Назва, місцезнаходження об’єкта замовника</strong>: <span style="text-align: center"><%= rs.getString("object_name")%></span> в <%= rs.getString("type_o")%> <%= rs.getString("object_adress")%>.</dt>
            <dt><strong>3. Дата поступлення коштів від замовника :</strong>  <%= rs.getString("date_pay_ns")%> року.</dt>
            <dt align="justify"><strong>4. Величини розрахункового максимального навантаження: </strong> <%= rs.getString("request_power").replace(".", ",")%> кВт, в тому числі:</dt>
            <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%>
            <strong>I категорія</strong><br>
            <%}%>
            <%if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE")) {%>
            <strong>II категорія</strong><br>
            <%}%>
            <%if (rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%>

            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="347" valign="top">
                        <span class="style1">III категорія </span></td>
                    <td width="340" valign="top"><span class="style1"><%= rs.getString("request_power").replace(".", ",")%> кВт,</span></td>
                </tr>
            </table>
            <%}%>
            <%if ((!rs.getString("power_plit").equals("_____")) || (!rs.getString("power_boil").equals("_____")) || (!rs.getString("power_for_electric_devices").equals("_________"))) {%>
            <span class="style1">Встановлена потужність електронагрівальних установок:</span>
            <%}%>
            <table border="0" cellspacing="0" cellpadding="0">
                <%if (!rs.getString("power_plit").equals("_____")) {%>
                <tr>
                    <td width="347" valign="top">
                        <span class="style1">стаціонарної електричної плити </span></td>
                    <td width="340" valign="top"><dt class="style1"><%if (!rs.getString("power_plit").equals("_____")) {%><%=nf.format(rs.getFloat("power_plit"))%><%} else {%><%=rs.getString("power_plit")%><%}%> кВт,</dt></td>
                </tr><%}%>
                <%if (!rs.getString("power_boil").equals("_____")) {%>
                <tr>
                    <td width="347" valign="top"><dt class="style1">електричного підігріву води</dt></td>
                <td width="340" valign="top"><dt class="style1"><%if (!rs.getString("power_boil").equals("_____")) {%><%=nf.format(rs.getFloat("power_boil"))%><%} else {%><%=rs.getString("power_boil")%><%}%> кВт,</dt></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_electric_devices").equals("_________")) {%>
                <tr>
                    <td width="347" valign="top"><dt class="style1">опалення приміщень</dt></td>
                <td width="340" valign="top"><dt class="style1"><%if (!rs.getString("power_for_electric_devices").equals("_________")) {%><%=nf.format(rs.getFloat("power_for_electric_devices"))%><%} else {%><%=rs.getString("power_for_electric_devices")%><%}%> кВт.</dt></td>
                </tr><%}%>
            </table>
            <dt align="justify"><strong>5. Напруга в точці приєднання:</strong><%= rs.getString("joint_point").replace(".", ",")%> кВ.</dt>
            <dt align="justify"><strong>6. Джерело електропостачання: </strong> <%//do {
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
            <dt><strong>7. Точка забезпечення потужності: </strong><%= rs.getString("point_zab_power")%></dt>
            <dt><strong>8. Точка приєднання: </strong><%= rs.getString("connection_treaty_number")%></dt>
            <dt><strong>9. Для приєднання замовника  необхідно виконати проектування та будівництво, реконструкцію об’єктів: </strong></dt>
            <dl><%= rs.getString("do1").replace("7.1.1", "<br>-").replace("7.1.2", "<br>-").replace("7.1.3", "<br>-").replace("7.1.4", "<br>-").replace("7.1.5", "<br>-").replace("7.1.6", "<br>-").replace("7.1.7", "<br>-")%>
                <dt><%= rs.getString("do2").replace("7.2.1", "<br>-").replace("7.2.2", "<br>-").replace("7.2.3", "<br>-").replace("7.2.4", "<br>-").replace("7.2.5", "<br>-").replace("7.2.6", "<br>-").replace("7.2.7", "<br>-")%>
                </dt><dt> <%= rs.getString("do3").replace("7.2.1", "<br>-").replace("7.2.2", "<br>-").replace("7.2.3", "<br>-").replace("7.2.4", "<br>-").replace("7.2.5", "<br>-").replace("7.2.6", "<br>-").replace("7.2.7", "<br>-")%></dt>
            </dl>
            <dt><strong>Інвентарні номера об’єктів (ТП, ЛЕП) що підлягають реконструкції; ЛЕП до  якої здійснюється приєднання: </strong>
                <%if (!rs.getString("inv_num_04").equals("")) {%><%=rs.getString("inv_num_04")%>;&nbsp;<%}%><%if (!rs.getString("inv_num_rec_10").equals("")) {%><%=rs.getString("inv_num_rec_10")%>;&nbsp;<%}%><%if (!rs.getString("inv_num_tp").equals("")) {%><%=rs.getString("inv_num_tp")%>.&nbsp;<%}%></dt>
            <dt><strong>10. Орієнтовні терміни завершення робіт: </strong><%=rs.getString("term_for_joining")%> днів(день).</dt>
            <dt><strong>11. Схема приєднання (у випадку необхідності):</strong></dt>
            <dt>&nbsp;</dt>
            <dt>&nbsp;</dt>
            <dt>&nbsp;</dt>
            <dt>&nbsp; </dt>
        </div>
        <bean:define id="name" name="loginActionForm" property="PIP" type="java.lang.String"/>
        <table width="714" border="0">
            <tr>
                <td width="392"><strong>Підготував  інженер ВТГ</strong></td>
                <td width="481"><strong><%=name%></strong></td>
            </tr>
            <tr>
                <td><strong>Погоджено</strong>&nbsp;</td>
                <td><strong>Паливода Ірина Василівна</strong></td>
            </tr>
        </table>
    <dt align="justify">&nbsp;</dt>
    <dt align="justify">&nbsp;</dt>
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