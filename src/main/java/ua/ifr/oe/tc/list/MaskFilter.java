/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ua.ifr.oe.tc.list;

/**
 *
 * @author AsuSV
 */

import java.io.File;
import java.io.FilenameFilter;
public  class  MaskFilter   implements FilenameFilter
{
  String mask;

  MaskFilter(String sMask)
  {
    mask = sMask;
  }

  public boolean accept(File f, String name)
  {
    if(mask.equals("*"))
      return true;

    else if(mask.equals("*dir"))
      return(new File(f, name).isDirectory());

    else
      return(name.endsWith(mask));
  }
}
