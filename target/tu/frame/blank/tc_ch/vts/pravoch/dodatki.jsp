<%-- dorobutu
    Document   : zmin
    Created on : 12 квіт 2011, 10:21:34
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.*,java.text.NumberFormat"%>
<%  response.setHeader("Content-Disposition", "inline;filename=dodatki.doc");
    NumberFormat nf = NumberFormat.getInstance();
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    HttpSession ses = request.getSession();
    String db = new String();
    if (ses.getAttribute("db_name") != null) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try {
        c = ds.getConnection();
        String qry = "SELECT "
                + "TC_V2.type_contract as type_contract "
                + ",TC_V2.number as number "
                + ",isnull(TC_V2.type_join,0) as join2"
                + ",isnull( dbo.TC_V2.functional_target,'') as functional_target"
                + ",YEAR(isnull(convert(varchar,TC_V2.date_intro_eksp,104),'')) as date_intro_eksp"
                + ", isnull(convert(varchar,TC_V2.date_intro_eksp,104),'___.___.____') as date_intro_eksp2"
                + ",CAST(ISNULL(CAST(TC_V2.build_strum_power AS FLOAT),'') AS VARCHAR) as build_strum_power"
                + ",isnull( dbo.TC_V2.point_zab_power,'') as point_zab_power"
                + ",isnull(TC_V2.do10,'') as do10 "
                + ",TC_V2.registration_no_contract as registration_no_contract"
                + ",isnull(convert(varchar,TC_V2.initial_registration_date_rem_tu,104),'__.__.____') as initial_registration_date_rem_tu"
                + ",isnull(TC_V2.no_zvern,'') as no_zvern"
                + ",isnull(convert(varchar,TC_V2.registration_date,104),'') as registration_date"
                + ",TC_V2.customer_type"
                + ",isnull(soc_status.full_name,'') as customer_soc_status "
                + ",isnull(soc_status.name,'') as customer_soc_status0"
                + ",isnull(TC_V2.customer_soc_status,'') as customer_soc_status_1"
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
                + "     when objadr.type=3 then 'смт.' "
                + "     else '' end as type_o"
                + ",case when nullif(TC_V2.[object_adress],'') is null then "
                + "         isnull(objadr.name,'') "
                + "     when nullif(objadr.name,'') is null then "
                + "         isnull(TC_V2.[object_adress],'') "
                + "     else isnull(objadr.name,'')+', вул.'+ isnull(TC_V2.[object_adress],'') end as object_adress"
                + ",isnull(convert(varchar,TC_V2.date_contract,104),'__.__.____') as date_contract"
                + ",isnull(convert(varchar,TC_V2.date_customer_contract_tc,104),'___.___.____') as date_customer_contract_tc"
                + ",case when cusadr.type=1 then 'м.'"
                + "     when cusadr.type=2 then 'с.'"
                + "     when cusadr.type=3 then 'смт.' "
                + "     else '' end as type_c"
                + ", case when nullif(TC_V2.[customer_adress],'') is null then"
                + "         isnull(cusadr.name,'')"
                + "		when nullif(cusadr.name,'') is null then"
                + "         isnull(TC_V2.[customer_adress],'')"
                + "     else isnull(cusadr.name,'')+', вул. '+ isnull(TC_V2.[customer_adress],'') end as customer_adress"
                + ",isnull(TC_V2.[bank_account],'') as [bank_account]"
                + ",isnull(TC_V2.[bank_mfo],'') as [bank_mfo]"
                + ",isnull(TC_V2.[bank_identification_number],'') as [bank_identification_number]"
                + ",isnull(TC_V2.[connection_treaty_number],'') as [connection_treaty_number] "
                + ",isnull(replace(rtrim(REPLACE(replace(rtrim(replace(cast(TC_V2.request_power as varchar(150)),'0',' ')),' ','0'),'.',' ')),' ','.'),0) as request_power"
                + ", CASE"
                + " WHEN TC_V2.reliabylity_class_1='true' THEN 'I '"
                + " ELSE '' END AS reliabylity_class_1_0"
                + " ,CASE"
                + " WHEN TC_V2.reliabylity_class_2='true' THEN 'II '"
                + " ELSE '' END AS reliabylity_class_2_0"
                + " ,CASE"
                + " WHEN TC_V2.reliabylity_class_3='true' THEN 'III'"
                + " ELSE ' ' END AS reliabylity_class_3_0"
                + " ,case when SUPPLYCH.join_point=1 then '0,4' "
                + "     when SUPPLYCH.join_point=11 then '0,23' "
                + "     when SUPPLYCH.join_point=2 then '0,4' "
                + "     when SUPPLYCH.join_point=21 then '0,23' "
                + "     when SUPPLYCH.join_point=3 then '10' "
                + "     when SUPPLYCH.join_point=4 then '10' "
                + "     when SUPPLYCH.join_point=5 then '35'"
                + "     when SUPPLYCH.join_point=6 then '35' "
                + "     when SUPPLYCH.join_point=7 then '110' "
                + "    else '___' end as joint_point_2 "
                + ",isnull(TC_V2.[reliabylity_class_1],'') as reliabylity_class_1"
                + ",isnull(TC_V2.[reliabylity_class_2],'') as reliabylity_class_2"
                + ",isnull(TC_V2.[reliabylity_class_3],'') as reliabylity_class_3"
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
                + ",case when cast(TC_V2.[reliabylity_class_1_val] AS varchar) like '%.00' then cast(cast(TC_V2.[reliabylity_class_1_val] AS numeric(10,0)) AS varchar) "
                + "else cast(TC_V2.[reliabylity_class_1_val] as varchar) "
                + "end as reliabylity_class_1_val"
                + ",case when cast(TC_V2.[reliabylity_class_2_val] AS varchar) like '%.00' then cast(cast(TC_V2.[reliabylity_class_2_val] AS numeric(10,0)) AS varchar) "
                + "else cast(TC_V2.[reliabylity_class_2_val] as varchar) "
                + "end as reliabylity_class_2_val "
                + ",case when cast(TC_V2.[reliabylity_class_3_val] AS varchar) like '%.00' then cast(cast(TC_V2.[reliabylity_class_3_val] AS numeric(10,0)) AS varchar) "
                + "else cast(TC_V2.[reliabylity_class_3_val] as varchar) "
                + "end as reliabylity_class_3_val "
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
                + "     end as power_plit "
                + ",case when cast(isnull(TC_V2.[power_old],0.00) AS varchar) like '%.00' then cast(cast(isnull(TC_V2.[power_old],0.00) AS numeric(10,0)) AS varchar) "
                + "         else cast(TC_V2.[power_old] as varchar) "
                + "     end as power_old"
                + ",isnull(TC_V2.nom_data_dog,'') as nom_data_dog "
                + ",isnull(TC_V2.performance_data_tc_no,'') as performance_data_tc_no"
                + ",isnull(nullif(TC_V2.do1,''),'') as do1 "
                + ",isnull(TC_V2.do2,'') as do2 "
                + ",isnull(TC_V2.do3,'') as do3 "
                + ",isnull(TC_V2.do4,'') as do4 "
                + ",isnull(TC_V2.do5,'') as do5 "
                + ",isnull(TC_V2.do6,'') as do6 "
                + ",isnull(TC_V2.do7,'') as do7 "
                + ",isnull(TC_V2.do8,'') as do8 "
                + ",isnull(TC_V2.do10,'') as do10 "
                + ",isnull(TC_V2.do11,'') as do11 "
                + ",isnull(TC_V2.do14,'') as do14 "
                + ",isnull(TC_V2.do15,'') as do15 "
                + ",isnull(TC_V2.do15,'') as do16 "
                + ",isnull(TC_V2.do17,'') as do17 "
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
                + "    else '____________________' end as joint_point "
                + ",isnull(convert (varchar(10),TC_V2.initial_registration_date_rem_tu,104),'___.___.____') as initial_date"
                + ",isnull(TC_V2.customer_telephone,'_________') as customer_telephone"
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
                + " ,isnull(dbo.TC_V2.term_for_joining,0) as term_for_joining "
                + ",isnull(dbo.TC_V2.price_join,'0') as price_join"
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
                + ",isnull (ps10.ps_nom_nav,'') as ps10_nom_nav "
                + ",isnull (ps10.ps_nom_nav_2,'') as ps10_nom_nav_2 "
                + ",case when ps10.ps_nom_nav_2=0 or ps10.ps_nom_nav_2 is null "
                + " then 1 else 2 end as kilkist10 "
                + ",isnull(SUPPLYCH.power,'') as power "
                + ",(select count(*) from SUPPLYCH where tc_id=" + request.getParameter("tu_id") + ") as kilk "
                + ",isnull(ch.No_letter,'') as No_letter "
                + ",isnull(ch.Description_change,'') as Description_change "
                + ",isnull(convert(varchar,ch.send_date_lenner,104),'') as send_date_lenner "
                + ",isnull(convert(varchar,ch.Tc_continue_to,104),'___.___.___') as Tc_continue_to "
                + ",[rem_name] "
                + ",[Director] "
                + ",[director_rod]"
                + ",[dovirenist]"
                + ",[contacts] "
                + ",[rek_bank] "
                + ",[rem_licality] "
                + ",[golovnyi_ingener] "
                + ",[director_dav] "
                + ",isnull(tj.name,'надання доступу') as type_join"
                + ",case  "
                + "when TC_V2.type_join=1 or TC_V2.type_join=2 then 'Виконавець послуг'"
                + "else 'Власник мереж' end as executor_template"
                + " from TC_V2 "
                + " left join Changestc ch on ch.id_tc=TC_V2.id"
                + " left join [TC_LIST_locality] objadr on objadr.id=TC_V2.name_locality"
                + " left join [TC_LIST_locality] cusadr on cusadr.id=TC_V2.customer_locality"
                + " left join [TUweb].[dbo].[TC_LIST_customer_soc_status] soc_status on soc_status.id=TC_V2.customer_soc_status "
                + " left join [TUweb].[dbo].[rem] rem on TC_V2.department_id=rem.rem_id "
                + " left join TC_V2 TC_O on TC_V2.main_contract=TC_O.id "
                + " left join SUPPLYCH on SUPPLYCH.tc_id=TC_V2.id "
                + " left join [TUweb].[dbo].[ps_tu_web] ps35 on SUPPLYCH.ps_35_disp_name=ps35.ps_id "
                + " left join [TUweb].[dbo].[ps_tu_web] ps110 on SUPPLYCH.ps_110_disp_name=ps110.ps_id "
                + " left join [TUweb].[dbo].[ps_tu_web] ps10 on SUPPLYCH.ps_10_disp_name=ps10.ps_id"
                + " left join [TUweb].[dbo].[type_join] tj on TC_V2.type_join=tj.id"
                + " where ch.id=" + request.getParameter("id");
        pstmt = c.prepareStatement(qry,
                ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();
        rs.next();
        String tmp = "";
        int i = 1;
        int k = 2;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns:w="urn:schemas-microsoft-com:office:word">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <style type="text/css">
    <!--
    body,td,th {
        font-size: 11pt;
    }
    .tb8pt, .tb8pt tr, .tb8pt td {
        font-size: 8pt;
    }
    .style1 {
        font-weight: bold;
    }
    .shablon {
        font-weight: bold;
    }
    @page Section1
    {
        margin:1.0cm 1.0cm 1.0cm 2.0cm;
    }
    div.Section1
    {page:Section1;}
    -->
    <xml>
    <w:WordDocument>
    <w:View>Print</w:View>
    <w:GrammarState>Clean</w:GrammarState>
    <w:HyphenationZone>21</w:HyphenationZone>
    <w:ValidateAgainstSchemas/>
    <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
    <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
    <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
    <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
    </w:WordDocument>
    </xml>
</style>
    </head>
    <body>
        <div class="Section1">
            <p align="center"><strong>Додатковий  правочин № П-<%= rs.getString("No_letter")%> </strong> <br>
                до Договору про <%=rs.getString("type_join")%> до електричних мереж<br>
                <strong>№  <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> року </strong></p>
            <table border="0" cellpadding="0" width="100%">
                <tr>
                    <td width="50%">м. Івано-Франківськ </td>
                    <td><p align="right">“_____”______________    201_ р.</p></td>
                </tr>
            </table>
            <p style="text-align:justify;text-indent:20pt"><strong>ПАТ “Прикарпаттяобленерго”,</strong> що&nbsp; діє за  умовами та правилами Ліцензії АБ № 177333 (далі – <%=rs.getString("executor_template")%>), в особі технічного директора ПАТ  «Прикарпаттяобленерго» Сеника Олега Степановича, який діє на підставі  довіреності № 927 від 25.08.2015 року, з однієї сторони,  та  <strong><%if (!rs.getString("customer_soc_status_1").equals("9")
                                && !rs.getString("customer_soc_status_1").equals("12")) {%><%= rs.getString("customer_soc_status")%><%}%> <%= rs.getString("name")%></strong>, надалі ― замовник, <%if ((!rs.getString("customer_soc_status_1").equals("15")
                                            && !rs.getString("customer_soc_status_1").equals("11")) && (rs.getString("customer_type").equals("1"))) {%> в особі <strong><%= rs.getString("customer_post")%>&nbsp;<%= rs.getString("PIP")%></strong>,<%}
                                                        if (rs.getString("customer_type").equals("1")) {%> який діє на підставі <%}%><strong><%= rs.getString("constitutive_documents")%></strong>, з іншої сторони, (далі – Сторони), враховуючи заяву  Замовника від <%= rs.getString("send_date_lenner")%> року, домовились про наступне: </p>
                <%--<p style="text-align:justify;text-indent:20pt">
     Продовжити термін дії Договору про <%=rs.getString("type_join")%> до електричних  мереж <strong>№ <%= rs.getString("number")%> від <%= rs.getString("date_customer_contract_tc")%> року</strong>  до <strong><%= rs.getString("Tc_continue_to")%> року</strong>.</p>--%>
            <ol>
                <li>Викласти  Договір про <%=rs.getString("type_join")%> до електричних мереж <strong>№ <%= rs.getString("number")%> від <%= rs.getString("date_customer_contract_tc")%> року</strong> (далі Договір) у новій редакції, що додається  (Додаток № 1).</li>
                <li>По всіх  виконаних та невиконаних зобов’язаннях по Договору <strong>№ <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> року</strong> сторони не мають претензій одна до одної.</li>
                <li>Внести зміни  до Додатку № 1 по Договору про <%=rs.getString("type_join")%> до електричних мереж <strong>№ <%= rs.getString("number")%> від <%= rs.getString("date_customer_contract_tc")%> року</strong> шляхом його викладення у новій редакції, що  додається (Додаток № 2).</li>
                <li>Даний  Додатковий правочин про зміни до Договору набирає чинності після його  підписання та Додатків № 1, 2 Сторонами та діє протягом двох років з дати  укладення.</li>
                <li>Даний  Додатковий правочин, Додаток № 1, Додаток № 2 укладено у двох примірниках, з  яких перший примірник зберігається у Власника мереж, другий зберігається у  Замовника.</li>
            </ol>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <%if (rs.getString("join2").equals("2")) {%>
            <table border="0" cellspacing="0" cellpadding="0" width="716">
                <tr>
                    <td><strong><%=rs.getString("executor_template")%>:</strong></td>
                    <td>замовник</td>
                </tr>
                <tr>
                    <td width="295" valign="top"><p>
                            <strong>ПАТ «Прикарпаттяобленерго»</strong><br>
                            м. Івано-Франківськ, вул. Індустріальна 34 <br>
                        <% if ((rs.getString("join2").equals("1")) || (rs.getString("join2").equals("2"))) { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р <% if (rs.getString("join2").equals("1")) { %>26000011732450 <%} else { %> 26003011732479 <% } %> в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                        Код МФО 300023<br>
                        <% } else { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р 26009305757  в філії Івано-Франківське обласне управління АТ «Ощадбанк»<br>
                        Код МФО 336503 <br>
                        <% } %>
                            <strong>Технічний директор </strong><br>
                            <strong>ПАТ «Прикарпаттяобленерго»</strong><br>
                        </p></td>
                    <td width="421" valign="top"><p><strong><%= rs.getString("customer_soc_status")%> <%= rs.getString("name")%></strong><br>
                            <strong><%=rs.getString("type_c")%> <%= rs.getString("customer_adress")%></strong><br>
                            р/р <%= rs.getString("bank_account")%> МФО <%= rs.getString("bank_mfo")%><br>
                            _________________________________________________<br>
                            <strong>_____________________________________</strong><br>
                            Код ЄДРПОУ    <%= rs.getString("bank_identification_number")%><br>
                            Свідоцтво платника ПДВ № _____________________<br>
                            Індивідуальний податковий №    ___________________<br>
                            <strong><u><%if ((!rs.getString("customer_soc_status_1").equals("15")
                                                && !rs.getString("customer_soc_status_1").equals("11")) && (rs.getString("customer_type").equals("1"))) {%> в особі <strong><%= rs.getString("customer_post")%><%}%></u></strong></p></td>
                </tr>
                <tr>
                    <td><strong>_____________Сеник Олег Степанович </strong></td>
                    <td><strong>____________________    <%= rs.getString("PIP")%></strong></td>
                </tr>
            </table><%} else if (rs.getString("join2").equals("1")) {%>
            <table border="0" cellspacing="0" cellpadding="0" width="716">
                <tr>
                    <td><strong><%=rs.getString("executor_template")%>:</strong></td>
                    <td>замовник</td>
                </tr>
                <tr>
                    <td width="328" valign="top"><p>ПАТ «Прикарпаттяобленерго»<br>                            
                            <u>м. Івано-Франківськ, вул. Індустріальна, 34</u><br>
                        <% if ((rs.getString("join2").equals("1")) || (rs.getString("join2").equals("2"))) { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р <% if (rs.getString("join2").equals("1")) { %>26000011732450 <%} else { %> 26003011732479 <% } %> в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                        Код МФО 300023<br>
                        <% } else { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р 26009305757  в філії Івано-Франківське обласне управління АТ «Ощадбанк»<br>
                        Код МФО 336503 <br>
                        <% } %>
                            тел: <%= rs.getString("contacts").replace("тел. (", "").replace(")", "")%><br>
                            Директор філії ПАТ «Прикарпаттяобленерго»<br>
                            “<%= rs.getString("rem_name")%> РЕМ”<br>
                        </p></td>
                    <td width="421" valign="top"><p><strong><%= rs.getString("customer_soc_status")%> <%= rs.getString("name")%></strong><br>
                            <strong><%=rs.getString("type_c")%> <%= rs.getString("customer_adress")%></strong><br>
                            р/р <%= rs.getString("bank_account")%> МФО <%= rs.getString("bank_mfo")%><br>
                            _________________________________________________<br>
                            <strong>_____________________________________</strong><br>
                            Код ЄДРПОУ    <%= rs.getString("bank_identification_number")%><br>
                            Свідоцтво платника ПДВ № _____________________<br>
                            Індивідуальний податковий №    ___________________<br>
                            <strong><u><%if ((!rs.getString("customer_soc_status_1").equals("15")
                                                && !rs.getString("customer_soc_status_1").equals("11")) && (rs.getString("customer_type").equals("1"))) {%> в особі <strong><%= rs.getString("customer_post")%><%}%></u></strong></p></td>
                </tr>
                <tr>
                    <td>________________        <u><%=rs.getString("Director")%></u><br>
                                (підпис)                              (П.І.Б.)</td>
                    <td>_______________       <u><%=rs.getString("PIP")%></u><br>
                                   (підпис)                        (П.І.Б.)</td>
                </tr>
            </table><%} else {%>
            <table border="0" cellspacing="0" cellpadding="0" width="716">
                <tr>
                    <td><strong>Власник мереж:</strong></td>
                    <td>замовник</td>
                </tr>
                <tr>
                    <td width="295" valign="top"><p>
                            <strong>ПАТ «Прикарпаттяобленерго»</strong><br>
                            м. Івано-Франківськ, вул. Індустріальна 34 <br>
                        <% if ((rs.getString("join2").equals("1")) || (rs.getString("join2").equals("2"))) { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р <% if (rs.getString("join2").equals("1")) { %>26000011732450 <%} else { %> 26003011732479 <% } %> в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                        Код МФО 300023<br>
                        <% } else { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р 26009305757  в філії Івано-Франківське обласне управління АТ «Ощадбанк»<br>
                        Код МФО 336503 <br>
                        <% } %>
                            <strong>Технічний директор </strong><br>
                            <strong>ПАТ «Прикарпаттяобленерго»</strong><br>
                        </p></td>
                    <td width="421" valign="top"><p><strong><%= rs.getString("customer_soc_status")%> <%= rs.getString("name")%></strong><br>
                            <strong><%=rs.getString("type_c")%> <%= rs.getString("customer_adress")%></strong><br>
                            р/р <%= rs.getString("bank_account")%> МФО <%= rs.getString("bank_mfo")%><br>
                            _________________________________________________<br>
                            <strong>_____________________________________</strong><br>
                            Код ЄДРПОУ    <%= rs.getString("bank_identification_number")%><br>
                            Свідоцтво платника ПДВ № _____________________<br>
                            Індивідуальний податковий №    ___________________<br>
                                    <strong><u><%if ((!rs.getString("customer_soc_status_1").equals("15")
                                        && !rs.getString("customer_soc_status_1").equals("11")) && (rs.getString("customer_type").equals("1"))) {%> в особі <strong><%= rs.getString("customer_post")%><%}%></u></strong></p></td>
                </tr>
                <tr>
                    <td><strong>_____________Сеник Олег Степанович </strong></td>
                    <td><strong>____________________    <%= rs.getString("PIP")%></strong></td>
                </tr>
            </table>
            <%}%>
        </div>
        <br clear=all style="page-break-before:always">
        <%--стандартне приєднання--%>
        <%if (rs.getString("join2").equals("1")) {%>
        <div class="Section1">
            <p align="right" class="style1">ОП 4.1-Ґ</p>
            <p align="center">
                 &nbsp;<span class="style1">ФІЛІЯ ПАТ «ПРИКАРПАТТЯОБЛЕНЕРГО»<br>
                    “<%=rs.getString("rem_name").toUpperCase()%> РАЙОН ЕЛЕКТРИЧНИХ МЕРЕЖ”</span></p>

            <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" style="font-size: 11pt">
                <tr>
                    <td width="50%" valign="top">76014, м.Івано-Франківськ,<br/> вул.Індустріальна, 34<br>тел./факс.    2-39-38
                        <p>На № <%=rs.getString("no_zvern")%> від <%=rs.getString("registration_date")%> р. </p>
                        <p>Обов’язковий    додаток до проекту.</p></td>
                                <td valign="top"><p align="right"><strong><%if (!rs.getString("customer_soc_status_1").equals("9")
                                && !rs.getString("customer_soc_status_1").equals("12")) {%> <%= rs.getString("customer_soc_status")%><%}%><br> 
                                <%= rs.getString("name")%><br>
                                <span class="style1"><%= rs.getString("type_o")%><%= rs.getString("customer_adress").replace("вул.", "<br>вул.")%> </span></strong></p></td>
                </tr>
            </table>
            <p align="center"><span class="style1"><strong>ТЕХНІЧНІ УМОВИ СТАНДАРТНОГО ПРИЄДНАННЯ № <%= rs.getString("number")%></strong><br>
                    <strong>до електричних мереж електроустановок</strong><br></span></p>
            <div align="right">Додаток № 2 до додаткового правочину <strong><br>
                    № П-<%= rs.getString("No_letter")%> від __.__.____ року про внесення змін до </strong><br>
                договору про <%=rs.getString("type_join")%><br>
                до електричних мереж  від<br>
                <%= rs.getString("date_contract")%> року<br>
                № <%= rs.getString("number")%></div>
            <p>Дата видачі <%= rs.getString("initial_registration_date_rem_tu")%> року № <%=rs.getString("registration_no_contract")%> <br>

                Назва об'єкту та повне найменування замовника: <%--<span style="text-align: center"><strong><%= rs.getString("reason_tc")%>--%><span style="text-align: center"><strong><%= rs.getString("object_name")%>, <%= rs.getString("customer_soc_status")%> <%= rs.getString("name")%>.</strong></span><br>
                1. Місцезнаходження об’єкта Замовника: <span style="text-align: center"><strong> <%= rs.getString("type_o")%> <%= rs.getString("object_adress")%>.</strong></span><br>
                Функціональне призначення об'єкта: <strong><%= rs.getString("functional_target")%></strong><br>
                Прогнозований рік уведення  об’єкта в експлуатацію:  <strong><%= rs.getString("date_intro_eksp").replaceAll("1900", "_____")%></strong><br>
                2. Величина максимального розрахункового навантаження  <strong><%= rs.getString("request_power").replace(".", ",")%> кВт</strong>, у тому числі для:<br> 
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
                <p align="center"><strong> 7. Вимоги до електроустановок замовника</strong></p>
                <div align="justify" style="text-align:justify"><dt>7.1. Для одержання потужності замовнику необхідно виконати:</dt>
                    <dt>7.1.1. Вимоги до технічного узгодження електроустановок Замовника та  електропередавальної організації: _______________________________________________________________.</dt>
                    <dt>7.1.2. Вимоги до ізоляції, пристроїв захисного відключення, засобів стабілізації, захисту від перенапруги: Виконати монтаж контуру захисного заземлення, заземлити та занулити  ввідний пристрій 0,4(23) кВ з опором заземлення не більше 4,0 Ом;</dt> 
                    <dt>7.1.3 Для підключення електроустановки Замовнику необхідно представити: </dt>
                </dt><dt>- копію наказу про призначення особи, відповідальної за електрогосподарство з числа ІТП, та копію протоколу комісії з перевірки знань ПТЕ і ПТБ при експлуатації електроустановок особи, відповідальної за електрогосподарство, або копію договору про технічне обслуговування електроустановки замовника, укладеного між замовником і спеціалізованою експлуатаційною організацією, яка має відповідний електротехнічний персонал та право на обслуговування електроустановок інших споживачів (п. 4.10 ПТЕЕС) (крім електроустановок населення); </dt>
            <dt>- список осіб оперативного та оперативно-ремонтного персоналу, яким дозволяється від імені споживача давати заявки на відключення та підключення електроустановок, вести оперативні переговори та записи (крім електроустановок населення); </dt>
            <dt>- протоколи вимірювання опору заземлення (п. 1.8.36 ПУЕ); </dt>
            <dt>- протоколи перевірки засобів захисту від ураження електричним струмом (п. 4.10 ПТЕЕС) (крім електроустановок населення); </dt>
            <dt>- документ, що підтверджує право власності на об’єкт;</dt>
            <dt>- дозвіл на виконання будівельних робіт або декларацію про початок виконання будівельних робіт, або повідомлення про початок виконання будівельних робіт (для будівельних струмоприймачів).</dt>
            <dt>7.1.4. Вимоги до електропостачання приладів та пристроїв, які використовуються для будівництва та реконструкції об’єктів електромереж: </dt> 
            <dt>- <%=rs.getString("do10")%></dt>
    </dl>
</div>
<%} else if (rs.getString("join2").equals("2")) {%>
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
    <div align="right">Додаток № 2 до додаткового правочину <strong><br>
            № П-<%= rs.getString("No_letter")%> від __.__.____ року про внесення змін до </strong><br>
        договору про <%=rs.getString("type_join")%><br>
        до електричних мереж  від<br>
        <%= rs.getString("date_contract")%> року<br>
        № <%= rs.getString("number")%></div>
    <div align="justify" style="text-align:justify">
        <dl>
            <dt>Дата видачі <%= rs.getString("initial_registration_date_rem_tu")%> року № <%=rs.getString("registration_no_contract")%> </dt>
            <dt>Назва об'єкту: <strong><%= rs.getString("object_name")%></strong>.</dt>
            <dt>1. Місцезнаходження об’єкта Замовника: <strong><%=rs.getString("type_o")%> <%= rs.getString("object_adress")%>.</strong></dt>
            <dt>Функціональне призначення об'єкта: <strong><%= rs.getString("functional_target")%>.</strong></dt>
            <dt>Прогнозований рік уведення  об’єкта в експлуатацію:  <strong><%= rs.getString("date_intro_eksp").replaceAll("1900", "_____")%>.</strong></dt>       
            <%if (!rs.getString("power_old").equals("0")) {%><%=k++%>. <%=rs.getString("power_old")%>Існуюча дозволена потужність згідно з договором про постачання/користування електричною енергією <strong>№ <%=rs.getString("nom_data_dog")%></strong> року <strong><%=nf.format(rs.getFloat(("power_old")))%></strong> кВт, у тому числі:</dt>
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
            <%if (!rs.getString("power_for_electric_devices").equals("0") || !rs.getString("power_plit").equals("0") || !rs.getString("power_boil").equals("0")) {%>Встановлена потужність електронагрівальних установок:
            <table width="180" border="0" cellpadding="0" cellspacing="0">
                <%if (!rs.getString("power_for_electric_devices").equals("0")) {%><tr><td width="110">електроопалення</td><td width="70"><strong><%=nf.format(rs.getFloat(("power_for_electric_devices")))%></strong> кВт</td></tr><%}%>
                <%if (!rs.getString("power_plit").equals("0")) {%><tr><td>електроплити</td><td><strong><%=nf.format(rs.getFloat(("power_plit")))%></strong>  кВт</td></tr><%}%>
                <%if (!rs.getString("power_boil").equals("0")) {%><tr><td>гаряче водопостачання</td><td><strong><%=nf.format(rs.getFloat(("power_boil")))%></strong> кВт</td></tr><%}%>
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
            <dt>1.1. Вимоги до електричних мереж основного живлення: <strong><%= rs.getString("do2").replace("7.2", "<dt>1.1")%></strong></dt>
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
        </dl>
    </div>
    <%} else {%>
    <div class="Section1">
        <p align="right"><SPAN lang="UK">7.51-ПР-1-ТД-1.4.Д</SPAN></p>
        <p align="center">ПАТ «ПРИКАРПАТТЯОБЛЕНЕРГО»</p>

        <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td width="50%" valign="top">76014, м. Івано-Франківськ, вул.Індустріальна,34<br>тел./факс.    2-39-38
                    <p>На № <%=rs.getString("no_zvern")%> від <%=rs.getString("registration_date")%> р. </p>
                    <p>Обов’язковий    додаток до проекту.</p></td>
                <td valign="top"><p align="right"><strong><%= rs.getString("customer_soc_status")%><br>
                            <%= rs.getString("name")%><br> 
                            Директору філії<br>
                            ПАТ «Прикарпаттяобленерго»<br>
                            <%=rs.getString("rem_name")%> РЕМ<br>
                            п. <%= rs.getString("director_dav")%></strong></p></td>
            </tr>
        </table>
        <p align="center"><strong>ТЕХНІЧНІ УМОВИ № <%= rs.getString("number")%></strong>
            <%if (rs.getString("type_contract").equals("1")) {%>
        </p>
        <div align="right">Додаток № 2 до додаткового правочину <strong><br>
                № П-<%= rs.getString("No_letter")%> від __.__.____ року про внесення змін до </strong><br>
            договору про <%=rs.getString("type_join")%><br>
            до електричних мереж  від<br>
            <%= rs.getString("date_contract")%> року<br>
            № <%= rs.getString("number")%></div>
        <p>Дата видачі: <%= rs.getString("date_customer_contract_tc")%> року<br>
        <table>
            <tr>
                <td width="149" style="text-align:left">Назва об'єкта:</td>
                <td width="1129" style="text-align:center"><strong><u><%= rs.getString("object_name")%></u></strong>.</td></tr></table>
        <dl>
            <dt>1 Місцезнаходження об’єкта замовника: <strong><%= rs.getString("type_o")%> <%= rs.getString("object_adress")%></strong></dt>
            <dt>2 Величина розрахункового максимального навантаження: <strong><%= rs.getString("request_power")%> кВт</strong>,</dt>
            <dt>у тому числі: <%if (rs.getInt("kilk") > 1) {
                        do {%> <%=rs.getString("type_source")%>-<%=rs.getString("ps10_name")%>:<%=rs.getString("power")%> кВт.<%} while (rs.next());
                                rs.first();
                            }
                            if (!rs.getString("power_old").equals("0")) {%>
                існуюча потужність <%=rs.getString("power_old")%> кВт, договір №<%=rs.getString("nom_data_dog")%><%}%></dt></dl>

        <table border="0" cellspacing="0" cellpadding="0" width="651" align="center">
            <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%>
            <tr>
                <td width="310" valign="top">
                    I категорія<br>
                    у тому числі для: </td>
                <td width="341" valign="top"><p><%= rs.getString("reliabylity_class_1_val")%> кВт,</p></td>
            </tr><%}%>
            <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
            <tr>
                <td width="310" valign="top"><p>електронагрівальних установок</p></td>
                <td width="341" valign="top"><p><%= rs.getString("power_for_electric_devices")%> кВт (у разі необхідності),</p></td>
            </tr><%}%>
            <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
            <tr>
                <td width="310" valign="top"><p>екологічної броні</p></td>
                <td width="341" valign="top"><p><%= rs.getString("power_for_electric_devices")%> кВт,</p></td>
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
            <%if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE")) {%>
            <tr>
                <td width="310" valign="top"><p>II категорія<br>
                        у тому числі для:</p></td>
                <td width="341" valign="top"><p><%= rs.getString("reliabylity_class_2_val")%> кВт,</p></td>
            </tr><%}%>
            <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
            <tr>
                <td width="310" valign="top"><p>електронагрівальних установок</p></td>
                <td width="341" valign="top"><p><%= rs.getString("power_for_electric_devices")%> кВт (у разі необхідності),</p></td>
            </tr><%}%>
            <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
            <tr>
                <td width="310" valign="top"><p>екологічної броні</p></td>
                <td width="341" valign="top"><p><%= rs.getString("power_for_electric_devices")%> кВт,</p></td>
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
            <%if (rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%>
            <tr>
                <td width="310" valign="top"><p>III категорія<br>
                        у тому числі для:</p></td>
                <td width="341" valign="top"><p><%= rs.getString("reliabylity_class_3_val")%> кВт,</p></td>
            </tr><%}%>
            <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
            <tr>
                <td width="310" valign="top"><p>електронагрівальних установок</p></td>
                <td width="341" valign="top"><p><%= rs.getString("power_for_electric_devices")%> кВт (у разі необхідності).</p></td>
            </tr><%}%>
        </table>
        <dl style="text-align:justify">
            <dt>3 Джерело електропостачання <strong>
                    <%do {
                            if ((!rs.getString("ps35110_name").equals(tmp)) || (i == 1)) {%>
                    ПС "<%=rs.getString("ps35110_name")%> кВ"<%i++;
                            }
                            tmp = rs.getString("ps35110_name");
                        } while (rs.next());
                        rs.first();%></strong>,
                    <%i = 1;
                        do {
                            //if ((!rs.getString("ps35110_name").equa      ls(tmp    )) || (i==1)) {
%><strong><%=rs.getString("type_source")%>-<%=rs.getString("ps10_name")%> <%if (rs.getInt("ps10_nom_nav") != 0 || rs.getInt("ps10_nom_nav_2") != 0) {
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
                        rs.first();%>
                    .</strong></dt>
            <dt>4 Точка підключення:
                <%do {%><strong> <%=rs.getString("selecting_point")%></strong><%} while (rs.next());
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
            </dt><dt><strong><%=rs.getString("do2").replaceAll("7.1.", "</dt><dt>7.2.")%></strong></dt><%} else {%>відсутні</dt><%}%>
            <dt>7.3 Вимоги до електромереж резервного живлення, в тому числі виділення відповідного електрообладнання на окремі резервні лінії
                живлення для збереження електропостачання цього електрообладнання у разі виникнення дефіциту потужності
                в об’єднаній енергосистемі: <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%>
                для споживачів першої категорії електропостачання передбачити автономне джерело живлення необхідної потужності. 
                Тип автономного джерела живлення визначити проектом. <% if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE") || rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%> <%=rs.getString("do4")%><%}%>
                <%} else {%><%=rs.getString("do4")%><%}%></dt>
            <dt>7.4 Вимоги до розрахункового обліку електричної енергії: <strong><%=rs.getString("do3").replaceAll("7.2.", "</dt><dt>7.4.")%></strong> </dt>
            <dt> - У випадку встановлення багатотарифного приладу обліку та неможливості застосування приладу обліку з функцією обмеження максимального споживання потужності, встановити ПЗР. Номінальний струм ПЗР визначити проектом.</dt>
            <dt>7.5 Вимоги до компенсації реактивної потужності <u>відсутні</u>.</dt>
            <dt>7.6 Вимоги до автоматичного частотного  розвантаження (АЧР), системної протиаварійної автоматики (СПА):  <u>відсутні</u></dt>
            <dt>7.7 Вимоги до релейного захисту й  автоматики, захисту від коротких замикань та перевантажень, компенсації струмів  однофазного замикання в мережах з ізольованою шиною нейтралі тощо: <%=rs.getString("do6")%></dt>
            <dt>7.8 Вимоги до телемеханіки та зв’язку: <%if (rs.getString("do7").equals("")) {%> <%=rs.getString("do7")%><%} else {%>відсутні<%}%>.</dt>
            <dt>7.9 Вимоги до ізоляції, захисту від  перенапруги: <u>відсутні</u>.</dt>
            <dt>7.10 Специфічні вимоги щодо живлення  електроустановок замовника, які стосуються резервного живлення, допустимості  паралельної роботи елементів електричної мережі: 
                <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%> <strong>
                    встановити блокуючий пристрій для неможливості подачі генерованої напруги в мережі ПАТ «Прикарпаттяобленерго». Встановити АВР 
                    на напрузі 0,4 кВ (централізовано на вводах в споруду чи децентралізовано у електроприймачів І категорії по надійності 
                    електропостачання). <% if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE") || rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%> <%=rs.getString("do8")%><%}%></strong><%} else {%><%=rs.getString("do8")%><%}%> </dt></dl>
        <dl>
            <dt>8 Додаткові вимоги та умови:</dt>
            <dt>8.1 До початку будівництва винести із зони забудови існуючі ЛЕП. Параметри ліній, що підлягають під винос, отримати в філії “<%=rs.getString("rem_name")%> РЕМ”.</dt>
            <dt>8.2 До початку будівництва проект  погодити з філією “<%=rs.getString("rem_name")%> РЕМ”. На стадії проектування траси  ЛЕП погодити із землевласниками (землекористувачами), усіма зацікавленими  організаціями та філією “<%=rs.getString("rem_name")%> РЕМ”.</dt></dl>
            <%} else {%>
        <br> на приєднання будівельних струмоприймачів <br>
        <br>
        </p>
        <div align="right">
            <p>Додаток № 2 до додаткового правочину <strong><br>
                    № П-<%= rs.getString("No_letter")%> від ______року про внесення змін </strong><br>до договору про <%=rs.getString("type_join")%> будівельних струмоприймачів<br>
                до електричних мереж  від<br>
                <%= rs.getString("date_contract")%> року<br>
                № <%= rs.getString("number")%></p></div>
        <p>Дата видачі <%= rs.getString("date_customer_contract_tc")%>року № <%= rs.getString("registration_no_contract")%></p>
        <table style="font-size: 11pt"> 
            <tr><td width="149">Назва об'єкта:</td>
                <td width="1084" style="text-align:center"><strong><u><%= rs.getString("object_name")%></u></strong>.</td>
            </tr>
        </table>
        <dl>
            <dt>1 Місцезнаходження об’єкта замовника: <strong><%= rs.getString("type_o")%> <%= rs.getString("object_adress")%></strong>.</dt>
            <dt>2 Величина розрахункового максимального навантаження: <strong><%= rs.getString("request_power")%> кВт</strong>,</dt>
            <dt>у тому числі: <%if (rs.getInt("kilk") > 1) {
                        do {%> <%=rs.getString("type_source")%>-<%=rs.getString("ps10_name")%>:<%=rs.getString("power")%> кВт.<%} while (rs.next());
                                rs.first();
                            }
                            if (!rs.getString("power_old").equals("0")) {%>
                існуюча потужність <%=rs.getString("power_old")%> кВт, договір №<%=rs.getString("nom_data_dog")%><%}%></dt>
        </dl>

        <div align="center">
            <table border="0" cellspacing="0" cellpadding="0" width="651" style="font-size: 11pt">
                <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%>
                <tr>
                    <td width="310" valign="top">
                        I категорія<br>
                        у тому числі для: </td>
                    <td width="341" valign="top"><p><%= rs.getString("reliabylity_class_1_val")%> кВт,</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>електронагрівальних установок</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_electric_devices")%> кВт (у разі необхідності),</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>екологічної броні</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_electric_devices")%> кВт,</p></td>
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
                <%if (!rs.getString("power_old").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>існуюча потужність</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_old")%> кВт;</p></td>
                </tr><%}%>
                <%if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE")) {%>
                <tr>
                    <td width="310" valign="top"><p>II категорія<br>
                            у тому числі для:</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("reliabylity_class_2_val")%> кВт,</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>електронагрівальних установок</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_electric_devices")%> кВт (у разі необхідності),</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>екологічної броні</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_electric_devices")%> кВт,</p></td>
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
                <%if (!rs.getString("power_old").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>існуюча потужність</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_old")%> кВт;</p></td>
                </tr><%}%>
                <%if (rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%>
                <tr>
                    <td width="310" valign="top"><p>III категорія<br>
                            у тому числі для:</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("reliabylity_class_3_val")%> кВт,</p></td>
                </tr><%}%>
                <%if (!rs.getString("power_for_electric_devices").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>електронагрівальних установок</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_for_electric_devices")%> кВт (у разі необхідності).</p></td>
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
                <%if (!rs.getString("power_old").equals("0")) {%>
                <tr>
                    <td width="310" valign="top"><p>існуюча потужність</p></td>
                    <td width="341" valign="top"><p><%= rs.getString("power_old")%> кВт;</p></td>
                </tr><%}%>
            </table></div>
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
            <dt>4 Точка підключення:
                <%do {%><strong> <%=rs.getString("selecting_point")%></strong><%} while (rs.next());
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
            </dt><strong><dt><%=rs.getString("do2").replaceAll("7.1.", "</dt><dt>7.2.")%></dt></strong><%} else {%>відсутні</dt><%}%>
            <dt>7.3 Вимоги до електромереж резервного  живлення, в тому числі виділення відповідного електрообладнання на окремі  резервні лінії
                живлення для збереження електропостачання цього  електрообладнання у разі виникнення дефіциту потужності
                в об’єднаній  енергосистемі: <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%>
                для споживачів першої категорії електропостачання передбачити автономне джерело живлення необхідної потужності. 
                Тип автономного джерела живлення визначити проектом. <% if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE") || rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%> <%=rs.getString("do4")%><%}%>
                <%} else {%><%=rs.getString("do4")%><%}%></dt>
            <dt>7.4 Вимоги до розрахункового обліку  електричної енергії: <strong><%=rs.getString("do3").replaceAll("7.2.", "</strong></dt><dt><strong>7.4.")%></strong></dt>
            <dt> - У випадку встановлення багатотарифного приладу обліку та неможливості застосування приладу обліку з функцією обмеження максимального споживання потужності, встановити ПЗР. Номінальний струм ПЗР визначити проектом.</dt>
            <dt>7.5 Вимоги до компенсації реактивної  потужності: відсутні.</dt>
            <dt>7.6 Вимоги до автоматичного частотного  розвантаження (АЧР), системної протиаварійної автоматики (СПА): відсутні</dt>
            <dt>7.7 Вимоги до релейного захисту й  автоматики, захисту від коротких замикань та перевантажень, компенсації струмів  однофазного замикання в мережах з ізольованою шиною нейтралі тощо: <%=rs.getString("do6")%></dt>
            <dt>7.8 Вимоги до телемеханіки та зв’язку:  <%=rs.getString("do7")%>.</dt>
            <dt>7.9 Вимоги до ізоляції, захисту від  перенапруги: відсутні.</dt>
            <dt>7.10 Специфічні вимоги щодо живлення  електроустановок замовника, які стосуються резервного живлення, допустимості  паралельної роботи елементів електричної мережі: 
                <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%><strong>
                    встановити блокуючий пристрій для неможливості подачі генерованої напруги в мережі ПАТ «Прикарпаттяобленерго». Встановити АВР 
                    на напрузі 0,4 кВ (централізовано на вводах в споруду чи децентралізовано у електроприймачів І категорії по надійності 
                    електропостачання). <%if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE") || rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%> <%=rs.getString("do8")%><%}%></strong><%} else {%><%=rs.getString("do8")%><%}%></dt>
        </dl>
        <dl style="text-align:justify">
            <%if (!rs.getString("performance_data_tc_no").equals("")) {%> <dt>8 Виконання технічних умов можливе спільно з технічними умовами №<%=rs.getString("performance_data_tc_no")%> </dt><%} else {%>
            8 Додаткові вимоги та умови <%}%>
            <dt style="text-align: justify">8.1 До початку будівництва винести із зони забудови існуючі  ЛЕП. Параметри ліній, що підлягають під винос, отримати в філії  “<%=rs.getString("rem_name")%> РЕМ”. </dt>
            <dt style="text-align: justify">8.2 До початку будівництва проект  погодити з філією “<%=rs.getString("rem_name")%> РЕМ”. На стадії проектування траси  ЛЕП погодити із землевласниками (землекористувачами), усіма зацікавленими  організаціями та філією “<%=rs.getString("rem_name")%> РЕМ”. </dt></dl>
            <%}%> 
            </div><%}%>
            <%if (!rs.getString("join2").equals("1")) {%>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="391" valign="top" class="style2"><p><strong>Власник</strong></p></td>
                <td width="240" valign="top" class="style2"><p>замовник</p></td>
            </tr>
            <tr>
                <td width="391" valign="top" class="style2"><p><strong>&nbsp;</strong></p>
                    <p>М. П.</p>
                    <p>Технічний    директор <br>
                        <u>Сеник Олег Степанович</u></p>
                    <p>____________<br>
                        Підпис</p></td>
                <td width="240" valign="top" class="style2"><p><strong>&nbsp;</strong></p>
                    <p>М. П.</p>
                    <p><u><%= rs.getString("customer_soc_status")%></u><br>
                        <u><%= rs.getString("name")%></u></p>
                    <p>____________<br>
                        Підпис</p></td>
            </tr>
        </table><%} else {%>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="391" valign="top"><p class="style1"><strong>Власник</strong></p></td>
                <td width="240" valign="top"><p class="style1">замовник</p></td>
            </tr>
            <tr>
                <td width="391" valign="top"><p class="style1">М. П.</p>
                    <p class="style1">Головний інженер філії ПАТ «Прикарпаттяобленерго»</p>
                    <p class="style1">"<%= rs.getString("rem_name")%>" РЕМ</p>
                    <p class="style1"><%= rs.getString("golovnyi_ingener")%></p>
                    <p class="style1">____________<br>
                        підпис</p></td>
                <td width="240" valign="top"><p class="style1">М. П.</p>
                    <p class="style1">Громадянин (ка)</p>
                    <p class="style1"><%= rs.getString("PIP")%> <br>
                        <br>
                        ____________<br>
                        Підпис</p></td>
            </tr>
        </table><%}%>
        <p class="style2">Прізвище  виконавця:<br>
            телефон</p>
    
    
    <br clear=all style="page-break-before:always">
    <%if (!rs.getString("join2").equals("2") && !rs.getString("join2").equals("1")) {%>
    <div class="Section1"><font size="-1">
        </font><div align="justify">
            <p align="right"><font size="-1"><SPAN lang="UK">7.5.1-ПР-1-ТД-1.4   Г</SPAN></font></p>
            <p align="center"><font size="-1"><strong>Додаток № 1 до додаткового правочину № П-<%= rs.getString("No_letter")%> від __.__.____року про внесення<br> змін до
                        договору № <%= rs.getString("number")%> від <%= rs.getString("date_customer_contract_tc")%></strong><br />
                        <%if (rs.getString("type_contract").equals("1")) {%>
                    <strong>про <%=rs.getString("type_join")%> до електричних мереж</strong></font></p>
            <table width="100%"><tr><td width="50%"><font size="-1">м. Івано-Франківськ </font></td>
                    <td align="right"><font size="-1"><strong><%=rs.getString("date_contract")%></strong> р.</font></td></tr></table>

            <div style="text-align:justify; text-indent:20pt"><font size="-1"><strong>Публічне акціонерне товариство «Прикарпаттяобленерго»</strong>,&nbsp;надалі ―
                    <strong>Електропередавальна організація (далі – ЕО)</strong>,&nbsp;що здійснює ліцензовану діяльність з передачі електроенергії, в особі технічного директора  ПАТ «Прикарпаттяобленерго»&nbsp;
                    <strong>Сеника Олега Степановича</strong>,&nbsp;який діє на підставі довіреності № 927 від 25.08.2015
                    &nbsp;року, з однієї сторони, та&nbsp;<strong><%= rs.getString("customer_soc_status")%> <%= rs.getString("name")%></strong>, надалі ―
                    замовник, <%if (!rs.getString("customer_soc_status_1").equals("15")
                                && !rs.getString("customer_soc_status_1").equals("11")) {%> в особі <strong><%= rs.getString("customer_post")%>&nbsp;<%= rs.getString("PIP")%></strong>,<%}%> який діє на підставі <strong><u><%= rs.getString("constitutive_documents")%></u></strong>
                    , з іншої сторони, далі ― Сторони, уклали цей Договір про <%=rs.getString("type_join")%> електроустановок Замовника до електричних мереж ЕО (надалі ― Договір).</font></div>
            <div style="text-align: justify; text-indent:20pt"><font size="-1">При виконанні умов  цього Договору, а також вирішенні всіх питань, що не обумовлені цим Договором,  сторони зобов'язуються керуватися Законом України “Про електроенергетику”,  Законом України &quot;Про архітектурну діяльність&quot;, Законом України “Про  регулювання містобудівної діяльності” та іншими нормативно-правовими актами. Підписавши цей Договір, Сторони підтверджують, що  відповідно до законодавства та установчих документів, мають право укладати цей  Договір, його укладання відповідає справжнім намірам сторін, які ґрунтуються на  правильному розумінні предмету та всіх інших умов договору, наслідків його  виконання та свідомо бажають настання цих наслідків.</font></div>
            <p align="center"><font size="-1"><strong>1 Предмет Договору</strong></font></p>
            <dl style="text-align:justify">
                <dt><font size="-1">1.1 ЕО здійснює <%=rs.getString("type_join")%> електроустановок (<strong><u><%= rs.getString("object_name")%>,&nbsp; <%=rs.getString("type_o")%> <%= rs.getString("object_adress")%></u></strong>) Замовника до своїх електричних мереж після виконання Замовником технічних умов, укладення Замовником договору про постачання електричної енергії та інших договорів передбачених Правилами користування електричною енергією.1.2 Прогнозована межа балансової належності електромереж встановлюється: <strong><u><%= rs.getString("connection_treaty_number")%></u></strong></font></dt>
                <dt><font size="-1">1.3 Клас напруги в точці підключення буде становити клас <%=rs.getString("joint_point")%>.</font></dt>
            </dl>
            <p align="center"><font size="-1"><strong>2 Обов'язки сторін</strong></font></p>
            <dl style="text-align:justify"><font size="-1">
                    <dt>2.1 ЕО зобов'язаний підключити електроустановки Замовника до своїх електромереж в термін до 5 днів після виконання Замовником вимог пункту 2.2 цього Договору в повному обсязі, прийняття електроустановки Замовника в експлуатацію, оформлення акту допуску на підключення електроустановки Замовника.
                    <dt>2.2 Замовник зобов'язаний:</dt> 
                    <dt>2.2.1	Виконати вимоги технічних умов № <strong><%= rs.getString("number")%></strong> від <strong><%= rs.getString("date_customer_contract_tc")%></strong> року в повному обсязі до завершення терміну дії даного Договору (Додаток № 1).</dt>
                    <dt>2.2.2	До підключення електроустановки Замовника до електричної мережі ЕО оплатити вартість допуску та підключення згідно виставленого рахунку та укласти договори, передбачені Правилами користування електричною енергією.</dt>
                    <dt>2.2.3	У випадку прокладання ЛЕП-0,4 кВ Замовника по опорах ЕО укласти з останнім відповідний договір про спільне підвішування проводів. </dt></font>
            </dl>
            <p align="center"><font size="-1"><strong>3 Відповідальність сторін</strong></font></p>
            <dl style="text-align:justify">
                <dt><font size="-1">3.1 ЕО несе відповідальність за зміст та обґрунтованість виданих технічних умов. 3.2 Замовник несе відповідальність за достовірність наданих ЕО документів, належне виконання вимог технічних умов, розроблення проектної документації, своєчасне її узгодження з ЕО та іншими зацікавленими особами.</font></dt>
                <dt><font size="-1">3.3 Сторони не відповідають за невиконання умов цього Договору, якщо це спричинено дією обставин непереборної сили. Факт дії обставин непереборної сили підтверджується відповідними документами. </font></dt>
            </dl>
            <p align="center"><font size="-1"><strong>4 Порядок вирішення спорів</strong></font></p>
            <dl style="text-align:justify">
                <dt><font size="-1">4.1  Усі спірні питання, пов'язані з виконанням цього Договору, вирішуються шляхом переговорів між сторонами.</font></dt>
                <dt><font size="-1">4.2 У разі недосягнення згоди спір вирішується в судовому порядку відповідно до законодавства України. Спори, що виникають при укладенні, зміні та (або) розірванні Договору, справи у спорах про визнання договору недійсним або пов’язаних з виконанням даного договору, розглядаються в судах за місцем знаходження ЕО. </font></dt>
            </dl>
            <p align="center"><font size="-1"><strong>5 Строк дії Договору</strong></font></p>
            <dl style="text-align:justify"><font size="-1">
                    <dt>5.1 Цей Договір набирає чинності з моменту його підписання і діє протягом двох років з дати підписання.
                    <dt>5.2 Сторони мають право достроково виконати покладені на них зобов’язання по Договору. У разі дострокового виконання зобов’язань сторін згідно умов Договору може мати місце дострокове припинення Договору за згодою сторін або на підставах, передбачених чинним в Україні законодавством.</dt>
                    <dt>5.3 Договір може бути змінено або розірвано в односторонньому порядку на вимогу ЕО у разі порушення Замовником вимог п. 2.2 даного Договору, про що Замовника повідомляється окремим письмовим повідомленням. Дане повідомлення вважається невід’ємною частиною Договору. Замовник має право на протязі 20 днів з дня отримання повідомлення виконати зобов’язання по договору та повідомити про це ЕО.</dt>
                    <dt>5.4 У разі розірвання Договору згідно п. 5.3, а також в інших випадках дострокового розірвання договору, оплачені Замовником кошти за видачу технічних умов та погодження проектної документації, ЕО не повертаються.</dt>
                    <dt>5.5 Термін дії Договору може бути продовжений за згодою сторін.</dt></font>
            </dl>
            <p align="center"><font size="-1"><strong>6 Інші умови Договору</strong></font></p>
            <font size="-1"><dl style="text-align:justify">
                    <dt>6.1 Після одержання проекту Договору Замовник у 20-ти денний термін повертає підписаний примірник Договору. У разі наявності заперечень до умов Договору у цей же термін надсилає протокол розбіжностей чи повідомляє ЕО про відмову від укладення Договору.</dt>
                    <dt>6.2 У разі недотримання  порядку зазначеному в п. 6.1 цього Договору, Договір вважається неукладеним  (таким, що не відбувся).</dt>
                    <dt>6.3 Додатки до цього Договору є невід’ємними частинами цього Договору. Усі зміни та доповнення Договору оформляються письмово, підписуються уповноваженими особами та скріплюються печатками з обох сторін.</dt>
                    <dt>6.4 Цей Договір укладений у двох примірниках, які мають однакову юридичну силу для Замовника та ЕО.</dt>
                    <dt>6.5 У разі, якщо на час дії даного Договору відбулися зміни в чинному законодавстві України, ЕО в односторонньому порядку вносяться зміни, які доводяться до Замовника окремим письмовим повідомленням. Дане повідомлення вважається невід’ємною частиною Договору.</dt>
                    <dt>6.6  Замовник має, немає (необхідне підкреслити) статус платника податку на прибуток підприємств на загальних умовах.</dt>
                    <dt>6.7 ЕО має статус платника податку на прибуток підприємств на загальних умовах.</dt>
                </dl></font>
                <%} else {%>
            <strong>про <%=rs.getString("type_join")%> до  електричних мереж будівельних електромеханізмів</strong></p>
            <table width="100%"><tr><td width="50%">м. Івано-Франківськ</td><td align="right"><strong><%=rs.getString("date_contract")%></strong>р.</td>
                </tr></table>

            <div style="text-align:justify; text-indent:20pt"><font size="-1"><strong>Публічне акціонерне товариство  «Прикарпаттяобленерго»</strong>, надалі ― <strong>
                        Електропередавальна організація (далі – ЕО)</strong>, що здійснює  ліцензовану діяльність з передачі електроенергії, в особі технічного
                    директора  ПАТ «Прикарпаттяобленерго» <strong>Сеника Олега Степановича</strong>, який діє на підставі довіреності № <strong>816</strong>
                    &nbsp;від&nbsp;<strong>11.08.2014</strong> року, з однієї сторони, та <strong><%if (!rs.getString("customer_soc_status_1").equals("9")
                                && !rs.getString("customer_soc_status_1").equals("12")) {%> <%= rs.getString("customer_soc_status")%><%}%>
                        <%= rs.getString("name")%></strong> надалі ― замовник,
                        <%if ((!rs.getString("customer_soc_status_1").equals("15")
                                && !rs.getString("customer_soc_status_1").equals("11")) && (rs.getString("customer_type").equals("1"))) {%> в особі  <strong><%= rs.getString("customer_post")%>&nbsp;<%= rs.getString("PIP")%></strong>,<%}
                                    if (rs.getString("customer_type").equals("1")) {%> який (яка) діє на підставі<%}%> <strong><u><%= rs.getString("constitutive_documents")%></u></strong>, з іншої сторони,
                    далі ― Сторони, уклали цей  Договір на доступ електроустановок Замовника до електричних мереж ЕО (надалі ―  Договір).</font></div>
            <div style="text-align:justify; text-indent:20pt"><font size="-1">При виконанні умов цього  Договору, а також вирішенні всіх питань, що не обумовлені цим Договором, сторони зобов'язуються
                    керуватися Законом України “Про електроенергетику”,  Законом України &quot;Про архітектурну діяльність&quot;, Законом України “Про  регулювання
                    містобудівної діяльності” та іншими нормативно-правовими актами.</font></div>
            <div style="text-align:justify; text-indent:20pt"><font size="-1">Підписавши  цей Договір, Сторони підтверджують, що відповідно до законодавства та  установчих документів, мають право
                    укладати цей Договір, його укладання  відповідає справжнім намірам сторін, які ґрунтуються на правильному розумінні  предмету та всіх інших умов
                    договору, наслідків його виконання та свідомо  бажають настання цих наслідків.</font></div>
            <p align="center"><font size="-1"><strong>1 Предмет Договору</strong></font></p>
            <dl style="text-align:justify"><font size="-1">
                    <dt>1.1 ЕО  здійснює тимчасове надання послуги з доступу  електроустановок (<strong><u><%= rs.getString("object_name")%>,&nbsp;
                                <%=rs.getString("type_o")%> <%= rs.getString("object_adress")%></u></strong>) Замовника до  своїх електричних мереж після виконання Замовником
                        технічних умов, своїх  зобов’язань по даному договору, укладення Замовником договору про постачання  електричної енергії та інших договорів
                        передбачених Правилами користування  електричною енергією.</dt>
                    <dt>1.2 З метою  тимчасового електрозабезпечення будівельних електромеханізмів та потреб  Замовника на об’єкті, між Замовником та ЕО
                        укладається договір про електрозабезпечення  будівельних електромеханізмів у встановленому законодавством України  порядку і діє до завершення
                        терміну дії договору про <%=rs.getString("type_join")%> <strong>№ <%= rs.getString("TC_Onumber")%> </strong>від<strong> <%= rs.getString("TC_Odate_contract")%>
                        </strong> року, Договір про електрозабезпечення  будівельних електромеханізмів укладається після виконання Замовником  умов даного Договору.</dt>
                    <dt>1.3 Прогнозована  межа балансової належності електромереж встановлюється: <strong><u><%= rs.getString("connection_treaty_number")%></u></strong>.</dt>
                    <dt>1.4 Клас напруги в точці підключення буде становити клас <%=rs.getString("joint_point")%>.</dt></font></dl>

            <p align="center"><font size="-1"><strong>2 Обов'язки сторін</strong></font></p>
            <dl style="text-align:justify"><font size="-1">
                    <dt>2.1 ЕО зобов'язана підключити електроустановки Замовника до  своїх електромереж в термін до 5 днів після виконання Замовником вимог пункту  2.2
                        цього Договору в повному обсязі, прийняття електроустановки Замовника в  експлуатацію, оформлення акту допуску на підключення електроустановки
                        Замовника.</dt>
                    <dt>2.2 Замовник зобов'язаний: </dt>
                    <dt>2.2.1 Виконати вимоги технічних умов<strong> № </strong><strong><%= rs.getString("number")%></strong> від <strong>
                            <%= rs.getString("date_customer_contract_tc")%></strong> року на підключення  будівельних електромеханізмів в повному обсязі до завершення
                        терміну
                        дії даного  Договору (додаток № 1).</dt>
                    <dt>2.2.2  Розробити проектну документацію згідно з вимогами технічних умов та узгодити її  з ЕО та іншими зацікавленими організаціями.</dt>
                    <dt>2.2.3 До підключення електроустановки Замовника до електричної  мережі ЕО оплатити вартість допуску та підключення, згідно виставленого рахунку
                        та укласти договір про постачання електричної енергії, а за необхідності ― інші  договори, передбачені Правилами користування електричною
                        енергією.</dt></font></dl>
            <p align="center"><font size="-1"><strong>3 Відповідальність сторін</strong></font></p>
            <dl><font size="-1">
                    <dt>3.1 ЕО несе відповідальність за зміст та обґрунтованість  виданих технічних умов.</dt>
                    <dt>3.2 Замовник несе відповідальність за достовірність наданих ЕО  документів, належне виконання вимог технічних умов, розроблення проектної
                        документації, своєчасне її узгодження з ЕО та іншими зацікавленими особами.</dt>
                    <dt>3.3 Сторони не відповідають за невиконання умов цього  Договору, якщо це спричинено дією обставин непереборної сили. Факт дії обставин непереборної
                        сили підтверджується відповідними документами.</dt>
                    <dt>3.4 У разі розірвання або неналежного виконання Замовником п.  2.2 цього Договору – витрати, понесені Замовником (за видачу технічних умов,
                        погодження проектної документації тощо) не відшкодовуються.</dt></font></dl>
            <p align="center"><font size="-1"><strong>4 Порядок вирішення спорів</strong></font></p>
            <dl style="text-align:justify"><font size="-1">
                    <dt>4.1  Усі спірні питання,  пов'язані з виконанням цього Договору, вирішуються шляхом переговорів між  сторонами.</dt>
                    <dt>4.2 У разі недосягнення згоди спір вирішується в судовому  порядку відповідно до законодавства України. Спори, що виникають при укладенні, зміні
                        та (або) розірванні Договору, справи у спорах про визнання договору недійсним або пов’язаних з виконанням даного договору, розглядаються в судах
                        за місцем знаходження ЕО.</dt></font></dl>
            <p align="center"><font size="-1"><strong>5 Строк дії Договору</strong></font></p>
            <dl style="text-align: justify"><font size="-1">
                    <dt>5.1 Цей Договір набирає чинності з моменту його підписання і  діє до закінчення терміну дії Договору про <%=rs.getString("type_join")%> до електричних мереж
                        <strong>№ <%=rs.getString("TC_Onumber")%> від <%=rs.getString("TC_Odate_contract")%> року</strong>.</dt>
                    <dt>5.2 У разі дострокового виконання зобов’язань сторін згідно  умов Договору може мати місце дострокове припинення Договору за згодою сторін або
                        на підставах, передбачених чинним в  Україні законодавством.</dt>
                    <dt>5.3 Договір може бути змінено або розірвано в односторонньому  порядку на вимогу ЕО у разі невиконання умов Договору про <%=rs.getString("type_join")%> до
                        електричних мереж № <%= rs.getString("TC_Onumber")%> від<strong><%=rs.getString("TC_Odate_contract")%></strong> року, про що Замовника повідомляється окремим письмовим
                        повідомленням. Дане повідомлення вважається невід’ємною частиною даного  Договору.</dt>
                    <dt>5.4 Термін дії Договору може бути продовжений за згодою  сторін.</dt></font></dl>
            <p align="center"><font size="-1"><strong>6 Інші умови Договору</strong></font></p>
            <dl style="text-align:justify"><font size="-1">
                    <dt>6.1 Після одержання проекту Договору Замовник у 20-ти денний термін  повертає підписаний примірник Договору. У разі наявності заперечень до умов
                        Договору у цей же термін надсилає протокол розбіжностей чи повідомляє ЕО про  відмову від укладення Договору.</dt>
                    <dt>6.2 У разі недотримання порядку зазначеному в п. 6.1 цього  Договору, Договір вважається неукладеним (таким, що не відбувся).</dt>
                    <dt>6.3 Додатки до цього Договору є невід’ємними частинами цього Договору. Усі зміни та доповнення Договору оформляються письмово, підписуються
                        уповноваженими особами та скріплюються печатками з обох сторін.</dt>
                    <dt>6.4 Цей Договір укладений у двох примірниках, які мають  однакову юридичну силу для Замовника та ЕО.</dt>
                    <dt>6.5 У разі, якщо на час дії даного Договору відбулися зміни в чинному законодавстві України, ЕО в односторонньому порядку вносяться зміни,
                        які доводяться до Замовника окремим письмовим повідомленням. Дане повідомлення  вважається невід’ємною частиною Договору.</dt>
                    <dt>6.6  Замовник має, немає  (необхідне підкреслити) статус платника податку на прибуток підприємств на  загальних умовах.</dt>
                    <dt>6.7 ЕО має статус платника податку на прибуток підприємств на  загальних умовах.</dt></font></dl>
                    <%}%>
            <p align="center"><font size="-1"><strong>7 Місцезнаходження сторін</strong></font></p>
            <%if (rs.getString("join2").equals("2")) {%>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="355" valign="top"><font size="-1"><span>Електропередавальна    організація:</span></font></td>
                    <td width="355" valign="top"><p><font size="-1">Замовник:</font></p></td>
                </tr>
                <tr>
                    <td width="295" valign="top"><p>
                            <strong>ПАТ «Прикарпаттяобленерго»</strong><br>
                            м. Івано-Франківськ, вул. Індустріальна 34 <br>
                        <% if ((rs.getString("join2").equals("1")) || (rs.getString("join2").equals("2"))) { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р <% if (rs.getString("join2").equals("1")) { %>26000011732450 <%} else { %> 26003011732479 <% } %> в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                        Код МФО 300023<br>
                        <% } else { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р 26009305757  в філії Івано-Франківське обласне управління АТ «Ощадбанк»<br>
                        Код МФО 336503 <br>
                        <% } %>
                            <strong>Технічний директор </strong><br>
                            <strong>ПАТ «Прикарпаттяобленерго»</strong><br>
                        </p></td>
                    <td width="355" valign="top"><p><font size="-1"><strong><u><%= rs.getString("customer_soc_status")%> <%= rs.getString("name")%></u></strong>
                                <br>
                                <strong><u><%=rs.getString("type_c")%> <%= rs.getString("customer_adress")%></u></strong><br>
                                р/р <%= rs.getString("bank_account")%> МФО <%= rs.getString("bank_mfo")%><br>
                                <strong>_____________________________________</strong><br>
                                Код ЄДРПОУ    <%= rs.getString("bank_identification_number")%><br>
                                Свідоцтво платника ПДВ № _____________________<br>
                                Індивідуальний податковий №    ___________________<br>
                                        <strong><u><%if ((!rs.getString("customer_soc_status_1").equals("15")
                                                    && !rs.getString("customer_soc_status_1").equals("11")) && (rs.getString("customer_type").equals("1"))) {%> в особі <strong><%=rs.getString("customer_post")%><%}%></u></strong></font></p>
                        <font size="-1"><br></font></td>
                </tr>
                <tr>
                    <td><p><font size="-1"><strong>_______________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    Сеник Олег Степанович</strong></font></p></td>
                    <td><font size="-1"><strong>____________________    <%= rs.getString("PIP")%></strong></font></td>


                </tr>
            </table><%} else if (rs.getString("join2").equals("1")) {%>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="328" valign="top"><p>Електропередавальна    організація:</p></td>
                    <td width="329" valign="top"><p>Замовник:</p></td>
                </tr>
                <tr>
                    <td width="328" valign="top"><p>ПАТ «Прикарпаттяобленерго»<br>                            
                            <u>м. Івано-Франківськ, вул. Індустріальна, 34</u><br>
                        <% if ((rs.getString("join2").equals("1")) || (rs.getString("join2").equals("2"))) { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р <% if (rs.getString("join2").equals("1")) { %>26000011732450 <%} else { %> 26003011732479 <% } %> в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                        Код МФО 300023<br>
                        <% } else { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р 26009305757  в філії Івано-Франківське обласне управління АТ «Ощадбанк»<br>
                        Код МФО 336503 <br>
                        <% } %>
                            тел: <%= rs.getString("contacts").replace("тел. (", "").replace(")", "")%><br>
                            Директор філії ПАТ «Прикарпаттяобленерго»<br>
                            “<%= rs.getString("rem_name")%> РЕМ”<br>
                        </p></td>
                    <td width="329" valign="top"><p><u><%=rs.getString("PIP")%></u>
                            <u><%=rs.getString("type_c")%> <%=rs.getString("customer_adress")%></u><br>
                            <%--<strong><u><%=rs.getString("constitutive_documents").substring(0,rs.getString("constitutive_documents").indexOf("виданий"))%></u></strong><br>
                            <strong><u><%=rs.getString("constitutive_documents").substring(rs.getString("constitutive_documents").indexOf("виданий"))%></u> </strong><br>--%>
                            <%=rs.getString("constitutive_documents")%><br>
                            Ідентифікаційний код <%=rs.getString("bank_identification_number")%><br><br><br><br>
                            Громадянин (ка)<br>
                        </p></td>
                </tr>
                <tr>
                    <td>________________        <u><%=rs.getString("Director")%></u><br>
                                (підпис)                              (П.І.Б.)</td>
                    <td>_______________       <u><%=rs.getString("PIP")%></u><br>
                                   (підпис)                        (П.І.Б.)</td>
                </tr>
            </table><%} else {%>
            <table border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="355" valign="top"><font size="-1"><span>Електропередавальна    організація:</span></font></td>
                    <td width="355" valign="top"><p><font size="-1">Замовник:</font></p></td>
                  </tr>
                  <tr>
                    <td width="355" valign="top"><font size="-1"><strong>ПАТ «Прикарпаттяобленерго»</strong> <br>
                    <strong>м.    Івано-Франківськ, вул. Індустріальна, 34</strong><br>
                        <% if ((rs.getString("join2").equals("1")) || (rs.getString("join2").equals("2"))) { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р <% if (rs.getString("join2").equals("1")) { %>26000011732450 <%} else { %> 26003011732479 <% } %> в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                        Код МФО 300023<br>
                        <% } else { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р 26009305757  в філії Івано-Франківське обласне управління АТ «Ощадбанк»<br>
                        Код МФО 336503 <br>
                        <% } %>
                        <p><strong>Технічний    директор </strong><br>
                      <strong>ПАТ    «Прикарпаттяобленерго»</strong><br></font></td>
                    <td width="355" valign="top"><p><font size="-1"><strong><u><%= rs.getString("customer_soc_status")%> <%= rs.getString("name")%></u></strong>
					<br>
                    <strong><u><%=rs.getString("type_c")%> <%= rs.getString("customer_adress")%></u></strong><br>
                    р/р <%= rs.getString("bank_account")%> МФО <%= rs.getString("bank_mfo")%><br>
                    <strong>_____________________________________</strong><br>
                    Код ЄДРПОУ    <%= rs.getString("bank_identification_number")%><br>
                      Свідоцтво платника ПДВ № _____________________<br>
                            Індивідуальний податковий №    ___________________<br>
                            <strong><u><%if ((!rs.getString("customer_soc_status_1").equals("15") &&
        !rs.getString("customer_soc_status_1").equals("11")) && (rs.getString("customer_type").equals("1"))){%> в особі <strong><%=rs.getString("customer_post")%><%}%></u></strong></font></p>
                    <font size="-1"><br></font></td>
                  </tr>
				  <tr>
				  	<td><p><font size="-1"><strong>_______________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 Сеник Олег Степанович</strong></font></p></td>
					<td><font size="-1"><strong>____________________    <%= rs.getString("PIP")%></strong></font></td>
				  
				  
				  </tr>
                </table><%}%>
        </div>
    </div>
    <%} else if (!rs.getString("join2").equals("2")) {%>
    <div class="Section1">
        <p align="right"><SPAN lang="UK">ОП 4.1-Б</SPAN></p>
        <p align="center"><strong>Додаток № 1 до додаткового правочину № П-<%= rs.getString("No_letter")%> від __.__.____року про внесення змін до договору № <%= rs.getString("number")%></strong>
            <strong>про стандартне приєднання до електричних мереж</strong></p>
        <table width="100%"><tr><td width="50%"><%=rs.getString("rem_licality").substring(0, rs.getString("rem_licality").indexOf(','))%></td><td align="right"><%=rs.getString("date_customer_contract_tc")%> р.</td></tr></table><br >

        <div align="justify" style="text-align:justify; text-indent:20pt"><strong>ПАТ  «Прикарпаттяобленерго»</strong>,  що здійснює ліцензовану діяльність з передачі  електроенергії, в особі директора філії <strong>&quot;<%= rs.getString("rem_name")%> РЕМ&quot; </strong><strong><%= rs.getString("director_rod")%></strong> , який діє на підставі довіреності <%= rs.getString("dovirenist")%> року, далі - Виконавець послуг з однієї сторони, та громадянин (ка) <strong><%=rs.getString("PIP")%></strong>, надалі – замовник,  <strong><%=rs.getString("constitutive_documents")%></strong>, ідентифікаційний код <%=rs.getString("bank_identification_number")%>, з іншої сторони,  уклали цей Договір про  приєднання електроустановок Замовника до електричних мереж (далі ―  Договір).<br>
        </div>
        <div align="justify" style="text-align:justify; text-indent:20pt">При виконанні умов цього  Договору, а також вирішенні всіх питань, що не обумовлені цим Договором,  сторони зобов'язуються керуватися Законом України "Про електроенергетику "  та іншими нормативно-правовими актами у сфері приєднання електроустановок до електромереж.<br> 
        </div>
        <div align="justify" style="text-align:justify; text-indent:20pt"></div>
        <div align="center"><strong>1. Загальні положення </strong></div>
        <div align="justify" style="text-align:justify">
            <dl>
                <dt>1.1 За цим Договором до електричних мереж Виконавця послуг або іншого Власника приєднується:<strong><u> <%= rs.getString("object_name")%></u></strong>, який знаходиться за адресою: <strong><u><%=rs.getString("type_o")%> <%= rs.getString("object_adress")%></u></strong> (далі - об'єкт Замовника). </dt>
                <dt>1.2 Місце забезпечення потужності об’єкта Замовника  встановлюється: <strong><u><%= rs.getString("point_zab_power")%></u></strong></dt>
                <dt>1.3 Точка приєднання (межа балансової належності  об’єкта Замовника) встановлюється:<strong><u><%= rs.getString("connection_treaty_number")%></u></strong></dt>
                <dt>1.4 Тип приєднання об’єкта Замовника: <u><strong> <%= rs.getString("type_join")%></strong></u>.</dt>
                <dt>1.5. Замовлено до приєднання потужність в точці приєднання <strong><%= rs.getString("request_power").replace(".", ",")%></strong> кВт.</dt>
                <dt>1.6. Категорія з надійності електропостачання <strong><%= rs.getString("reliabylity_class_1_0")%> <%= rs.getString("reliabylity_class_2_0")%> <%= rs.getString("reliabylity_class_3_0")%></strong>.</dt>
                <dt>1.7. Ступінь напруги в точці приєднання визначається напругою на межі  балансової належності і буде становити <strong><%= rs.getString("joint_point_2").replace(".", ",")%></strong> кВ, <strong><%= rs.getString("class_joint_point")%></strong> клас.</dt>

            </dl>
        </div>
        <div align="center"><strong>2. Предмет договору </strong></div>
        <div align="justify" style="text-align:justify">
            <dl>
                <dt>2.1. Виконавець послуг забезпечує приєднання електроустановок  об’єкта Замовника (будівництво, реконструкція, технічне переоснащення та  введення в експлуатацію електричних мереж зовнішнього електропостачання об’єкта  Замовника від місця забезпечення потужності до точки приєднання) відповідно до  схеми зовнішнього електропостачання та проектної документації на зовнішнє  електропостачання, розробленої згідно з технічними умовами від <strong><%= rs.getString("initial_date")%></strong> року № <strong><%= rs.getString("number")%></strong>,  які є додатком до цього Договору, а також здійснює підключення об’єкта  Замовника до електричних мереж на умовах цього Договору.</dt>
                <dt>2.2. Замовник оплачує Виконавцю послуг вартість приєднання.</dt>

            </dl>
        </div>
        <div align="center"><strong>3. Права та обов'язки сторін</strong></div>
        <div align="justify" style="text-align:justify"><dl>
                <dt>3.1. Виконавець послуг зобов’язаний:</dt>
                <dt>3.1.1. Забезпечити в установленому порядку  приєднання об’єкта Замовника (будівництво та введення в експлуатацію  електричних мереж зовнішнього електропостачання об’єкта Замовника від місця  забезпечення потужності до точки приєднання) у терміни відповідно до  домовленості сторін та визначених СНИП 1.04.03-85 термінів будівництва після  виконання Замовником зобов`язань визначених п.3.2 Договору.</dt>
                <dt>3.1.2. Підключити електроустановки Замовника до  електричних мереж протягом 10 робочих днів після представлення Замовником ЕО документів про введення в експлуатацію  об’єкту замовника, в порядку, встановленому законодавством у сфері  містобудування, та після виконання наступних етапів:</dt>
                <ul type="square">
                    <li>Оплати       Замовником вартості приєднання;</li>
                    <li>введення в       експлуатацію електричних мереж зовнішнього електропостачання об’єкта       Замовника;</li>
                    <li>надання       документів, що підтверджують готовність до експлуатації електроустановки       об’єкта замовника;</li>
                    <li>узгодження між сторонами акту розмежування балансової належності електроустановок та       експлуатаційної відповідальності сторін.</li>
                </ul>
                <dt>3.1.3 Виконавець послуг  зобов’язується здійснити у відповідності до Закону України «Про захист  персональних даних» заходи щодо організації захисту персональних даних та не  розголошувати відомості стосовно персональних даних Замовника.</dt>
                <% if (rs.getInt("term_for_joining") <= 15) {%>
                <dt>3.1.4 Термін надання послуги із стандартного приєднання становить 15 робочих днів з дня оплати Замовником плати за приєднання.</dt> <%}%>
                <% if (rs.getInt("term_for_joining") > 15) {%>
                <dt>3.1.4 Строк надання послуги з приєднання від дня оплати плати за приєднання становить <%= rs.getString("term_for_joining")%> днів, відповідно до вимог СОУ-Н МЕВ 42.2-37471933-45:2011.</dt><%}%>
                <dt>3.1.5 Тривалість надання послуги зі стандартного приєднання може бути продовжена на строк необхідний для погодження та оформлення права користування земельними ділянками під електроустановки зовнішнього електрозабезпечення відповідно до закону. Повідомлення власників земельних ділянок та Замовника є невід'ємною частиною даного Договору</dt>
                <dt>3.2. Замовник зобов'язаний:</dt>
                <dt>3.2.1. Оплатити на умовах цього Договору вартість  наданих Виконавцем послуг з приєднання електроустановок Замовника в точці  приєднання.</dt>
                <dt>3.2.2. Дата <strong><%= rs.getString("date_intro_eksp2")%></strong>  року введення в експлуатацію власного об’єкту та електроустановки зовнішнього забезпечення від точки приєднання до об’єкта.</dt>
                <dt>3.3. Виконавець послуг має право:</dt>
                <dt>3.3.1. Прийняти рішення щодо надання послуги з  приєднання як господарським, так і підрядним способом.</dt>
                <dt>3.3.2. У разі порушення Замовником порядку  розрахунків за цим Договором, призупинити виконання зобов’язань за цим  Договором до належного виконання Замовником відповідних умов Договору та/або  ініціювати перегляд Сторонами істотних умов цього Договору.</dt>
                <dt>3.4. Замовник має право:</dt>
                <dt>3.4.1. Контролювати виконання Виконавцем послуг зобов`язань  щодо будівництва електричних мереж зовнішнього електропостачання об’єкта  Замовника від місця забезпечення потужності до точки приєднання, у тому числі  шляхом письмових запитів до Виконавця послуг про хід виконання приєднання.</dt>
                <dt>3.5. Після введення в експлуатацію електричних мереж  зовнішнього електропостачання Виконавець послуг набуває право власності на  збудовані електричні мережі зовнішнього електропостачання.</dt><dt> 3.6. Підключення електроустановки замовника до електричних мереж  електропередавальної організації здійснюється на підставі заяви протягом 5  робочих днів, якщо підключення не потребує  припинення електропостачання інших споживачів, або 10 робочих днів, якщо  підключення потребує припинення електропостачання інших споживачів, після  введення в експлуатацію об’єкту замовника в порядку, встановленому  законодавством у сфері містобудування.</dt>

            </dl>
        </div>
        <div align="center"><strong>4. Плата  за приєднання та порядок розрахунків</strong></div>
        <div align="justify" style="text-align:justify">
            <dl>
                <dt>4.1. Плата за приєднання за цим Договором відповідно  до Постанови НКРЕ № 805 від 16.12.2014 «Про затвердження ставок плати за приєднання електроустановок для Автономної Республіки Крим, областей, міст Києва та Севастополя на 2015 рік», становить <strong>  <%= rs.getString("price_join").replace(".", ",")%></strong> грн. з ПДВ.</dt>
                <div align="justify" style="text-align:justify; text-indent:20pt">Плата за приєднання вказується з урахуванням  діючих ставок та податку на додану вартість на день  здійснення платежу.<br></div>
                <dt>4.2. Замовник сплачує плату за приєднання,визначену в пункті 4.1 цього Договору, на поточний рахунок Виконавця послуг: п/р <%if (rs.getString("type_join").equals("1")){%>26000011732450<%} else{ %>26003011732479<%}%>в філії Івано-Франківське обласне управління ПАТ «Укрсоцбанк», Код ЄДРПОУ 00131564, в  термін до ____ днів з дня укладання Договору.</dt>
            </dl>
        </div>
        <div align="center"><strong>5.  Відповідальність сторін</strong></div>
        <div align="justify" style="text-align:justify"><dl>
                <dt>5.1. У випадку порушення своїх зобов'язань за цим  Договором Сторони несуть відповідальність, визначену цим Договором та чинним  законодавством. Порушення зобов'язання є його невиконання або неналежне  виконання, тобто виконання з порушенням умов, визначених змістом зобов'язання.</dt>
                <dt>5.2. Виконавець послуг несе відповідальність за зміст  та обґрунтованість виданих технічних умов та правильність розрахунку плати за  приєднання за цим Договором.</dt>
                <dt>5.3. За порушення строків виконання зобов'язання  за цим Договором винна сторона сплачує іншій Стороні пеню у розмірі 0,1  відсотка вартості приєднання за кожний день прострочення, а за прострочення  понад тридцять днів додатково стягується штраф у розмірі семи відсотків  вказаної вартості.</dt>
                <div align="justify" style="text-align:justify; text-indent:20pt">За порушення умов зобов'язання щодо якості  (повноти та комплектності) надання послуги з приєднання стягується штраф у  розмірі семи відсотків вартості приєднання.<br></div>
                <dt>5.4. Сторони не відповідають за невиконання умов цього Договору, якщо це  спричинено дією обставин непереборної сили. Факт дії обставин непереборної сили  підтверджується відповідними документами.</dt>

            </dl>
        </div><br><br>
        <div align="center"><strong>6. Порядок вирішення спорів</strong></div>
        <div align="justify" style="text-align:justify"><dl>
                <dt>6.1. Усі спірні питання, пов’язані з виконанням  цього Договору, вирішуються шляхом переговорів між сторонами.</dt>
                <dt>6.2. У разі недосягнення згоди спір вирішується в судовому порядку  відповідно до законодавства України.</dt>

            </dl>
        </div>
        <div align="center"><strong>7. Строк дії Договору</strong></div>
        <div align="justify" style="text-align:justify">
            <p><dt>7.1. Цей Договір набирає чинності з моменту його підписання і діє до повного виконання Сторонами передбачених ним зобов'язань (до завершення будівництва об’єкту архітектури).</dt>
            <dt> 7.2. Договір може бути змінено або розірвано і в  іншій термін за ініціативою будь-якої із сторін у порядку, визначеному  законодавством України.</dt>
            <dt>7.3. Строк дії Договору може бути продовжений за  вмотивованим зверненням однієї із Сторін у передбаченому законодавством  порядку.</dt>
            <dt>7.4. Договір може бути розірвано у разі відсутності розробленої  проектно-кошторисної документації та виконання будівництва в терміни, зазначені  в заяві.</dt></div>
        <div align="center"><strong>8. Інші умови Договору</strong></div>
        <div align="justify" style="text-align:justify">
            <p><dt>8.1 Після одержання проекту Договору Замовник у 20-ти  денний термін повертає підписаний примірник Договору. У разі наявності  заперечень до умов Договору у цей же термін надсилає протокол розбіжностей чи  повідомляє Виконавця послуг про відмову від укладення Договору.</dt>
            <dt>8.2 У разі недотримання порядку зазначеному в п. 8.1  цього Договору, Договір вважається неукладеним (таким, що не відбувся).</dt>
            <dt>8.3. Фактом  виконання зобов`язання Виконавця послуг з приєднання об`єкта Замовника  (будівництва електричних мереж зовнішнього електропостачання об’єкта Замовника  від місця забезпечення потужності до точки приєднання) Сторони вважатимуть факт  подачі напруги в узгоджену точку приєднання, підтверджену підписаним двома Сторонами &quot;Акт приймання-передачі виконаних робіт (наданих послуг)&quot;.</dt>
            <dt>8.4.Перелік  невід’ємних додатків до цього Договору:<dt>
            <div align="justify" style="text-align:justify; text-indent:20pt">1.Технічні умови № <strong><%= rs.getString("number")%></strong>  від <strong><%= rs.getString("initial_date")%></strong> року.</div>
            <dt>8.5 Цей Договір укладений у двох примірниках, які  мають однакову юридичну силу для Замовника та Виконавця послуг.</dt>
            <dt>8.6 Виконавець послуг здійснює  обробку персональних даних Замовника на підставі його письмової згоди для  проведення розрахунків по договору про приєднання до електричних мереж та  оформлення документів пов’язаних з виконанням умов по договору з метою  забезпечення реалізації податкових відносин, відносин у сфері бухгалтерського  обліку, адміністративно-правових та інших відносин, які вимагають обробки  персональних даних відповідно до Конституції України, Цивільного кодексу  України, Податкового кодексу України, Законів України «Про бухгалтерський облік  та фінансову звітність в Україні», Закону України «Про електроенергетику» та  інших нормативно-правових документів у сфері приєднання до електричних мереж.</dt>
            <dt>8.7 Виконавець послуг відповідно  до Закону України «Про захист персональних даних» повідомляє, що персональні  дані Замовника будуть включені до бази персональних даних «Фізичні особи,  персональні дані, яких обробляються в ході ведення господарської діяльності».  Вказана база розміщена за адресою: 76014, м. Івано-Франківськ, вул.  Індустріальна, 34.</dt>
            <dt>8.8 Виконавець послуг  повідомляє, що Замовник має права, визначені Законом України «Про захист  персональних даних», зокрема передбачені ст. 8 цього Закону:</dt>
            <ul type="square">
                <li>  знати про місцезнаходження бази персональних даних, яка містить його  персональні дані, її призначення та найменування, місцезнаходження та/або  місце проживання (перебування) володільця чи розпорядника персональних даних  або дати відповідне доручення щодо отримання цієї інформації уповноваженим ним  особам, крім випадків, встановлених законом; </li>
                <li>  отримувати інформацію про умови надання доступу до персональних даних, зокрема  інформацію про третіх осіб, яким передаються його персональні дані; </li>
                <li>  на доступ до своїх персональних даних;</li>
                <li>  отримувати не пізніш як за тридцять календарних днів з дня надходження запиту,  крім випадків, передбачених законом, відповідь про те, чи зберігаються його  персональні дані у відповідній базі персональних даних, а також отримувати  зміст його персональних даних, які зберігаються;</li>
                <li>  пред'являти вмотивовану вимогу володільцю персональних даних із запереченням  проти обробки своїх персональних даних;</li>
                <li>  пред'являти вмотивовану вимогу щодо зміни або знищення своїх персональних даних  будь-яким володільцем та розпорядником персональних даних, якщо ці дані  обробляються незаконно чи є недостовірними; </li>
                <li>  на захист своїх персональних даних від незаконної обробки та випадкової втрати,  знищення, пошкодження у зв'язку з умисним приховуванням, ненаданням чи  несвоєчасним їх наданням, а також на захист від надання відомостей, що є  недостовірними чи ганьблять честь, гідність та ділову репутацію фізичної особи;</li>
                <li>  звертатися із скаргами на обробку своїх персональних даних до органів державної  влади та посадових осіб, до повноважень яких належить забезпечення захисту  персональних даних, або до суду;</li>

                <li> застосовувати засоби правового захисту в разі порушення законодавства про  захист персональних даних; </li>
                <li>  вносити застереження стосовно обмеження права на обробку своїх персональних  даних під час надання згоди;</li>
                <li>  відкликати згоду на обробку персональних даних;</li>
                <li>  знати механізм автоматичної обробки персональних даних;</li>
                <li> на захист від автоматизованого рішення, яке має  для нього правові наслідки.</li>
            </ul>
            </dl>
            <dt>&nbsp;</dt>
        </div>

        <div align="center"><strong>9. Місцезнаходження сторін</strong></div>
        <div><br></div>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="328" valign="top"><p>Виконавець послуг:</p></td>
                <td width="329" valign="top"><p>Замовник:</p></td>
            </tr>
            <tr>
                <td width="328" valign="top"><p>ПАТ «Прикарпаттяобленерго»<br>                            
                        <u>м. Івано-Франківськ, вул. Індустріальна, 34</u><br>
                    <% if ((rs.getString("type_join").equals("1")) || (rs.getString("type_join").equals("2"))) { %>
                    Код ЄДРПОУ 00131564<br>
                    п/р <% if (rs.getString("type_join").equals("1")) { %>26000011732450 <%} else { %> 26003011732479 <% } %> в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                    Код МФО 300023<br>
                    <% } else { %>
                    Код ЄДРПОУ 00131564<br>
                    п/р 26009305757  в філії Івано-Франківське обласне управління АТ «Ощадбанк»<br>
                    Код МФО 336503 <br>
                    <% } %>
                        тел: <%= rs.getString("contacts").replace("тел. (", "").replace(")", "")%><br>
                        Директор філії ПАТ «Прикарпаттяобленерго»<br>
                        “<%= rs.getString("rem_name")%> РЕМ”<br>
                    </p></td><td width="329" valign="top"><p><strong><%=rs.getString("PIP")%></strong><br>
                        <%=rs.getString("type_c")%> <%=rs.getString("customer_adress")%><br>
                        <%--<strong><u><%=rs.getString("constitutive_documents").substring(0,rs.getString("constitutive_documents").indexOf("виданий"))%></u></strong><br>
                        <strong><u><%=rs.getString("constitutive_documents").substring(rs.getString("constitutive_documents").indexOf("виданий"))%></u> </strong><br>--%>
                        <%=rs.getString("constitutive_documents")%><br>
                        Ідентифікаційний код <%=rs.getString("bank_identification_number")%><br><br>
                        тел: <%=rs.getString("customer_telephone")%><br><br>
                        Громадянин (ка)<br><br>
                    </p>
                </td>
            </tr>
            <tr>
                <td>________________        <u><%=rs.getString("Director")%></u><br>
                                                          <br>_____________________20___ року</td>
                <td>_______________       <u><%=rs.getString("PIP")%></u><br>
                                                       <br>_____________________20___ року</td>
            </tr>
        </table>
    </div>
    <%} else if (rs.getString("join2").equals("2")) {%>
    <div class="Section1" style="font-size: 8pt;">
<p align="right"><SPAN lang="UK"><%if (rs.getString("customer_type").equals("0")) {%>ОП 4.1-Є<%} else {%>ОП 4.1-Е <%}%></SPAN></p>
        <p align="center"><strong>Додаток № 1 до додаткового правочину № П-<%= rs.getString("No_letter")%> від __.__.____року про внесення змін до договору № <%= rs.getString("number")%></strong>
            <strong>про нестандартне приєднання до електричних мереж</strong></p>
        <table width="100%" class="tb8pt"><tr>
                <td width="50%">м. Івано-Франківськ</td>
                <td align="right"><%=rs.getString("date_customer_contract_tc")%> р.</td></tr></table><br >

        <div align="justify" style="text-align:justify;"><strong>ПАТ «Прикарпаттяобленерго»</strong>, в особі технічного директора ПАТ «Прикарпаттяобленерго»&nbsp; <strong>Сеника Олега Степановича</strong>,&nbsp;який діє на підставі довіреності № 816&nbsp;від 11.08.2014&nbsp;з однієї сторони (далі - Виконавець послуг), та громадянин (ка) <strong><%=rs.getString("PIP")%></strong>, (далі – замовник), <strong><%=rs.getString("constitutive_documents")%></strong>, ідентифікаційний код <%=rs.getString("bank_identification_number")%>, з іншої сторони (далі – Сторони), уклали цей  договір про нестандартне приєднання електроустановок Замовника до електричних мереж (далі –  Договір).<br>
        </div>
        <div align="justify" style="text-align:justify; text-indent:20pt">При виконанні умов цього Договору Сторони  зобов'язуються діяти відповідно до чинного законодавства, зокрема, Правил  приєднання електроустановок до електричних мереж, затверджених постановою  Національної комісії, що здійснює державне регулювання у сфері енергетики № 32 від 17.01.2013 року, Методики розрахунку плати за приєднання,  затвердженою Постановою НКРЕ № 115 від 28.02.2013 року, Закону України «Про  електроенергетику», Закону України «Про регулювання містобудівної діяльності».<br> 
        </div>
        <div align="justify" style="text-align:justify; text-indent:20pt"></div>
        <div align="center"><strong>1. Загальні положення </strong></div>
        <div align="justify" style="text-align:justify">
            <dl>
                <dt>1.1 За цим Договором до електричних мереж Виконавця  послуг або іншого власника мереж приєднується об’єкт Замовника: <strong><u><%= rs.getString("object_name")%></u></strong>, який знаходиться за адресою: <strong><u><%=rs.getString("type_o")%> <%= rs.getString("object_adress")%></u></strong>. </dt>
                <dt>1.2 Місце забезпечення потужності об’єкта Замовника  встановлюється: <strong><u><%= rs.getString("point_zab_power")%></u></strong></dt>
                <dt>1.3 Точка приєднання (межа балансової належності  об’єкта Замовника) встановлюється:<strong><u><%= rs.getString("connection_treaty_number")%></u></strong></dt>
                <dt>1.4 Тип приєднання об’єкта Замовника: <u><strong> <%= rs.getString("type_join")%></strong></u>.</dt>
                <dt>1.5. Замовлено до приєднання потужність в точці приєднання <strong><%= rs.getString("request_power").replace(".", ",")%></strong> кВт.</dt>
                <dt>1.6. Категорія з надійності електропостачання <strong><%= rs.getString("reliabylity_class_1_0")%> <%= rs.getString("reliabylity_class_2_0")%> <%= rs.getString("reliabylity_class_3_0")%></strong>.</dt>
                <dt>1.7. Ступінь напруги в точці приєднання визначається напругою на межі  балансової належності і буде становити <strong><%= rs.getString("joint_point_2").replace(".", ",")%></strong> кВ, <strong><%= rs.getString("class_joint_point")%></strong> клас.</dt>
            </dl>
        </div>
        <div align="center"><strong>2. Предмет договору </strong></div>
        <div align="justify" style="text-align:justify">
            <dl>
                <dt>2.1. Виконавець послуг забезпечує приєднання  електроустановок об'єкта Замовника (будівництво, реконструкція, технічне  переоснащення та введення в експлуатацію електричних мереж зовнішнього  електропостачання об'єкта Замовника від місця забезпечення потужності до точки  приєднання) відповідно до схеми зовнішнього електропостачання і проектної  документації, розробленої згідно з технічними умовами <strong>№ <%= rs.getString("number")%></strong> від <strong><%= rs.getString("initial_date")%></strong> року (Додаток № 1 до Договору) та здійснює  підключення об'єкта Замовника до електричних мереж на умовах цього Договору.</dt>
                <dt>2.2. Замовник оплачує Виконавцю послуг вартість приєднання.</dt>
            </dl>
        </div>
        <div align="center"><strong>3. Права та обов'язки сторін</strong></div>
        <div align="justify" style="text-align:justify"><dl>
                <dt>3.1. Виконавець послуг зобов’язаний:</dt>
                <dt>3.1.1. Забезпечити в установленому порядку приєднання  об’єкта Замовника (будівництво та введення в експлуатацію електричних мереж  зовнішнього електропостачання об’єкта Замовника від місця забезпечення  потужності до точки приєднання) у строки відповідно до домовленості  сторін та після виконання Замовником зобов`язань визначених  п.3.2 Договору.</dt>
                <dt>3.1.2. Підключити електроустановки Замовника до  електричних мереж протягом ____ робочих  днів після введення в експлуатацію об'єкта  Замовника в порядку, встановленому законодавством у сфері містобудування, та  після виконання таких етапів:</dt>
                <ul type="square">
                        <li>оплати Замовником вартості приєднання;</li>
                        <li>введення в експлуатацію електричних мереж зовнішнього електропостачання об'єкта Замовника та письмового повідомлення Виконавця послуг протягом 2 днів</li>
                        <li>надання документів, що підтверджують готовність до експлуатації електроустановки об'єкта Замовника;</li>
                </ul>
                <dt>3.1.3 Строк надання послуги з нестандартного приєднання  встановлюється відповідно до термінів будівництва/реконструкції, визначених в  проектно-кошторисній документації, і зазначається в додатковій угоді до даного  Договору.</dt>
                <dt>3.1.4 Виконавець послуг зобов’язується здійснити у відповідності до Закону України «Про захист  персональних даних» заходи щодо організації захисту персональних даних та не  розголошувати відомості стосовно персональних даних Замовника.</dt> <dt>3.2. Замовник зобов'язаний:</dt>
                <dt>3.2.1. Розробити на підставі технічних умов  <strong>№ <%= rs.getString("number")%></strong>  від <strong><%= rs.getString("initial_date")%></strong> року які є додатком до цього Договору, проектну  документацію, протягом 60 днів з дня укладення даного договору, та погодити її з Виконавцем послуг.</dt>
                <dt>При наявності у Виконавця послуг зауважень та  рекомендацій до проектної документації, які викладені окремим розділом у  технічному рішенні, доопрацювати проектну документацію у строк, який не може  перевищувати 30 робочих днів від дня отримання зауважень до неї.</dt>
                <dt>
                    При необхідності продовжити строк  доопрацювання проектної документації подати Виконавцю послуг заяву не пізніше  ніж за 2 робочі дні до закінчення строку на доопрацювання.                    </dt>
                <dt>3.2.2. Узгодити із  землевласниками (землекористувачами) та усіма зацікавленими організаціями траси проходження запроектованих мереж на стадії проектування. </dt>
                <dt>3.2.3. Оплатити на умовах цього Договору вартість наданих  Виконавцем послуг з приєднання електроустановок Замовника в точці приєднання. </dt>
                <dt>3.2.4. Передати Виконавцю послуг проектну документацію на  зовнішнє електропостачання у 4 примірниках для виконання ним зобов'язань за  Договором.</dt>
                <dt>3.2.5. Дата <strong><%= rs.getString("date_intro_eksp2")%></strong>  року введення в експлуатацію власного об’єкту та електроустановки зовнішнього забезпечення від точки приєднання до об’єкта.</dt>
                <dt>3.2.6. Ввести електроустановки зовнішнього забезпечення від точки приєднання до об'єкта, про що письмово повідомити Виконавця послуг протягом двох днів.</dt>
                <dt>3.2.7. У разі виникнення потреби у перенесенні існуючих мереж Виконавця послуг звернутися за складанням додаткової угоди щодо надання послуг з перенесення вищезазначених мереж відповідно до частини четвертої статті 18 Закону України "Про електроенергетику".</dt>
                <dt>3.3. Виконавець послуг має право:</dt>
                <dt>3.3.1.  Прийняти  рішення щодо надання послуги з приєднання самостійно або із залученням підрядних організацій.</dt>
                <dt>3.3.2. У разі порушення Замовником порядку розрахунків  за цим Договором призупинити виконання зобов'язань за цим Договором до  належного виконання Замовником відповідних умов Договору та/або ініціювати  перегляд Сторонами істотних умов цього Договору.</dt>
                <dt>3.4. Замовник має право контролювати виконання  Виконавцем послуг зобов'язань щодо будівництва електричних мереж зовнішнього  електропостачання об'єкта Замовника від місця забезпечення потужності до точки  приєднання, у тому числі шляхом письмових запитів до Виконавця послуг про хід  виконання приєднання.</dt>
                <dt>3.5. Після введення в експлуатацію електричних мереж  зовнішнього електропостачання Виконавець послуг набуває право власності на  збудовані електричні мережі зовнішнього електропостачання.</dt>
                <dt>3.6. Підключення електроустановки Замовника до  електричних мереж електропередавальної організації здійснюється на підставі  заяви протягом 5 днів, якщо підключення не потребує припинення  електропостачання інших споживачів, або 10 днів, якщо підключення потребує  припинення електропостачання інших споживачів, після введення в експлуатацію  об'єкта Замовника в порядку, встановленому законодавством у сфері  містобудування.</dt>
            </dl>
        </div>
        <div align="center"><strong>4. Плата  за приєднання та порядок розрахунків</strong></div>
        <div align="justify" style="text-align:justify">
            <dl>
                <dt>4.1. Плата за нестандартне приєднання остаточно  узгоджується після погодження електропередавальною організацією проектної  документації та  оформляється додатковою угодою до даного Договору № <strong><%= rs.getString("number")%></strong>, у тому числі вартість проектної документації на  зовнішнє електрозабезпечення, яка передана Замовником Виконавцю послуг за актом приймання-передавання  в рахунок плати за приєднання. </dt>
                <dt>4.2  Замовник сплачує плату за приєднання на поточний рахунок Виконавця послуг до дати визначеної у додатковій угоді. У випадку несплати Замовником плати за приєднання у вказаний термін, Виконавець послуг перераховує вартість послуги з приєднання відповідно до діючої на момент перерахунку вартості проектно-кошторисної документації. При цьому кошторисна вартість робіт підлягає уточненню та коригуванню у зв'язку із зміною цін на матеріали, тарифів на послуги, інших складових структури кошторисної вартості.</dt>
                <dt></p>
            </dl>
        </div><br><br><br>
        <div align="center"><strong>5.  Відповідальність сторін</strong></div>
        <div align="justify" style="text-align:justify"><dl>
                <dt>5.1. У випадку порушення своїх зобов'язань за цим  Договором Сторони несуть відповідальність, визначену цим Договором та чинним  законодавством. Порушенням зобов'язання є його невиконання або неналежне  виконання, тобто виконання з порушенням умов, визначених змістом зобов'язання.</dt>
                <dt>5.2. Виконавець послуг несе відповідальність за зміст  та обґрунтованість виданих технічних умов та правильність розрахунку плати за  приєднання за цим Договором.</dt>
                <dt>5.3. Замовник несе відповідальність за своєчасне та  належне виконання вимог технічних умов, розроблення проектної документації,  своєчасне узгодження цієї документації з Виконавцем послуг.</dt>
                <dt>5.4. За порушення строків виконання зобов'язання за цим  Договором винна Сторона сплачує іншій Стороні пеню у розмірі 0,1 відсотка вартості приєднання за кожний день  прострочення, а за прострочення понад 30 днів додатково стягується штраф у  розмірі 0,1 відсотка від  вказаної вартості.</dt>
                <dt>За порушення умов зобов'язання щодо якості (повноти та  комплектності) надання послуги з приєднання стягується штраф у розмірі 0,1 відсотка від вартості приєднання.</dt>
                <dt>5.5. Сторони не відповідають за невиконання умов  цього Договору, якщо це спричинено дією обставин непереборної сили. Факт дії  обставин непереборної сили підтверджується відповідними документами.</dt>

            </dl>
        </div>
        <div align="center"><strong>6. Порядок вирішення спорів</strong></div>
        <div align="justify" style="text-align:justify"><dl>
                <dt>6.1. Усі спірні питання, пов'язані з виконанням цього  Договору, вирішуються шляхом переговорів між Сторонами.</dt>
                <dt>6.2. У разі недосягнення згоди спір вирішується в судовому порядку  відповідно до законодавства України.</dt>

            </dl>
        </div>
        <div align="center"><strong>7. Строк дії Договору</strong></div>
        <div align="justify" style="text-align:justify">
            <p><dt>7.1. Цей Договір набирає чинності з моменту його підписання і діє до повного виконання Сторонами передбачених ним зобов'язань (до завершення будівництва об’єкту архітектури).</dt>
            <dt> 7.2. Договір може бути змінено або розірвано і в інший  строк за ініціативою будь-якої зі Сторін у порядку, визначеному законодавством  України.</dt>
            <dt>7.3. Строк дії Договору може бути продовжений за  вмотивованим зверненням однієї зі Сторін у передбаченому законодавством  порядку.</dt>
            <dt>7.4. Договір може бути розірвано у разі відсутності (ненадання) розробленої проектно-кошторисної документації у терміни передбачені даним  договором або неврахування зауважень наданих Виконавцем послуг до  проектно-кошторисної документації, або відсутності звернення Замовника за  продовженням строку доопрацювання проектно-кошторисної документації, та виконання будівництва в строки, зазначені в  заяві.<strong> </strong></dt>
        </div>
        <div align="center"><strong>8. Інші умови Договору</strong></div>
        <div align="justify" style="text-align:justify">
            <p><dt>8.1 Після одержання проекту Договору Замовник у 20-ти  денний термін повертає підписаний примірник Договору. У разі наявності  заперечень до умов Договору у цей же термін надсилає протокол розбіжностей чи  повідомляє Виконавця послуг про відмову від укладення Договору.</dt>
            <dt>8.2 У разі недотримання порядку зазначеному в п. 8.1 цього Договору, Договір вважається неукладеним (таким, що не відбувся).</dt>
            <dt>8.3. Фактом виконання зобов'язання Виконавця послуг з приєднання об'єкта Замовника (будівництва електричних мереж зовнішнього електропостачання об'єкта Замовника від місця забезпечення потужності до точки приєднання) Сторони вважатимуть дату подачі напруги в узгоджену точку приєднання, підтверджену підписаним двома Сторонами «Актом приймання-здачі виконаних робіт (наданих послуг)».</dt>
            <dt>8.4.Перелік  невід’ємних додатків до цього Договору:<dt>
            <div align="justify" style="text-align:justify; text-indent:20pt">1.Технічні умови № <strong><%= rs.getString("number")%></strong>  від <strong><%= rs.getString("initial_date")%></strong> року.</div>
            <dt>8.5 Цей Договір укладено у двох примірниках, які мають однакову  юридичну силу для Замовника та Виконавця послуг.</dt>
            <dt>8.6 Виконавець послуг здійснює обробку персональних  даних Замовника на підставі його письмової згоди для проведення розрахунків по  договору про нестандартне приєднання до електричних мереж та оформлення документів  пов’язаних з виконанням умов по договору з метою забезпечення реалізації  податкових відносин, відносин у сфері бухгалтерського обліку,  адміністративно-правових та інших відносин, які вимагають обробки персональних  даних відповідно до Конституції України, Цивільного кодексу України,  Податкового кодексу України, Законів України «Про бухгалтерський облік та  фінансову звітність в Україні», Закону України «Про електроенергетику» та інших  нормативно-правових документів у сфері приєднання до електричних мереж.</dt>
            <dt>8.7 Виконавець послуг відповідно до Закону України «Про  захист персональних даних» повідомляє, що персональні дані Замовника будуть  включені до бази персональних даних «Фізичні особи, персональні дані, яких  обробляються в ході ведення господарської діяльності». Вказана база розміщена  за адресою: 76014, м. Івано-Франківськ, вул. Індустріальна, 34.</dt>
            <dt>8.8 Виконавець послуг повідомляє, що Замовник має  права, визначені Законом України «Про захист персональних даних», зокрема  передбачені ст. 8 цього Закону:</dt>
            <ul type="square">
                <li>  знати про місцезнаходження бази персональних даних, яка містить його  персональні дані, її призначення та найменування, місцезнаходження та/або  місце проживання (перебування) володільця чи розпорядника персональних даних  або дати відповідне доручення щодо отримання цієї інформації уповноваженим ним  особам, крім випадків, встановлених законом; </li>
                <li>  отримувати інформацію про умови надання доступу до персональних даних, зокрема  інформацію про третіх осіб, яким передаються його персональні дані; </li>
                <li>  на доступ до своїх персональних даних;</li>
                <li>  отримувати не пізніш як за тридцять календарних днів з дня надходження запиту,  крім випадків, передбачених законом, відповідь про те, чи зберігаються його  персональні дані у відповідній базі персональних даних, а також отримувати  зміст його персональних даних, які зберігаються;</li>
                <li>  пред'являти вмотивовану вимогу володільцю персональних даних із запереченням  проти обробки своїх персональних даних;</li>
                <li>  пред'являти вмотивовану вимогу щодо зміни або знищення своїх персональних даних  будь-яким володільцем та розпорядником персональних даних, якщо ці дані  обробляються незаконно чи є недостовірними; </li>
                <li>  на захист своїх персональних даних від незаконної обробки та випадкової втрати,  знищення, пошкодження у зв'язку з умисним приховуванням, ненаданням чи  несвоєчасним їх наданням, а також на захист від надання відомостей, що є  недостовірними чи ганьблять честь, гідність та ділову репутацію фізичної особи;</li>
                <li>  звертатися із скаргами на обробку своїх персональних даних до органів державної  влади та посадових осіб, до повноважень яких належить забезпечення захисту  персональних даних, або до суду;</li>

                <li> застосовувати засоби правового захисту в разі порушення законодавства про  захист персональних даних; </li>
                <li>  вносити застереження стосовно обмеження права на обробку своїх персональних  даних під час надання згоди;</li>
                <li>  відкликати згоду на обробку персональних даних;</li>
                <li>  знати механізм автоматичної обробки персональних даних;</li>
                <li> на захист від автоматизованого рішення, яке має  для нього правові наслідки.</li>
            </ul>
            </dl>
            <dt>&nbsp;</dt>
        </div>

        <div align="center" ><strong>9. Місцезнаходження сторін</strong></div>
        <div><br></div>
        <table border="0" cellspacing="0" cellpadding="0" class="tb8pt">

            <tr>
                <td width="328" valign="top"><p>Виконавець послуг:</p></td>
                <td width="329" valign="top"><p>Замовник:</p></td>
            </tr>
            <tr>
                <td width="328" valign="top"><p><strong>ПАТ «Прикарпаттяобленерго»</strong><br>                            
                        м. Івано-Франківськ, вул. Індустріальна, 34<br>
                    <% if ((rs.getString("join2").equals("1")) || (rs.getString("join2").equals("2"))) { %>
                    Код ЄДРПОУ 00131564<br>
                    п/р <% if (rs.getString("join2").equals("1")) { %>26000011732450 <%} else { %> 26003011732479 <% } %> в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                    Код МФО 300023<br>
                    <% } else { %>
                    Код ЄДРПОУ 00131564<br>
                    п/р 26009305757  в філії Івано-Франківське обласне управління АТ «Ощадбанк»<br>
                    Код МФО 336503 <br>
                    <% } %>
                        <strong>Технічний директор <br>
                            ПАТ  «Прикарпаттяобленерго»</strong><br>
                    </p></td><td width="329" valign="top"><p><strong><%=rs.getString("PIP")%></strong><br>
                        <%=rs.getString("type_c")%> <%=rs.getString("customer_adress")%><br>
                        <%--<strong><u><%=rs.getString("constitutive_documents").substring(0,rs.getString("constitutive_documents").indexOf("виданий"))%></u></strong><br>
                        <strong><u><%=rs.getString("constitutive_documents").substring(rs.getString("constitutive_documents").indexOf("виданий"))%></u> </strong><br>--%>
                        <%=rs.getString("constitutive_documents")%><br>
                        Ідентифікаційний код <%=rs.getString("bank_identification_number")%><br>
                        тел: <%=rs.getString("customer_telephone")%><br><br>
                        <strong>Громадянин (ка)</strong><br><br>
                    </p>
                </td>
            </tr>
            <tr>
                <td>________________  <strong>Сеник Олег Степанович </strong><br>
                             <br></td>
                <td>_______________       <strong><%=rs.getString("PIP")%></strong><br>
                               <br></td>
            </tr>
        </table>
    </div>
    <%}%>
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
