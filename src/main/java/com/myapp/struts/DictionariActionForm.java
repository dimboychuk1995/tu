/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.myapp.struts;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author AsuSV
 */
public class DictionariActionForm extends org.apache.struts.action.ActionForm {
    
    private String id;
    private String name;
    private String type;
    private
    List list_name;
    private String namelist;
    private String parid;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List getList_name() {
        return list_name;
    }

    public void setList_name(List list_name) {
        this.list_name = list_name;
    }

    public String getNamelist() {
        return namelist;
    }

    public void setNamelist(String namelist) {
        this.namelist = namelist;
    }


    /**
     * @return
     */
    public String getName() {
        return name;
    }

    /**
     * @param string
     */
    public void setName(String string) {
        name = string;
    }

    /**
     * @return
     */
    public String getId() {
        return id;
    }

    /**
     * @param i
     */
    public void setId(String i) {
        id = i;
    }

    public String getParid() {
        return parid;
    }

    public void setParid(String parid) {
        this.parid = parid;
    }

    /**
     *
     */
    public DictionariActionForm() {
        super();
        // TODO Auto-generated constructor stub
    }
}
