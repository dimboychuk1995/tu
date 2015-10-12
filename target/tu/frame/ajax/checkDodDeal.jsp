<%@page import="com.google.gson.Gson"%>
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession ses = request.getSession();
    String db;
    String check="";
    response.setContentType("application/json");
    if (ses.getAttribute("db_name")!=null) {
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
        
        String sql = "IF EXISTS (SELECT [id] FROM [dbo].[Changestc] WHERE type_letter=15 AND id_tc ='" + request.getParameter("tu_id") + "') "
           + "    SELECT 'true' as [check] "
           + "ELSE "
           + "   SELECT 'false' as [check] ";
        pstmt = c.prepareStatement(sql);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            check = rs.getString("check");
        }
        String jsonString = new Gson().toJson(check);
        response.getWriter().write(jsonString);
    } catch (SQLException ex) {
        ex.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    }

%>