package ua.ifr.oe.tc.list;

import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author us8610
 */
public class SQLUtils {
    private static Logger logger = Logger.getLogger(SQLUtils.class);

    public static void closeQuietly(Connection connection) {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            logger.error("An error occurred closing connection.", e);
        }
    }

    public static void closeQuietly(Statement statement) {
        try {
            if (statement != null) {
                statement.close();
            }
        } catch (SQLException e) {
            logger.error("An error occurred closing statement.", e);
        }
    }

    public static void closeQuietly(ResultSet resultSet) {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
        } catch (SQLException e) {
            logger.error("An error occurred closing result set.", e);
        }
    }
}
