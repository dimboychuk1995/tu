/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ua.ifr.oe.tc.list;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author AsuSV
 */
public class MyCoocie {
    static public String getCoocie(String name,HttpServletRequest request ){
        String val = null;

            Cookie cookies [] = request.getCookies ();
            Cookie myCookie = null;
            if (cookies != null)
            {
                for (int i = 0; i < cookies.length; i++)
                {
                    if (cookies [i].getName().equals (name))
                    // we have added the cookie with name "name"
                    {
                        myCookie = cookies[i];
                        break;
                    }
                }
            }
        if (myCookie == null) { val=null; } else {     val=myCookie.getValue();  }

        return val;
    }

}
