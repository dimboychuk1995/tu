/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.myapp.struts;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import ua.ifr.oe.tc.list.SQLUtils;
import ua.ifr.oe.tc.list.ListMaker;

import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author AsuSV
 */
public class DictionariAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";

    /**
     * This is the action called from the Struts framework.
     *
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        DictionariActionForm dictionari = (DictionariActionForm) form;
        InitialContext ic = null;
        Connection Conn = null;
        PreparedStatement pstmt = null;
        HttpSession ses = request.getSession();
        String db = (String) ses.getAttribute("db_name");
        if (request.getParameter("method").equals("add")) {
            try {
                ic = new InitialContext();
                DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
                Conn = ds.getConnection();
                pstmt = Conn.prepareStatement("{call dbo.LIST_SET_" + request.getParameter("dic") + "(?,?,?)}");
                pstmt.setString(1, dictionari.getName());
                pstmt.setString(2, dictionari.getType());
                pstmt.setString(3, dictionari.getParid());
                pstmt.executeUpdate();
                dictionari.setName("");
            } catch (SQLException ex) {
                ex.printStackTrace();
            } finally {
                SQLUtils.closeQuietly(pstmt);
                SQLUtils.closeQuietly(Conn);
                ic.close();
            }
        }
        {
            String s = "{call dbo.LIST_GET_";
            s = s + request.getParameter("dic") + "}";

            ListMaker list = new ListMaker("java:comp/env/jdbc/" + db, "");
            dictionari.setList_name(list.getList(s));
            //list.close();
            return mapping.findForward(SUCCESS);
        }
    }
}
