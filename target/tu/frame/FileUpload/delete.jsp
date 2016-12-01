<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>

<%   HttpSession ses = request.getSession();
    String db = (String) ses.getAttribute("db_name");
    Connection c = null;
    Statement s = null;
    String path = "\\\\Obl-java\\TUFiles\\";
    String file_name = request.getParameter("file");
    path+=file_name;
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    System.out.println(file_name.replace("'", "''"));
    try {
        c = ds.getConnection();
        s = c.createStatement();
        String SQL = "DELETE FROM [Files] WHERE [file_name]='" + file_name.replace("'", "''") + "'";
        
        s.execute(SQL);
        File file = new File(path);
        file.delete();
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(s);
        SQLUtils.closeQuietly(c);
        ic.close();
        response.sendRedirect(request.getContextPath() + "/frame/FileUpload/fileupload.jsp?tu_id=" + request.getParameter("tu_id"));
    }
%>
