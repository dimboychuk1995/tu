/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.myapp.struts;

import ua.ifr.oe.tc.list.SQLUtils;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class loginActionForm extends org.apache.struts.action.ActionForm {

    private int number;
    private ArrayList REM_list;
    private String rem;
    private String user;
    private String password;
    private String role;
    private String PIP;
    private String tab_no;
    private String db_name;
    private String fbdb_name;
    private String rem_name;
    private String id_rem;
    private String Director;
    private String contacts;
    private String rek_bank;
    private String UREM_ID;
    private int ret;
    private String tel_number;
    private String permisions;
    /**
     *
     */
    public void Check () throws SQLException, NamingException{

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/TUWeb");
        Connection conn = ds.getConnection();
        PreparedStatement pstmt = conn.prepareStatement("{call dbo.TC_LOGIN(?,?,?)}");
        pstmt.setString(1, user);
        pstmt.setString(2, password);
        pstmt.setString(3, rem );
        ResultSet rs=pstmt.executeQuery();
        rs.next();
        password = rs.getString("USER_PASS");
        setId_rem(rs.getString("USER_ID_REM"));
        setUser(rs.getString("USER_NAME"));
        setPIP(rs.getString("USER_PIP"));
        setDb_name(rs.getString("DB_NAME"));
        setRem_name(rs.getString("REM_NAME"));
        setFbdb_name(rs.getString("FBDB_NAME"));
        setRole(rs.getString("USER_ROLE"));
        setDirector(rs.getString("Director"));
        setContacts(rs.getString("contacts"));
        setRek_bank(rs.getString("rek_bank"));
        setUREM_ID(rs.getString("UREM_ID"));
        setTel_number(rs.getString("TEL_NUMBER"));
        setRet(rs.getInt("RET"));
        setPermisions(rs.getString("PERMISIONS"));
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(conn);
        ic.close();
    }

    public String getPermisions() {
        return permisions;
    }


    public void setPermisions(String permisions) {
        this.permisions = permisions;
    }

    public String getTel_number() {
        return tel_number;
    }

    public void setTel_number(String tel_number) {
        this.tel_number = tel_number;
    }

    public String getUREM_ID() {
        return UREM_ID;
    }

    public void setUREM_ID(String UREM_ID) {
        this.UREM_ID = UREM_ID;
    }

    public String getDirector() {
        return Director;
    }

    public void setDirector(String Director) {
        this.Director = Director;
    }

    public String getContacts() {
        return contacts;
    }

    public void setContacts(String contacts) {
        this.contacts = contacts;
    }

    public String getRek_bank() {
        return rek_bank;
    }


    public void setRek_bank(String rek_bank) {
        this.rek_bank = rek_bank;
    }

    public int getRet() {
        return ret;
    }

    public void setRet(int ret) {
        this.ret = ret;
    }

    public String getId_rem() {
        return id_rem;
    }

    public void setId_rem(String id_rem) {
        this.id_rem = id_rem;
    }

     /**
     * @return
     */
    public ArrayList getREM_list() {
        return REM_list;
    }
    /**
     * @param i
     */
    public void setREM_list(ArrayList Ar) {
        REM_list = Ar;
    }

    /**
     * @return
     */
    public String getRem() {
        return rem;
    }
    /**
     * @param string
     */
    public void setRem(String string) {
        rem = string;
    }

    /**
     * @return
     */
    public String getUser() {
        return user;
    }
    /**
     * @param string
     */
    public void setUser(String string) {
        user = string;
    }

    /**
     * @return
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param string
     */
    public void setPassword(String string) {
        password = string;
    }

    /**
     * @return
     */
    public int getNumber() {
        return number;
    }

    /**
     * @param i
     */
    public void setNumber(int i) {
        number = i;
    }

    public String getPIP() {
        return PIP;
    }

    public void setPIP(String PIP) {
        this.PIP = PIP;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getTab_no() {
        return tab_no;
    }

    public void setTab_no(String tab_no) {
        this.tab_no = tab_no;
    }

    public String getDb_name() {
        return db_name;
    }

    public void setDb_name(String db_name) {
        this.db_name = db_name;
    }

    public String getRem_name() {
        return rem_name;
    }

    public void setRem_name(String rem_name) {
        this.rem_name = rem_name;
    }

    public String getFbdb_name() {
        return fbdb_name;
    }

    public void setFbdb_name(String fbdb_name) {
        this.fbdb_name = fbdb_name;
    }
    public loginActionForm() {
        super();
        // TODO Auto-generated constructor stub
    }

}
