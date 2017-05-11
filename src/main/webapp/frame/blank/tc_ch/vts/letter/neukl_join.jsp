<%-- 
    Document   : neukl
    Created on : 14 квіт 2011, 12:18:14
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
                + ",isnull(TC_V2.juridical,'') as juridical"
                + ",isnull(soc_status.name,'') as customer_soc_status1"
                + ",isnull(TC_V2.customer_soc_status,'') as customer_soc_status"
                + ",CASE WHEN TC_V2.customer_type=1 and TC_V2.customer_soc_status<>15 and TC_V2.customer_soc_status<>11 and TC_V2.customer_soc_status<>9 and  TC_V2.customer_soc_status<>12 and  TC_V2.customer_soc_status<>8"
                + "THEN  '\"" + "'+isnull(TC_V2.juridical,'')" + "+'\"' "
                + "WHEN TC_V2.customer_type=1 and (TC_V2.customer_soc_status=15 or TC_V2.customer_soc_status=11 or TC_V2.customer_soc_status=12 or               TC_V2.customer_soc_status=9 or TC_V2.customer_soc_status=8)"
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
                + ",isnull(convert(varchar,TC_V2.date_customer_contract_tc,104),'___.___.2013р.') as date_customer_contract_tc"
                + ",case when cusadr.type=1 then 'м.'"
                + "     when cusadr.type=2 then 'с.'"
                + "     when cusadr.type=3 then 'смт.' end as type_c"
                + ", case when nullif(TC_V2.[customer_adress],'') is null then"
                + "         isnull(cusadr.name,'')"
                + "     else isnull(cusadr.name,'')+', вул. '+ isnull(TC_V2.[customer_adress],'') end as customer_adress"
                + ",isnull(TC_V2.[bank_account],'') as [bank_account]"
                + ",isnull(TC_V2.[bank_mfo],'') as [bank_mfo]"
                + ",isnull(TC_V2.[bank_identification_number],'') as [bank_identification_number]"
                + ",isnull(TC_V2.[connection_treaty_number],'') as [connection_treaty_number] "
                + ",[rem_name] "
                + ",[Director] "
                + ",[director_rod]"
                + ",[dovirenist]"
                + ",[contacts] "
                + ",[rek_bank] "
                + ",[rem_licality] "
                + ",[golovnyi_ingener] "
                + ",[director_dav] "
                + ",[vykonavets] "
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
        <style>
            p {margin-top: 0 ; margin-bottom: 0; } 
        </style>
        <title>JSP Page</title>
        <jsp:include page="../../../word_page_format_letter.jsp"/>
    </head>
    <body>
        <div class="Section1">
            <%if (rs.getString("customer_soc_status").equals("1") || rs.getString("customer_soc_status").equals("6")) {%>
            <strong><%=rs.getString("customer_soc_status1")%></strong><br>
            <strong>п. <%=rs.getString("PIP")%></strong><%}%>
            <%if (rs.getString("customer_soc_status").equals("2") || rs.getString("customer_soc_status").equals("3") || rs.getString("customer_soc_status").equals("4") || rs.getString("customer_soc_status").equals("5") || rs.getString("customer_soc_status").equals("14") || rs.getString("customer_soc_status").equals("16")) {%>
            <strong><%=rs.getString("customer_post")%>&nbsp;<%=rs.getString("customer_soc_status1")%>&nbsp; "<%=rs.getString("juridical")%>"</strong><br>
            <strong>п. <%=rs.getString("PIP")%></strong><%}%>
            <%if (rs.getString("customer_soc_status").equals("11") || rs.getString("customer_soc_status").equals("15")) {%>
            <strong><%=rs.getString("customer_soc_status1")%></strong><br>
            <strong>п. <%=rs.getString("PIP")%></strong><%}%>
            <%if (rs.getString("customer_soc_status").equals("7") || rs.getString("customer_soc_status").equals("8") || rs.getString("customer_soc_status").equals("9") || rs.getString("customer_soc_status").equals("10") || rs.getString("customer_soc_status").equals("12") || rs.getString("customer_soc_status").equals("13")) {%>
            <strong><%=rs.getString("customer_post")%><br><%=rs.getString("juridical")%></strong><br>
            <strong>п. <%=rs.getString("PIP")%></strong><%}%>
            <br><%=rs.getString("type_c")%><%=rs.getString("customer_adress")%><br>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>Про не укладення договору</p>
            <p>&nbsp;</p>
            <div style="text-align:justify;"><p style="text-indent: 40px"><%= rs.getString("date_customer_contract_tc")%> року  енергопередавальною компанією запропоновано до укладення та підписання Вам  проект договору про стандартне приєднання. </p>
                <p style="text-indent: 40px">Водночас, у  проекті договору встановлений 20-денний строк для прийняття пропозиції та  підписання договору. У разі наявності заперечень  до умов отриманого проекту договору у цей же  строк Вам слід було оформити та надіслати протокол розбіжностей чи повідомити  АТ&quot;Прикарпаттяобленерго&quot; про відмову від укладення договору.</p>
                <p style="text-indent: 40px">Таким чином, враховуючи, що Вами не дотримано встановленого порядку, та  керуючись ст. 643 Цивільного кодексу України, та відповідно до 8.2 проекту  договору, енергопередавальна компанія вважає себе вільною від зробленої  пропозиції, договір про стандартне приєднання вважається неукладеним (таким, що  не відбувся), про що і повідомляємо Вас.</p></div>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p><strong>Директор  філії</strong><br>
                АТ «Прикарпаттяобленерго»<br>
                <%= rs.getString("rem_name")%> РЕМ<strong></strong><br>
                <strong><%= rs.getString("Director")%></strong></p>
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