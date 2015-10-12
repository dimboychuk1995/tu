<%-- 
    Document   : ajax35
    Created on : 14 черв 2011, 10:40:50
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
    String pow = new String();
    String p_max = new String();
    String koef = new String();
    String sum_pow = new String();
    ResultSet rs = null;
    ResultSet rs1 = null;
    Connection c = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt1 = null;
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
        String SQL = " select "
                + " (SELECT [ps_id] FROM [TUWeb].[dbo].[ps_tu_web] where ps_id='" + request.getParameter("ps_id") + "') as ps_id "
                + " ,(select isnull([ps_nom_nav],0)+isnull([ps_nom_nav_2],0) from [TUweb].[dbo].[ps_tu_web] where ps_id='" + request.getParameter("ps_id") + "') as ps_nom_nav "
                + " ,(select isnull([ps_nav],0) from [TUweb].[dbo].[ps_tu_web] where ps_id='" + request.getParameter("ps_id") + "') as ps_nav "
                + " ,(SELECT cast( "
                //+" (select((isnull([ps_nom_nav],0)+isnull([ps_nom_nav_2],0))*0.92)-isnull([ps_nav],0) from [TUweb].[dbo].[ps_tu_web] where ps_id='"+request.getParameter("ps_id")+"')- "
                + "(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb190].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb190].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb200].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb200].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb210].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb210].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb220].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb220].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb230].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb230].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb240].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb240].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb250].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb250].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb260].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb260].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb270].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb270].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb280].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb280].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb290].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb290].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb300].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb300].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb310].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb310].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb320].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb320].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb330].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb330].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb340].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb340].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + "+(select isnull(sum(TC_V2.request_power)/1000,0)  from [TUWeb350].[dbo].TC_V2   "
                + "where  "
                + "	TC_V2.id IN (SELECT DISTINCT tc_id FROM [TUWeb350].[dbo].SUPPLYCH WHERE ps_35_disp_name='" + request.getParameter("ps_id") + "') AND \n"
                + "	TC_V2.type_contract=1   "
                + "	AND date_admission_consumer IS null  "
                + "	AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13))"
                + " as numeric(10,2))) as ps_rez "
                + " ,(SELECT   "
                + " cast(((select isnull([ps_nav],0) from [TUWeb].[dbo].[ps_tu_web] where ps_id='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb190].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb190].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + " 		and isnull(state_contract,0)<>8  "
                + "		and isnull(state_contract,0)<>2  "
                + "		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb200].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb200].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + "		and isnull(state_contract,0)<>8  "
                + " 		and isnull(state_contract,0)<>2  "
                + "		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb210].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb210].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + " 		and isnull(state_contract,0)<>8  "
                + " 		and isnull(state_contract,0)<>2  "
                + " 		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb220].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb220].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + " 		and isnull(state_contract,0)<>8  "
                + "		and isnull(state_contract,0)<>2  "
                + " 		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb230].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb230].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + " 		and isnull(state_contract,0)<>8  "
                + " 		and isnull(state_contract,0)<>2  "
                + "		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb240].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb240].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + " 		and isnull(state_contract,0)<>8  "
                + "		and isnull(state_contract,0)<>2  "
                + "		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb250].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb250].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + "		and isnull(state_contract,0)<>8  "
                + "		and isnull(state_contract,0)<>2  "
                + " 		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb260].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb260].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + " 		and isnull(state_contract,0)<>8  "
                + "		and isnull(state_contract,0)<>2  "
                + "		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb270].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb270].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + "		and isnull(state_contract,0)<>8  "
                + " 		and isnull(state_contract,0)<>2  "
                + "		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb280].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb280].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + " 		and isnull(state_contract,0)<>8  "
                + "		and isnull(state_contract,0)<>2  "
                + " 		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb290].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb290].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + " 		and isnull(state_contract,0)<>8  "
                + " 		and isnull(state_contract,0)<>2  "
                + " 		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb300].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb300].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + "		and isnull(state_contract,0)<>8  "
                + "		and isnull(state_contract,0)<>2  "
                + "		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb310].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb310].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + "		and isnull(state_contract,0)<>8  "
                + " 		and isnull(state_contract,0)<>2  "
                + " 		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb320].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb320].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + " 		and isnull(state_contract,0)<>8  "
                + " 		and isnull(state_contract,0)<>2  "
                + " 		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb330].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb330].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + " 		and isnull(state_contract,0)<>8  "
                + "		and isnull(state_contract,0)<>2  "
                + " 		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb340].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb340].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + " 		and isnull(state_contract,0)<>8  "
                + "		and isnull(state_contract,0)<>2  "
                + " 		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')+ "
                + " (select isnull(sum(TC_V2.request_power),0)/1000 from [TUWeb350].[dbo].SUPPLYCH   "
                + "  right join TC_V2 on [TUWeb350].[dbo].SUPPLYCH.tc_id=TC_V2.id  "
                + " 		where TC_V2.type_contract=1  "
                + " 		and nullif(date_admission_consumer,'') is null  "
                + " 		and isnull(state_contract,0)<>8  "
                + "		and isnull(state_contract,0)<>2  "
                + " 		and isnull(state_contract,0)<>5  "
                + " 		and TC_V2.id not in (" + request.getParameter("tu_id") + ")  "
                + " 		and SUPPLYCH.ps_35_disp_name='" + request.getParameter("ps_id") + "')		  "
                + "    + (select isnull(request_power,0)/1000 from [" + db + "].[dbo].TC_V2 where id=" + request.getParameter("tu_id") + ")  "
                + " )/ "
                + " nullif((select ((isnull([ps_nom_nav],0)+isnull([ps_nom_nav_2],0))*0.92) from [TUWeb].[dbo].[ps_tu_web] where ps_id='" + request.getParameter("ps_id") + "'),0) "
                + " *100 as numeric(10,2))) as ps_zav "
                + ",(select isnull(TC_V2.request_power,0)  from dbo.TC_V2 where TC_V2.id = (" + request.getParameter("tu_id") + ") ) AS [request_power] "
                + ",(SELECT case"
                + "  when ptw.ps_nom_nav_2 IS NULL THEN 0.92*ptw.ps_nom_nav "
                + "  WHEN ptw.ps_nom_nav>=ptw.ps_nom_nav_2 THEN 0.92*ptw.ps_nom_nav_2*1.4 "
                + "  WHEN ptw.ps_nom_nav<ptw.ps_nom_nav_2 THEN 0.92*ptw.ps_nom_nav*1.4"
                + "  ELSE 0 end  "
                + " FROM TUWeb.dbo.ps_tu_web ptw WHERE ptw.ps_id='" + request.getParameter("ps_id") + "')  AS p_max";

        String SQL1 = "SELECT (SELECT case  \n"
                + "when sum(rt.cnt) BETWEEN 1 AND 10 THEN 1 \n"
                + "when sum(rt.cnt) BETWEEN 11 AND 50 THEN 0.81 \n"
                + "when sum(rt.cnt) BETWEEN 51 AND 100 THEN 0.69 \n"
                + "when sum(rt.cnt) BETWEEN 101 AND 250 THEN 0.61 \n"
                + "when sum(rt.cnt) BETWEEN 251 AND 500 THEN 0.55 \n"
                + "when sum(rt.cnt) BETWEEN 501 AND 750 THEN 0.5 \n"
                + "when sum(rt.cnt) BETWEEN 751 AND 1000 THEN 0.46 \n"
                + "when sum(rt.cnt) BETWEEN 1001 AND 10000 THEN 0.42 \n"
                + "when sum(rt.cnt) BETWEEN 10001 AND 100000 THEN 0.38 \n"
                + "when sum(rt.cnt) BETWEEN 100001 AND 1000000 THEN 0.36 \n"
                + "ELSE 1 END \n"
                + "FROM SUPPLYCH s \n"
                + "LEFT JOIN tuweb.dbo.ps_tu_web ptw ON s.ps_10_disp_name=ptw.ps_id \n"
                + "LEFT JOIN ResultTP rt ON ptw.ps_name=cast(rt.tp_name as varchar(30)) \n"
                + "WHERE s.ps_35_disp_name=NULLIF('" + request.getParameter("ps_id") + "',0)) AS koef \n"
                + ",CAST((SELECT sum(rt.SumPow)  \n"
                + "FROM SUPPLYCH s \n"
                + "LEFT JOIN tuweb.dbo.ps_tu_web ptw ON s.ps_10_disp_name=ptw.ps_id \n"
                + "LEFT JOIN ResultTP rt ON ptw.ps_name=cast(rt.tp_name as varchar(30)) \n"
                + "WHERE s.ps_35_disp_name=nullif('" + request.getParameter("ps_id") + "',0)) AS NUMERIC(10,2)) as SumPow";
        pstmt = c.prepareStatement(SQL);
        pstmt1 = c.prepareStatement(SQL1);
        rs = pstmt.executeQuery();
        rs1 = pstmt1.executeQuery();
        rs.next();
//        rs1.next();
        ps_nom = rs.getString("ps_nom_nav");
        ps_u = rs.getString("ps_nav");
        ps_zav = rs.getString("ps_zav");
        ps_rez = rs.getString("ps_rez");
        pow = rs.getString("request_power");
        if (rs1.next()) {
            sum_pow = rs1.getString("SumPow");
            koef = rs1.getString("koef");
        } else {
            sum_pow = "0";
            koef = "1";
        }
        p_max = rs.getString("p_max");

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
    pageContext.setAttribute("ps_nom", ps_nom);
    pageContext.setAttribute("ps_zav", ps_zav);
    pageContext.setAttribute("ps_rez", ps_rez);
    pageContext.setAttribute("pow", pow);
    pageContext.setAttribute("koef", koef);
    pageContext.setAttribute("sum_pow", sum_pow);
    pageContext.setAttribute("p_max", p_max);
%>
<json:object>
    <json:property name="ps_id"> ${ps_id}</json:property>
    <json:property name="ps_u"> ${ps_u}</json:property>
    <json:property name="ps_nom"> ${ps_nom}</json:property>
    <json:property name="ps_zav"> ${ps_zav}</json:property>
    <json:property name="ps_rez"> ${ps_rez}</json:property>
    <json:property name="pow"> ${pow}</json:property>
    <json:property name="koef"> ${koef}</json:property>
    <json:property name="sum_pow"> ${sum_pow}</json:property>
    <json:property name="p_max"> ${p_max}</json:property>
</json:object>

