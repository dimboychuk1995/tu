<%@page import="ua.ifr.oe.tc.list.SQLUtils" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/json.tld" prefix="json" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page
        import="javax.sql.DataSource,java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException" %>
<% HttpSession ses = request.getSession();
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server

    String price_el_dev = new String();
    String price_el_dev_1 = new String();
    String p_price_join = new String();
    String customer_participate = new String();
    String db = new String();
    if (!ses.getAttribute("db_name").equals(null)) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = null;
    DataSource ds = null;
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        ic = new InitialContext();
        ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
        c = ds.getConnection();
        String SQL = ""
                + "SELECT ((((ISNULL(reliabylity_class_1_val,0) - ISNULL(reliabylity_class_1_val_old,0))*2) + ((ISNULL(reliabylity_class_2_val,0) - ISNULL(reliabylity_class_2_val_old,0))*2) + ((ISNULL(reliabylity_class_3_val,0) - ISNULL(reliabylity_class_3_val_old,0))))*250+ISNULL(tv.price_rec_build,0)+ISNULL(tv.fact_costs_build,0)-isnull(tv.devellopment_price,0)) as price_el_dev, \n"
                + "ISNULL(cast(((ISNULL(tv.cap_costs_build,0)-ISNULL(tv.unmount_devices_price,0))/NULLIF(s.ps_10_inc_rez,0)) AS NUMERIC(10,2)),0) AS p_price_join, \n"
                + "ISNULL(CAST(((ISNULL(tv.request_power,0)/NULLIF(tv.sum_join_pow,0))*(ISNULL(tv.rez_pow_for_date,0)*250+(ISNULL(tv.sum_join_pow,0)-ISNULL(tv.rez_pow_for_date,0))*ISNULL(cast(((ISNULL(tv.cap_costs_build,0)-ISNULL(tv.unmount_devices_price,0))/NULLIF(s.ps_10_inc_rez,0)) as numeric(10,2)),0)+ISNULL(tv.price_rec_build,0)+ISNULL(tv.fact_costs_build,0)-isnull(tv.devellopment_price,0)))AS NUMERIC(10,2)),0) AS price_el_dev_1 \n"
                + ",ISNULL(CAST(((ISNULL(tv.request_power,0)/NULLIF(tv.sum_join_pow,0))* ((ISNULL(tv.sum_join_pow,0) -  ISNULL(s.ps_10_reserv,0))/(NULLIF(s.ps_10_inc_rez,0)))*ISNULL(tv.cap_costs_build,0)) AS NUMERIC(15,2)),0) AS customer_participate \n"
                + " FROM   TC_V2 tv \n"
                + " left join [SUPPLYCH] s on tv.id = s.tc_id \n"
                + " where tv.id='" + request.getParameter("tu_id") + "'";
        pstmt = c.prepareStatement(SQL);
        System.out.println(SQL);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            price_el_dev = rs.getString("price_el_dev");
            price_el_dev_1 = rs.getString("price_el_dev_1");
            p_price_join = rs.getString("p_price_join");
            customer_participate = rs.getString("customer_participate");
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    }
    pageContext.setAttribute("price_el_dev", price_el_dev);
    pageContext.setAttribute("price_el_dev_1", price_el_dev_1);
    pageContext.setAttribute("p_price_join", p_price_join);
    pageContext.setAttribute("customer_participate", customer_participate);
%>
<json:object>
    <json:property name="price_el_dev"> ${price_el_dev}</json:property>
    <json:property name="price_el_dev_1"> ${price_el_dev_1}</json:property>
    <json:property name="p_price_join"> ${p_price_join}</json:property>
    <json:property name="customer_participate"> ${customer_participate}</json:property>
</json:object>

