/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.struts;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author AsuSV
 */
public class MSuppluChAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String ISADD = "isadd";
    public static final String NEW = "-1";

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
            HttpServletRequest request, HttpServletResponse response) {


        MSupplyChForm mscf = (MSupplyChForm) form;
        mscf.init(request);
        final String method = request.getParameter("method");
        final String id = request.getParameter("id");
        if ("update".equals(method)) {
            if (NEW.equals(id)) {
                mscf.insert();
            } else {
                mscf.Update(id);
            }
            return mapping.findForward(ISADD);
        } else if ("edit".equals(method)) {
            mscf.Set(id);
            return mapping.findForward(SUCCESS);
        } else if ("delete".equals(method)) {
            mscf.Delete(id);
            return mapping.findForward(ISADD);
        } else {
            mscf.Clear();
            return mapping.findForward(SUCCESS);
        }
    }
}
