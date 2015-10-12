<%-- 
    Document   : changes_tu_json
    Created on : 11 жовт 2010, 10:37:37
    Author     : AsuSV
--%>

<%@page import="com.myapp.struts.loginActionForm"%>
<%@page import="org.json.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/json.tld" prefix="json" %>
<%@ page import="org.json.JSONObject"%>
<%@ page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@ page import="javax.naming.InitialContext,javax.sql.DataSource,java.sql.*,java.util.ArrayList"%>
<%@ page import="ua.ifr.oe.tc.list.Row" %>
<%
    String page_json = request.getParameter("page");
    String rows_json = request.getParameter("rows");
    String sidx_json = request.getParameter("sidx");
    String sord_json = request.getParameter("sord");
    Connection c = null;
    Connection c1 = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt1 = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    ResultSetMetaData rsmd = null;
    JSONObject json = new JSONObject();
    JSONArray rules;
    String st = new String();
    int count = 0;
    int total_pages=0;
    String qWhere = new String();
    ArrayList list = null;
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
    if (!ses.getAttribute("db_name").equals(null)) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try {
        c = ds.getConnection();
        stmt = c.createStatement();
        pstmt = c.prepareStatement("SELECT top " + rows_json + " isnull(Changestc.id,'') as id,"
                + "isnull(TC_V2.number,'') as id_tc,"
                + "isnull(juridical,'')+' '+isnull(TC_V2.f_name,'')+' '+isnull(TC_V2.s_name,'')+' '+isnull(TC_V2.t_name,'') as pip,"
                + "isnull(No_letter,''), "
                + "case when type_letter=1 then 'Неукладений'"
                + "when type_letter=2 then 'Правочин з додатками' "
                + "when type_letter=3 then 'Продовжений листом'"
                + "when type_letter=4 then 'Продовжений по правочину'"
                + "when type_letter=5 then 'Розірваний листом'"
                + "when type_letter=6 then 'Розірваний по правочину' "
                + "when type_letter=7 then 'Змінений листом'"
                + "when type_letter=8 then 'Змінений по правочину' "
                + "when type_letter=9 then 'Лист відмова' "
                + "when type_letter=10 then 'Лист попередження' "
                + "when type_letter=11 then 'Неукладений(приєднання)' "
                + "when type_letter=12 then 'Розірваний по правочину(приєднання)' "
                + "when type_letter=13 then 'Лист про продовження строку приєднання' "
                + "when type_letter=14 then 'Лист-звернення до власника земельної ділянки' "
                + "when type_letter=15 then 'Додаткова угода про оплату нестандартного приєднання' "
                + "when type_letter=16 then 'Лист-відмова у стандартному приєднанні' "
                + "else 'невказано' end as type_letter,"
                + "isnull(in_namber,''),  "
                + "isnull(out_namber    ,''),  "
                + "isnull(convert(char(10),send_date_lenner,104),'') as send_date_lenner ,"
                + "isnull(convert(varchar,limit_date,104),'') as limit_date ,"
                + "isnull(convert(char(10),tc_continue_to,104),'') as Tc_continue_to,"
                + "isnull(convert(char(10),change_date_tc,104),'') as Change_date_tc,"
                + "isnull(Description_change,''), "
                + "isnull(TC_v2.executor_company,1) as executor_company "
                + ",isnull(TC_V2.customer_soc_status,'') as customer_soc_status "
                + "FROM Changestc "
                + "left join TC_V2 on Changestc.id_tc = TC_V2.id "
                + "WHERE (Changestc.id not in (select top (" + rows_json + "*(" + page_json + "-1)) id from Changestc  "
                + "ORDER BY " + sidx_json + " " + sord_json + ") and " + request.getParameter("tu_id") + "=-1) or Changestc.id_tc=" + request.getParameter("tu_id") + qWhere + " ORDER BY " + sidx_json + " " + sord_json);
        rs = pstmt.executeQuery();
        DataSource ds1 = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
        c1 = ds1.getConnection();
        pstmt1 = c1.prepareStatement("SELECT COUNT(*) AS count   FROM Changestc where 1=1 " + qWhere);
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
        cell = new ArrayList();
        int j = 0;
        String type = "";
        String pr = "";
        while (rs.next()) {
            if (rs.getString("executor_company").equals("1")) {
                pr = "vts";
            } else {
                pr = "rem";
            }

            if (rs.getString(5).equals("Правочин з додатками")) {
                type = "/pravoch/dodatki.jsp";
            } else if (rs.getString(5).equals("Продовжений листом")) {
                type = "/letter/prod.jsp";
            } else if (rs.getString(5).equals("Продовжений по правочину")) {
                type = "/pravoch/prod.jsp";
            } else if (rs.getString(5).equals("Розірваний листом")) {
                type = "/letter/roz.jsp";
            } else if (rs.getString(5).equals("Розірваний по правочину")) {
                type = "/pravoch/roz.jsp";
            } else if (rs.getString(5).equals("Змінений листом")) {
                type = "/letter/zmin.jsp";
            } else if (rs.getString(5).equals("Змінений по правочину")) {
                type = "/pravoch/zmin.jsp";
            } else if (rs.getString(5).equals("Неукладений")) {
                type = "/letter/neukl.jsp";
            } else if (rs.getString(5).equals("Неукладений")) {
                type = "/pravoch/neukl.jsp";
            } else if (rs.getString(5).equals("Лист відмова")) {
                type = "/letter/vidmova.jsp";
            } else if (rs.getString(5).equals("Лист попередження")) {
                type = "/letter/popereg.jsp";
            } else if (rs.getString(5).equals("Неукладений(приєднання)")) {
                type = "/letter/neukl_join.jsp";
            } else if (rs.getString(5).equals("Розірваний по правочину(приєднання)")) {
                type = "/pravoch/roz_join.jsp";
            } else if (rs.getString(5).equals("Лист про продовження строку приєднання")) {
                type = "/letter/extension_of_term.jsp";
            } else if (rs.getString(5).equals("Лист-звернення до власника земельної ділянки")) {
                type = "/letter/appeals_to_owner.jsp";
            } else if (rs.getString(5).equals("Додаткова угода про оплату нестандартного приєднання")) {
                type = "/letter/dod_deal.jsp";
            } else if (rs.getString(5).equals("Лист-відмова у стандартному приєднанні")) {
                type = "/pravoch/vidmova_join.jsp";
            }



            cell.clear();
            if (((loginActionForm) ses.getAttribute("log")).getRole().equals("128")) {
                cell.add("");
            } else {
                cell.add(new String("<a href='changestuxp.do?method=edit&id=" + rs.getString(1) + "'><img src=\"../../codebase/imgs/edit3.bmp\" alt=\"books_cat\" width=\"15\"/></a><a href=\"#\"onClick=\"window.open('../blank/tc_ch/" + pr + type + "?id=" + rs.getString(1) + "', '_blank', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');\" >Видати документ</a>"));
            }
            for (int i = 2; i < numCols; i++) {
                cell.add(new String(rs.getString(i)));
            }
            cell.add(qWhere);
            list.add(new Row(rs.getInt(1), (ArrayList) cell.clone()));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(rs1);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(pstmt1);
        SQLUtils.closeQuietly(c);
        ic.close();
    }
    pageContext.setAttribute("page", page_json);
    pageContext.setAttribute("total", total_pages);
    pageContext.setAttribute("records", count);
    pageContext.setAttribute("rows", list);
    pageContext.setAttribute("sord_json", sord_json);
%>
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