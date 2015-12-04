<%-- 
    Document   : prod
    Created on : 12 квіт 2011, 10:20:19
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%  response.setHeader("Content-Disposition", "inline;filename=zmin.doc");
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
                + ",isnull(soc_status.name,'') as customer_soc_status0"
                + ",isnull(TC_V2.customer_soc_status,'') as customer_soc_status_1"
                 + ",isnull(TC_V2.type_join,0) as join2"               
                + ",isnull(TC_V2.no_zvern,'') as no_zvern"
                + ",isnull(convert(varchar,TC_V2.registration_date,104),'') as registration_date"
                + ",TC_V2.customer_type"
                + ",isnull(soc_status.full_name,'') as customer_soc_status"
                + ",CASE WHEN TC_V2.customer_type=1 "
                + "and TC_V2.customer_soc_status<>15 "
                + "and TC_V2.customer_soc_status<>11 "
                + "and TC_V2.customer_soc_status<>9 "
                + "THEN  '\"" + "'+isnull(TC_V2.juridical,'')" + "+'\"' "
                + "WHEN TC_V2.customer_type=1 and (TC_V2.customer_soc_status=15 "
                + "or TC_V2.customer_soc_status=11 "
                + "or TC_V2.customer_soc_status=9)"
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
                + ",case when nullif(TC_V2.[object_adress],'') is not null then "
                + "         isnull(objadr.name,'')+', вул.'+ isnull(TC_V2.[object_adress],'') "
                + "     else isnull(objadr.name,'') end as object_adress"
                + ",isnull(convert(varchar,TC_V2.date_contract,104),'') as date_contract"
                + ",isnull(convert(varchar,TC_V2.date_customer_contract_tc,104),'___.___.2013р.') as date_customer_contract_tc"
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
                + ",isnull(ch.No_letter,'') as No_letter "
                + ",isnull(ch.Description_change,'') as Description_change "
                + ",isnull(convert(varchar,ch.send_date_lenner,104),'__.__.____') as send_date_lenner "
                + ",isnull(TC_V2.request_power,0.00) as request_power"
                + ",isnull(TC_V2.[reliabylity_class_1],'') as reliabylity_class_1"
                + ",isnull(TC_V2.[reliabylity_class_2],'') as reliabylity_class_2"
                + ",isnull(TC_V2.[reliabylity_class_3],'') as reliabylity_class_3"
                + ",isnull(TC_V2.[reliabylity_class_1_val],0.00) as reliabylity_class_1_val"
                + ",isnull(TC_V2.[reliabylity_class_2_val],0.00) as reliabylity_class_2_val"
                + ",isnull(TC_V2.[reliabylity_class_3_val],0.00) as reliabylity_class_3_val"
                + ",isnull(TC_V2.[power_for_electric_devices],0.00) as power_for_electric_devices"
                + ",isnull(TC_V2.[power_for_environmental_reservation],0.00) as power_for_environmental_reservation"
                + ",isnull(TC_V2.[power_for_emergency_reservation],0.00) as power_for_emergency_reservation"
                + ",isnull(TC_V2.[power_for_technology_reservation],0.00) as power_for_technology_reservation"
                + ",isnull(nullif(TC_V2.do1,''),'') as do1 "
                + ",isnull(TC_V2.do2,'') as do2 "
                + ",isnull(TC_V2.do3,'') as do3 "
                + ",isnull(TC_V2.do4,'') as do4 "
                + ",isnull(TC_V2.do5,'') as do5 "
                + ",isnull(TC_V2.do6,'') as do6 "
                + ",isnull(TC_V2.do7,'') as do7 "
                + ",isnull(TC_V2.do8,'') as do8 "
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
                + ",isnull (ps10.ps_nom_nav,'') as ps10_nom_nav "
                + ",isnull (ps10.ps_nom_nav_2,'') as ps10_nom_nav_2 "
                + ",case when ps10.ps_nom_nav_2=0 or ps10.ps_nom_nav_2 is null "
                + " then 1 else 2 end as kilkist10 "
                + ",isnull(SUPPLYCH.power,'') as power "
                + ",(select count(*) from SUPPLYCH where tc_id=" + request.getParameter("tu_id") + ") as kilk "
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
                + "else 'Власник мереж' end as executor_template "
                + "from TC_V2 "
                + " left join Changestc ch on ch.id_tc=TC_V2.id"
                + " left join [TC_LIST_locality] objadr on objadr.id=TC_V2.name_locality"
                + " left join [TC_LIST_locality] cusadr on cusadr.id=TC_V2.customer_locality"
                + " left join [TUweb].[dbo].[TC_LIST_customer_soc_status] soc_status on soc_status.id=TC_V2.customer_soc_status "
                + " left join [TUweb].[dbo].[rem] rem on TC_V2.department_id=rem.rem_id "
                + " left join TC_V2 TC_O on TC_V2.main_contract=TC_O.id "
                + " left join SUPPLYCH on SUPPLYCH.tc_id=TC_V2.id "
                + " left join [TUweb].[dbo].[ps_tu_web] ps35 on SUPPLYCH.ps_35_disp_name=ps35.ps_id "
                + "	left join [TUweb].[dbo].[ps_tu_web] ps110 on SUPPLYCH.ps_110_disp_name=ps110.ps_id "
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

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="../../../word_page_format.jsp"/>
    </head>
    <body>
        <div class="Section1">
            <p align="center"><strong>Додатковий правочин № </strong><strong>П-<%= rs.getString("No_letter")%> </strong><br>
                до Договору про <%= rs.getString("type_join")%> до  електричних мереж<br>
                № <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> року </p>
            <table width="100%"><tr><td width="50%">м. Івано-Франківськ </td><td align="right">“_____”______________ 20____ р.</td></tr></table>
            <p style="text-align:justify;text-indent:20pt">ПАТ “Прикарпаттяобленерго”, що  діє за умовами та правилами Ліцензії АБ №  177333 (далі – <%= rs.getString("executor_template")%>), в особі
                Технічного директора ПАТ  «Прикарпаттяобленерго» Сеника Олега Степановича, який діє на підставі  довіреності 
                № 816 від 11.08.2014 року, з однієї сторони,
                та <strong><%= rs.getString("customer_soc_status")%> <%= rs.getString("name")%></strong>,  надалі ― <strong>Замовник</strong>, який діє на
                підставі <%= rs.getString("constitutive_documents")%>, з іншої  сторони, (далі – Сторони), враховуючи заяву Замовника від <%= rs.getString("send_date_lenner")%> року,  домовились про наступне: </p>
            <p style="text-align:justify;text-indent:20pt">Внести зміни до Договору про  <%= rs.getString("type_join")%> до електричних мереж (далі – Договір)
                № <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> року в пункт. </p>
            <p style="text-align:justify;text-indent:20pt">Пункт : <%= rs.getString("Description_change")%></p>
            <p style="text-align:justify;text-indent:20pt">Умови даного  Додаткового правочину до Договору не змінюють умови основного  Договору відносно інших обов’язків Сторін і є його невід′ємною частиною.  </p>
            <p style="text-align:justify;text-indent:20pt">  Даний  Додатковий правочин до  Договору складено  у  двох   примірниках  по  одному   для  кожної  із   сторін <span style="text-align:justify; text-indent:20pt;">та діє протягом  дії   Договору  про <%= rs.getString("type_join")%> до  електричних мереж  № <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> р</span>.</p>
            <%if (!rs.getString("join2").equals("2") && !rs.getString("join2").equals("1")) {%>
            <table border="0" cellspacing="0" cellpadding="0" width="672">
                <tr>
                    <td><strong><%= rs.getString("executor_template")%>:</strong></td>
                    <td><strong>Замовник:</strong></td>
                </tr>
                <tr><font size="-1">
                    <td width="358" valign="top">
                        <p><strong>ПАТ    «Прикарпаттяобленерго»</strong></p>
                        <p>м. Івано-Франківськ, вул. Індустріальна 34 <br>
                        <% if ((rs.getString("join2").equals("1")) || (rs.getString("join2").equals("2"))) { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р <% if (rs.getString("join2").equals("1")) { %>26000011732450 <%} else { %> 26003011732479 <% } %> в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                        Код МФО 300023<br>
                        <% } else { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р 26009305757  в філії Івано-Франківське обласне управління АТ «Ощадбанк»<br>
                        Код МФО 336503 <br>
                        <% } %>
                        <p><strong>Технічний директор </strong><br>
                            <strong>ПАТ «Прикарпаттяобленерго»</strong></p>
                    </td>
                    <td width="350" valign="top"><font size="-1"><strong><%= rs.getString("customer_soc_status")%> <%= rs.getString("name")%></strong></font><br>
                        <strong><u><%=rs.getString("type_c")%> <%= rs.getString("customer_adress")%></u></strong><br>
                        р/р <%=rs.getString("bank_account")%>МФО <%= rs.getString("bank_mfo")%> <br>
                        ___________________________<br>
                        Код ЄДРПОУ <%= rs.getString("bank_identification_number")%> <br>
                        Свідоцтво платника ПДВ № ______________________<br>
                        Індивідуальний податковий № _____________________<br>
                        <strong><u>в особі <%= rs.getString("customer_post")%></u></strong><br />
                    </td></font>
                </tr>
                <tr><font size="-1">
                    <td><strong>_______________ О. С. Сеник </strong></td>
                    <td><strong>____________________    <%= rs.getString("PIP")%></strong></td></font>
                </tr>
            </table>
            <%} else  if (!rs.getString("join2").equals("2")) {%>
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
            <table border="0" cellspacing="0" cellpadding="0" width="716">
                <tr>
                    <td><strong><%=rs.getString("executor_template")%>:</strong></td>
                    <td><strong>Замовник:</strong></td>
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
                            <strong>_____________________________________</strong>  <br>
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
