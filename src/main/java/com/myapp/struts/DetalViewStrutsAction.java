/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.struts;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;


/**
 *
 * @author VasjaNet
 */
public class DetalViewStrutsAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    public static final String NEW_TU_ID = "-1";
    private final Logger logger = Logger.getLogger(DetalViewStrutsAction.class);

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
            HttpServletRequest request, HttpServletResponse response) throws NamingException, SQLException {
        DetalViewActionForm detailview = (DetalViewActionForm) form;
        HttpSession ses = request.getSession();
        detailview.initCustomer(request);
        String tmp = null;
        final String method = request.getParameter("method");
        final String tu_id = request.getParameter("tu_id");
        if ("update".equals(method)) {
            if (NEW_TU_ID.equals(tu_id)) {
                logger.info("insert()");
                detailview.InsertCustomer();
            } else if (!"".equals(detailview.getNumber())) {
                logger.info("update()");
                tmp = detailview.UpdateCustomer(tu_id);
            }
            return mapping.findForward("test");
        } else if ("edit".equals(method)) {
            detailview.SetCustomer(tu_id);
            logger.info("get()");
            ses.setAttribute("tcCustomer", detailview);
            return mapping.findForward(SUCCESS);
        } else if ("delete".equals(method)) {
            logger.info("delete()");
            detailview.DeleteCustomer(tu_id);
            return mapping.findForward(SUCCESS);
        } else {
            detailview.ClirBean();
            logger.info("clear bean()");
            return mapping.findForward(SUCCESS);
        }
    }
}
