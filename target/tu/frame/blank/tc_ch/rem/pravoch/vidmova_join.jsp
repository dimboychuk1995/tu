
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
                + ",isnull(convert(varchar,TC_V2.registration_date,104),'') as registration_date"
                + ",TestDB.dbo.count_date_15_day(TC_V2.registration_date) as day_15"
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
                + ",isnull(ch.description_change,'') as description_change "
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
        <jsp:include page="../../../word_page_format.jsp"/></head>
    <body>
        <div align="right" style="margin-bottom:5px;">ОП 4.1-К</div>
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
        <p>&nbsp;</p>
        <div style="text-align:justify;">
            <p style="text-indent: 40px">Філія ПАТ «Прикарпаттяобленерго» «<%= rs.getString("rem_name")%> РЕМ», отримала Вашу заяву <%= rs.getString("registration_date")%> року, щодо приєднання електроустановок <%= rs.getString("object_name")%>, що знаходяться за адресою: <%= rs.getString("object_adress")%>, до мереж ПАТ «Прикарпаттяобленерго».</p>
            <p style="text-indent: 40px">
                При визначенні типу приєднання, встановлено, що приєднання Ваших електроустановок відноситься до нестандартного приєднання, а саме:</p> 
            <p style="text-indent: 40px"><%=rs.getString("description_change")%></p>
            <p style="text-indent: 40px">Просимо Вас звернутися у філію ПАТ «Прикарпаттяобленерго» «<%= rs.getString("rem_name")%> РЕМ» <strong><%= rs.getString("day_15")%></strong> року, що знаходиться за адресою: <%= rs.getString("rem_licality")%> для отримання проекту договору про нестандартне приєднання та технічних умов.</p>
            <p style="text-indent: 40px">У разі відмови від приєднання, яке не є стандартним, просимо письмово повідомити про це філію ПАТ «Прикарпаттяобленерго» до <strong><%= rs.getString("day_15")%></strong> року. </p> </div>
        <p>&nbsp;</p>

        <strong>З поваю, <br/>
            Директор філії<br>
            “<%= rs.getString("rem_name")%> РЕМ” <br/>
            <%=rs.getString("Director")%></strong>




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