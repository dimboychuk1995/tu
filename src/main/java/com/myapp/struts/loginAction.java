/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.myapp.struts;


import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author AsuSV
 */
public class loginAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String ERROR = "error";

    /**
     * This is the action called from the Struts framework.
     *
     * @param mapping  The ActionMapping used to select this instance.
     * @param form     The optional ActionForm bean for this request.
     * @param request  The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @return
     * @throws java.lang.Exception
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        loginActionForm login = (loginActionForm) form;
        HttpSession ses = request.getSession();

        login.Check();
        if ("login".equals(request.getParameter("method")) &&
                login != null && (login.getRet() == 1)) {
            ses.setAttribute("db_name", login.getDb_name());
            ses.setAttribute("fbdb_name", login.getFbdb_name());
            ses.setAttribute("user_name", login.getPIP());
            ses.setAttribute("userName", login.getPIP());
            ses.setAttribute("log", login);
            ses.setAttribute("rem_id", login.getId_rem());
            Cookie cookie_rem_id = new Cookie("rem_id", login.getId_rem());
            Cookie cookie_db_name = new Cookie("db_name", login.getDb_name());
            Cookie cookie_fbdb_name = new Cookie("fbdb_name", login.getFbdb_name());
            Cookie cookie_UREM_ID = new Cookie("UREM_ID", login.getUREM_ID());
            Cookie cookie_permisions = new Cookie("permisions", login.getPermisions());
            response.addCookie(cookie_UREM_ID);
            response.addCookie(cookie_db_name);
            response.addCookie(cookie_fbdb_name);
            response.addCookie(cookie_rem_id);
            response.addCookie(cookie_permisions);
            return mapping.findForward(SUCCESS);
        } else {
            return mapping.findForward(ERROR);
        }

    }
}
