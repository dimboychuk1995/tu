/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.myapp.struts;

import Utils.md5ApacheCl;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author AsuSV
 */
public class PassAction extends org.apache.struts.action.Action {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    
    /**
     * This is the action called from the Struts framework.
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
        PassActionForm pass = (PassActionForm)form;

        if (request.getParameter("method").equals("edit"))
        {
            InitialContext ic = new InitialContext();
            DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/TUWeb");
            Connection Conn = ds.getConnection();
            PreparedStatement pstmt = Conn.prepareStatement("{call dbo.TC_CH_PSWD(?,?,?,?)}");
            pstmt.setString(1, pass.getUser_name());
            pstmt.setString(2, md5ApacheCl.md5Apache(pass.getUser_pass()));
            pstmt.setString(3, md5ApacheCl.md5Apache(pass.getNew_user_pass()));
            pstmt.setString(4, md5ApacheCl.md5Apache(pass.getRnew_user_pass()));
            //Якщо додати параметр (номер рему), то процедура не буде виконуватись для рористувачв в яких rem_id = 0
            //pstmt.setString(5, pass.getUser_id_rem());
            pstmt.executeUpdate();
            pstmt.close();
            Conn.close();
            ic.close();
        }
  
        return mapping.findForward(SUCCESS);
    }
}
