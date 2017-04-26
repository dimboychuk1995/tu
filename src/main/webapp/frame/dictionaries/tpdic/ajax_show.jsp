<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/json.tld" prefix="json" %>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
    String ps_t1 = new String();
    String ps_t2 = new String();
    String ps_nav = new String();
    String edit_date = new String();
    String typeRTR = new String();
    String isRTR = new String();
    InitialContext ic = null;
    DataSource ds = null;
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        ic = new InitialContext();
        ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
        c = ds.getConnection();
        String sql = "SELECT  ps_nom_nav,ps_nav,ps_nom_nav_2,isnull(convert(varchar(20),edit_date,104),'') as edit_date, isRTR, ISNULL([typeRTR],'-') as typeRTR"
                + " FROM ps_tu_web WHERE ps_id=" + request.getParameter("ps_id");
        pstmt = c.prepareStatement(sql);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            ps_t1 = rs.getString("ps_nom_nav");
            ps_t2 = rs.getString("ps_nom_nav_2");
            ps_nav = rs.getString("ps_nav");
            edit_date = rs.getString("edit_date");
            typeRTR = rs.getString("typeRTR");
            isRTR = rs.getString("isRTR");
        }
    } catch (SQLException ex) {
        System.out.println("Помилка БД");
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    }
    pageContext.setAttribute("ps_t1", ps_t1);
    pageContext.setAttribute("ps_t2", ps_t2);
    pageContext.setAttribute("ps_nav", ps_nav);
    pageContext.setAttribute("edit_date", edit_date);
    pageContext.setAttribute("typeRTR", typeRTR);
    pageContext.setAttribute("isRTR", isRTR);
%>
<json:object >
    <json:property name="ps_t1" > ${ps_t1}</json:property>
    <json:property name="ps_t2" > ${ps_t2}</json:property>
    <json:property name="ps_nav" > ${ps_nav}</json:property>
    <json:property name="edit_date" > ${edit_date}</json:property>
    <json:property name="typeRTR" > ${typeRTR}</json:property>
    <json:property name="isRTR" > ${isRTR}</json:property>
</json:object>
