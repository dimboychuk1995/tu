<%--
    Document   : index
    Created on : 18 трав 2010, 12:22:46
    Author     : asupv
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
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
        ss = " Select "
                + " 'Всього по філії' as coment "
                + " ,(select count(*) from [" + db + "].[dbo].TC_V2 where registration_date>='" + request.getParameter("FromDate") + "' and registration_date<='" + request.getParameter("TillDate") + "') as otr "
                + " ,(select count(*) from [" + db + "].[dbo].TC_V2 where initial_registration_date_rem_tu>='" + request.getParameter("FromDate") + "' and initial_registration_date_rem_tu<='" + request.getParameter("TillDate") + "') as vyh_data_vsogo "
                + " ,(select  count(*) "
                + " from [" + db + "].[dbo].TC_V2 "
                + " left join [" + db + "].[dbo].TC_V2 osn on ([" + db + "].[dbo].TC_V2.main_contract=osn.id and osn.initial_registration_date_rem_tu>='" + request.getParameter("FromDate") + "'"
                + " and osn.initial_registration_date_rem_tu<='" + request.getParameter("TillDate") + "') "
                + " left join [" + db + "].[dbo].SUPPLYCH bud on [" + db + "].[dbo].TC_V2.id=bud.tc_id "
                + " left join [" + db + "].[dbo].SUPPLYCH os on osn.id=os.tc_id "
                + " where [" + db + "].[dbo].TC_V2.initial_registration_date_rem_tu>='" + request.getParameter("FromDate") + "' "
                + " and [" + db + "].[dbo].TC_V2.initial_registration_date_rem_tu<='" + request.getParameter("TillDate") + "' "
                + " and [" + db + "].[dbo].TC_V2.type_contract=2 "
                //+" --and bud.opor_nom_04=os.opor_nom_04 "
                //+" and bud.fid_04_disp_name=os.fid_04_disp_name "
                //+" --and bud.[fid_04_leng] "
                //+" --and bud.[type_source]=os.[type_source] "
                + " and (bud.ps_10_disp_name=os.ps_10_disp_name "
                + " 	or bud.ps_10_disp_name_tmp=os.ps_10_disp_name_tmp) "
                //+" --[fid_10_disp_name] "
                //+" --[fid_10_leng] "
                + " and bud.[ps_35_disp_name]=os.[ps_35_disp_name] "
                //+" --[fid_35_disp_name] "
                //+" --[fid_35_leng] "
                + " and isnull(bud.[ps_110_disp_name],0)=isnull(os.[ps_110_disp_name],0) "
                //+" --[fid_110_disp_name] "

                + ") as shem_odnakovi "
                // +",(select 1)"
                + " ,isnull((select sum(isnull(estimated_total_lump_pitch_tu,0.00)) from [" + db + "].[dbo].TC_V2 where initial_registration_date_rem_tu>='" + request.getParameter("FromDate") + "' and initial_registration_date_rem_tu<='" + request.getParameter("TillDate") + "'),0) as orientovna_vartist "
                + " ,(select count(*) from [" + db + "].[dbo].TC_V2 where date_contract>='" + request.getParameter("FromDate") + "' and date_contract<='" + request.getParameter("TillDate") + "') as ukladeni "
                + " ,(select count(*) from [" + db + "].[dbo].TC_V2 where date_admission_consumer>='" + request.getParameter("FromDate") + "' and date_admission_consumer<='" + request.getParameter("TillDate") + "') as dopuscheni "
                + " ,(select isnull(sum(estimated_total_lump_pitch_tu),0.00) from [" + db + "].[dbo].TC_V2 where date_admission_consumer>='" + request.getParameter("FromDate") + "' and date_admission_consumer<='" + request.getParameter("TillDate") + "') as dopuscheni_sum "
                + " ,(select rem_name from [TUWeb].[dbo].rem where DB_NAME like '" + db + "') as rem_name "
                + ",(select golovnyi_ingener from [TUWeb].[dbo].rem where DB_NAME like '" + db + "') as golovnyi_ingener "
                + ",(select vykonavets from [TUWeb].[dbo].rem where DB_NAME like '" + db + "') as vykonavets "
                + " union "
                + " Select "
                + " 'у т. ч. по ТУ, підготовлених у ВТП' as coment "
                + " ,(select count(*) from [" + db + "].[dbo].TC_V2 where registration_date>='" + request.getParameter("FromDate") + "' and registration_date<='" + request.getParameter("TillDate") + "' and executor_company=1) as otr "
                + " ,(select count(*) from [" + db + "].[dbo].TC_V2 where initial_registration_date_rem_tu>='" + request.getParameter("FromDate") + "' and initial_registration_date_rem_tu<='" + request.getParameter("TillDate") + "' and executor_company=1) as vyh_data_vsogo "
                + " ,(select  count(*) "
                + " from [" + db + "].[dbo].TC_V2 "
                + " left join [" + db + "].[dbo].TC_V2 osn on ([" + db + "].[dbo].TC_V2.main_contract=osn.id and osn.initial_registration_date_rem_tu>='" + request.getParameter("FromDate") + "' "
                + " and osn.initial_registration_date_rem_tu<='" + request.getParameter("TillDate") + "') "
                + " left join [" + db + "].[dbo].SUPPLYCH bud on TC_V2.id=bud.tc_id "
                + " left join [" + db + "].[dbo].SUPPLYCH os on osn.id=os.tc_id "
                + " where [" + db + "].[dbo].TC_V2.initial_registration_date_rem_tu>='" + request.getParameter("FromDate") + "' "
                + " and [" + db + "].[dbo].TC_V2.initial_registration_date_rem_tu<='" + request.getParameter("TillDate") + "' "
                + " and [" + db + "].[dbo].TC_V2.type_contract=2 "
                //+" --and bud.opor_nom_04=os.opor_nom_04 "
                //+" and bud.fid_04_disp_name=os.fid_04_disp_name "
                //+" --and bud.[fid_04_leng] "
                + " and bud.type_source=os.type_source "
                + " and (bud.[ps_10_disp_name]=os.[ps_10_disp_name] "
                + " or bud.[ps_10_disp_name_tmp]=os.[ps_10_disp_name_tmp]) "
                //+" --[fid_10_disp_name] "
                //+" --[fid_10_leng] "
                + " and bud.[ps_35_disp_name]=os.[ps_35_disp_name] "
                //+" --[fid_35_disp_name] "
                //+" --[fid_35_leng] "
                + " and bud.[ps_110_disp_name]=os.[ps_110_disp_name] "
                //+" --[fid_110_disp_name] "
                //+" --[fid_110_leng] "
                + " and [" + db + "].[dbo].TC_V2.executor_company=1) as shem_odnakovi "
                + " ,-1 as orientovna_vartist "
                + " ,(select count(*) from [" + db + "].[dbo].TC_V2 where date_contract>='" + request.getParameter("FromDate") + "' and date_contract<='" + request.getParameter("TillDate") + "' and executor_company=1) as ukladeni "
                + " ,-1 as dopuscheni "
                + " ,-1 as dopuscheni_sum "
                + " ,(select rem_name from [TUWeb].[dbo].rem where DB_NAME like '" + db + "') as rem_name "
                + ",(select golovnyi_ingener from [TUWeb].[dbo].rem where DB_NAME like '" + db + "') as golovnyi_ingener "
                + ",(select vykonavets from [TUWeb].[dbo].rem where DB_NAME like '" + db + "') as vykonavets "
                + " order by otr desc " //+ "left join ["+db+"].[dbo].[SUPPLYCH] on TC_V2.id=SUPPLYCH.tc_id "
                //+ "left join [TUweb].[dbo].[ps_tu_web] ps110 on SUPPLYCH.ps_110_disp_name=ps110.ps_id and ps110.ps_nominal=1 "
                //+ "left join [TUweb].[dbo].[ps_tu_web] ps35 on SUPPLYCH.ps_35_disp_name=ps35.ps_id and ps35.ps_nominal=2 "
                //+ "left join [TUweb].[dbo].[ps_tu_web] ps10 on SUPPLYCH.ps_10_disp_name=ps10.ps_id and ps10.ps_nominal=3 "
                //+ "left join [TUWeb].[dbo].[supply_power_point]  on (SUPPLYCH.join_point=[TUWeb].[dbo].[supply_power_point].supply_power_point_id) "
                //+"where date_contract>='"+request.getParameter("FromDate")+"' and  date_contract<='"+request.getParameter("TillDate")+"'"
                ;

        pstmt = c.prepareStatement(ss,
                ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        //pstmt.setString(1,FromDate);
        //pstmt.setString(2,TillDate);
        rs = pstmt.executeQuery();
        String tmp = "", i = "18";
        int inz = 1;

%>
<style type="text/css">
    <!--
    body,td,th {
        font-size: 12pt;
        font-family: "Times New Roman"
    }
    .style2 {font-size: 10pt}
    @page Section1
    {
        margin:1.0cm 1.0cm 1.0cm 1.0cm;
    }
    div.Section1
    {page:Section1;}
    -->
    <xml>
    <w:WordDocument>
    <w:View>Print</w:View>
    <w:GrammarState>Clean</w:GrammarState>
    <w:HyphenationZone>21</w:HyphenationZone>
    <w:ValidateAgainstSchemas/>
    <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
    <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
    <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
    <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
    </w:WordDocument>
    </xml>
</style>
<%--=ss--%>
<%rs.next();%>
<table><tr><td colspan="3"><strong>Загальна інформація про стан ТУ (витяг "з Бази даних ТУ") за <%=request.getParameter("FromDate")%>-<%=request.getParameter("TillDate")%>  по філії "<%=rs.getString("rem_name")%> РЕМ"</strong></td></tr></table>
<table width="1190" border="1" cellpadding="0" cellspacing="0" class="tabl">

    <tr>
        <td width="45" rowspan="2" align="center">&nbsp;</td>
        <td width="70" rowspan="2" align="center">К-сть отриманих заяв на видачу ТУ у звітному періоді, шт.</td>
        <td colspan="2" align="center">Кількість виданих ТУ у звітному періоді, шт.</td>
        <td rowspan="2" width="144" align="center">Орієнтовна вартість робіт та обладнання по виданих ТУ у звітному періоді, грн.</td>
        <td rowspan="2" width="103" align="center">К-сть укладених договорів у звітному періоді, шт.</td>
        <td width="113" rowspan="2" align="center">К-сть здійснених допусків у звітному періоді, шт.</td>
        <td width="136" rowspan="2" align="center">Орієнтовна вартість робіт та обладнання по здійснених допусках у звітному періоді, грн.</td>
    </tr>
    <tr>
        <td width="181" align="center">Всього, шт</td>
        <td width="330" align="center">у т. ч. ТУ, які видані на основний об'єкт, а схема підключення, яких однакова із схемою підключення на б/м (графа "Границя розмежування балансової належності"), шт.</td>
    </tr>
    <%do {%>
    <tr>
        <td align="center">&nbsp <%= rs.getString(1)%></td>
        <td align="center">&nbsp <%= rs.getString(2)%></td>
        <td align="center">&nbsp <%= rs.getString(3)%></td>
        <td align="center">&nbsp <%= rs.getString(4)%></td>
        <td align="center">&nbsp <%if (!rs.getString(5).equals("-1.00")) {%><%= rs.getString(5)%><%} else {%><%="X"%><%}%> </td>

        <td align="center">&nbsp <%= rs.getString(6)%></td>
        <td align="center">&nbsp <%if (!rs.getString(7).equals("-1")) {%><%= rs.getString(7)%><%} else {%><%="X"%><%}%></td>
        <td align="center">&nbsp <%if (!rs.getString(8).equals("-1.00")) {%><%= rs.getString(8)%><%} else {%><%="X"%><%}%></td>
    </tr>
    <%} while (rs.next());
        rs.first();
    %>
</table>


<table cellspacing="0" cellpadding="0">
    <col width="154" />
    <col width="82" span="2" />
    <col width="188" />
    <col width="96" />
    <col width="82" span="2" />
    <col width="96" />
    <tr height="21">
        <td height="21" colspan="2" width="236">Головний інженер філії &quot;<%=rs.getString("rem_name")%> РЕМ&quot;</td>
        <td colspan="2" width="178"><%= rs.getString("golovnyi_ingener")%></td>
    </tr>
    <tr height="21">
        <td height="21"></td>
        <td></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr height="21">
        <td height="21"></td>
        <td></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr height="21">
        <td height="21" colspan="2">Інженер-керівник ВТГ</td>
        <td colspan="2"><%= rs.getString("vykonavets")%></td>
    </tr>
</table>
<%} catch (SQLException e) {
        e.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    }
%>
