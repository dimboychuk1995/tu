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
        <%  String ps_nom_nav = request.getParameter("ps_t1_add");
            String ps_nom_nav_2 = request.getParameter("ps_t2_add");
            String ps_nav = request.getParameter("ps_nav_add");
            String ps_name = request.getParameter("ps_name_add");
            String ps_nominal = request.getParameter("ps_nominal");
            String rem_id = request.getParameter("rem");
            InitialContext ic = new InitialContext();
            Connection c = null;
            CallableStatement st = null;
            DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
            String insertStoreProc = "{call addTP(?,?,?,?,?,?)}";
            try {
                c = ds.getConnection();
                st=c.prepareCall(insertStoreProc);
                st.setInt(1, Integer.parseInt(rem_id));
                st.setString(2, ps_name);
                st.setInt(3, Integer.parseInt(ps_nominal));
                st.setString(4, ps_nom_nav.replace(",", "."));
                st.setString(5, ps_nom_nav_2.replace(",", "."));
                st.setString(6, ps_nav.replace(",", "."));
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
