<%--
    Document   : fiz
    Created on : 31 бер 2011, 14:28:00
    Author     : asupv
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%
    HttpSession ses = request.getSession();
    String db = new String();
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
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
                + ",isnull(soc_status.full_name,'') as customer_soc_status"
                + ",CASE WHEN TC_V2.customer_type=1 THEN isnull(TC_V2.juridical,'')"
                + "     WHEN TC_V2.customer_type=0 THEN isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'')"
                + "ELSE '' end as [name]"
                + ",isnull(TC_V2.constitutive_documents,'') as constitutive_documents"
                + ",isnull(TC_V2.customer_post,'') as customer_post"
                + ",isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'') as PIP"
                + ",isnull(TC_V2.[connection_treaty_number],'') as [connection_treaty_number] "
                + ",isnull(TC_V2.voltage_class,'') as voltage_class "
                + ",isnull(TC_V2.request_power,0.00) as request_power"
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
                + ",isnull(TC_V2.do1,'') as do1 "
                + ",isnull(TC_V2.do2,'') as do2 "
                + ",isnull(TC_V2.do3,'') as do3 "
                + ",isnull(TC_V2.do4,'') as do4 "
                + ",isnull(TC_V2.do5,'') as do5 "
                + ",isnull(TC_V2.do6,'') as do6 "
                + ",isnull(TC_V2.do7,'') as do7 "
                + ",isnull(TC_V2.do8,'') as do8 "
                + ",isnull(res.name,'') as reason_tc "
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
                + ",ltrim (case when ps110.ps_name not like '' or ps110.ps_name is not null "
                + "            then isnull(ps110.ps_name,'') "
                + "     when ps35.ps_name not like '' or ps35.ps_name is not null "
                + "             then isnull(ps35.ps_name,'') "
                + "     else '________ ___' end) as ps35110_name "
                + ",case when ps10.ps_name not like '' and ps10.ps_name is not null then "
                + "isnull (ps10.ps_name,'_____') "
                + "    when SUPPLYCH.ps_10_disp_name_tmp not like '' and SUPPLYCH.ps_10_disp_name_tmp is not null "
                + "         then isnull (SUPPLYCH.ps_10_disp_name_tmp,'_____') "
                + "else '_________________' end as ps10_name "
                + ",isnull(SUPPLYCH.selecting_point,'') as selecting_point "
                + ",isnull(SUPPLYCH.fid_04_disp_name,'') as fid04_name "
                + ",isnull(SUPPLYCH.opor_nom_04,'_____') as opor_nom_04 "
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
        rs.next();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="../word_page_format.jsp"/>
    </head>
    <body>
        <div class="Section1">
            <p align="center">ОПИТУВАЛЬНИЙ ЛИСТ <br>
                для населення<br>
                (типова форма)</p>
            <p>1. Прогнозована приєднана потужність  <%=rs.getString("request_power")%> кВт, <br>
                у тому числі необхідна потужність електротермічного обладнання  (електронагрівальних  установок): _______  кВт.<br>
                2. Напруга приєднання: <%=rs.getString("join_point").substring(16)%> кВ.<br>
                3. Відомості щодо необхідної Замовнику категорії  надійності електропостачання об’єкта та електротермічного обладнання:
                <%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%><%="(I)"%><%}%>
                <%if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE")) {%><%="(II)"%><%}%>
                <%if (rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%><%="(III)"%><%}%>
                <br>
                4. Орієнтовна схема підключення:<%=rs.getString("connection_treaty_number")%></p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&quot;___&quot; ____________ 20___ року</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="300" valign="top"><p>Замовник:</p></td>
                </tr>
                <tr>
                    <td width="300" valign="top"><p><br></p></td>
                </tr>
                <tr>
                    <td width="500" valign="top"><p>___________       <%=rs.getString("pip")%><br>
                            (підпис)                  </p></td>
                </tr>
            </table>
            <p align="right"><strong>&nbsp;</strong></p>
            <p align="right"><strong>&nbsp;</strong></p>
            <p align="right"><strong>&nbsp;</strong></p>
            <p align="right"><strong>&nbsp;</strong></p>
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
