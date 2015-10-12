/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ua.ifr.oe.tc.list;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 * @author AsuSV
 */
public class DataBase {
    private DataSource ds;
    private InitialContext ic;

    public DataBase(HttpServletRequest request) throws NamingException {
        HttpSession ses = request.getSession();
        String db = new String();
        if (ses.getAttribute("db_name") != null) {
            db = (String) ses.getAttribute("db_name");
        } else {
            db = MyCoocie.getCoocie("db_name", request);
        }
        //this.ic = new InitialContext();
        this.ds = (DataSource) this.ic.lookup("java:comp/env/jdbc/" + db);
    }

    public DataSource getDataSource() {
        return this.ds;
    }

    public boolean close() throws NamingException {
        this.ic.close();
        return true;
    }

}
