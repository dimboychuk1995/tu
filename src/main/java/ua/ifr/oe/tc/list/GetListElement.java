/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ua.ifr.oe.tc.list;

import java.util.ArrayList;

/**
 *
 * @author AsuSV
 */
public class GetListElement {
    
    static public String getValbyId(ArrayList list,String id){
    ComboBoxList cb;
    String str = "";
    for(int i=0;i<list.size();i++){
        cb = (ComboBoxList)list.get(i);
        if(cb.getId().equals(id))str = cb.getName();
    }
        return str;
    }

}
