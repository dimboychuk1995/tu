<%--
    Document   : fiz
    Created on : 16 лют 2011, 16:18:59
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%
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
                + ",isnull(TC_V2.registration_no_contract,'') as registration_no_contract "
                + ",isnull(convert(varchar,TC_V2.registration_date,104),'') as registration_date"
                + ",isnull(soc_status.full_name,'') as customer_soc_status"
                + ",isnull(TC_V2.projected_year_operation,'') as projected_year_operation"
                + ",CASE WHEN TC_V2.customer_type=1 THEN isnull(TC_V2.juridical,'')"
                + "     WHEN TC_V2.customer_type=0 THEN isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'')"
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
        rs.next();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="../word_page_format_12pt.jsp"/>
    </head>
    <body>
        <div class="Section1">
            <p align="right" class="style1">7.51-ПР-1-ТД-1.4.Д</p>
            <p align="center">
                 &nbsp;<span class="style1">ФІЛІЯ ПАТ «ПРИКАРПАТТЯОБЛЕНЕРГО»<br>
                    “<%=rs.getString("rem_name").toUpperCase()%> РАЙОН ЕЛЕКТРИЧНИХ МЕРЕЖ”</span></p>

            <table border="0" cellspacing="0" cellpadding="0" align="center" width="100%">
                <tr>
                    <td width="70%" valign="top"><p align="left" class="style1"><%=rs.getString("rem_licality")%></p>
                        <p align="left" class="style1">На № <%=rs.getString("no_zvern")%> від <%=rs.getString("registration_date")%> р.<br>
                            Обов’язковий додаток до проекту.<br></p></td>
                    <td valign="top"><p class="style1">Громадянин (ка)<br> <strong><%= rs.getString("PIP")%></strong> <br>
                            <%= rs.getString("type_o")%><%= rs.getString("customer_adress")%><br>
                        </p></td>
                </tr>
            </table>
            <p align="center"><span class="style1"><strong>ТЕХНІЧНІ УМОВИ № <%= rs.getString("number")%></strong><br>
                    <strong>для населення</strong><br></span></p>
            <p align="right" class="style1">Додаток 1<br>
                до договору про надання доступу<br>
                до електричних мереж будівельних електромеханізмів від<br>
                <%= rs.getString("date_contract")%> року<br>
                № <%= rs.getString("number")%></p>
            <p class="style1">Дата видачі <%= rs.getString("date_customer_contract_tc")%> року, <br>
                вихідний номер реєстрації у РЕМ № <%= rs.getString("registration_no_contract")%></p>
            <p class="style1">Назва об'єкту: <span style="text-align: center"><strong><%= rs.getString("object_name")%></strong>.</span><br></p>
            <p class="style1">1 Місцезнаходження об’єкта Замовника  <%= rs.getString("type_o")%> <%= rs.getString("object_adress")%>.<br>
                2 Величина розрахункового максимального навантаження <%= rs.getString("request_power")%> кВт,<br>
                у тому числі для:</p>
                <%if (!rs.getString("power_old").equals("0.00")) {%>
            існуюча потужність <%=rs.getString("power_old")%> кВт, договір №<%=rs.getString("nom_data_dog")%><%}%>
            <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%>
            <strong>I категорія</strong><br>
            <%}%>
            <%if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE")) {%>
            <strong>II категорія</strong><br>
            <%}%>
            <%if (rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%>
            <strong>III категорія</strong><br>
            <%}%>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="347" valign="top">
                        <span class="style1">стаціонарної електричної плити </span></td>
                    <td width="340" valign="top"><p class="style1"><%=rs.getString("power_plit")%> кВт,</p></td>
                </tr>
                <tr>
                    <td width="347" valign="top"><p class="style1">електричного підігріву води</p></td>
                    <td width="340" valign="top"><p class="style1"><%= rs.getString("power_boil")%> кВт,</p></td>
                </tr>
                <tr>
                    <td width="347" valign="top"><p class="style1">опалення приміщень</p></td>
                    <td width="340" valign="top"><p class="style1"><%= rs.getString("power_for_electric_devices")%> кВт.</p></td>
                </tr>
            </table><br>
            <dl>
                <dt>3 Напруга <%= rs.getString("join_point").substring(16)%> кВ.</dt>
                <dt>4 Джерело електропостачання:<strong>
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
                        %>2x<%=rs.getString("ps10_nom_nav")%><%
                            }%><%
                            if (rs.getFloat("ps10_nom_nav") != rs.getFloat("ps10_nom_nav_2") && rs.getFloat("ps10_nom_nav_2") != 0.00) {
                        %>1x<%=rs.getString("ps10_nom_nav")%>1x<%=rs.getString("ps10_nom_nav_2")%><%
                            }%><%
                            if (rs.getFloat("ps10_nom_nav_2") == 0.00) {
                        %>1x<%=rs.getString("ps10_nom_nav")%><%
                            }%> кВА)
                        <%}
                            //}//while(rs.next());
                            //rs.first();%>
                        .</strong></dt>
                <dt>5 Точка підключення: <strong><%= rs.getString("connection_treaty_number")%></strong></dt>
                <dt>6 Для підключення до електромережі необхідно виконати  проектування та будівництво:</dt>
                <dt>6.1 У електромережах до прогнозованої межі балансової  належності:</dt><strong>
                    <dt><% if (!rs.getString("do1").equals("")) {%><%= rs.getString("do1").replaceAll("7.1.", "</dt><dt>6.1.")%><%}%></dt></strong>
                <dt>6.2 Від межі балансової належності до електроустановок  Замовника:</dt><strong>
                    <dt><%= rs.getString("do2").replaceAll("7.2.", "</dt><dt>6.2.")%></dt></strong>
                <dt> 7. Розрахунковий облік електричної енергії: <strong><%= rs.getString("do3").replaceAll("7.2.", "</dt><dt>7.1.")%></strong>. Прилади обліку придбаваються, встановлюються, підключаються  енергопостачальником (електропередавальною організацією), а вартість цих послуг  оплачується Замовником за окремим договором. Придбання, встановлення та підключення приладів обліку електричної енергії  виконується РЕМ за рахунок абонента згідно вимог п.8 ПКЕЕН.<br>
                    Вимоги щодо встановлення  розрахункових засобів обліку:</dt>
                <dd> - У випадку встановлення багатотарифного приладу  обліку та неможливості застосування приладу обліку  з функцією обмеження максимального споживання  потужності, встановити ПЗР . Номінальний струм ПЗР визначити проектом.</dd>
                <dd> - На  трифазних лічильниках, що встановлюються, повинні бути пломби Держповірки з  терміном давності не більше 12 місяців, а на однофазних лічильниках – з  терміном давності не більше 2 років (п. 1.5.13. ПУЕ).</dd>
                <dd> - Клас  точності розрахункових лічильників електроенергії повинен бути не нижче 2.0.</dd>
                <dd> - Висота  встановлення засобів обліку електричної енергії повинна бути в межах 0,8-1,7 м (п.&nbsp;1.5.29. ПУЕ).</dd>
                <dd> - Ввідний  комутаційний апарат при 3-фазних лічильниках встановлювати з номінальними  даними згідно робочого проекту на електропостачання.</dd>
                <dd> - Доступ  до дооблікових струмовідних кіл повинен бути закритий і передбачати можливість  для пломбування.</dd>
                <dd> - Ввід  від опори (ТП, РП) повинен бути виконаний суцільним проводом без розривів до  контейнера (ввідного комутаційного пристрою п.1.5.33. ПУЕ).</dd>
                <dt>8. Влаштування  захисту від пошкоджень та обмеження дозволеної потужності: Встановити дообліковий комутаційний пристрій (<%= rs.getString("join_point").substring(16)%>) кВ. Тип і номінальний струм автоматичного комутаційного пристрою визначити проектом.<br>
                    У ввідному пристрої житлового будинку змонтувати пристрій захисного вимкнення (ПЗВ), його тип визначити проектом.
                    <%= rs.getString("do5")%> (тип  дооблікових та післяоблікових автоматів з зазначенням допустимих величин.</dt>
                <dt>9. Змонтувати  контур заземлення на <strong>ввідній опорі</strong> з опором заземлення не більше <strong>30 </strong>Ом.
                    заземлення,  виконання силової електропроводки в 3-провідному виконанні тощо). Виконати монтаж контуру заземлення з опором не білше 4 Ом. </dt>

                <dt>10. Перелік документів, які необхідно надати для підключення:</dt>
                <dd><em>10.1<u>. проект на влаштування вводу до  будинку та виносної шафи обліку електроенергіі;</u></em></dd>
                <dd><em>10.2<u>. протоколи випробування  електропроводки;</u></em></dd>
                <dd><em>10.3<u>. протокол заміру опору захисного заземлення;</u></em></dd>
                <dd><em>10.4<u>. акти прихованих робіт;</u></em></dd>
                <dd><em>10.5<u>. акт обстеження технічного стану  електроустановки та допуску в експлуатацію.</u></em></dd>
                <dt>11. Інші вимоги, передбачені законодавством України:</dt>
                <dd><em>11.1. <u>На стадіі проектування траси ЛЕП погодити із  землевласниками(землекористувачами), усіма зацікавленими організаціями та <%=rs.getString("rem_name").substring(0, rs.getString("rem_name").length() - 1)%>м РЕМ.</u></em></dd>
                <dd><em>11.2. <u>До початку будівництва проект електропостачання погодити з <%=rs.getString("rem_name").substring(0, rs.getString("rem_name").length() - 1)%>м РЕМ.</u></em></dd>
                <dt>12. Акт допуску на підключення оформити в  <%=rs.getString("rem_name").substring(0, rs.getString("rem_name").length() - 2)%>ому РЕМ.</dt>
                <%if (!rs.getString("performance_data_tc_no").equals("")) {%> <dt>13. Виконання технічних умов можливе спільно з технічними умовами №<%=rs.getString("performance_data_tc_no")%> </dt><%}%>
                <dt style="text-align: justify">13. До початку будівництва винести із зони забудови існуючі ЛЕП. Параметри ліній, що підлягають під винос, отримати в філії “<%=rs.getString("rem_name")%> РЕМ”. </dt>
                <dt>14.  У випадку наявності існуючих ЛЕП в зоні забудови, винести їх з даної зони відповідно до технічного завдання, отриманого в філії «<%=rs.getString("rem_name")%> РЕМ»</dt>
            </dl>
            <p>&nbsp;</p>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="391" valign="top"><p class="style1"><strong>Власник</strong></p></td>
                    <td width="240" valign="top"><p class="styleToZamovnyk">Замовник</p></td>
                </tr>
                <tr>
                    <td width="391" valign="top"><p class="style1">М. П.</p>
                        <p class="style1">Головний    інженер </p>
                        <p class="style1"><%= rs.getString("golovnyi_ingener")%></p>
                        <p class="style1">____________<br>
                            Підпис</p></td>
                    <td width="240" valign="top"><p class="styleToZamovnyk">М. П.</p>
                        <p class="styleToZamovnyk">Громадянин (ка)</p>
                        <p class="styleToZamovnyk"><%= rs.getString("PIP")%> <br>
                            <br>
                            ____________<br>
                            Підпис</p></td>
                </tr>
            </table>
            <p>&nbsp;</p>
            <p class="style1">Прізвище виконавця<br>
                Телефон</p>
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
