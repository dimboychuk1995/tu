<%-- 
    Document   : vidmova
    Created on : 31 серп 2011, 15:25:56
    Author     : asupv
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
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
                + ",isnull(TC_V2.input_number_application_vat,'____') as input_number_application_vat"
                + ",isnull(convert(varchar,TC_V2.registration_date),'__.__.____') as registration_date"
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
                + "     when objadr.type=3 then 'смт.' end as type_o"
                + ",case when nullif(TC_V2.[object_adress],'') is not null and objadr.name is not null then "
                + "         isnull(objadr.name,'')+', вул.'+ isnull(TC_V2.[object_adress],'') "
                + "     when objadr.name is null then "
                + "         isnull(TC_V2.[object_adress],'')"
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
                + ",isnull(convert(varchar,ch.Tc_continue_to,104),'____________________') as Tc_continue_to "
                + ",isnull(convert(varchar,ch.send_date_lenner,104),'__________________') as send_date_lenner "
                + ",[rem_name] "
                + ",[Director] "
                + ",[director_rod]"
                + ",[dovirenist]"
                + ",[contacts] "
                + ",[rek_bank] "
                + ",[rem_licality] "
                + ",[golovnyi_ingener] "
                + ",[director_dav] "
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
        <jsp:include page="../../../word_page_format_letter.jsp"/>
    </head>
    <body>
        <div class="Section1">
            <p><%= rs.getString("name")%><br>
                <%=rs.getString("customer_adress")%></p>

            <p>&nbsp;</p>
            <p>Копія: <br>
                <strong>Директору  філії </strong><br>
                <strong>ПАТ  «Прикарпаттяобленерго»</strong><br>
                <strong><%= rs.getString("rem_name")%></strong><br>
                <strong>п. <%= rs.getString("director_dav")%></strong></p>
            На лист № <%= rs.getString("No_letter")%> від <%= rs.getString("send_date_lenner")%><br>
            ПАТ «Прикарпаттяобленерго»  розглянуло Ваше звернення щодо продовження терміну дії технічних умов № <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> на електропостачання <%= rs.getString("object_name")%> та повідомляє наступне. Термін дії технічних  умов № <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> вже закінчився, тому дані технічні умови  вважаються такими, що втратили свою чинність. <br>
            Враховуючи вищезазначене, для отримання нових технічних умов Вам потрібно  звернутися у філію «<%= rs.getString("rem_name")%> РЕМ» ПАТ «Прикарпаттяобленерго» (<%= rs.getString("rem_licality")%>) із  наступними документами: <br>
            1.  Заява на видачу технічних умов.<br>
            2.  Підписаний  проектувальною організацією Опитувальний лист складений за типовою формою.<br>
            3.  Інженерна характеристика об’єкта.<br>
            4. Копія свідоцтва про державну реєстрацію фізичної  особи-підприємця.<br>
            5. Копії  документів, якими підтверджується право власності або користування на об’єкт  Замовника, або за відсутності об’єкта на право власності чи користування земельною ділянкою.<br>
            6. Копія містобудівних умов і обмежень забудови земельної  ділянки або за умови їх відсутності копія дозволу на виконання проектно-вишукувальних  робіт, отриманого у встановленому порядку до 29.05.2009 р. (для новозбудованих  об’єктів, які вводяться в експлуатацію вперше).<br>
            7. Викопіювання з генерального або ситуаційного плану  відповідної території, із зазначенням місця розташування об’єкта архітектури.<br>
            8. Копія квитанції про оплату за видачу технічних умов.<br>
            9. У разі представлення інтересів Замовника іншою особою,  копія належним чином оформленої довіреності на особу, яка уповноважена  підписувати договори про надання доступу до електричних мереж .<br>
            10. Копія  паспорту Замовника або особи уповноваженої підписувати договір про приєднання.<br>
            11. Копія  довідки про взяття на облік платника ПДВ (при наявності). <br>
            12. У випадку, коли майно знаходиться у спільній власності  кількох осіб, то необхідно отримати письмове доручення всіх співвласників про  те, що вони доручають або не заперечують відповідному замовнику укласти договір  про надання доступу до електричних мереж ПАТ «Прикарпаттяобленерго»</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p><strong>О. С. Сеник</strong><br>
                <strong>Технічний директор</strong></p>
            <p><strong>&nbsp;</strong></p>
            Виконавець:<p>Виконавець:<bean:write name="log" property="PIP"/>
                <br>
                <bean:write name="log" property="tel_number"/></p>
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
