<%-- 
    Document   : ajax
    Created on : 11 бер 2011, 10:58:23
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/json.tld" prefix="json" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource,java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet" %>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
    //String ps_id = request.getParameter("ps_id");
    String ps_u = new String();
    String ps_nom = new String();
    String ps_zav = new String();
    String ps_rez = new String();
    String sum_pow = new String();
    String koef = new String();
    String p_max = new String();
    String pow = new String();
    ResultSet rs = null;
    ResultSet rs1 = null;
    Connection c = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt1 = null;
    HttpSession ses = request.getSession();
    String db = new String();
    if (ses.getAttribute("db_name") != null) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try {
        c = ds.getConnection();
        String SQL =
                "select "
                        + " (SELECT [ps_id] FROM [TUWeb].[dbo].[ps_tu_web] where ps_id='" + request.getParameter("ps_id") + "') as ps_id "
                        // +" -------------------------------------------------------------- "
                        + " ,(select isnull([ps_nom_nav],0)+isnull([ps_nom_nav_2],0) from [TUweb].[dbo].[ps_tu_web] where ps_id='" + request.getParameter("ps_id") + "') as ps_nom_nav "
                        // +" ----------------------------------------------------------------- "
                        + " ,(select isnull([ps_nav],0) from [TUweb].[dbo].[ps_tu_web] where ps_id='" + request.getParameter("ps_id") + "') as ps_nav "
                        //  +" ------------------------------------------------------------------ "
                        + " , (SELECT Cast(Sum(A.[Power]) AS NUMERIC(10,2) ) FROM (SELECT "
                        + " "
                        + "      Isnull(CASE WHEN (SELECT Count(id) FROM SUPPLYCH WHERE SUPPLYCH.tc_id=TC_V2.id GROUP BY supplych.tc_id)>1 "
                        + "					AND Upper(reliabylity_class_1) LIKE 'FALSE' "
                        + "					AND Upper(reliabylity_class_2) LIKE 'FALSE' "
                        + "					AND Upper(reliabylity_class_3) LIKE 'TRUE' "
                        + "                                AND (sp.[power]<>0 and sp.[power] IS NOT NULL) "
                        + "		THEN sp.[POWER] "
                        + "		ELSE TC_V2.request_power END,'') AS [power] "
                        + "        FROM TC_V2 "
                        + "            LEFT JOIN SUPPLYCH sp ON sp.tc_id=TC_V2.id "
                        + "            LEFT JOIN [TUweb].[dbo].[status_document] ON ([TUweb].[dbo].[status_document].status_id=TC_V2.state_contract) "
                        + "        WHERE TC_V2.type_contract=1 "
                        + "		AND NULLIF(date_admission_consumer,'') IS NULL "
                        + "		AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13) "
                        + "		AND sp.ps_10_disp_name='" + request.getParameter("ps_id") + "') A) AS ps_rez "
                        + " ,(select isnull(TC_V2.request_power,0)  from dbo.TC_V2 where TC_V2.id = (" + request.getParameter("tu_id") + ") ) AS [request_power] "
                        + " ,(SELECT   "
                        + " 	cast(((select isnull([ps_nav],0) from [TUWeb].[dbo].[ps_tu_web] where ps_id='" + request.getParameter("ps_id") + "')+ "
                        + " 	(select isnull(sum(TC_V2.request_power),0) from [TUWeb].[dbo].[ps_tu_web]  "
                        + "          left join SUPPLYCH on ps_id=ps_10_disp_name  "
                        + "          left join TC_V2 on SUPPLYCH.tc_id=TC_V2.id  "
                        + " 			where TC_V2.type_contract=1  "
                        + " 			and nullif(date_admission_consumer,'') is null  "
                        + " 			and isnull(state_contract,0)<>8  "
                        + " 			and isnull(state_contract,0)<>2  "
                        + " 			and isnull(state_contract,0)<>5  "
                        + "                     and isnull(state_contract,0)<>7  "
                        + " 			and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                        + " 			and ps_id='" + request.getParameter("ps_id") + "')  "
                        + "    + isnull((select isnull(request_power,0) from TC_V2 where id=" + request.getParameter("tu_id")
                        + " 								and TC_V2.type_contract=1  "
                        + " 								and nullif(date_admission_consumer,'') is null  "
                        + " 								and isnull(state_contract,0)<>8  "
                        + " 								and isnull(state_contract,0)<>2  "
                        + " 								and isnull(state_contract,0)<>5  "
                        + "                                                              and isnull(state_contract,0)<>7  "
                        + "),0)  "
                        + "    )/ "
                        + "    (select (isnull([ps_nom_nav],0)+isnull([ps_nom_nav_2],0))*0.92 from [TUWeb].[dbo].[ps_tu_web] where ps_id='" + request.getParameter("ps_id") + "') "
                        + "    *100 as numeric(10,2))) as ps_zav"
                        + ",(SELECT case"
                        + "  when ptw.ps_nom_nav_2 IS NULL THEN 0.92*ptw.ps_nom_nav "
                        + "  WHEN ptw.ps_nom_nav>=ptw.ps_nom_nav_2 THEN 0.92*ptw.ps_nom_nav_2*1.4 "
                        + "  WHEN ptw.ps_nom_nav<ptw.ps_nom_nav_2 THEN 0.92*ptw.ps_nom_nav*1.4"
                        + "  ELSE 0 end  "
                        + " FROM TUWeb.dbo.ps_tu_web ptw WHERE ptw.ps_id='" + request.getParameter("ps_id") + "')  AS p_max";
        String SQL1 = "SELECT "
                + "SumPow , "
                + " CASE "
                + " WHEN cnt BETWEEN 1 AND 10 THEN 0.9"
                + " WHEN cnt BETWEEN 11 AND 50 THEN 0.67"
                + " WHEN cnt BETWEEN 51 AND 100 THEN 0.53"
                + " WHEN cnt BETWEEN 101 AND 250 THEN 0.43"
                + " WHEN cnt BETWEEN 251 AND 500 THEN 0.36"
                + " WHEN cnt BETWEEN 501 AND 750 THEN 0.29"
                + " WHEN cnt BETWEEN 751 AND 1000 THEN 0.24"
                + " WHEN cnt BETWEEN 1001 AND 10000 THEN 0.2"
                + " WHEN cnt BETWEEN 10001 AND 100000 THEN 0.16"
                + " WHEN cnt BETWEEN 100001 AND 1000000 THEN 0.12"
                + " WHEN cnt >1000001 THEN 0.12"
                + " ELSE 1"
                + " END AS koef"
                + " FROM dbo.ResultTP WHERE cast(tp_name as varchar(20))='" + request.getParameter("ps") + "'";
        pstmt = c.prepareStatement(SQL);
        pstmt1 = c.prepareStatement(SQL1);
        rs = pstmt.executeQuery();
        rs1 = pstmt1.executeQuery();
        rs.next();
        ps_nom = rs.getString("ps_nom_nav");
        ps_u = rs.getString("ps_nav");
        ps_zav = rs.getString("ps_zav");
        ps_rez = rs.getString("ps_rez");
        p_max = rs.getString("p_max");
        pow = rs.getString("request_power");
        if (rs1.next()) {
            sum_pow = rs1.getString("SumPow");
            koef = rs1.getString("koef");
        } else {
            sum_pow = "0";
            koef = "1";
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(rs1);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(pstmt1);
        SQLUtils.closeQuietly(c);
    }
    pageContext.setAttribute("ps_id", request.getParameter("ps_id"));
    pageContext.setAttribute("ps_u", ps_u);
    pageContext.setAttribute("pow", pow);
    pageContext.setAttribute("ps_nom", ps_nom);
    pageContext.setAttribute("ps_zav", ps_zav);
    pageContext.setAttribute("ps_rez", ps_rez);
    pageContext.setAttribute("p_max", p_max);
    pageContext.setAttribute("sum_pow", sum_pow);
    pageContext.setAttribute("koef", koef);
%>
<json:object>
    <json:property name="ps_id"> ${ps_id}</json:property>
    <json:property name="ps_u"> ${ps_u}</json:property>
    <json:property name="pow"> ${pow}</json:property>
    <json:property name="ps_nom"> ${ps_nom}</json:property>
    <json:property name="ps_zav"> ${ps_zav}</json:property>
    <json:property name="ps_rez"> ${ps_rez}</json:property>
    <json:property name="p_max"> ${p_max}</json:property>
    <json:property name="sum_pow"> ${sum_pow}</json:property>
    <json:property name="koef"> ${koef}</json:property>
</json:object>
