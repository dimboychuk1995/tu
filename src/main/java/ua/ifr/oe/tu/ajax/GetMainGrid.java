/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.ifr.oe.tu.ajax;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import ua.ifr.oe.tc.list.Row;
import ua.ifr.oe.tc.list.SQLUtils;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * @author us8610
 */
public class GetMainGrid extends HttpServlet {
    private static Logger logger = Logger.getLogger(GetMainGrid.class);
    private HttpServletRequest request;


    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.info("in GetMainGrid servlet");
        response.setContentType("text/html;charset=UTF-8");
        this.request = request;
        PrintWriter out = response.getWriter();
        Connection c = null;
        Connection c1 = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt1 = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSetMetaData rsmd = null;
        InitialContext ic = null;
        InitialContext ic1 = null;
        DataSource ds = null;
        List list = null;
        int count = 0;
        int total_pages = 0;
        JSONObject json = null;
        JSONArray rules = null;
        response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
        response.setHeader("Pragma", "no-cache"); //HTTP 1.0
        response.setDateHeader("Expires", 0); //prevents caching at the proxy server
        String page_json = param("page");
        String rows_json = param("rows");
        String sidx_json = param("sidx");
        String sord_json = param("sord");
        String ser_str = "";
        if (param("number") != null) {

            ser_str = " and ('" + param("number") + "' like '' or ltrim(number) like '%'+ltrim('" + param("number") + "')+'%')and"
                    + "('" + param("juridical") + "' like '' or ltrim(juridical) like '%'+ltrim('" + param("juridical") + "')+'%')and"
                    + "('" + param("f_name") + "' like '' or ltrim(f_name)	like '%'+ltrim(	'" + param("f_name") + "')+'%')and"
                    + "('" + param("object_name") + "' like '' or	ltrim(object_name)	like '%'+ltrim(	'" + param("object_name") + "')+'%')and"
                    + "('" + param("name_locality") + "' like '0'or	name_locality like '" + param("name_locality") + "' or object_adress like '%'+(select [name] from TC_LIST_locality where TC_LIST_locality.id like '" + param("name_locality") + "')+'%')and"
                    + "('" + param("object_adress") + "' like '' or ltrim(object_adress) like '%'+ltrim('" + param("object_adress") + "')+'%') and"
                    + "(('" + param("request_power_from") + "' like '' or '" + param("request_power_till") + "' like '') or "
                    + "(request_power>= cast(replace('" + param("request_power_from") + "',',','.') as numeric(10,2)) and "
                    + "request_power<= cast(replace('" + param("request_power_till") + "',',','.') as numeric(10,2)))) and"
                    + "('" + param("develloper_company") + "' like '0'or	develloper_company like '" + param("develloper_company") + "')and"
                    + "('" + param("performer_proect_to_point") + "' like '0' or performer_proect_to_point like '" + param("performer_proect_to_point") + "') and"
                    + "('" + param("performer_proect_after_point") + "' like '0' or performer_proect_after_point like '" + param("performer_proect_after_point") + "') and"
                    + "('" + param("customer_type") + "' like '2' or customer_type=cast('" + param("customer_type") + "' as int))and"
                    + "('" + param("customer_soc_status") + "' like '100' or customer_soc_status like cast('" + param("customer_soc_status") + "' as int))and"
                    + "(('" + param("initial_registration_date_rem_tu_from") + "' like '' or '" + param("initial_registration_date_rem_tu_till") + "' like '') or (initial_registration_date_rem_tu>='" + param("initial_registration_date_rem_tu_from") + "' and initial_registration_date_rem_tu<='" + param("initial_registration_date_rem_tu_till") + "')) and"
                    + "(('" + param("date_admission_consumer_from") + "' like '' or '" + param("date_admission_consumer_till") + "' like '') or (date_admission_consumer>='" + param("date_admission_consumer_from") + "' and date_admission_consumer<='" + param("date_admission_consumer_till") + "')) and"
                    + "(('" + param("date_contract_from") + "' like '' or '" + param("date_contract_till") + "' like '') or (date_contract>='" + param("date_contract_from") + "' and date_contract<='" + param("date_contract_till") + "'))and"
                    + "('" + param("ps_10_disp_name") + "' like '' or TC_V2.id in (select tc_id from SUPPLYCH where ps_10_disp_name ='" + param("ps_10_disp_name") + "') or TC_V2.id in (select tc_id from SUPPLYCH where ps_10_disp_name_tmp ='%'+'" + param("ps_10_disp_name") + "'+'%'))and"
                    + "('" + param("ps_35_disp_name") + "' like '0' or TC_V2.id in (select tc_id from SUPPLYCH where ps_35_disp_name ='" + param("ps_35_disp_name") + "'))and"
                    + "('" + param("fid_10_disp_name") + "' like '0' or TC_V2.id in (select tc_id from SUPPLYCH where fid_10_disp_name ='" + param("fid_10_disp_name") + "'))and"
                    + "('" + param("state_contract") + "' like '0' or state_contract like '" + param("state_contract") + "')and"
                    + "('" + param("do1") + "' like '' or do1 like '%" + param("do1") + "%')and"
                    + "('" + param("do2") + "' like '' or do2 like '%" + param("do2") + "%')and"
                    + "('" + param("do3") + "' like '' or do3 like '%" + param("do3") + "%')and"
                    + "('" + param("point_zab_power") + "' like '' or point_zab_power like '%" + param("point_zab_power") + "%')";
        }


        String st = "";
        String qWhere = "";

            if (param("_search") != null) {
                if (param("_search").equals("true")) {
                    json = new JSONObject(param("filters"));
                    logger.info("JSONObject(param(\"filters\")");
                    rules = json.getJSONArray("rules");
                    for (int ji = 0; ji < rules.length(); ji++) {
                        logger.info("for loop");
                        qWhere += " " + json.getString("groupOp") + " ";
                        if (rules.getJSONObject(ji).getString("op").equals("eq")) {
                            qWhere += rules.getJSONObject(ji).getString("field") + " = '" + rules.getJSONObject(ji).getString("data") + "'";
                        } else if (rules.getJSONObject(ji).getString("op").equals("ne")) {
                            qWhere += rules.getJSONObject(ji).getString("field") + " <> '" + rules.getJSONObject(ji).getString("data") + "'";
                        } else if (rules.getJSONObject(ji).getString("op").equals("bw")) {
                            qWhere += rules.getJSONObject(ji).getString("field") + "  LIKE  '" + rules.getJSONObject(ji).getString("data") + "%'";
                        } else if (rules.getJSONObject(ji).getString("op").equals("cn")) {
                            qWhere += rules.getJSONObject(ji).getString("field") + "  LIKE  " + "'%" + rules.getJSONObject(ji).getString("data") + "%'";
                        } else {
                            break;
                        }
                    }
                }
            }
            logger.info("before session");
            HttpSession ses = request.getSession();
            logger.info("after session");
            String db = (String) ses.getAttribute("db_name");
            logger.info("before try");
            try {
                ic = new InitialContext();
                ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
                c = ds.getConnection();
                logger.info("connection c");
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
                ic1 = new InitialContext();
                DataSource ds1 = (DataSource) ic1.lookup("java:comp/env/jdbc/" + db);
                c1 = ds1.getConnection();
                logger.info("connection c1");
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
                int numCols = rsmd.getColumnCount();
                JSONObject jsonObject = new JSONObject();
                logger.info("preparing json");
                List<Row> rows = new LinkedList<Row>();
                List cell;
                while (rs.next()) {
                    cell = new LinkedList();
                    cell.add("<a href=\"#\"onClick=\"window.open('tab.do?method=edit&bdname=" + db + "&tu_id=" + rs.getString(1) + "', '_parent', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');\" ><img src=\"../codebase/imgs/edit3.bmp\" alt=\"books_cat\" width=\"15\"/></a>");
                    for (int i = 2; i <= numCols; i++) {
                        if (rs.getString(i) == null) {
                            cell.add("");
                        } else {
                            cell.add(rs.getString(i));
                        }
                    }
                    rows.add(new Row(rs.getInt(1), cell));
                }
                SQLUtils.closeQuietly(rs);
                SQLUtils.closeQuietly(rs1);
                SQLUtils.closeQuietly(pstmt);
                SQLUtils.closeQuietly(pstmt1);
                SQLUtils.closeQuietly(pstmt1);
                SQLUtils.closeQuietly(c);
                SQLUtils.closeQuietly(c1);
                jsonObject.put("page", page_json);
                jsonObject.put("total", total_pages);
                jsonObject.put("records", count);
                jsonObject.put("sord_json", sord_json);
                jsonObject.put("rows", new JSONArray(rows));
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                out.write(jsonObject.toString());

            } catch (SQLException sqle) {
                logger.error(sqle.getMessage(), sqle);
            } catch (NamingException ne) {
                logger.error(ne.getMessage(), ne);
            } finally {
                SQLUtils.closeQuietly(rs);
                SQLUtils.closeQuietly(rs1);
                SQLUtils.closeQuietly(pstmt);
                SQLUtils.closeQuietly(pstmt1);
                SQLUtils.closeQuietly(pstmt1);
                SQLUtils.closeQuietly(c);
                SQLUtils.closeQuietly(c1);
                out.close();
            }
        }

    private String param(String name) {
        return request.getParameter(name);
    }
// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
