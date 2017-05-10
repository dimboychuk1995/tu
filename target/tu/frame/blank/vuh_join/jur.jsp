<%--
    Document   : fiz
    Created on : 23 бер 2011, 12:02:36
    Author     : asupv
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
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
                + ",TC_V2.customer_type"
                + ",isnull(TC_V2.no_zvern,'') as no_zvern"
                + ",isnull(convert(varchar,TC_V2.registration_date,104),'') as registration_date"
                + ",isnull(soc_status.full_name,'') as customer_soc_status"
                + ",isnull(TC_V2.projected_year_operation,'') as projected_year_operation"
                + ",CASE WHEN TC_V2.customer_type=1 and TC_V2.customer_soc_status<>15 and TC_V2.customer_soc_status<>11 and TC_V2.customer_soc_status<>9"
                + "THEN  '\"" + "'+isnull(TC_V2.juridical,'')" + "+'\"' "
                + "WHEN TC_V2.customer_type=1 and (TC_V2.customer_soc_status=15 or TC_V2.customer_soc_status=11)"
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
                + "         isnull(objadr.name,'')+', вул.'+ isnull(TC_V2.[object_adress],'') "
                + "     else isnull(objadr.name,'') end as object_adress"
                + ",isnull(convert(varchar,TC_V2.date_contract,104),'') as date_contract"
                + ",isnull(convert(varchar,TC_V2.date_customer_contract_tc,104),'') as date_customer_contract_tc"
                + ",case when cusadr.type=1 then 'м.'"
                + "     when cusadr.type=2 then 'с.'"
                + "     when cusadr.type=3 then 'смт.' end as type_c "
                + ",case when TC_V2.[customer_adress] not like '' then "
                + "isnull(cusadr.name,'')+', вул. '+ isnull(TC_V2.[customer_adress],'') "
                + "     else isnull(cusadr.name,'') end as customer_adress "
                + ",isnull(TC_V2.[bank_account],'') as [bank_account]"
                + ",isnull(TC_V2.[bank_mfo],'') as [bank_mfo]"
                + ",isnull(TC_V2.[bank_identification_number],'') as [bank_identification_number]"
                + ",isnull(TC_V2.[connection_treaty_number],'') as [connection_treaty_number] "
                //+ ",isnull(TC_V2.voltage_class,'') as voltage_class "
                + ",isnull(TC_V2.request_power,0.00) as request_power"
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
                + ",isnull(TC_V2.do1,'') as do1 "
                + ",isnull(TC_V2.do2,'') as do2 "
                + ",isnull(TC_V2.do3,'') as do3 "
                + ",isnull(TC_V2.do4,'') as do4 "
                + ",isnull(TC_V2.do5,'') as do5 "
                + ",isnull(TC_V2.do6,'') as do6 "
                + ",isnull(TC_V2.do7,'') as do7 "
                + ",isnull(TC_V2.do8,'') as do8 "
                + ",isnull(TC_V2.geo_cord_1,'____________________') as geo_cord_1 "
                + ",isnull(TC_V2.geo_cord_2,'____________________') as geo_cord_2 "
                + ",isnull(TC_V2.[point_zab_power],'') as [point_zab_power] "
                + ",isnull(res.name,'') as reason_tc "
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
                + ",case when SUPPLYCH.join_point=1 then 'C4.1 Напруга кВ 0.4'"
                + "     when SUPPLYCH.join_point=11 then 'C4.1 Напруга кВ 0.23'"
                + "     when SUPPLYCH.join_point=2 then 'C4.0 Напруга кВ 0.4'"
                + "     when SUPPLYCH.join_point=21 then 'C4.0 Напруга кВ 0.23'"
                + "     when SUPPLYCH.join_point=3 then 'C3.1 Напруга кВ 10'"
                + "     when SUPPLYCH.join_point=4 then 'C3.0 Напруга кВ 10'"
                + "     when SUPPLYCH.join_point=5 then 'C2.1 Напруга кВ 35'"
                + "     when SUPPLYCH.join_point=6 then 'C2.0 Напруга кВ 35'"
                + "     when SUPPLYCH.join_point=7 then 'C1.1 Напруга кВ 110'"
                + "    else '___________________' end as join_point "
                + ",isnull (SUPPLYCH.type_source,'') as type_source"
                + ",ltrim (case when ps110.ps_name not like '' or ps110.ps_name is not null "
                + "            then isnull(ps110.ps_name,'') "
                + "     when ps35.ps_name not like '' or ps35.ps_name is not null "
                + "             then isnull(ps35.ps_name,'') "
                + "     else '________ ___' end) as ps35110_name "
                + ",case when ps110.ps_name like '%110/35%' then isnull (ps110.ps_name,'') else '' end as ps1103510pr "
                + ",case when ps110.ps_name like '%110/35%' then isnull (ps110.ps_nom_nav,0.00) else 0.00 end as ps1103510_nom_nav "
                + ",case when ps110.ps_name like '%110/35%' then isnull (ps110.ps_nom_nav_2,0.00) else 0.00 end as ps1103510_nom_nav_2 "
                + ",case when ps110.ps_name like '%110/35%' and (ps110.ps_nom_nav_2=0 or ps110.ps_nom_nav_2 is null) "
                + "then 1 else 2 end as kilkist1103510 "
                + ",case when ps110.ps_name like '%110/35%' then isnull (ps110.ps_nav,'') else '' end as ps1103510_nav "
                + ",case when ps110.ps_name like '%110/10%' then isnull (ps110.ps_name,'') else '' end as ps11010pr "
                + ",case when ps110.ps_name like '%110/10%' then isnull (ps110.ps_nom_nav,'') else '' end as ps11010_nom_nav "
                + ",case when ps110.ps_name like '%110/10%' then isnull (ps110.ps_nom_nav_2,'') else '' end as ps11010_nom_nav_2 "
                + ",case when ps110.ps_name like '%110/10%' and (ps110.ps_nom_nav_2=0 or ps110.ps_nom_nav_2 is null) "
                + " then 1 else 2 end as kilkist11010 "
                + ",case when ps110.ps_name like '%110/10%' then isnull (ps110.ps_nav,'') else '' end as ps11010_nav "
                + ",isnull (ps35.ps_name,'') as ps3510pr "
                + ",isnull (ps35.ps_nom_nav,'') as ps3510_nom_nav "
                + ",isnull (ps35.ps_nom_nav_2,'') as ps3510_nom_nav_2 "
                + ",case when ps35.ps_nom_nav_2=0 or ps35.ps_nom_nav_2 is null "
                + " then 1 else 2 end as kilkist3510"
                + ",isnull (ps35.ps_nav,'') as ps3510_nav "
                + ",case when ps10.ps_name not like '' and ps10.ps_name is not null then "
                + "         isnull (ps10.ps_name,'_____') "
                + "     when SUPPLYCH.ps_10_disp_name_tmp not like '' and SUPPLYCH.ps_10_disp_name_tmp is not null "
                + "         then isnull (SUPPLYCH.ps_10_disp_name_tmp,'_____') "
                + "else '_________________' end as ps10_name "
                + ",isnull(SUPPLYCH.type_source,'') as type_source"
                + ",isnull (ps10.ps_nom_nav,'') as ps10_nom_nav "
                + ",isnull (ps10.ps_nom_nav_2,'') as ps10_nom_nav_2 "
                + ",case when ps10.ps_nom_nav_2=0 or ps10.ps_nom_nav_2 is null "
                + " then 1 else 2 end as kilkist10"
                + ",isnull (ps10.ps_nav,'') as ps10_nav "
                + ",isnull(SUPPLYCH.selecting_point,'') as selecting_point "
                + ",isnull(SUPPLYCH.fid_04_disp_name,'') as fid04_name "
                + ",isnull(SUPPLYCH.opor_nom_04,'_____') as opor_nom_04 "
                + ",isnull(SUPPLYCH.fid_04_leng,0.00) as fid_04_leng "
                + " ,(SELECT cast( "
                + " 	(select((isnull([ps_nom_nav],0)+isnull([ps_nom_nav_2],0))*0.92)-isnull([ps_nav],0) from [TUweb].[dbo].[ps_tu_web] where ps_id=SUPPLYCH.tc_id)- "
                + " 	(select sum(isnull(TC_V2.request_power,0)) from [TUWeb].[dbo].[ps_tu_web]  "
                + "          left join SUPPLYCH on ps_id=ps_10_disp_name  "
                + "          left join TC_V2 on (SUPPLYCH.tc_id=TC_V2.id  "
                + " 								and TC_V2.type_contract=1  "
                + " 								and nullif(date_admission_consumer,'') is null  "
                + " 								and isnull(state_contract,0)<>8  "
                + " 								and TC_V2.id not in (" + request.getParameter("tu_id") + "))  "
                + " 		where  ps_id=SUPPLYCH.tc_id)- "
                + " 	(select isnull(request_power,0) from TC_V2 where id=" + request.getParameter("tu_id") + ")  "
                + "     as numeric(10,2))) as ps_rez10 "
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
        rs.next();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="../word_page_format.jsp"/>
    </head>
    <body>
        <div class="Section1">
            <p align="right"><strong>ОП 4.1-Л</strong> </p>
            <h5 align="center">Вихідні дані та пропозиції  філії <%=rs.getString("rem_name")%> РЕМ</h5>
            <p align="center"><strong>по приєднанню електроустановок  Замовників до електричних мереж</strong></p>
            <p align="left"><br>
                <strong><u>І. Загальні дані</u></strong><br>
                <u>1. Найменування, місцезнаходження, телефон Замовника: <strong><%=rs.getString("customer_soc_status")%> <%=rs.getString("name")%>,
                        <%=rs.getString("type_c")%> <%=rs.getString("customer_adress")%>.</strong></u><br>
                <u>2. Назва, місцезнаходження об’єкту Замовника:</u><strong> <%=rs.getString("object_name")%> <%=rs.getString("type_o")%> <%=rs.getString("object_adress")%>.</strong><br>
                <u>3. Заявлена потужність, <strong><%=rs.getString("request_power")%> </strong> <em>кВт; </em> категорія з надійності електропостачання
                    <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%><%="(I)"%><%}%>
                    <%if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE")) {%><%="(II)"%><%}%>
                    <%if (rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%><%="(III)"%><%}%></u><br>
                <u>в т. ч. існуюча (договірна)  потужність     -     <em>кВт</em> ,  категорія з надійності  електропостачання (ІІІ)</u><br>
                <u>4. Напруга в точці приєднання, кВ, (1-ф. чи 3-ф. ввід):</u>_<strong><%=rs.getString("join_point").substring(5)%></strong>.<br>
                <strong>--------------------------------------------------------------------------------------------------------------------------------------------------</strong><br>
                <strong><u>ІІ. Пропозиції по забезпеченню  передачі потужності в точку приєднання </u></strong><br>
                <u>1. Джерело електропостачання: </u><em>(дисп. назва ПС, ТП;  номер опори, комірки) <u> ПС "<%= rs.getString("ps35110_name")%>",<%=rs.getString("type_source")%>-<%= rs.getString("ps10_name")%></u></em><br>
                <u>2. Точка приєднання: </u><em>існуюча  (дисп. назва) –</em><strong><%= rs.getString("connection_treaty_number")%> </strong><br>
                <em>проектна  (дисп. назва) – </em><br><em>Географічні кординати – </em><strong><%= rs.getString("geo_cord_1")%></strong>
                <br><u>3. Точка забезпечення потужності: </u><strong><%= rs.getString("point_zab_power")%></strong><br>
                <em>Географічні кординати – </em><strong><%= rs.getString("geo_cord_2")%></strong><br>
                <strong><u>ІІІ. Орієнтовні обсяги робіт для  передачі потужності до точки приєднання (роботи, які необхідно виконати в  мережах ПАТ&nbsp;&quot;Прикарпаттяобленерго&quot;):
                    </u></strong><br>
                1  Будівництво (реконструкція та/або технічне переоснащення) нових ТП , РП, ПС;  ПЛ, КЛ<em> (<strong>причини реконструкції</strong>, кількість, протяжність (від-до),  рекомендовані типи, конструктивне виконання,  технічні параметри): <strong><%=rs.getString("do1").replaceAll("7.1.", "<br>")%></strong></em><br>
                 2 Вимоги по влаштуванню розрахункового обліку електроенергії:_______<br>
                3 Орієнтовна однолінійна схема  <strong><em>(заповнюється обов’язково)</em></strong>:<br/><br/><br/><br/><br/><br/>
                Довжина вводу______________<br>
                СІП_____, довжина до об’єкту ____ ; СІП____, довжина по конструкціях об’єкту_________<br> 
                Орієнтована потреба в матеріалах: опора_______шт<br>
                Провід________<br>
                СІП_________,<br>
                Інші матеріали_______________<br>
                Необхідні механізми_________________<br>
                Інвентарні номера об’єктів, що підлягають реконструкції,_________<br>
                Примітки:__________
            </p>
            <p align="left">
                <strong><u>ІV. Орієнтовні обсяги робіт для  передачі потужності від точки приєднання до Замовника:
                    </u></strong><br>
                1  Будівництво (реконструкція та/або технічне переоснащення) нових ТП , РП, ПС;  ПЛ, КЛ<em> (<strong>причини реконструкції</strong>, кількість, протяжність (від-до),  рекомендовані типи, конструктивне виконання,  технічні  параметри): <strong><%=rs.getString("do2").replaceAll("7.2.", "<br>")%></strong></em></p>
            <dl>
                <dt>1.2. по влаштуванню розрахункового обліку  електроенергії:</dt>
            </dl>
            <strong><em><%=rs.getString("do3").replaceAll("7.2.", "<br>")%></dt></em></strong><strong><br></strong>
                <%--<p><strong><em>- Розрахунковий  засіб обліку електричної енергії має бути з функцією обмеження максимального  споживання потужності, опломбований двома пломбами Держстандарту.</em></strong><br>
            <strong><em>- У  випадку встановлення багатотарифного приладу обліку та неможливості  застосування приладу обліку  з функцією  обмеження максимального споживання потужності, встановити ПЗР . Номінальний  струм ПЗР визначити проектом. Тип лічильника визначити проектом та погодити в  заступника по енергонагляду</em></strong><strong>;</strong> </p>--%>
            <dl style="line-height:150%">
                <dt>1. по компенсації реактивної потужності ––</dt>
                <dt>2. по влаштуванню пристроїв захисту ––</dt>
                <dt>3. по дотриманню охоронних зон електромереж ––</dt>
            </dl>
            <table border="0" cellspacing="0" cellpadding="0" style="line-height:150%">
                <tr>
                    <td width="225" height="25" valign="top"><p>Головний інженер</p></td>
                    <td width="225" valign="top"><p>&nbsp;</p></td>
                    <td width="225" valign="top"><p><%=rs.getString("golovnyi_ingener")%></p></td>
                </tr>
                <tr>
                    <td width="225" height="25" valign="top"><p>Заступник директора РЕМ</p></td>
                    <td width="225" valign="top"><p>&nbsp;</p></td>
                    <td width="225" valign="top"><p>__________________________</p></td>
                </tr>
                <tr>
                    <td width="225" height="25" valign="top"><p>Інженер-керівник ВТГ</p>
                    <td width="225" valign="top"><p>&nbsp;</p></td>
                    <td width="225" valign="top"><p>__________________________</p></td>
                </tr>
                <tr>
                    <td width="225" valign="top"><p>Майстер дільниці</p></td>
                    <td width="225" valign="top"><p>&nbsp;</p></td>
                    <td width="225" valign="top"><p>__________________________</p></td>
                </tr>
            </table>
            <br clear="all">
            <!--<p align="right"><strong>7.5.1-ПР-1-ТД-1.4 Ж</strong></p>
            <table border="1" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="44" valign="top" align="center">№ п/п</td>
                    <td width="316" valign="top" align="center">&nbsp;</td>
                    <td width="59" valign="top" align="center">&nbsp;Позна-чення</td>
                    <td width="65" align="center">Значен-ня&nbsp;</td>
                    <td width="188" valign="top" align="center">Примітки, у тому числі: номер технічних умов, договору, потужність&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">1&nbsp;</td>
                    <td width="316" valign="top">Електропередавальна організація:</td>
                    <td width="312" colspan="3" valign="top" align="center"><strong>філія &quot;<%=rs.getString("rem_name")%> РЕМ&quot;    АТ&quot;ПрОЕ&quot;</strong></td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">2&nbsp;</td>
                    <td width="316" valign="top">Дані Замовника    (найменування):&nbsp;</td>
                    <td width="312" colspan="3" valign="top" align="center"><strong>&nbsp;</strong></td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">2.1&nbsp;</td>
                    <td width="316" valign="top">Приєднана потужність (збільшення    потужності) електроустановок, кВт&nbsp;</td>
                    <td width="59" valign="bottom" align="center">WС&nbsp;</td>
                    <td width="65" valign="bottom" align="center"><strong><%=rs.getString("request_power")%> &nbsp; </strong></td>
                    <td width="188" valign="bottom">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">&nbsp;</td>
                    <td width="316" valign="top">у тому числі за категорією    надійності електропостачання:&nbsp;</td>
                    <td width="59" valign="bottom" align="center">&nbsp;</td>
                    <td width="65" valign="bottom" align="center">&nbsp;</td>
                    <td width="188" valign="bottom" align="center">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">2.1.1</td>
                    <td width="316" valign="top" align="center">I</td>
                    <td width="59" valign="top" align="center">WС1</td>
                    <td width="65" valign="top" align="center"><%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%><%=rs.getString("reliabylity_class_1_val")%><%} else {%>&nbsp;<%}%></td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">2.1.2</td>
                    <td width="316" valign="top" align="center">II </td>
                    <td width="59" valign="top" align="center">WС2&nbsp;</td>
                    <td width="65" valign="top" align="center"><%if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE")) {%><%=rs.getString("reliabylity_class_2_val")%><%} else {%>&nbsp;<%}%></td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">2.1.3</td>
                    <td width="316" valign="top" align="center">III</td>
                    <td width="59" valign="top" align="center">WС3&nbsp;</td>
                    <td width="65" valign="top" align="center"> <%if (rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%><%=rs.getString("reliabylity_class_3_val")%><%} else {%>&nbsp;<%}%></td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">3&nbsp;</td>
                    <td width="316" valign="top" >Узгоджена точка приєднання електроустановок у відповідності до договору про приєднання</td>
                    <td width="59" valign="top" align="center">C 4._</td>
                    <td width="65" valign="top" align="center"><%=rs.getString("join_point").substring(0, 4)%>&nbsp;</td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">4&nbsp;</td>
                    <td width="316" valign="top">Передбачена точка забезпечення  потужності </td>
                    <td width="59" valign="top" align="center">С 1.1</td>
                    <td width="65" valign="top" align="center">&nbsp;</td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5&nbsp;</td>
                    <td width="628" colspan="4" valign="top">Характеристика ПС, від яких передбачають забезпечення  потужності електроустановок Замовника</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.1&nbsp;</td>
                    <td width="628" colspan="4" valign="top" align="center"><strong>ПС 110(150)/35/10(6) кВ (назва):<%=rs.getString("ps1103510pr")%> &nbsp;</strong></td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.1.1&nbsp;</td>
                    <td width="316" valign="top">кількість та потужність силових тр-рів, од. х МВА&nbsp;</td>
                    <td width="124" colspan="2" valign="top" align="center">
                        <%if (rs.getFloat("ps1103510_nom_nav") == rs.getFloat("ps1103510_nom_nav_2") && rs.getFloat("ps1103510_nom_nav_2") != 0.00) {%> 2x<%=rs.getString("ps1103510_nom_nav")%><%}%>
                        <%if (rs.getFloat("ps1103510_nom_nav") != rs.getFloat("ps1103510_nom_nav_2") && rs.getFloat("ps1103510_nom_nav_2") != 0.00) {%> 1x<%=rs.getString("ps1103510_nom_nav")%><br>
                        1x<%=rs.getString("ps1103510_nom_nav_2")%><%}%>
                        <%if (rs.getFloat("ps1103510_nom_nav_2") == 0.00 && rs.getFloat("ps1103510_nom_nav") != 0.00) {%>1x<%=rs.getString("ps1103510_nom_nav")%><%}%>
                        &nbsp;</td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.1.2&nbsp;</td>
                    <td width="316" valign="top">існуюче максимальне навантаження ПС, МВт</td>
                    <td width="124" colspan="2" valign="top" align="center"><%if (rs.getFloat("ps1103510_nom_nav") != 0)%><%=rs.getString("ps1103510_nom_nav")%></td>
                    <td width="188" valign="top">Згідно таблиці максимальних навантажень по ПС</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.1.3</td>
                    <td width="316" valign="top">дозволена потужність для Замовників згідно з діючими технічними умовами та договорами про надання доступу (про приєднання), кВт</td>
                    <td width="124" colspan="2" valign="top" align="center">&nbsp;</td>
                    <td width="188" valign="top">Додається списком (Додаток 1)</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.2&nbsp;</td>
                    <td width="628" colspan="4" valign="top" align="center"><strong>ПС 110(150)/10(6) кВ (назва):<%=rs.getString("ps11010pr")%> &nbsp;</strong></td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.2.1&nbsp;</td>
                    <td width="316" valign="top">кількість та потужність силових тр-рів, од. х МВА&nbsp;</td>
                    <td width="124" colspan="2" valign="top" align="center">
                        <%if (rs.getFloat("ps11010_nom_nav") == rs.getFloat("ps11010_nom_nav_2") && rs.getFloat("ps11010_nom_nav_2") != 0.00) {%> 2x<%=rs.getString("ps11010_nom_nav")%><%}%>
                        <%if (rs.getFloat("ps11010_nom_nav") != rs.getFloat("ps11010_nom_nav_2") && rs.getFloat("ps11010_nom_nav_2") != 0.00) {%> 1x<%=rs.getString("ps11010_nom_nav")%><br>
                        1x<%=rs.getString("ps1103510_nom_nav_2")%><%}%>
                        <%if (rs.getFloat("ps11010_nom_nav_2") == 0.00 && rs.getFloat("ps11010_nom_nav") != 0.00) {%>1x<%=rs.getString("ps11010_nom_nav")%><%}%>
                        &nbsp;</td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.2.2&nbsp;</td>
                    <td width="316" valign="top">існуюче максимальне навантаження ПС, МВт</td>
                    <td width="124" colspan="2" valign="top" align="center"><%if (!rs.getString("ps11010pr").equals(""))%><%=rs.getString("ps11010_nom_nav")%>&nbsp;</td>
                    <td width="188" valign="top">Згідно таблиці максимальних навантажень по ПС</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.2.3&nbsp;</td>
                    <td width="316" valign="top">дозволена потужність для Замовників згідно з діючими технічними умовами та договорами про надання доступу (про приєднання), кВт&nbsp;</td>
                    <td width="124" colspan="2" valign="top" align="center">&nbsp;</td>
                    <td width="188" valign="top">Додається списком (Додаток 2)</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.3&nbsp;</td>
                    <td width="628" colspan="4" valign="top" align="center"><strong>ПС 35/10(6) кВ (назва):<%=rs.getString("ps3510pr")%>&nbsp;</strong></td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.3.1&nbsp;</td>
                    <td width="316" valign="top">кількість та потужність силових тр-рів, од. х МВА&nbsp;</td>
                    <td width="124" colspan="2" valign="top" align="center">
                        <%if (rs.getFloat("ps3510_nom_nav") == rs.getFloat("ps3510_nom_nav_2") && rs.getFloat("ps3510_nom_nav_2") != 0.00) {%> 2x<%=rs.getString("ps3510_nom_nav")%><%}%>
                        <%if (rs.getFloat("ps3510_nom_nav") != rs.getFloat("ps3510_nom_nav_2") && rs.getFloat("ps3510_nom_nav_2") != 0.00) {%> 1x<%=rs.getString("ps3510_nom_nav")%><br>
                        1x<%=rs.getString("ps3510_nom_nav_2")%><%}%>
                        <%if (rs.getFloat("ps3510_nom_nav_2") == 0.00 && rs.getFloat("ps3510_nom_nav") != 0.00) {%>1x<%=rs.getString("ps3510_nom_nav")%><%}%>
                        <%--if(!rs.getString("ps3510pr").equals(""))%><%=rs.getString("ps3510_nom_nav")--%> &nbsp;</td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.3.2&nbsp;</td>
                    <td width="316" valign="top">існуюче максимальне навантаження ПС, МВт</td>
                    <td width="124" colspan="2" valign="top" align="center"><%if (!rs.getString("ps3510pr").equals(""))%><%=rs.getString("ps3510_nav")%>&nbsp;</td>
                    <td width="188" valign="top">Згідно таблиці максимальних навантажень по ПС</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.3.3&nbsp;</td>
                    <td width="316" valign="top">дозволена потужність для Замовників згідно з діючими технічними умовами та договорами про надання    доступу (про приєднання), кВт&nbsp;</td>
                    <td width="124" colspan="2" valign="top" align="center">&nbsp;</td>
                    <td width="188" valign="top">Додається списком (Додаток 3)</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.4&nbsp;</td>
                    <td width="628" colspan="4" valign="top" align="center"><strong>ПС 10(6)/0,4 кВ (назва, номер):<%=rs.getString("type_source")%>-<%=rs.getString("ps10_name")%>&nbsp;</strong></td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.4.1</td>
                    <td width="316" valign="top">кількість та потужність силових тр-рів, од. х кВА&nbsp;</td>
                    <td width="124" colspan="2" valign="top" align="center">
                        <%if (rs.getFloat("ps10_nom_nav") == rs.getFloat("ps10_nom_nav_2") && rs.getFloat("ps10_nom_nav_2") != 0.00) {%> 2x<%=rs.getString("ps10_nom_nav")%><%}%>
                        <%if (rs.getFloat("ps10_nom_nav") != rs.getFloat("ps10_nom_nav_2") && rs.getFloat("ps10_nom_nav_2") != 0.00) {%> 1x<%=rs.getString("ps10_nom_nav")%><br>
                        1x<%=rs.getString("ps10_nom_nav_2")%><%}%>
                        <%if (rs.getFloat("ps10_nom_nav_2") == 0.00) {%> 1x<%=rs.getString("ps10_nom_nav")%><%}%>
                        &nbsp;</td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.4.2&nbsp;</td>
                    <td width="316" valign="top">існуюче максимальне навантаження ПС, кВт</td>
                    <td width="124" colspan="2" valign="top" align="center"><%=rs.getString("ps10_nav")%>&nbsp;</td>
                    <td width="188" valign="top">Згідно таблиці максимальних навантажень по ТП</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">5.4.3&nbsp;</td>
                    <td width="316" valign="top">дозволена потужність для Замовників згідно з діючими технічними умовами або договорами про надання доступу (про приєднання), кВт&nbsp;</td>
                    <td width="124" colspan="2" valign="top" align="center"><%=rs.getString("ps_rez10")%>&nbsp;</td>
                    <td width="188" valign="top">Додається списком (Додаток 4)</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">6&nbsp;</td>
                    <td width="628" colspan="4" valign="top">Кількість і орієнтовна довжина (найбільша) ліній електропередачі, які передбачають будувати (реконструювати), для видачі потужності / забезпечення надійності ліній напругою, кВ&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">&nbsp;6.1</td>
                    <td width="316" valign="top" align="center">110 (150)</td>
                    <td width="59" valign="top" align="center">lФ1&nbsp;</td>
                    <td width="65" valign="top" align="center">-&nbsp;</td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">&nbsp;6.2</td>
                    <td width="316" valign="top" align="center">35</td>
                    <td width="59" valign="top" align="center">lФ2&nbsp;</td>
                    <td width="65" valign="top" align="center">-&nbsp;</td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">&nbsp;6.3</td>
                    <td width="316" valign="top" align="center">10 (6)</td>
                    <td width="59" valign="top" align="center">lФ3&nbsp;</td>
                    <td width="65" valign="top" align="center">&nbsp;-</td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td width="44" nowrap valign="top" align="center">&nbsp;6.4</td>
                    <td width="316" valign="top" align="center">0,4</td>
                    <td width="59" valign="top" align="center">lФ4&nbsp;</td>
                    <td width="65" valign="top" align="center">&nbsp;</td>
                    <td width="188" valign="top">&nbsp;</td>
                </tr>
            </table>
            <p align="right">&nbsp;</p>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="218" height="25" valign="top"><p>Головний інженер</p></td>
                    <td width="225" valign="top"><p>&nbsp;</p></td>
                    <td width="225" valign="top"><p><%=rs.getString("golovnyi_ingener")%></p></td>
                </tr>
                <tr>
                    <td width="218" valign="top"><p>Інженер-керівник ВТГ</p></td>
                    <td width="225" valign="top"><p>&nbsp;</p></td>
                    <td width="225" valign="top"><p>________________________</p></td>
                </tr>
            </table>-->
            <br clear="all">
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
