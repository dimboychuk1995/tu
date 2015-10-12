<%-- 
    Document   : roz
    Created on : 12 квіт 2011, 10:21:15
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
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
                + ",TC_V2.customer_type"
                + ",isnull(soc_status.full_name,'') as customer_soc_status"
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
                + "from TC_V2 "
                + " left join Changestc ch on ch.id_tc=TC_V2.id"
                + " left join [TC_LIST_locality] objadr on objadr.id=TC_V2.name_locality"
                + " left join [TC_LIST_locality] cusadr on cusadr.id=TC_V2.customer_locality"
                + " left join [TUweb].[dbo].[TC_LIST_customer_soc_status] soc_status on soc_status.id=TC_V2.customer_soc_status "
                + " left join [TUweb].[dbo].[rem] rem on TC_V2.department_id=rem.rem_id "
                + " left join TC_V2 TC_O on TC_V2.main_contract=TC_O.id "
                + " left join SUPPLYCH on SUPPLYCH.tc_id=TC_V2.id "
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
        <title>JSP Page</title>
        <jsp:include page="../../../word_page_format.jsp"/>
    </head>
    <body>
        <div class="Section1">
            <p><strong><%= rs.getString("customer_soc_status")%> <%= rs.getString("name")%></strong><br>
                <u>п</u>.<%= rs.getString("PIP")%><br>
                <%=rs.getString("customer_adress")%></p>

            <p>&nbsp;</p>
            <p>Копія: <br>
                <strong>Директору  філії </strong><br>
                <strong>ПАТ  «Прикарпаттяобленерго»</strong><br>
                <strong><%= rs.getString("rem_name")%></strong><br>
                <strong>п.<%= rs.getString("director_dav")%></strong></p>
            <p><strong>&nbsp;</strong></p>
            <p>Про розірвання договору</p>
            <p>&nbsp;</p>
            <p style="text-align:justify;text-indent:20pt">Між  ПАТ «Прикарпаттяобленерго» та <%= rs.getString("name")%> укладено Договір № <%= rs.getString("number")%>
                від <%= rs.getString("date_contract")%> року про надання доступу до електричних мереж.</p>
            <p style="text-align:justify;text-indent:20pt">Згідно  з умовами Договору  № <%= rs.getString("number")%>  від <%= rs.getString("date_contract")%> року п. 2.1.1,
                Наше товариство розробило та направило Вам (лист вих. № ________________ від _________року) кошторисну
                документацію, Протокол погодження кошторисної вартості створення технічної  можливості доступу (далі – Протокол) та
                Графік оплати за надання послуги зі  створення технічної можливості доступу (далі – Графік).
                Станом  на ________року від Вас не поступало жодної відповіді на лист вих. № _________від ____________року та не повернуті підписані Протокол та  Графік.</p>
            <p style="text-align:justify;text-indent:20pt">  Враховуючи  вищенаведене пропонуємо розірвати даний Договір № <%= rs.getString("number")%>
                від <%= rs.getString("date_contract")%> року.  Для цього надсилаємо Вам проект Додаткового правочину 
                № П-<%= rs.getString("No_letter")%> про розірвання договору про надання доступу до електричних мереж № <%= rs.getString("number")%>
                від <%= rs.getString("date_contract")%> року. </p>
            <p style="text-align:justify;text-indent:20pt"> У разі згоди з умовами  Додаткового правочину, прошу у двадцятиденний термін повернути на нашу адресу, оформлений  належним чином Додатковий правочин.</p>
            <p style="text-align:justify">Додаток: Додатковий правочин № П-<%= rs.getString("No_letter")%> про розірвання договору про  надання доступу до електричних мереж № __________від _____________року (у 2  прим., на 2 арк.).</p>
            <p>&nbsp;</p>
            <p><strong>О.  C. Сеник</strong><br>
                <strong>Технічний  директор</strong></p>

            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p align="center"><strong>ДОДАТКОВИЙ  ПРАВОЧИН № П-<%= rs.getString("No_letter")%> </strong><br>
                про розірвання договору про надання  доступу<br>
                до електричних мереж № <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> р.</p>
            <p align="center">&nbsp;</p>
            <table width="100%"> <tr><td width="50%">м. Івано-Франківськ</td><td align="right">“___”_____________ 2013 року</td></tr></table>
            <p><strong>Публічне акціонерне товариство «Прикарпаттяобленерго»</strong>, надалі ― <strong>Власник</strong>, в особі технічного директора  ПАТ «Прикарпаттяобленерго» Сеника Олега Степановича, який діє на підставі  довіреності № 653 від 29.03.2013 року, з однієї сторони, та <strong><%= rs.getString("customer_soc_status")%><%= rs.getString("name")%></strong>,  надалі ― <strong>Замовник</strong>, який діє на підставі <%= rs.getString("constitutive_documents")%>,  з іншої сторони, далі ― Сторони, уклали даний Додатковий правочин про наступне:</p>
            <ol>
                <li>Сторони дійшли згоди розірвати Договір про надання  доступу до електричних мереж № <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> р.</li>
                <li>З моменту набрання чинності даного Додаткового  правочину сторони не вважають себе пов’язаними  будь-якими правами і зобов’язаннями за Договором про  надання доступу до електричних мереж  № <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> р.</li>
                <li>Даний Додатковий правочин  укладено у двох примірниках, з яких перший  примірник зберігається у Власника мереж, другий зберігається у Замовника.</li>
                <li>Даний Додатковий правочин  набуває чинності з моменту підписання його сторонами.</li>
            </ol>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p align="center">&nbsp;</p>
            <p align="center">&nbsp;</p>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="355" valign="top"><p><strong>Власник мереж:</strong></p></td>
                    <td width="355" valign="top"><p><strong>Замовник:</strong></p></td>
                </tr>
                <tr>
                    <td width="355" valign="top"><p><strong>ПАТ    «Прикарпаттяобленерго»</strong></p>
                        <p>м. Івано-Франківськ, вул.    Індустріальна, 34<br>
                            р/р 26003301757 МФО 336503<br>
                            Філія Івано-Франківського ОУ АТ<br>АТ «Ощадбанк»<br>
                            Код ЄДРПОУ 00131564<br>
                            тел./факс: 594451</p>
                        <p><strong>Технічний директор </strong><br>
                            <strong>ПАТ «Прикарпаттяобленерго»</strong><strong> </strong></p></td>
                    <td width="350" valign="top"><font size="-1"><strong><%= rs.getString("customer_soc_status")%><%= rs.getString("name")%></strong></font><br>
                        <font size="-1"><strong><u><%=rs.getString("type_c")%> <%= rs.getString("customer_adress")%></u></strong><br>
                            р/р <%=rs.getString("bank_account")%>МФО <%= rs.getString("bank_mfo")%> <br>
                            ___________________________<br>
                            Код ЄДРПОУ <%= rs.getString("bank_identification_number")%> <br>
                            Свідоцтво платника ПДВ № ______________________<br>
                            Індивідуальний податковий № _____________________</font><br>
                        <strong><u><%= rs.getString("customer_post")%></u></strong><br />
                    </td>
                </tr>
                <tr>
                    <td>________________ <strong>О. С. Сеник</strong></td>
                    <td><font size="-1"><strong>____________________<%= rs.getString("PIP")%></strong><br>
                            <strong>                 (підпис)                                (П.І.Б.)</strong></font></td>


                </tr>
            </table>
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
