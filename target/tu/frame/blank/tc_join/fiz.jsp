<%-- 
    Document   : fiz
    Created on : 16 лют 2011, 16:18:59
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
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
        String qry = "SELECT "
                + "TC_V2.number as number"
                + ",isnull(TC_V2.performance_data_tc_no,'') as performance_data_tc_no "
                + ",TC_V2.customer_type"
                + ",isnull(TC_V2.no_zvern,'') as no_zvern"
                + ",isnull(TC_V2.registration_no_contract,'_____') as registration_no_contract "
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
                + ",isnull(TC_V2.do10,'') as do10 "
                + ",isnull(res.name,'') as reason_tc "
                + ",isnull(cast(TC_V2.power_plit as varchar),'_____') as power_plit "
                + ",isnull(cast(TC_V2.power_boil as varchar),'_____') as power_boil "
                + ",isnull(cast(TC_V2.power_old as varchar),'_____') as power_old "
                + ",CAST(ISNULL(CAST(TC_V2.build_strum_power AS FLOAT),'') AS VARCHAR) as build_strum_power"
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
        rs.next();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
        <title>JSP Page</title>
        <jsp:include page="../word_page_format_12pt.jsp"/>
        <style type="text/css">
            <!--
            body,td,th {
                font-size: 9pt;
            }
            .style1 {
                font-size: 9pt;
                font-weight: bold;

            }
            .style2 {
                font-size: 9pt;
                font-weight: bold;
                margin-top: 0; /* Отступ сверху */
                margin-bottom: 0; /* Отступ снизу */  
            }
            li {
                margin-top: 0; /* Отступ сверху */
                margin-bottom: 0; /* Отступ снизу */    
            }
            -->
        </style>
    </head>
    <body>
        <div class="Section1">
            <p align="right" class="style1">ОП 4.1-Ґ</p>
            <p align="center">
                 &nbsp;<span class="style1">ФІЛІЯ ПАТ «ПРИКАРПАТТЯОБЛЕНЕРГО»<br/>
                    “<%=rs.getString("rem_name").toUpperCase()%> РАЙОН ЕЛЕКТРИЧНИХ МЕРЕЖ”</span></p>

            <table border="0" cellspacing="0" cellpadding="0" align="center" width="100%">
                <tr>
                    <td width="70%" valign="top"><p align="left" class="style1"><%=rs.getString("rem_licality")%></p>
                        <p align="left" class="style1">На № <%=rs.getString("no_zvern")%> від <%=rs.getString("registration_date")%> р.<br/>
                            Обов’язковий додаток до проекту.<br/></p></td>
                    <td valign="top"><p class="style1">Громадянин (ка)<br/> <strong><%= rs.getString("PIP")%></strong><br>
                            <%= rs.getString("type_o")%><%= rs.getString("customer_adress").replace("вул.", "<br>вул.")%>
                        </p></td>
                </tr>
            </table>
            <p align="center"><span class="style1"><strong>ТЕХНІЧНІ УМОВИ СТАНДАРТНОГО ПРИЄДНАННЯ № <%= rs.getString("number")%></strong><br/>
                    <strong>до електричних мереж електроустановок</strong><br/></span></p>
            <p align="right" class="style1">Додаток 1<br/>
                до договору про стандартне приєднання<br/>
                до електричних мереж  від<br>
                <%= rs.getString("date_contract")%> року<br/>
                № <%= rs.getString("number")%></p>
            <p>Дата видачі <%= rs.getString("initial_registration_date_rem_tu")%> року № <%=rs.getString("registration_no_contract")%> </p><br/>

                Назва об'єкту та повне найменування Замовника: <%--<span style="text-align: center"><strong><%= rs.getString("reason_tc")%>--%><span style="text-align: center"><%= rs.getString("object_name")%>, громадянин (ка)<br/> <strong><%= rs.getString("PIP")%></strong>.</span><br>
                1. Місцезнаходження об’єкта Замовника: <span style="text-align: center"><strong> <%= rs.getString("type_o")%> <%= rs.getString("object_adress")%>.</strong></span><br/>
                Функціональне призначення об'єкта: <strong><%= rs.getString("functional_target")%>.</strong><br/>
                Прогнозований рік уведення  об’єкта в експлуатацію:  <strong><%= rs.getString("date_intro_eksp").replaceAll("1900", "_____")%>.</strong><br/>
                2. Величина максимального розрахункового навантаження <strong><%= rs.getString("request_power").replace(".", ",")%> кВт</strong>, у тому числі для:<br/>
                <%if (!rs.getString("power_old").equals("0.00")) {%>
                існуюча потужність <%=rs.getString("power_old")%> кВт, договір №<%=rs.getString("nom_data_dog")%><%}%>
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
                <%if ((!rs.getString("power_plit").equals("_____")) || (!rs.getString("power_boil").equals("_____")) || (!rs.getString("power_for_electric_devices").equals("_________"))) {%><tr>
                    <td width="347" valign="top"><span class="style1">Встановлена потужність електронагрівальних установок:</span></td>
                </tr><%}%>
            </table>
            <%}%>
            <table border="0" cellspacing="0" cellpadding="0">
                <%if (!rs.getString("power_plit").equals("_____")) {%><tr>
                    <td width="347" valign="top">
                        <span class="style1">стаціонарної електричної плити </span></td>
                    <td width="340" valign="top"><p class="style1"><%=nf.format(rs.getFloat("power_plit"))%> кВт,</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_boil").equals("_____")) {%><tr>
                    <td width="347" valign="top"><p class="style1">електричного підігріву води</p></td>
                    <td width="340" valign="top"><p class="style1"><%=nf.format(rs.getFloat("power_boil"))%> кВт,</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_electric_devices").equals("_________")) {%><tr>
                    <td width="347" valign="top"><p class="style1">опалення приміщень</p></td>
                    <td width="340" valign="top"><p class="style1"><%=nf.format(rs.getFloat("power_for_electric_devices"))%> кВт.</p></td>
                </tr><%}%>
            </table>
            <dl>
                <%if (!rs.getString("build_strum_power").equals("0")) {%>Величина навантаження будівельних струмоприймачів <strong><%=rs.getString("build_strum_power")%> кВт</strong>.<%}%>
                <dt>3. Джерело електропостачання:<strong>
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
                <dt>4. Точка забезпечення потужності: <strong><%= rs.getString("point_zab_power")%></strong></dt>
                <dt>5. Точка приєднання: <strong><%= rs.getString("connection_treaty_number")%></strong></dt> 
                <dt>6. Прогнозовані межі балансової належності та експлуатаційної відповідальності встановлюються в точці приєднання електроустановки.<br>
                <dd>
                    <p align="center"><strong> 7. Вимоги до електроустановок Замовника</strong></p>
                </dd>
                <dt>
                <div align="justify" style="text-align:justify">
                    <dt>1. Для одержання потужності Замовнику необхідно виконати:</dt>
                    <dt>1.1. Вимоги до технічного узгодження електроустановок Замовника та електропередавальної організації:
                        <strong>до початку виконання робіт електропередавальну організацію по наданню послуг приєднання забезпечити
                        місце для встановлення приладу обліку(спеціальну конструкцію або цегляна стіна висотою 1,8 м з
                        термостійким і жорстким кріпленням...) та письмово повідомити ЕО про готовність такого місця для
                        встановлення приладу обліку електроенергії на ньому.</strong></dt>
                    <dt>1.2. Вимоги до ізоляції, пристроїв захисного відключення, засобів стабілізації,
                        захисту від перенапруги: при встановленні металевого ВРЩ виконати монтаж контуру
                        захисного заземлення з опором заземлення не більше 4,0 Ом.</dt>
                    <dt>1.3  Для укладення ДКЕЕ Замовник повинен надати наступні документи: </dt>
                    <dt>-	оригінал та копію паспорта власника (користувача) об’єкта;</dt> 
                    <dt>-	ідентифікаційний код власника (користувача) об’єкта;</dt> 
                    <dt>-	документ, який засвідчує право власності (користування) на об’єкт. При відсутності документа про право на власність, документ який засвідчує право власності (користування) на земельну ділянку.</dt> 
                    <dt>Для укладення договору про постачання електричної енергії або договору про спільне використання технологічних електричних мереж заявник (власник технологічних електричних мереж (основний споживач)) має надати документи, передбачені п. 5.4 Правил користування електричною енергією.</dt> 
                    <dt>1.4. Вимоги до електропостачання приладів та пристроїв, які використовуються для будівництва та реконструкції об’єктів електромереж:  </dt> 
                    <dt>- <%=rs.getString("do10")%></dt>
                    <dt>2  У випадку наявності існуючих ЛЕП в зоні забудови, винести їх з даної зони відповідно до технічного завдання, отриманого в філії. «<%=rs.getString("rem_name")%> РЕМ»</dt>
            </dl></div>

        <br>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="391" valign="top"><p class=""><strong>Власник</strong></p></td>
                <td width="240" valign="top"><p class=""><strong>Замовник</strong></p></td>
            </tr>
            <tr>
                <td width="328" valign="top">М.П.
                    <br>Головний інженер філії ПАТ «Прикарпаттяобленерго»<br>
                    “<%= rs.getString("rem_name")%> РЕМ”<br>
                    <u><%=rs.getString("golovnyi_ingener")%></u>					  
                </td>
                <td width="329" valign="top">М.П.<br>
                    Громадянин (ка)<br><br>
                    <u><%=rs.getString("PIP")%></u>
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

        <p>Прізвище виконавця<br>
            Телефон</p>
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
