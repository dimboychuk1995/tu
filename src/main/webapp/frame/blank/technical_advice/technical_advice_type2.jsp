<%--
  Created by IntelliJ IDEA.
  User: us9522
  Date: 24.04.2017
  Time: 8:27
  To change this template use File | Settings | File Templates.
--%>
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.*,java.text.NumberFormat"%>

<%  response.setHeader("Content-Disposition", "inline;filename=fiz.doc");
    NumberFormat nf = NumberFormat.getInstance();
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
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



        String qry = "";



        pstmt = c.prepareStatement(qry);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCdls = rsmd.getColumnCount();
        String tmp = "";
        int i = 1;
        int k = 2;
        rs.next();
%>

<html>
    <head>
        <title>Title</title>
    </head>
    <body>
        <%} catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(c);
            ic.close();
        }
        %>
    </body>
</html>
