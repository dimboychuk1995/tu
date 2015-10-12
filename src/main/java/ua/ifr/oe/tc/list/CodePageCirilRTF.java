/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ua.ifr.oe.tc.list;

/**
 *
 * @author AsuSV
 */
public class CodePageCirilRTF {
    private String cirilic;
    private String rtf;

    public CodePageCirilRTF(String cirilic, String rtf)
    {
        this.cirilic = cirilic;
        this.rtf = rtf;
    }

    public String getCirilic() {
        return cirilic;
    }

    public void setCirilic(String cirilic) {
        this.cirilic = cirilic;
    }

    public String getRtf() {
        return rtf;
    }

    public void setRtf(String rtf) {
        this.rtf = rtf;
    }


}
