/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.struts;

/**
 *
 * @author AsuSV
 */

import ua.ifr.oe.tc.list.SQLUtils;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class History {

    private String id;
    private String tc_id;
    private String user;
    private String date;
    private String logstring;

    public String getTc_id() {
        return tc_id;
    }

    public void setTc_id(String tc_id) {
        this.tc_id = tc_id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLogstring() {
        return logstring;
    }

    public void setLogstring(String logstring) {
        this.logstring = logstring;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public void HistorySave(HttpServletRequest request) throws NamingException, SQLException {

        HttpSession ses = request.getSession();
        String db;
        if (ses.getAttribute("db_name") != null) {
            db = (String) ses.getAttribute("db_name");
        } else {
            db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
        }
        String us_name = (String) ses.getAttribute("user_name");

        Connection Conn = null;
        PreparedStatement pstmt = null;
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
        try {
            Conn = ds.getConnection();
            pstmt = Conn.prepareStatement("{call dbo.history(?,?,?)}");
            pstmt.setString(1, getTc_id());
            pstmt.setString(2, us_name);
            pstmt.setString(3, getLogstring());
            pstmt.executeUpdate();
        } catch (SQLException sqlex) {
            sqlex.getMessage();
        } finally {
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(Conn);
            ic.close();
        }
    }
}
