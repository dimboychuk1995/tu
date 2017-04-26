<%-- 
    Document   : ins_tu_in_sc
    Created on : 1 вер 2010, 11:24:53
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <%@ page import="javax.naming.InitialContext"%>
        <%@ page import="javax.sql.DataSource,java.sql.CallableStatement"%>
        <%@ page import="java.sql.Connection" %>
        <%@ page import="java.sql.SQLException" %>
        <%  String ps_nom_nav = request.getParameter("ps_t1");
            String ps_nom_nav_2 = request.getParameter("ps_t2");
            String ps_nav = request.getParameter("ps_nav");
            String ps_id = request.getParameter("tplist");
            String isRTR = request.getParameter("isRTR");
            InitialContext ic = new InitialContext();
            Connection c = null;
            CallableStatement st = null;
            DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
            String insertStoreProc = "{call updateTP(?,?,?,?,?)}";
            try {
                c = ds.getConnection();
                st=c.prepareCall(insertStoreProc);
                st.setInt(1, Integer.parseInt(ps_id));
                st.setString(2, ps_nom_nav.replace(",", "."));
                st.setString(3, ps_nom_nav_2.replace(",", "."));
                st.setString(4, ps_nav.replace(",", "."));
                st.setInt(5, Integer.parseInt(isRTR));
                st.executeUpdate();
            } catch (SQLException sqlex) {
                sqlex.printStackTrace();
            } finally {
                SQLUtils.closeQuietly(st);
                SQLUtils.closeQuietly(c);
                ic.close();
                response.sendRedirect("../../dic_ps.jsp");
            }
        %></body>
</html>