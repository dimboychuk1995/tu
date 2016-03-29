<%-- 
    Document   : index
    Created on : 18 трав 2010, 12:22:46
    Author     : asupv
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>

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
        String FromDate = (String) request.getParameter("FromDate");
        String TillDate = (String) request.getParameter("TillDate");
        //PreparedStatement pstmt = Conn.prepareStatement("{call dbo.oblik_uklad_dog_nad_dost_elmer_tu(?,?)}");
        String ss;
        ss = " SELECT "
                + "number, isnull(convert (varchar(10),date_contract,104),'') as date_contract, "
                + " isnull(case when customer_type=0 and department_id<>240 then isnull(f_name,'')+' '+isnull(substring(s_name,1,1),'')+'. '+isnull(substring(t_name,1,1),'')+'.' "
                + "	when customer_type=0 and department_id=240 then isnull(f_name,'') "
                + " else Juridical end,'') as zamovnyk, "
                + " case when TC_V2.[customer_locality] is not null and TC_V2.[customer_locality]>0 then "
                + " (select case "
                + "     when [type]=1 then 'м.' "
                + "     when [type]=2 then 'c.' "
                + "     when [type]=3 then 'cмт.' "
                + "     end as [type] from TC_LIST_locality t where t.id=cust.id)+ "
                + " isnull(cust.name,'')+', вул.'+ isnull(TC_V2.[customer_adress],'') "
                + "     when TC_V2.[customer_locality] is null or TC_V2.[customer_locality]=0 then "
                + "         isnull(TC_V2.customer_adress,'') "
                + " else (select case "
                + "     when [type]=1 then 'м.' "
                + "     when [type]=2 then 'c.' "
                + "     when [type]=3 then 'cмт.' "
                + "  end as [type] from TC_LIST_locality t where t.id=cust.id)+ "
                + " isnull(cust.name,'') end as customer_adress, "
                + " ISNULL(customer_telephone,'') as customer_telephone, "
                + "isnull(replace(convert(varchar(20),request_power),'.',','),'') as request_power, "
                + " case when (SELECT top 1 join_point FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)=1 then '4.1' "
                + "         when (SELECT top 1 join_point FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)=11 then '4.1' "
                + "         when (SELECT top 1 join_point FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)=2 then '4.0' "
                + "         when (SELECT top 1 join_point FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)=21 then '4.0' "
                + "         when (SELECT top 1 join_point FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)=3 then '3.1' "
                + "         when (SELECT top 1 join_point FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)=4 then '3.0' "
                + "         when (SELECT top 1 join_point FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)=5 then '2.1' "
                + "         when (SELECT top 1 join_point FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)=6 then '2.0' "
                + "         when (SELECT top 1 join_point FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)=7 then '1.1' "
                + "else '' end as join_point,   "
                + " case when (SELECT top 1 (select top 1 ps_name from [TUweb].[dbo].[ps_tu_web] where ps_id=ps_110_disp_name and ps_nominal=1) FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id) like '%35%' then (SELECT top 1 (select top 1 substring(ps_name,1,charindex(' ',ps_name)) from [TUweb].[dbo].[ps_tu_web] where ps_id=ps_110_disp_name and ps_nominal=1) FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id) else '' end as NazvaPSNapruga_110_150_35_10_6, "
                + " case when (SELECT top 1 (select top 1 ps_name from [TUweb].[dbo].[ps_tu_web] where ps_id=ps_110_disp_name and ps_nominal=1) FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id) not like '%35%' then (SELECT top 1 (select top 1 substring(ps_name,1,charindex(' ',ps_name)) from [TUweb].[dbo].[ps_tu_web] where ps_id=ps_110_disp_name and ps_nominal=1) FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id) else '' end as NazvaPSNapruga_110_150_10_6, "
                + " isnull((SELECT top 1 (select top 1 substring(ps_name,1,charindex(' ',ps_name)) from [TUweb].[dbo].[ps_tu_web] where ps_id=ps_35_disp_name and ps_nominal=2) FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id),'') as NazvaPSNapruga_35_10_6, "
                + "isnull((SELECT cast(case when (select ps_name from [TUweb].[dbo].[ps_tu_web] where [TUweb].[dbo].[ps_tu_web].ps_id=ps_10_disp_name) is not null then (select ps_name from [TUweb].[dbo].[ps_tu_web] where [TUweb].[dbo].[ps_tu_web].ps_id=ps_10_disp_name) when nullif(ps_10_disp_name_tmp,'') is not null then ps_10_disp_name_tmp else '?' end as varchar)+';' AS 'data()' FROM [" + db + "].[dbo].SUPPLYCH where tc_id=TC_V2.id FOR XML PATH('')),'')as NazvaPSNapruga_10_6_04,  "
                + "case when (SELECT top 1 (select top 1 ps_name from [TUweb].[dbo].[ps_tu_web] where ps_id=ps_110_disp_name and ps_nominal=1) FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id) like '%35%' then cast ((SELECT top 1 (select top 1 cast ((ps_nav*1000) as numeric(10,2)) from [TUweb].[dbo].[ps_tu_web] where ps_id=ps_110_disp_name and ps_nominal=1) FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id) as varchar) else '' end as MaxNavantagPS_110_150_35_10_6, "
                + "case when (SELECT top 1 (select top 1 ps_name from [TUweb].[dbo].[ps_tu_web] where ps_id=ps_110_disp_name and ps_nominal=1) FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id) not like '%35%' then cast ((SELECT top 1 (select top 1 cast ((ps_nav*1000) as numeric(10,2)) from [TUweb].[dbo].[ps_tu_web] where ps_id=ps_110_disp_name and ps_nominal=1) FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id) as varchar) else '' end as MaxNavantagPS_110_150_10_6, "
                + "isnull(cast((SELECT top 1 (select top 1 cast((ps_nav*1000) as numeric(10,2)) from [TUweb].[dbo].[ps_tu_web] where ps_id=ps_35_disp_name and ps_nominal=2) FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id) as varchar),'') as MaxNavantagPS_35_10_6, "
                + "isnull((SELECT cast((select cast(ps_nav as numeric(10,2)) from [TUweb].[dbo].[ps_tu_web] where [TUweb].[dbo].[ps_tu_web].ps_id=ps_10_disp_name) as varchar)+';' AS 'data()' FROM [" + db + "].[dbo].SUPPLYCH where tc_id=TC_V2.id FOR XML PATH('')),'') as MaxNavantagPS_10_6_04, "
                //+"'' as MaxNavantagPS_10_6_04,"
                + "isnull(nullif(convert(varchar(20),(SELECT top 1 fid_110_leng FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)),'0.000'),'') as NeobhBudLEP_110_150, "
                + "isnull(nullif(convert(varchar(20),(SELECT top 1 fid_35_leng FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)),'0.000'),'') as NeobhBudLEP_35, "
                + "isnull(nullif(convert(varchar(20),(SELECT top 1 fid_10_leng FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)),'0.000'),'') as NeobhBudLEP_10_6, "
                + "isnull(nullif(convert(varchar(20),(SELECT top 1 fid_04_leng FROM [" + db + "].[dbo].SUPPLYCH WHERE tc_id=TC_V2.id)),'0.000'),'') as NeobhBudLEP_04, "
                + "isnull(replace(convert(varchar(20),develop_price_akt),'.',','),'') as develop_price_akt "
                + "from [" + db + "].[dbo].TC_V2 "
                + " left join [" + db + "].[dbo].TC_LIST_locality cust on [" + db + "].[dbo].TC_V2.customer_locality=cust.id "
                //+ "left join ["+db+"].[dbo].[SUPPLYCH] on TC_V2.id=SUPPLYCH.tc_id "
                //+ "left join [TUweb].[dbo].[ps_tu_web] ps110 on SUPPLYCH.ps_110_disp_name=ps110.ps_id and ps110.ps_nominal=1 "
                //+ "left join [TUweb].[dbo].[ps_tu_web] ps35 on SUPPLYCH.ps_35_disp_name=ps35.ps_id and ps35.ps_nominal=2 "
                //+ "left join [TUweb].[dbo].[ps_tu_web] ps10 on SUPPLYCH.ps_10_disp_name=ps10.ps_id and ps10.ps_nominal=3 "
                //+ "left join [TUWeb].[dbo].[supply_power_point]  on (SUPPLYCH.join_point=[TUWeb].[dbo].[supply_power_point].supply_power_point_id) "
                + "where date_contract>='" + request.getParameter("FromDate") + "' and  date_contract<='" + request.getParameter("TillDate") + "'";

        pstmt = c.prepareStatement(ss);
        //pstmt.setString(1,FromDate);
        //pstmt.setString(2,TillDate);
        rs = pstmt.executeQuery();
        String tmp = "", i = "18";
        int inz = 1;

%>
<style type="text/css">
    <!--
    td.vertical{
        writing-mode:tb-rl;
        filter:flipH flipV;
    }
    -->
</style>
<%--=ss--%>
<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" class="tabl">
    <tr>
        <td rowspan="3" align="center">№ п/п </td>
        <td colspan="2" rowspan="2" align="center">Договір (технічні умови)</td>
        <td width="66" colspan="3" rowspan="2" align="center">Замовник</td>
        <td width="79" rowspan="2" align="center" style="mso-rotate:90">Приєднана потужність, кВт</td>
        <td width="86" rowspan="2" align="center" style="mso-rotate:90">Узгоджена точка приєднання напруга кВ, (втратний чи безвтратний споживач)</td>
        <td colspan="4" align="center">Назва (номер) ПС напругою, які задіяні в електрозабезпеченні електроустановок Замовника </td>
        <td colspan="4" align="center">Максимальне навантаження в кВт ПС, кВ, на час укладення договору, видачі техумов </td>
        <td colspan="4" align="center">Необхідність будівництва чи реконструкції ЛЕП у км напругою, кВ </td>
        <td width="90" rowspan="2" align="center">Вартість будівництва згідно акту, грн</td>
    </tr>
    <tr>
        <td width="120" rowspan="2" align="center" style="mso-rotate:90">110(150)/35/10(6)</td>
        <td width="99" rowspan="2" align="center" style="mso-rotate:90">110(150)/10(6)</td>
        <td width="56" rowspan="2" align="center" style="mso-rotate:90">35/10(6)</td>
        <td width="60" rowspan="2" align="center" style="mso-rotate:90">10(6)/0,4</td>
        <td width="119" height="48" align="center" style="mso-rotate:90">110(150)/35/10(6)</td>
        <td width="99" align="center" style="mso-rotate:90">110(150)/10(6)</td>
        <td width="55" align="center" style="mso-rotate:90">35/10(6)</td>
        <td width="58" align="center" style="mso-rotate:90">10(6)/0,4</td>
        <td width="62">110(150)</td>
        <td width="23" align="center">35</td>
        <td width="36">10(6)</td>
        <td width="23">0,4</td>
    </tr>
    <tr>

        <td width="44" align="center">Номер</td>
        <td width="70" align="center">Дата укладення</td>
        <td width="100" align="center">Найменування</td>
        <td width="100" align="center">Адреса</td>
        <td width="100" align="center">Телефон</td>
        <td align="center">W c </td>
        <td align="center">C</td>
        <td align="center">W мф (W мфоб) </td>
        <td align="center">W мф</td>
        <td align="center">W мф</td>
        <td align="center">W мф</td>
        <td align="center"><p><em>ι Ф </em></p></td>
        <td align="center"><p><em>ι Ф </em></p></td>
        <td align="center"><p><em>ι Ф </em></p></td>
        <td align="center"><p><em>ι Ф </em></p></td>
        <td align="center"> П </td>
    </tr>
    <%while (rs.next()) {%>  
    <tr>	
        <td align="center"> <%out.print(inz++);%></td>
        <td align="center"> &nbsp;<%out.print(tmp = rs.getString(1));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(2));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(3));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(4));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(5));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(6));%></td>
        <td align="center"> &nbsp;<%out.print(tmp = rs.getString(7));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(8));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(9));%></td>
        <td align="center"> &nbsp;<%out.print(tmp = rs.getString(10));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(11));%></td>
        <td align="center"> &nbsp;<%out.print(tmp = rs.getString(12));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(13));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(14));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(15));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(16));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(17));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(18));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(19));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(20));%></td>
    </tr>   
    <%}
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(c);
            ic.close();
        }
    %>
</table>


