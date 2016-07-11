<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>

<%
    Connection c = null;
    Statement s = null;
    String id = request.getParameter("rem_id");
    int num = Integer.parseInt(id);
    String rem_name = request.getParameter("rem_name");
    String dir_name = request.getParameter("dir_name");
    String rem_loc = request.getParameter("rem_loc");
    String dovirenist = request.getParameter("dovirenist");
    String golovnyi_ingener = request.getParameter("golovnyi_ingener");
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
    try {
        c = ds.getConnection();
        s = c.createStatement();
        String sql = "update rem set rem_name='" + rem_name + "',Director='" + dir_name.replace("'", "''") + "',rem_licality='" + rem_loc.replace("'", "''") + "',dovirenist='" + dovirenist + "',golovnyi_ingener='" + golovnyi_ingener + "' where rem_id='" + num + "'";
        //System.err.println(sql);
        s.executeUpdate(sql);
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(s);
        SQLUtils.closeQuietly(c);
        ic.close();
        response.sendRedirect(request.getContextPath() + "/frame/dic_rem.jsp");
    }
%>

