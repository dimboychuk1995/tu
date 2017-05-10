<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%
    response.setHeader("Content-Disposition", "inline;filename=roz_join.doc");
    HttpSession ses = request.getSession();
    String db = new String();
    Connection c = null;
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    ResultSetMetaData rsmd = null;
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
                + ",TestDB.dbo.count_date_10_day(TC_V2.date_contract) as day_10"
                + ",TestDB.dbo.count_date_20_day(TC_V2.date_contract) as day_20"
                + ",isnull(TC_V2.juridical,'') as juridical"
                + ",isnull(soc_status.name,'') as customer_soc_status1"
                + ",isnull(TC_V2.customer_soc_status,'') as customer_soc_status"
                + ",isnull(soc_status.full_name,'') as customer_soc_status2 "
                + ",CASE WHEN TC_V2.customer_type=1 and TC_V2.customer_soc_status<>15 and TC_V2.customer_soc_status<>11 and TC_V2.customer_soc_status<>9 and  TC_V2.customer_soc_status<>12 and  TC_V2.customer_soc_status<>8"
                + "THEN  '\"" + "'+isnull(TC_V2.juridical,'')" + "+'\"' "
                + "WHEN TC_V2.customer_type=1 and (TC_V2.customer_soc_status=15 or TC_V2.customer_soc_status=11 or TC_V2.customer_soc_status=12 or TC_V2.customer_soc_status=9 or TC_V2.customer_soc_status=8)"
                + "THEN  isnull(TC_V2.juridical,'')"
                + "WHEN TC_V2.customer_type=0"
                + "THEN isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'')"
                + "ELSE '' end as [name2]"
                + ",CASE WHEN TC_V2.customer_type=1 and TC_V2.customer_soc_status<>15 and TC_V2.customer_soc_status<>11 and TC_V2.customer_soc_status<>9 and  TC_V2.customer_soc_status<>12 and  TC_V2.customer_soc_status<>8"
                + "THEN  '\"" + "'+isnull(TC_V2.juridical,'')" + "+'\"' "
                + "WHEN TC_V2.customer_type=1 and (TC_V2.customer_soc_status=11 or TC_V2.customer_soc_status=12 or TC_V2.customer_soc_status=9 or TC_V2.customer_soc_status=8)"
                + "THEN  isnull(TC_V2.juridical,'')"
                + "WHEN TC_V2.customer_type=1 and (TC_V2.customer_soc_status=15)"
                + "THEN isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'')"
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
                + ",isnull(ch.No_letter,'________') as No_letter "
                + ",[rem_name] "
                + ",[Director] "
                + ",[director_rod]"
                + ",[director_dav]"
                + ",[dovirenist]"
                + ",[contacts] "
                + ",[rek_bank] "
                + ",[rem_licality] "
                + ",[golovnyi_ingener]"
                + ",isnull(TC_V2.price_join,'') as price_join "
                + ",isnull(tj.name,'') as type_join"
                + ",case TC_V2.type_join"
                + "     when 1 then 1"
                + "     else 2 "
                + "end as type_join2"
                + " from TC_V2 "
                + " left join Changestc ch on ch.id_tc=TC_V2.id"
                + " left join [TC_LIST_locality] objadr on objadr.id=TC_V2.name_locality"
                + " left join [TC_LIST_locality] cusadr on cusadr.id=TC_V2.customer_locality"
                + " left join [TUweb].[dbo].[TC_LIST_customer_soc_status] soc_status on soc_status.id=TC_V2.customer_soc_status "
                + " left join [TUweb].[dbo].[rem] rem on TC_V2.department_id=rem.rem_id "
                + " left join TC_V2 TC_O on TC_V2.main_contract=TC_O.id "
                + " left join SUPPLYCH on SUPPLYCH.tc_id=TC_V2.id "
                + " left join [TUweb].[dbo].[type_join] tj on TC_V2.type_join=tj.id"
                + " where ch.id=" + request.getParameter("id");
        pstmt = c.prepareStatement(qry);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();
        rs.next();

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            p {margin-top: 0; margin-bottom: 0; }
        </style>
        <title>JSP Page</title>
        <jsp:include page="../../../word_page_format.jsp"/></head>
    <body>
        <div class="Section1">
            <p><br>
                <%if (rs.getString("customer_soc_status").equals("1") || rs.getString("customer_soc_status").equals("6")) {%>
                <strong><%=rs.getString("customer_soc_status1")%></strong><br>
                <strong>п. <%=rs.getString("PIP")%></strong>
                <%}%>
                <%if (rs.getString("customer_soc_status").equals("2") || rs.getString("customer_soc_status").equals("3") || rs.getString("customer_soc_status").equals("4") || rs.getString("customer_soc_status").equals("5") || rs.getString("customer_soc_status").equals("14") || rs.getString("customer_soc_status").equals("16")) {%>
                <strong><%=rs.getString("customer_post")%>&nbsp;<%=rs.getString("customer_soc_status1")%>&nbsp; "<%=rs.getString("juridical")%>"</strong><br>
                <strong>п. <%=rs.getString("PIP")%></strong>
                <%}%>
                <%if (rs.getString("customer_soc_status").equals("11") || rs.getString("customer_soc_status").equals("15")) {%>
                <strong><%=rs.getString("customer_soc_status1")%></strong><br>
                <strong>п. <%=rs.getString("PIP")%></strong>
                <%}%>
                <%if (rs.getString("customer_soc_status").equals("7") || rs.getString("customer_soc_status").equals("8") || rs.getString("customer_soc_status").equals("9") || rs.getString("customer_soc_status").equals("10") || rs.getString("customer_soc_status").equals("12") || rs.getString("customer_soc_status").equals("13")) {%>
                <strong><%=rs.getString("customer_post")%><br>
                        <%=rs.getString("juridical")%></strong><br>
                <strong>п. <%=rs.getString("PIP")%></strong>
                <%}%>
                <br>
                    <%=rs.getString("type_c")%><%=rs.getString("customer_adress")%></p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p><strong>&nbsp;</strong></p>
            <p>щодо прострочення виконання зобов’язання</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p style="text-indent: 40px"><%= rs.getString("date_contract")%>  року між Вами та АТ«Прикарпаттяобленерго» укладено договір № <%= rs.getString("number")%>
                від <%= rs.getString("date_contract")%> року про <%=rs.getString("type_join")%>  до електричних мереж (далі - Договір).</p>
            <div style="text-align:justify;">
                <p style="text-indent: 40px">Пунктом 4.2. Договору  передбачено,  що Замовник сплачує плату  за <%=rs.getString("type_join")%> , визначену в пункті 4.1 цього Договору, на поточний рахунок  Надавача послуг в термін до 10 днів з дня укладання Договору на підставі  виставленого рахунку. </p>
                <p style="text-indent: 40px">Так, <%= rs.getString("day_10")%> року був останнім  днем для оплати плати за <%=rs.getString("type_join")%>  в сумі <%=rs.getString("price_join").replace(".", ",")%> грн.</p>
                <p style="text-indent: 40px">Відповідно до п. 5.3. Договору за  порушення строків виконання зобов'язання за цим Договором винна сторона сплачує  іншій Стороні пеню у розмірі 0,1 відсотка вартості приєднання за кожний день  прострочення, а за прострочення понад тридцять днів додатково стягується штраф  у розмірі семи відсотків вказаної вартості.</p>
                <p style="text-indent: 40px"><strong>Таким чином, Вам необхідно сплатити плату за <%=rs.getString("type_join")%>  з  урахуванням вимог п. 5.3. Договору. </strong></p>
                <p style="text-indent: 40px">У разі Вашої відмови виконувати  свої зобов’язання по Договору та відмови від Договору у повному обсязі АТ «Прикарпаттяобленерго», керуючись п.&nbsp;7.2. Договору, ст.&nbsp;651  Цивільного кодексу України, пропонує укласти додатковий правочин про розірвання  договору про <%=rs.getString("type_join")%>  до електричних мереж.</p>
                <p style="text-indent: 40px"><u>Враховуючи вищенаведене, просимо  провести оплату до <%= rs.getString("day_20")%> року на умовах укладеного Договору, або у вказаний  строк підписати та повернути електропередавальній компанії два примірники  додаткового правочину до Договору</u>.</p>
                <p style="text-indent: 40px">Додаток: додатковий правочин про розірвання договору  № <%= rs.getString("number")%>  про <%=rs.getString("type_join")%>  до електричних мереж від <%= rs.getString("date_contract")%> року</p>
            </div>
            <p style="text-align:justify;text-indent:20pt">&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p align="center"><strong>ДОДАТКОВИЙ  ПРАВОЧИН </strong><br>
                про розірвання договору про <%=rs.getString("type_join")%> <br>
                до електричних мереж № <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> р.</p>
            <p align="center">&nbsp;</p>
            <table width="100%"> <tr><td width="50%">м. Івано-Франківськ</td>
                <td align="right">“___”_____________ 201_ року</td></tr></table>
            <div style="text-align:justify;"><p style="text-indent: 40px">АТ«Прикарпаттяобленерго», що здійснює ліцензовану  діяльність з передачі електроенергії, в особі <%if (rs.getString("type_join2").equals("1")) {%>директора філії &quot;<%= rs.getString("rem_name")%> РЕМ&quot;  <%= rs.getString("director_rod")%>, який діє на підставі  довіреності <%= rs.getString("dovirenist")%> року<%} else {%> Технічного директора АТ«Прикарпаттяобленерго» Сеника Олега Степановича, який діє на підставі довіреності № 1202 від 13.02.2017 року<%}%> (Виконавець послуг), з однієї сторони, та <strong><%if (!rs.getString("customer_soc_status").equals("9")
                    && !rs.getString("customer_soc_status").equals("12")) {%> <%= rs.getString("customer_soc_status1")%><%}%>
                    <%= rs.getString("name")%></strong>, надалі ―
                Замовник, <%if ((!rs.getString("customer_soc_status").equals("15")
                        && !rs.getString("customer_soc_status").equals("11")) && (rs.getString("customer_type").equals("1"))) {%> в особі  <strong><%= rs.getString("customer_post")%>&nbsp;<%= rs.getString("PIP")%></strong>,<%}
                    if (rs.getString("customer_type").equals("1")) {%> який (яка) діє на підставі<%}%> <strong><%= rs.getString("constitutive_documents")%></strong>,  з іншої сторони, названі у подальшому «Сторони», відповідно до ст. ст. 651, 653, 654 Цивільного кодексу  України уклали цей додатковий правочин про наступне:</p>
                <dt>1. Сторони дійшли згоди  розірвати Договір № <%= rs.getString("number")%>  від <%= rs.getString("date_contract")%> року про <%=rs.getString("type_join")%>  до електричних мереж.</dt>
                <dt> 2. Даний додатковий правочин набирає чинності з моменту  підписання його сторонами та є невід’ємною частиною Договору № <%= rs.getString("number")%> про  <%=rs.getString("type_join")%>  до електричних мереж від <%= rs.getString("date_contract")%> року.</dt>
                <dt> 3. З моменту набрання чинності даного правочину сторони не вважають себе  пов’язаними будь-якими правами і зобов’язаннями за Договором № <%= rs.getString("number")%>  про <%=rs.getString("type_join")%>   до електричних мереж  від <%= rs.getString("date_contract")%> року.</dt></div>
            <p>&nbsp;</p>
            <p align="center">&nbsp;</p>
            <p align="center">&nbsp;</p>
            <%if(rs.getString("type_join2").equals("1")){%>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="355" valign="top"><span>Виконавець послуг :</span></td>
                    <td width="355" valign="top"><span>Замовник:</span></td>
                </tr>
                <tr>
                    <td width="400" valign="top"><p>АТ«Прикарпаттяобленерго»<br>
                        Філія “<u><%= rs.getString("rem_name")%></u> РЕМ”<br>
                        <u><%=rs.getString("rem_licality")%></u><br>
                            <%=rs.getString("rek_bank").substring(0, rs.getString("rek_bank").indexOf(','))%><br>
                        <%if (rs.getString("rek_bank").indexOf(",   Б") != -1) {%>
                            <%=rs.getString("rek_bank").substring(rs.getString("rek_bank").indexOf(",   Б") + 1, rs.getString("rek_bank").indexOf(",   М"))%><%}%>
                        <%if (rs.getString("rek_bank").indexOf(",   І") != -1) {%>
                            <%=rs.getString("rek_bank").substring(rs.getString("rek_bank").indexOf(",   І") + 1, rs.getString("rek_bank").indexOf(",   М"))%><%}%><br>
                            <%=rs.getString("rek_bank").substring(rs.getString("rek_bank").indexOf(",   М") + 1, rs.getString("rek_bank").indexOf(",  к"))%><br>
                            <%=rs.getString("rek_bank").substring(rs.getString("rek_bank").indexOf(",  к") + 1, rs.getString("rek_bank").indexOf('.'))%><br>
                            <%= rs.getString("contacts")%><br>
                        Директор    філії АТ«Прикарпаттяобленерго»<br>
                        “<%= rs.getString("rem_name")%> РЕМ”<br>
                    </p></td>
                    <td width="355" valign="top"><%if (rs.getString("customer_type").equals("1")) {%><u><%if (!rs.getString("customer_soc_status").equals("9")
                            && !rs.getString("customer_soc_status").equals("12")) {%> <%= rs.getString("customer_soc_status2")%><br><%}%><%= rs.getString("name2")%></u>
                        <br>
                        <u><%=rs.getString("type_c")%> <%= rs.getString("customer_adress")%></u><br>
                        р/р <%= rs.getString("bank_account")%> МФО <%= rs.getString("bank_mfo")%><br>

                        Код ЄДРПОУ    <%= rs.getString("bank_identification_number")%><br>
                        Свідоцтво платника ПДВ №________________<br>
                        Індивідуальний податковий №________________<br>
                        <%} else {%>
                        <u><%=rs.getString("PIP")%></u><br>
                            <%=rs.getString("type_c")%> <%=rs.getString("customer_adress")%><br>
                            <%--<strong><u><%=rs.getString("constitutive_documents").substring(0,rs.getString("constitutive_documents").indexOf("виданий"))%></u></strong><br>
                            <strong><u><%=rs.getString("constitutive_documents").substring(rs.getString("constitutive_documents").indexOf("виданий"))%></u> </strong><br>--%>
                            <%=rs.getString("constitutive_documents")%><br>
                        Ідентифікаційний код <%=rs.getString("bank_identification_number")%><br>

                        Громадянин (ка)<br><br>
                        <%}%>
                        тел: __________________<br><%=rs.getString("customer_post")%><br>
                    </td>
                </tr>
                <tr>
                    <td>________________        <u><%=rs.getString("Director")%></u><br>
                                (підпис)                              (П.І.Б.)<br>_____________________20___ року</td>

                    <td>_______________       <u><%=rs.getString("PIP")%></u><br>
                                   (підпис)                        (П.І.Б.)<br>_____________________20___ року</td>
                </tr>
            </table><%} else { %>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="355" valign="top"><span>Виконавець послуг :</span></td>
                    <td width="355" valign="top"><span>Замовник:</span></td>
                </tr>
                <tr>
                    <td width="328" valign="top"><p>АТ«Прикарпаттяобленерго»<br>
                        <u>м. Івано-Франківськ, вул. Індустріальна, 34</u><br>
                        <% if ((rs.getString("type_join2").equals("1")) || (rs.getString("type_join2").equals("2"))) { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р <% if (rs.getString("type_join2").equals("1")) { %>26000011732450 <%} else { %> 26003011732479 <% } %> в Івано-Франківське відділення №340 АТ«Укрсоцбанк»<br>
                        Код МФО 300023<br>
                        <% } else { %>
                        Код ЄДРПОУ 00131564<br>
                        п/р 26009305757  в філії Івано-Франківське обласне управління АТ «Ощадбанк»<br>
                        Код МФО 336503 <br>
                        <% } %>
                        Технічний директор<br> АТ«Прикарпаттяобленерго»<br>
                    </p></td>
                    <td width="355" valign="top"><%if (rs.getString("customer_type").equals("1")) {%><u><%if (!rs.getString("customer_soc_status").equals("9")
                            && !rs.getString("customer_soc_status").equals("12")) {%> <%= rs.getString("customer_soc_status2")%><br><%}%><%= rs.getString("name2")%></u>
                        <br>
                        <u><%=rs.getString("type_c")%> <%= rs.getString("customer_adress")%></u><br>
                        р/р <%= rs.getString("bank_account")%> МФО <%= rs.getString("bank_mfo")%><br>

                        Код ЄДРПОУ    <%= rs.getString("bank_identification_number")%><br>
                        Свідоцтво платника ПДВ №________________<br>
                        Індивідуальний податковий №________________<br>
                        <%} else {%>
                        <u><%=rs.getString("PIP")%></u><br>
                            <%=rs.getString("type_c")%> <%=rs.getString("customer_adress")%><br>
                            <%--<strong><u><%=rs.getString("constitutive_documents").substring(0,rs.getString("constitutive_documents").indexOf("виданий"))%></u></strong><br>
                            <strong><u><%=rs.getString("constitutive_documents").substring(rs.getString("constitutive_documents").indexOf("виданий"))%></u> </strong><br>--%>
                            <%=rs.getString("constitutive_documents")%><br>
                        Ідентифікаційний код <%=rs.getString("bank_identification_number")%><br>

                        Громадянин (ка)<br><br>
                        <%}%>
                        тел: __________________<br><%=rs.getString("customer_post")%><br>
                    </td>
                </tr>
                <tr>
                    <td>________________        <u>Сеник Олег Степанович </u><br>
                                (підпис)                              (П.І.Б.)<br>_____________________20___ року</td>

                    <td>_______________       <u><%=rs.getString("PIP")%></u><br>
                                   (підпис)                        (П.І.Б.)<br>_____________________20___ року</td>
                </tr>
            </table><%}%>
            <p>&nbsp;</p>
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