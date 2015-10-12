/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ua.ifr.oe.tc.list;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author AsuSV
 */
public class CirilicForRTFformat {
    private String[] cirilic;
    private String[] rtf;
    ArrayList listchar;
    private String db;
    public void CirilicForRTFformat(){
    cirilic[33]="Й";
    rtf[33]="\\\'c9";
    cirilic[34]="Ц";
    rtf[34]="\\\'d6";
    cirilic[35]="У";
    rtf[35]="\\\'d3";
    cirilic[36]="К";
    rtf[36]="\\\'ca";
    cirilic[37]="Е";
    rtf[37]="\\\'c5";
    cirilic[38]="Н";
    rtf[38]="\\\'cd";
    cirilic[39]="Г";
    rtf[39]="\\\'c3";
    cirilic[40]="Ш";
    rtf[40]="\\\'d8";
    cirilic[41]="Щ";
    rtf[41]="\\\'d9";
    cirilic[42]="З";
    rtf[42]="\\\'c7";
    cirilic[43]="Х";
    rtf[43]="\\\'d5";
    cirilic[44]="Ї";
    rtf[44]="\\\'af";
    cirilic[45]="Ф";
    rtf[45]="\\\'d4";
    cirilic[46]="І";
    rtf[46]="\\\'b2";
    cirilic[47]="В";
    rtf[47]="\\\'c2";
    cirilic[48]="А";
    rtf[48]="\\\'c0";
    cirilic[49]="П";
    rtf[49]="\\\'cf";
    cirilic[50]="Р";
    rtf[50]="\\\'d0";
    cirilic[51]="О";
    rtf[51]="\\\'ce";
    cirilic[52]="Л";
    rtf[52]="\\\'cb";
    cirilic[53]="Д";
    rtf[53]="\\\'c4";
    cirilic[54]="Ж";
    rtf[54]="\\\'c6";
    cirilic[55]="Є";
    rtf[55]="\\\'aa";
    cirilic[56]="Я";
    rtf[56]="\\\'df";
    cirilic[57]="Ч";
    rtf[57]="\\\'d7";
    cirilic[58]="С";
    rtf[58]="\\\'d1";
    cirilic[59]="М";
    rtf[59]="\\\'cc";
    cirilic[60]="И";
    rtf[60]="\\\'c8";
    cirilic[61]="Т";
    rtf[61]="\\\'d2";
    cirilic[62]="Ь";
    rtf[62]="\\\'dc";
    cirilic[63]="Б";
    rtf[63]="\\\'c1";
    cirilic[64]="Ю";
    rtf[64]="\\\'de";
    cirilic[65]="Ё";
    rtf[65]="\\\'a8";
    }
    public String convertCirilicToRTF(String source) throws NamingException, SQLException{
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/mydatabase");
        Connection c = ds.getConnection();
        PreparedStatement pstmt = c.prepareStatement("SELECT * FROM TC_code_page_CIR_RTF");
        ResultSet rs = pstmt.executeQuery();
       ///source="уйк уйк";
        String dest = "";
        while (rs.next()){
            dest=source.replaceAll(rs.getString("cir"),rs.getString("rtf"));
            source=dest;
        }
        ic.close();
        c.close();pstmt.close();

        rs.close();

        
        CodePageCirilRTF cb;
        
        Integer ch = 92;
        //char ch1 = (char)ch;
    this.listchar = new ArrayList();
    this.listchar.add(new CodePageCirilRTF("й","\'e9"));
    this.listchar.add(new CodePageCirilRTF("ц","\'f6"));
    this.listchar.add(new CodePageCirilRTF("у","\'f3"));
    this.listchar.add(new CodePageCirilRTF("к","\'ea"));
    this.listchar.add(new CodePageCirilRTF("е","\'e5"));
    this.listchar.add(new CodePageCirilRTF("н","\'ed"));
    this.listchar.add(new CodePageCirilRTF("г","\'e3"));
    this.listchar.add(new CodePageCirilRTF("ш","\'f8"));
    this.listchar.add(new CodePageCirilRTF("щ","^\\'f9"));
    this.listchar.add(new CodePageCirilRTF("з","^\\'e7"));
    this.listchar.add(new CodePageCirilRTF("х","^\\'f5"));
    this.listchar.add(new CodePageCirilRTF("ї","^\\'bf"));
    this.listchar.add(new CodePageCirilRTF("ф","\\'f4"));
    this.listchar.add(new CodePageCirilRTF("і","\\'b3"));
    this.listchar.add(new CodePageCirilRTF("в","\\'e2"));
    this.listchar.add(new CodePageCirilRTF("а","\\'e0"));
    this.listchar.add(new CodePageCirilRTF("п","\\'ef"));
    this.listchar.add(new CodePageCirilRTF("р","\\'f0"));
    this.listchar.add(new CodePageCirilRTF("о","\\'ee"));
    this.listchar.add(new CodePageCirilRTF("л","\\'eb"));
    this.listchar.add(new CodePageCirilRTF("д","\\'e4"));
    this.listchar.add(new CodePageCirilRTF("ж","\\'e6"));
    this.listchar.add(new CodePageCirilRTF("є","\\'ba"));
    this.listchar.add(new CodePageCirilRTF("я","\\'ff"));
    this.listchar.add(new CodePageCirilRTF("ч","\\'f7"));
    this.listchar.add(new CodePageCirilRTF("с","\\'f1"));
    this.listchar.add(new CodePageCirilRTF("м","\\'ec"));
    this.listchar.add(new CodePageCirilRTF("и","\\'e8"));
    this.listchar.add(new CodePageCirilRTF("т","\\'f2"));
    this.listchar.add(new CodePageCirilRTF("ь","\\'fc"));
    this.listchar.add(new CodePageCirilRTF("б","\\'e1"));
    this.listchar.add(new CodePageCirilRTF("ю","\\'fe"));
    this.listchar.add(new CodePageCirilRTF("ё","\\'b8"));
        return dest;
    }
}
