<%-- 
    Document   : zmin
    Created on : 12 квіт 2011, 10:21:34
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
    String db;
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
                + ",TC_V2.customer_type"
                + ",isnull(soc_status.full_name,'') as customer_soc_status"
                + ",CASE WHEN TC_V2.customer_type=1 and TC_V2.customer_soc_status<>15 and TC_V2.customer_soc_status<>11 and TC_V2.customer_soc_status<>9"
                + " THEN  '\"" + "'+isnull(TC_V2.juridical,'')" + "+'\"' "
                + " WHEN TC_V2.customer_type=1 and (TC_V2.customer_soc_status=15 or TC_V2.customer_soc_status=11) "
                + " THEN  isnull(TC_V2.juridical,'') "
                + " WHEN TC_V2.customer_type=0 "
                + " THEN isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'') "
                + " ELSE '_______' end as [name] "
                + ",isnull(nullif(TC_V2.constitutive_documents,''),'__________') as constitutive_documents"
                + ",isnull(nullif(TC_V2.customer_post,''),'__________') as customer_post"
                + ",isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'') as PIP"
                + ",isnull(TC_V2.[object_name],'') as object_name"
                + ",isnull(convert(varchar,TC_V2.date_contract,104),'') as date_contract "
                + ",isnull(convert(varchar,TC_V2.date_customer_contract_tc,104),'___.___.2013р.') as date_customer_contract_tc "
                + ",case when cusadr.type=1 then 'м.' "
                + "     when cusadr.type=2 then 'с.' "
                + "     when cusadr.type=3 then 'смт.' "
                + "     else '' end as type_o "
                + ",case when nullif(TC_V2.[object_adress],'') is not null and objadr.name is not null then "
                + "         isnull(objadr.name,'')+', вул.'+ isnull(TC_V2.[object_adress],'') "
                + "     when nullif(TC_V2.[object_adress],'') is not null and objadr.name is null then "
                + "         isnull (TC_V2.[object_adress],'')"
                + "     else isnull(objadr.name,'') end as object_adress"
                + ",isnull(convert(varchar,TC_V2.date_contract,104),'') as date_contract"
                + ",isnull(convert(varchar,TC_V2.date_customer_contract_tc,104),'___.___.2013р.') as date_customer_contract_tc"
                + ",case when cusadr.type=1 then 'м.'"
                + "     when cusadr.type=2 then 'с.'"
                + "     when cusadr.type=3 then 'смт.' end as type_c"
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
                + ",isnull(convert(varchar,ch.send_date_lenner,104),'') as send_date_lenner "
                + ",isnull(convert(varchar,ch.Tc_continue_to,104),'') as Tc_continue_to "
                + ",isnull(convert(varchar,ch.send_date_lenner,104),'') as send_date_lenner "
                + ",[rem_name] "
                + ",[Director] "
                + ",[director_rod]"
                + ",[dovirenist]"
                + ",[contacts] "
                + ",[rek_bank] "
                + ",[rem_licality] "
                + ",[golovnyi_ingener] "
                + ",[director_dav] "
                + ",isnull(TC_V2.type_join,0) as join_type"
                + ",isnull(tj.name,'надання доступу') as type_join"
                + ",case TC_V2.type_join "
                + "when 1 then 'Виконавець послуг'"
                + "when 2 then 'Виконавець послуг'"
                + "else 'Власник мереж' end as type_join_owner"
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
        <title>JSP Page</title>
        <jsp:include page="../../../word_page_format.jsp"/>
    </head>
    <body>
        <div class="Section1">
            <p align="center"><strong>Додатковий правочин № </strong><strong>П-<%= rs.getString("No_letter")%></strong><br>
                до Договору про <%= rs.getString("type_join")%> до  електричних мереж<br>
                № <%= rs.getString("number")%> від <%= rs.getString("date_customer_contract_tc")%></p><p>&nbsp;</p>
            <p><table width="100%"><tr><td width="50%" height="25">м. Івано-Франківськ</td>
                    <td align="right">“_____”______________ 20____ р.</td></tr></table></p>
        <p>&nbsp;</p>
        <p style="text-align:justify; text-indent:20pt">ПАТ “Прикарпаттяобленерго”, що  діє за умовами та правилами Ліцензії 
            АБ №  177333 (далі – <%=rs.getString("type_join_owner")%>), в особі Технічного директора ПАТ  «Прикарпаттяобленерго» Сеника Олега 
            Степановича, який діє на підставі  довіреності № 816 від 11.08.2014 року, з однієї сторони, та 
            <%= rs.getString("customer_soc_status")%> <%= rs.getString("name")%>, 

            надалі ― <strong>Замовник</strong>,  
            <%if ((!rs.getString("customer_soc_status_1").equals("15")
                        && !rs.getString("customer_soc_status_1").equals("11")) && (rs.getString("customer_type").equals("1"))) {%>
            в особі <strong><%= rs.getString("customer_post")%>&nbsp;<%= rs.getString("PIP")%></strong>,
            <%}
                if (rs.getString("customer_type").equals("1")) {%>
            який 
            діє на  підставі 
            <%}%> <strong><u><%= rs.getString("constitutive_documents")%></u></strong>, з іншої  сторони, 
            (далі – Сторони), враховуючи заяву Замовника від <%= rs.getString("send_date_lenner")%>,  домовились про наступне: </p>
        <p style="text-align:justify; text-indent:20pt">Продовжити термін дії Договору про  <%= rs.getString("type_join")%> до електричних мереж
            № <%= rs.getString("number")%> від <%= rs.getString("date_customer_contract_tc")%> (<%=rs.getString("object_name")%> <%=rs.getString("type_o")%> 
            <%=rs.getString("object_adress")%>) з <%=rs.getString("send_date_lenner")%> до завершення будівництва об’єкту архітектури 
            <%if (!rs.getString("Description_change").equals("")) {%> зі змінами, а саме:</p>
        <p style="text-align:justify; text-indent:20pt"><strong><%= rs.getString("Description_change")%></strong></p><%} else {%>без змін.</p><%}%>
    <p style="text-align:justify; text-indent:20pt">Умови даного  Додаткового правочину до Договору не змінюють умови 
        основного  Договору відносно інших обов’язків Сторін і є його невід′ємною частиною.</p>
    <p style="text-align:justify;text-indent:20pt">Даний  Додатковий  правочин  до  Договору  складено  у  двох 
        примірниках  по  одному  для  кожної  із  сторін.</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <%if (!rs.getString("join_type").equals("1")) {%>
    <table border="0" cellspacing="0" cellpadding="0" width="672">
        <tr>
            <td width="358" valign="top"><p><strong><%=rs.getString("type_join_owner")%></strong><strong>:</strong></p>
            <td width="400" valign="top"><p><strong>Замовник:</strong></p></td>
        </tr>
        <tr>
            <td>
                <p><strong>ПАТ    «Прикарпаттяобленерго»</strong><br>
                    м. Івано-Франківськ, вул. Індустріальна 34 <br>
                    р/р 26003301757 МФО 336503<br>
                    Філія Івано-Франківського ОУ АТ<br>АТ «Ощадбанк»<br>
                    Код ЄДРПОУ 00131564<br>
                    тел/факс: 594451 </p>
                <p><strong>Технічний директор </strong><br>
                    <strong>ПАТ    «Прикарпаттяобленерго»</strong></p>
            </td>
            <td width="350" valign="top"><strong><%= rs.getString("customer_soc_status")%><%= rs.getString("name")%></strong><br>
                <strong><%= rs.getString("customer_adress")%></strong><br>
                р/р <%=rs.getString("bank_account")%> МФО <%= rs.getString("bank_mfo")%> <br>
                ___________________________<br>
                Код ЄДРПОУ <%= rs.getString("bank_identification_number")%> <br>
                Свідоцтво платника ПДВ № ______________________<br>
                Індивідуальний податковий № _____________________<br>
                <br>
                <br></td>
        </tr>
        <tr>
            <td><strong>_______________ Сеник Олег <br>Степанович</strong></td><br>
        <td><strong>____________________ <%= rs.getString("PIP")%></strong><br>
            <strong>                </strong></td>
        </tr>
    </table><%} else{%>
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="400" valign="top"><p><strong>Електропередавальна організація:</strong></p></td>
            <td width="400" valign="top"><p><strong>Замовник:</strong></p></td>
        </tr>
        <tr>
            <td width="400" valign="top"><p>ПАТ «Прикарпаттяобленерго»<br>
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
                    Директор    філії ПАТ «Прикарпаттяобленерго»<br>
                    “<%= rs.getString("rem_name")%> РЕМ”<br>
                </p></td>
            <td width="400" valign="top"><p><u><%=rs.getString("PIP")%></u></p>
                <p><u><%=rs.getString("customer_adress")%></u><br>
                    <%--<strong><u><%=rs.getString("constitutive_documents").substring(0,rs.getString("constitutive_documents").indexOf("виданий"))%></u></strong><br>
<strong><u><%=rs.getString("constitutive_documents").substring(rs.getString("constitutive_documents").indexOf("виданий"))%></u> </strong><br>--%>
                    <%=rs.getString("constitutive_documents")%><br>
                    Ідентифікаційний код <%=rs.getString("bank_identification_number")%><br>
                    <br><br><br>
                    Громадянин (ка)<br>
                </p></td>
        </tr>
        <tr>
            <td>_________________    <%=rs.getString("Director")%></td>
            <td>_________________    <%=rs.getString("PIP")%></td>
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
