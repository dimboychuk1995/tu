package ua.ifr.oe.tc.list;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by us8610 on 09.02.2015.
 */
public class DBHelper {
    private static final String prefix = "java:comp/env/jdbc/";

    public static Connection getConnection(String db) throws NamingException, SQLException {
        Connection con;
        String path = prefix.concat(db);
        DataSource ds = (DataSource) new InitialContext().lookup(path);
        con = ds.getConnection();
        return con;
    }
    public static Connection getConnection() throws NamingException, SQLException {
        Connection con;
        String db = "java:comp/env/jdbc/TUWeb";
        DataSource ds = (DataSource) new InitialContext().lookup(db);
        con = ds.getConnection();
        return con;
    }

    public static void close(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                //TODO logging
                e.printStackTrace();
            }
        }
    }

    public static void close(Statement stmt) {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                //TODO logging
                e.printStackTrace();
            }
        }
    }

    public static void close(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                //TODO logging
                e.printStackTrace();
            }
        }
    }

    public static void closeAll(ResultSet rs, Statement stmt, Connection conn) {
        close(rs);
        close(stmt);
        close(conn);
    }
}
