<%-- 
    Document   : main_grid_json
    Created on : 13 жовт 2010, 15:50:57
    Author     : AsuSV
--%>
<%@page import="org.json.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/json.tld" prefix="json" %>
<%@ page import="org.json.JSONObject"%>
<%@ page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@ page import="javax.naming.InitialContext,javax.sql.DataSource,java.sql.*,java.util.ArrayList"%>
<%
    Connection c = null;
    Connection c1 = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt1 = null;
    Statement stmt = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    ResultSetMetaData rsmd = null;
    ArrayList list=null;
    int count = 0;
    int total_pages=0;
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
    String page_json = request.getParameter("page");
    String rows_json = request.getParameter("rows");
    String sidx_json = request.getParameter("sidx");
    String sord_json = request.getParameter("sord");

    String ser_str = "";
    if (request.getParameter("number") != null) {
        ser_str = " and ('" + request.getParameter("number") + "' like '' or ltrim(number) like '%'+ltrim('" + request.getParameter("number") + "')+'%')and"
                + "('" + request.getParameter("juridical") + "' like '' or ltrim(juridical) like '%'+ltrim('" + request.getParameter("juridical") + "')+'%')and"
                + "('" + request.getParameter("f_name") + "' like '' or ltrim(f_name)	like '%'+ltrim(	'" + request.getParameter("f_name") + "')+'%')and"
                + "('" + request.getParameter("object_name") + "' like '' or	ltrim(object_name)	like '%'+ltrim(	'" + request.getParameter("object_name") + "')+'%')and"
                + "('" + request.getParameter("name_locality") + "' like '0'or	name_locality like '" + request.getParameter("name_locality") + "' or object_adress like '%'+(select [name] from TC_LIST_locality where TC_LIST_locality.id like '" + request.getParameter("name_locality") + "')+'%')and"
                + "('" + request.getParameter("object_adress") + "' like '' or ltrim(object_adress) like '%'+ltrim('" + request.getParameter("object_adress") + "')+'%') and"
                + "(('" + request.getParameter("request_power_from") + "' like '' or '" + request.getParameter("request_power_till") + "' like '') or "
                + "(request_power>= cast(replace('" + request.getParameter("request_power_from") + "',',','.') as numeric(10,2)) and "
                + "request_power<= cast(replace('" + request.getParameter("request_power_till") + "',',','.') as numeric(10,2)))) and"
                + "('" + request.getParameter("develloper_company") + "' like '0'or	develloper_company like '" + request.getParameter("develloper_company") + "')and"
                + "('" + request.getParameter("performer_proect_to_point") + "' like '0' or performer_proect_to_point like '" + request.getParameter("performer_proect_to_point") + "') and"
                + "('" + request.getParameter("performer_proect_after_point") + "' like '0' or performer_proect_after_point like '" + request.getParameter("performer_proect_after_point") + "') and"
                + "('" + request.getParameter("customer_type") + "' like '2' or customer_type=cast('" + request.getParameter("customer_type") + "' as int))and"
                + "('" + request.getParameter("customer_soc_status") + "' like '100' or customer_soc_status like cast('" + request.getParameter("customer_soc_status") + "' as int))and"
                + "(('" + request.getParameter("initial_registration_date_rem_tu_from") + "' like '' or '" + request.getParameter("initial_registration_date_rem_tu_till") + "' like '') or (initial_registration_date_rem_tu>='" + request.getParameter("initial_registration_date_rem_tu_from") + "' and initial_registration_date_rem_tu<='" + request.getParameter("initial_registration_date_rem_tu_till") + "')) and"
                + "(('" + request.getParameter("date_admission_consumer_from") + "' like '' or '" + request.getParameter("date_admission_consumer_till") + "' like '') or (date_admission_consumer>='" + request.getParameter("date_admission_consumer_from") + "' and date_admission_consumer<='" + request.getParameter("date_admission_consumer_till") + "')) and"
                + "(('" + request.getParameter("date_contract_from") + "' like '' or '" + request.getParameter("date_contract_till") + "' like '') or (date_contract>='" + request.getParameter("date_contract_from") + "' and date_contract<='" + request.getParameter("date_contract_till") + "'))and"
                + "('" + request.getParameter("ps_10_disp_name") + "' like '' or TC_V2.id in (select tc_id from SUPPLYCH where ps_10_disp_name ='" + request.getParameter("ps_10_disp_name") + "') or TC_V2.id in (select tc_id from SUPPLYCH where ps_10_disp_name_tmp ='%'+'" + request.getParameter("ps_10_disp_name") + "'+'%'))and"
                + "('" + request.getParameter("ps_35_disp_name") + "' like '0' or TC_V2.id in (select tc_id from SUPPLYCH where ps_35_disp_name ='" + request.getParameter("ps_35_disp_name") + "'))and"
                + "('" + request.getParameter("fid_10_disp_name") + "' like '0' or TC_V2.id in (select tc_id from SUPPLYCH where fid_10_disp_name ='" + request.getParameter("fid_10_disp_name") + "'))and"
                + "('" + request.getParameter("state_contract") + "' like '0' or state_contract like '" + request.getParameter("state_contract") + "')and"
                + "('" + request.getParameter("do1") + "' like '' or do1 like '%" + request.getParameter("do1") + "%')and"
                + "('" + request.getParameter("do2") + "' like '' or do2 like '%" + request.getParameter("do2") + "%')and"
                + "('" + request.getParameter("do3") + "' like '' or do3 like '%" + request.getParameter("do3") + "%')and"
                + "('" + request.getParameter("point_zab_power") + "' like '' or point_zab_power like '%" + request.getParameter("point_zab_power") + "%')";
    }


    JSONObject json = new JSONObject();
    JSONArray rules;
    String st = new String();
    String qWhere = new String();
    if (request.getParameter("_search") != null) {
        if (request.getParameter("_search").equals("true")) {
            json = new JSONObject(request.getParameter("filters"));
            rules = json.getJSONArray("rules");
            for (int ji = 0; ji < rules.length(); ji++) {
                qWhere += " " + json.getString("groupOp") + " ";
                if (rules.getJSONObject(ji).getString("op").equals("eq")) {
                    qWhere += rules.getJSONObject(ji).getString("field") + " = '" + rules.getJSONObject(ji).getString("data") + "'";
                } else if (rules.getJSONObject(ji).getString("op").equals("ne")) {
                    qWhere += rules.getJSONObject(ji).getString("field") + " <> '" + rules.getJSONObject(ji).getString("data") + "'";
                } else if (rules.getJSONObject(ji).getString("op").equals("bw")) {
                    qWhere += rules.getJSONObject(ji).getString("field") + "  LIKE  '" + rules.getJSONObject(ji).getString("data") + "%'";
                } else if (rules.getJSONObject(ji).getString("op").equals("cn")) {
                    qWhere += rules.getJSONObject(ji).getString("field") + "  LIKE  " + "'%" + rules.getJSONObject(ji).getString("data") + "%'";
                }
            }
        }
    }

    HttpSession ses = request.getSession();
    String db = new String();
    if (ses.getAttribute("db_name")!=null) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try {
        c = ds.getConnection();
        stmt = c.createStatement();
        String SQL = "select top " + rows_json + " TC_V2.id,registration_date ,"
                + "isnull (TUWeb.dbo.TC_LIST_customer_soc_status.name,'Громадянин') as customer_soc_status,"
                + "juridical,f_name,s_name,customer_type,number,type_contract,type_join,initial_registration_date_rem_tu,"
                + "connection_price,price_join,date_pay_join,executor_company,"
                + "isnull(TUWeb.dbo.status_document.status_name,'') as state_contract," + "object_name,"
                + "isnull(TC_LIST_locality.name,'')+' '+isnull(object_adress,'') as object_adress,"
                + "request_power,"
                + "case when reliabylity_class_1 like 'true' or reliabylity_class_1 like '1' then 'І-кат.'"
                + "when reliabylity_class_2 like 'true' or reliabylity_class_2 like '1' then 'ІІ-кат.'"
                + "when reliabylity_class_3 like 'true' or reliabylity_class_3 like '1' then 'ІІІ-кат.' "
                + "else '' end as reliabylity_class,"
                + "point_zab_power,"
                + "isnull(cast(term_for_joining as varchar(20)),'') as term_for_joining,"
                + "isnull((select stuff(( "
                + "select distinct ', ' + cast(p.ps_name as varchar(50))  as 'text()' from SUPPLYCH s "
                + "left join TUWeb.dbo.ps_tu_web p on p.ps_id = s.ps_35_disp_name "
                + "where TC_V2.id=s.tc_id "
                + "for  xml path('')),1,2,'')),'') as ps_35_disp_name, "
                + "isnull((select stuff((select distinct ', ' + cast(p.ps_name as varchar(50)) as 'text()' from SUPPLYCH s "
                + "left join TUWeb.dbo.ps_tu_web p on p.ps_id = s.ps_10_disp_name "
                + "where TC_V2.id=s.tc_id "
                + "for  xml path('')),1,1,'')),'') as ps_10_disp_name, "
                + "isnull((stuff((select distinct ', ' + cast(p.feed_name as varchar(50)) as 'text()' from SUPPLYCH s "
                + "left join TUWeb.dbo.feed_35_110_tu_web p on p.feed_id = s.fid_10_disp_name "
                + "where TC_V2.id=s.tc_id "
                + "for xml path('')),1,1,'')),'') as fid_10_disp_name, "
                + "date_connect_consumers,"
                + "isnull(TUWeb.dbo.performer.name,'') as develloper_company,"
                + "devellopment_price," + "pay_date_devellopment,date_giving_akt"
                + ",date_admission_akt, date_start_bmr, "
                + " date_filling_voltage "
                + "FROM dbo.TC_V2 "
                + "left join TC_LIST_type_contract on (TC_LIST_type_contract.id = TC_V2.type_contract)"
                + "left join TUWeb.dbo.TC_LIST_customer_soc_status on ( TUWeb.dbo.TC_LIST_customer_soc_status.id=TC_V2.customer_soc_status)"
                + "left join TC_LIST_locality on (TC_LIST_locality.id = TC_V2.customer_locality)"
                + "left join TC_LIST_reason_tc on (TC_LIST_reason_tc.id =TC_V2.reason_tc)"
                + "left join TC_LIST_locality lc on (lc.id =TC_V2.name_locality)"
                + "left join TUWeb.dbo.performer on (TUWeb.dbo.performer.id = TC_V2.develloper_company)"
                + "left join TUWeb.dbo.status_document on (TUWeb.dbo.status_document.status_id=TC_V2.state_contract)"
                + "where TC_V2.id not in (select top (" + rows_json + "*(" + page_json + "-1)) TC_V2.id from TC_V2 left join SUPPLYCH on SUPPLYCH.tc_id=TC_V2.id where 1=1  " + ser_str + "  ORDER BY " + sidx_json + " " + sord_json + ")"
                + qWhere + " " + ser_str + " ORDER BY " + sidx_json + " " + sord_json;

        pstmt = c.prepareStatement(SQL);
        rs = pstmt.executeQuery();
        DataSource ds1 = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
        c1 = ds1.getConnection();
        pstmt1 = c1.prepareStatement("SELECT COUNT(*) AS count FROM dbo.TC_V2 where 1=1 " + ser_str);
        rs1 = pstmt1.executeQuery();
        rs1.next();
        count = rs1.getInt("count");
        if (count > 0) {
            total_pages = (count + (Integer.parseInt(rows_json) - 1)) / Integer.parseInt(rows_json);
        } else {
            total_pages = 0;
        }
        rsmd = rs.getMetaData();
        int records = rs.getRow();
        int numCols = rsmd.getColumnCount();
        list = new ArrayList();
        ArrayList cell;
        String tmpstr;
        int j = 0;
        while (rs.next()) {
            cell = new ArrayList();
            cell.add(new String("<a href=\"#\"onClick=\"window.open('tab.do?method=edit&bdname=" + db + "&tu_id=" + rs.getString(1) + "', '_parent', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');\" ><img src=\"../codebase/imgs/edit3.bmp\" alt=\"books_cat\" width=\"15\"/></a>"));
            for (int i = 2; i <= numCols; i++) {
                if (rs.getString(i) == null) {
                    tmpstr = "";
                } else {
                    tmpstr = rs.getString(i);
                }
                cell.add(tmpstr);
            }
            list.add(new rows(rs.getInt(1), cell));
        }


    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(rs1);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(pstmt1);
        SQLUtils.closeQuietly(pstmt1);
        SQLUtils.closeQuietly(stmt);
        SQLUtils.closeQuietly(c);
        SQLUtils.closeQuietly(c1);
        ic.close();
    }

    pageContext.setAttribute("page", page_json);
    pageContext.setAttribute("total", total_pages);
    pageContext.setAttribute("records", count);
    pageContext.setAttribute("rows", list);
    pageContext.setAttribute("sord_json", sord_json);
%>
<%--=SQL--%>
<json:object >
    <json:property name="page" > ${page}</json:property>
    <json:property name="total" > ${total}</json:property>
    <json:property name="records" > ${records}</json:property>
    <json:array name="rows" var="rows" items="${rows}">
        <json:object>
            <json:property name="id" value="${rows.id}"/>
            <json:array name="cell" items="${rows.cell}"/>
        </json:object>
    </json:array>
    <json:object name="userdata" >
        <json:property name="amount" > ${amount} </json:property>
        <json:property name="tax" > ${tax} </json:property>
        <json:property name="total" > ${total} </json:property>
        <json:property name="name" > ${name} </json:property>
    </json:object>
</json:object>
