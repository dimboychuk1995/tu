/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.myapp.struts;

/**
 *
 * @author AsuSV
 */
public class PassActionForm extends org.apache.struts.action.ActionForm {
    
    private String user_name;
    private String user_pass;
    private String new_user_pass;
    private String rnew_user_pass;
    private String user_id_rem;

    public String getNew_user_pass() {
        return new_user_pass;
    }

    public void setNew_user_pass(String new_user_pass) {
        this.new_user_pass = new_user_pass;
    }

    public String getRnew_user_pass() {
        return rnew_user_pass;
    }

    public void setRnew_user_pass(String rnew_user_pass) {
        this.rnew_user_pass = rnew_user_pass;
    }

    public String getUser_id_rem() {
        return user_id_rem;
    }

    public void setUser_id_rem(String user_id_rem) {
        this.user_id_rem = user_id_rem;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_pass() {
        return user_pass;
    }

    public void setUser_pass(String user_pass) {
        this.user_pass = user_pass;
    }

    
    
}
