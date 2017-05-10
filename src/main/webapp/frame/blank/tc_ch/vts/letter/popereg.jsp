<%-- 
    Document   : popereg
    Created on : 6 вер 2011, 12:33:33
    Author     : asupv
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
                + ",isnull(TC_V2.input_number_application_vat,'____') as input_number_application_vat"
                + ",isnull(convert(varchar,TC_V2.registration_date),'__.__.____') as registration_date"
                + ",TC_V2.customer_type"
                + ",isnull(soc_status.full_name,'') as customer_soc_status"
                + ",CASE WHEN TC_V2.customer_type=1"
                + "THEN isnull(TC_V2.juridical,'')"
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
                + ",case when cusadr.name is not null then "
                + "         isnull(cusadr.name,'')+', вул. '+ isnull(TC_V2.[customer_adress],'') "
                + "     when cusadr.name is null then isnull(TC_V2.[customer_adress],'') end as customer_adress "
                + ",isnull(TC_V2.[bank_account],'') as [bank_account]"
                + ",isnull(TC_V2.[bank_mfo],'') as [bank_mfo]"
                + ",isnull(TC_V2.[bank_identification_number],'') as [bank_identification_number]"
                + ",isnull(TC_V2.[connection_treaty_number],'') as [connection_treaty_number] "
                + ",isnull(ch.No_letter,'') as No_letter "
                + ",isnull(convert(varchar,ch.Tc_continue_to,104),'________________________') as Tc_continue_to "
                + ",isnull(convert(varchar,ch.Change_date_tc,104),'________________________') as Change_date_tc "
                + ",isnull(ch.Description_change,'') as Description_change "
                + ",case when (ch.type_letter=3 or ch.type_letter=4) and ch.Tc_continue_to is not null "
                + "         then isnull(convert(varchar,ch.Tc_continue_to,104),'__.__.____')  "
                + "     else isnull(convert(varchar,TC_V2.end_dohovoru_tu,104),'__.__.____') end as kinec "
                + ",[rem_name] "
                + ",[Director] "
                + ",[director_rod]"
                + ",[dovirenist]"
                + ",[contacts] "
                + ",[rek_bank] "
                + ",[rem_licality] "
                + ",[golovnyi_ingener] "
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
            <table width="100%">
                <tr><td width="50%">&nbsp; </td>
                    <td><p><strong>Філія  АТ«Прикарпаттяобленерго»</strong><br>
                            <strong>«<%= rs.getString("rem_name")%>»  РЕМ</strong></p>
                        <p><%=rs.getString("rem_licality")%></p>
                        <p><strong>№<%=rs.getString("No_letter")%> дата <%=rs.getString("Change_date_tc")%></strong></p> </td></tr>
            </table>

            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <table>
                <tr><td><strong><%=rs.getString("name")%></strong></td></tr>
                <tr><td><strong><%=rs.getString("customer_adress")%></strong></td></tr>
            </table>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>У зв’язку з закінченням <%= rs.getString("kinec")%> року строку дії договору № <%= rs.getString("number")%>  від <%= rs.getString("date_contract")%> року про приєднання надання доступу до електричних мереж (<%= rs.getString("object_name")%>),
                що знаходиться за адресою <%= rs.getString("object_adress")%>, просимо Вас в 5 денний термін з  дати отримання даного повідомлення з’явитися в філію АТ«Прикарпаттяобленерго» &quot; <strong><em><%= rs.getString("rem_name")%> РЕМ&quot;</em></strong> для впорядкування відносин між нашими сторонами.<br>
                За довідкою телефонувати за номером <%=rs.getString("contacts")%>,  <strong><em>виробничо-технічна група &quot;<%= rs.getString("rem_name")%> РЕМ</em></strong>&quot;. </p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p><strong><em>З повагою,</em></strong><br>
                <strong><em>Директор філії                                                          <%= rs.getString("Director")%> </em></strong></p>
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
