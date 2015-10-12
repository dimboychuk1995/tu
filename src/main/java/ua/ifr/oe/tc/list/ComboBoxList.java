/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ua.ifr.oe.tc.list;


/**
 *
 * @author AsuSV
 */
public class ComboBoxList {
    private String Id;
    private String name;

    public ComboBoxList(String Id, String Name)
    {
        this.Id = Id;
        this.name = Name;
    }

    /**
     * @return the setREM_Id
     */
    public String getId() {
        return Id;
    }

    /**
     * @param setREM_Id the setREM_Id to set
     */
    public void setId(String Id) {
        this.Id = Id;
    }

    /**
     * @return the getREM_Name
     */
    public String getName() {
        return name;
    }

    /**
     * @param getREM_Name the getREM_Name to set
     */
    public void setName(String Name) {
        this.name = Name;
    }
}
