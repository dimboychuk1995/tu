/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ua.ifr.oe.tc.list;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author AsuSV
 */
public class Row {
    public  int id;
    public List cell;

    public Row(int id,List cell) {
        this.cell=cell;
        this.id=id;
    }

    public List getCell() {
        return cell;
    }

    public void setCell(List cell) {
        this.cell = cell;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    

}
