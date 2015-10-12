/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.struts;

import org.apache.struts.action.ActionForm;
import ua.ifr.oe.tc.list.SQLUtils;
import ua.ifr.oe.tc.list.ListMaker;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.sql.*;
import java.util.List;

/**
 * @author AsuSV
 */
public class MSupplyChForm extends ActionForm {

    private String db_name;
    private int id;
    private int tu_id;
    private String join_point;
    private String selecting_point;
    private String power;
    //ЛЕП, 0,4 кВ
    private String opor_nom_04;
    private String fid_04_disp_name;
    private String fid_04_leng;
    private String fid_04_type_lep;
    //Підстанція ТП 10(6)/0,4 кВ
    private String type_source;
    private String ps_10_disp_name;
    private List ps_10_disp_name_list;
    private String ps_10_disp_name_tmp;
    private String ps_10_u_rez;
    //ЛЕП, 10(6) кВ
    private String opor_nom_10;
    private String fid_10_disp_name;
    private List Fid_10_disp_name_list;
    private String fid_10_leng;
    //Підстанція ПС 35/10(6) кВ
    private String ps_35_disp_name;
    private List Ps_35_disp_name_list;
    private String ps_35_u_rez;
    //ЛЕП, 35 кВ
    private String opor_nom_35;
    private String fid_35_disp_name;
    private List Fid_35_disp_name_list;
    private String fid_35_leng;
    //Підстанція 110/35/10(6) кВ
    private String ps_110_disp_name;
    private List Ps_110_disp_name_list;
    private String ps_110_u_rez;
    //ЛЕП, 110 кВ
    private String fid_110_disp_name;
    private List Fid_110_disp_name_list;
    private String fid_110_leng;
    private String ps_10_reserv;
    private String ps_35_reserv;
    private String ps_110_reserv;
    private String ps_10_price_reserv;
    private String ps_35_price_reserv;
    private String ps_110_price_reserv;
    //private String ps_10_sum_pow;
    //private String ps_10_k_vuk;	
    private String ps_10_pow_after_rec;
    private String ps_10_pow_before_rec;
    private String ps_35_pow_after_rec;
    private String ps_110_pow_after_rec;
    private String ps_35_pow_before_rec;
    private String inv_num_04;
    private String inv_num_rec_10;
    private String inv_num_tp;
    private String ps_10_inc_rez;

    public MSupplyChForm() {
        super();
        //changeTu = new ChangeTu();
    }

    public String getPs_110_pow_after_rec() {
        return ps_110_pow_after_rec;
    }

    public void setPs_110_pow_after_rec(String ps_110_pow_after_rec) {
        this.ps_110_pow_after_rec = ps_110_pow_after_rec;
    }

    public String getPs_10_inc_rez() {
        return ps_10_inc_rez;
    }

    public void setPs_10_inc_rez(String ps_10_inc_rez) {
        this.ps_10_inc_rez = ps_10_inc_rez;
    }

    public String getInv_num_04() {
        return inv_num_04;
    }

    public void setInv_num_04(String inv_num_04) {
        this.inv_num_04 = inv_num_04;
    }

    public String getInv_num_rec_10() {
        return inv_num_rec_10;
    }

    public void setInv_num_rec_10(String inv_num_rec_10) {
        this.inv_num_rec_10 = inv_num_rec_10;
    }

    public String getInv_num_tp() {
        return inv_num_tp;
    }

    public void setInv_num_tp(String inv_num_tp) {
        this.inv_num_tp = inv_num_tp;
    }

    public String getPs_35_pow_after_rec() {
        return ps_35_pow_after_rec;
    }

    public void setPs_35_pow_after_rec(String ps_35_pow_after_rec) {
        this.ps_35_pow_after_rec = ps_35_pow_after_rec;
    }

    public String getPs_35_pow_before_rec() {
        return ps_35_pow_before_rec;
    }

    public void setPs_35_pow_before_rec(String ps_35_pow_before_rec) {
        this.ps_35_pow_before_rec = ps_35_pow_before_rec;
    }

    public String getPs_10_pow_before_rec() {
        return ps_10_pow_before_rec;
    }

    public void setPs_10_pow_before_rec(String ps_10_pow_before_rec) {
        this.ps_10_pow_before_rec = ps_10_pow_before_rec;
    }

    public String getFid_04_type_lep() {
        return fid_04_type_lep;
    }

    public void setFid_04_type_lep(String fid_04_type_lep) {
        this.fid_04_type_lep = fid_04_type_lep;
    }

    public String getPs_10_pow_after_rec() {
        return ps_10_pow_after_rec;
    }

    public void setPs_10_pow_after_rec(String ps_10_pow_after_rec) {
        this.ps_10_pow_after_rec = ps_10_pow_after_rec;
    }

    public String getPs_110_reserv() {
        return ps_110_reserv;
    }

    public void setPs_110_reserv(String ps_110_reserv) {
        this.ps_110_reserv = ps_110_reserv;
    }

    public String getPs_35_reserv() {
        return ps_35_reserv;
    }

    public void setPs_35_reserv(String ps_35_reserv) {
        this.ps_35_reserv = ps_35_reserv;
    }

    public String getPs_35_price_reserv() {
        return ps_35_price_reserv;
    }

    public void setPs_35_price_reserv(String ps_35_price_reserv) {
        this.ps_35_price_reserv = ps_35_price_reserv;
    }

    public String getPs_110_price_reserv() {
        return ps_110_price_reserv;
    }

    public void setPs_110_price_reserv(String ps_110_price_reserv) {
        this.ps_110_price_reserv = ps_110_price_reserv;
    }

    public String getPs_10_price_reserv() {
        return ps_10_price_reserv;
    }

    public void setPs_10_price_reserv(String ps_10_price_reserv) {
        this.ps_10_price_reserv = ps_10_price_reserv;
    }

    public String getPs_10_reserv() {
        return ps_10_reserv;
    }

    public void setPs_10_reserv(String ps_10_reserv) {
        this.ps_10_reserv = ps_10_reserv;
    }

    public String getPower() {
        return power;
    }

    public void setPower(String power) {
        this.power = power;
    }

    public List getFid_10_disp_name_list() {
        return Fid_10_disp_name_list;
    }

    public void setFid_10_disp_name_list(List Fid_10_disp_name_list) {
        this.Fid_10_disp_name_list = Fid_10_disp_name_list;
    }

    public List getFid_110_disp_name_list() {
        return Fid_110_disp_name_list;
    }

    public void setFid_110_disp_name_list(List Fid_110_disp_name_list) {
        this.Fid_110_disp_name_list = Fid_110_disp_name_list;
    }

    public List getFid_35_disp_name_list() {
        return Fid_35_disp_name_list;
    }

    public void setFid_35_disp_name_list(List Fid_35_disp_name_list) {
        this.Fid_35_disp_name_list = Fid_35_disp_name_list;
    }

    public List getPs_110_disp_name_list() {
        return Ps_110_disp_name_list;
    }

    public void setPs_110_disp_name_list(List Ps_110_disp_name_list) {
        this.Ps_110_disp_name_list = Ps_110_disp_name_list;
    }

    public List getPs_35_disp_name_list() {
        return Ps_35_disp_name_list;
    }

    public void setPs_35_disp_name_list(List Ps_35_disp_name_list) {
        this.Ps_35_disp_name_list = Ps_35_disp_name_list;
    }

    public String getFid_04_disp_name() {
        return fid_04_disp_name;
    }

    public void setFid_04_disp_name(String fid_04_disp_name) {
        this.fid_04_disp_name = fid_04_disp_name;
    }

    public String getFid_04_leng() {
        return fid_04_leng;
    }

    public void setFid_04_leng(String fid_04_leng) {
        this.fid_04_leng = fid_04_leng;
    }

    public String getFid_10_disp_name() {
        return fid_10_disp_name;
    }

    public void setFid_10_disp_name(String fid_10_disp_name) {
        this.fid_10_disp_name = fid_10_disp_name;
    }

    public String getFid_10_leng() {
        return fid_10_leng;
    }

    public void setFid_10_leng(String fid_10_leng) {
        this.fid_10_leng = fid_10_leng;
    }

    public String getFid_110_disp_name() {
        return fid_110_disp_name;
    }

    public void setFid_110_disp_name(String fid_110_disp_name) {
        this.fid_110_disp_name = fid_110_disp_name;
    }

    public String getFid_110_leng() {
        return fid_110_leng;
    }

    public void setFid_110_leng(String fid_110_leng) {
        this.fid_110_leng = fid_110_leng;
    }

    public String getFid_35_disp_name() {
        return fid_35_disp_name;
    }

    public void setFid_35_disp_name(String fid_35_disp_name) {
        this.fid_35_disp_name = fid_35_disp_name;
    }

    public String getFid_35_leng() {
        return fid_35_leng;
    }

    public void setFid_35_leng(String fid_35_leng) {
        this.fid_35_leng = fid_35_leng;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getJoin_point() {
        return join_point;
    }

    public void setJoin_point(String join_point) {
        this.join_point = join_point;
    }

    public String getOpor_nom_04() {
        return opor_nom_04;
    }

    public void setOpor_nom_04(String opor_nom_04) {
        this.opor_nom_04 = opor_nom_04;
    }

    public String getOpor_nom_10() {
        return opor_nom_10;
    }

    public void setOpor_nom_10(String opor_nom_10) {
        this.opor_nom_10 = opor_nom_10;
    }

    public String getOpor_nom_35() {
        return opor_nom_35;
    }

    public void setOpor_nom_35(String opor_nom_35) {
        this.opor_nom_35 = opor_nom_35;
    }

    public String getPs_10_disp_name() {
        return ps_10_disp_name;
    }

    public void setPs_10_disp_name(String ps_10_disp_name) {
        this.ps_10_disp_name = ps_10_disp_name;
    }

    public List getPs_10_disp_name_list() {
        return ps_10_disp_name_list;
    }

    public void setPs_10_disp_name_list(List ps_10_disp_name_list) {
        this.ps_10_disp_name_list = ps_10_disp_name_list;
    }

    public String getPs_10_disp_name_tmp() {
        return ps_10_disp_name_tmp;
    }

    public void setPs_10_disp_name_tmp(String ps_10_disp_name_tmp) {
        this.ps_10_disp_name_tmp = ps_10_disp_name_tmp;
    }

    public String getPs_10_u_rez() {
        return ps_10_u_rez;
    }

    public void setPs_10_u_rez(String ps_10_u_rez) {
        this.ps_10_u_rez = ps_10_u_rez;
    }

    public String getPs_110_disp_name() {
        return ps_110_disp_name;
    }

    public void setPs_110_disp_name(String ps_110_disp_name) {
        this.ps_110_disp_name = ps_110_disp_name;
    }

    public String getPs_110_u_rez() {
        return ps_110_u_rez;
    }

    public void setPs_110_u_rez(String ps_110_u_rez) {
        this.ps_110_u_rez = ps_110_u_rez;
    }

    public String getPs_35_disp_name() {
        return ps_35_disp_name;
    }

    public void setPs_35_disp_name(String ps_35_disp_name) {
        this.ps_35_disp_name = ps_35_disp_name;
    }

    public String getPs_35_u_rez() {
        return ps_35_u_rez;
    }

    public void setPs_35_u_rez(String ps_35_u_rez) {
        this.ps_35_u_rez = ps_35_u_rez;
    }

    public String getSelecting_point() {
        return selecting_point;
    }

    public void setSelecting_point(String selecting_point) {
        this.selecting_point = selecting_point;
    }

    public int getTu_id() {
        return tu_id;
    }

    public void setTu_id(int tu_id) {
        this.tu_id = tu_id;
    }

    public String getType_source() {
        return type_source;
    }

    public void setType_source(String type_source) {
        this.type_source = type_source;
    }

    public void init(HttpServletRequest request) {
        try {
            HttpSession ses = request.getSession();
            String db = new String();
            //db = "TUWeb190";
            if (ses.getAttribute("db_name") != null) {
                db = (String) ses.getAttribute("db_name");
            } else {
                db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
            }
            String rem_id = db.substring(5, 8);
            //rem_id=ua.ifr.oe.tc.list.MyCoocie.getCoocie("rem_id",request);
            //String us_name=(String)ses.getAttribute("user_name");
            //this.request=request;
            this.db_name = "java:comp/env/jdbc/" + db;
            this.id = -1;

            ListMaker list1 = new ListMaker(db_name, rem_id);
            list1.make();
            Ps_110_disp_name_list = list1.getPs_110_disp_name_list();
            Fid_110_disp_name_list = list1.getFid_110_disp_name_list();
            Fid_35_disp_name_list = list1.getFid_35_disp_name_list();
            Ps_35_disp_name_list = list1.getPs_35_disp_name_list();
            ps_10_disp_name_list = list1.getPs_10_disp_name_list();
            Fid_10_disp_name_list = list1.getFid_10_disp_name_list();
        } catch (NamingException ex) {
            ex.printStackTrace();
        }
    }

    public void insert() {
        InitialContext ic = null;
        Connection Conn = null;
        CallableStatement pstmt = null;
        try {
            History his = new History();
            ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup(db_name);
            Conn = ds.getConnection();
            String SQL = "INSERT INTO [SUPPLYCH] ([tc_id],[join_point],[selecting_point],[opor_nom_04],[fid_04_disp_name],[fid_04_leng],[type_source],[ps_10_disp_name],[ps_10_disp_name_tmp]"
                    + ",[ps_10_u_rez],[opor_nom_10],[fid_10_disp_name],[fid_10_leng],[ps_35_disp_name],[ps_35_u_rez],[opor_nom_35],[fid_35_disp_name],[fid_35_leng]"
                    // + ",[ps_110_disp_name],[ps_110_u_rez],[fid_110_disp_name],[fid_110_leng],[power],[ps_10_reserv],[ps_10_price_reserv],[ps_35_reserv],[ps_35_price_reserv],[ps_110_reserv],[ps_110_price_reserv],[ps_10_sum_pow],[ps_10_k_vuk],[ps_10_pow_after_rec],[ps_10_inc_rez]) VALUES('"
                    + ",[ps_110_disp_name],[ps_110_u_rez],[fid_110_disp_name],[fid_110_leng],[power],[ps_10_reserv],[ps_10_price_reserv],[ps_35_reserv],[ps_35_price_reserv],[ps_110_reserv],[ps_110_price_reserv],[inv_num_04],[inv_num_rec_10],[inv_num_tp],[fid_04_type_lep],ps_10_inc_rez,ps_10_pow_after_rec,ps_35_pow_after_rec,ps_110_pow_after_rec) VALUES('"
                    + getTu_id() + "','"
                    //+tu_id+"','"
                    + getJoin_point() + "','"
                    + getSelecting_point() + "','"
                    + getOpor_nom_04() + "','"
                    + getFid_04_disp_name() + "','"
                    + getFid_04_leng().replace(",", ".") + "','"
                    + getType_source() + "','"
                    + getPs_10_disp_name() + "','"
                    + getPs_10_disp_name_tmp() + "','"
                    + getPs_10_u_rez().replace(",", ".") + "','"
                    + getOpor_nom_10() + "','"
                    + getFid_10_disp_name() + "','"
                    + getFid_10_leng().replace(",", ".") + "','"
                    + getPs_35_disp_name() + "','"
                    + getPs_35_u_rez().replace(",", ".") + "','"
                    + getOpor_nom_35() + "','"
                    + getFid_35_disp_name() + "','"
                    + getFid_35_leng().replace(",", ".") + "','"
                    + getPs_110_disp_name() + "','"
                    + getPs_110_u_rez().replace(",", ".") + "','"
                    + getFid_110_disp_name() + "','"
                    + getFid_110_leng().replace(",", ".") + "','"
                    + getPower().replace(",", ".") + "','"
                    + getPs_10_reserv().replace(",", ".") + "','"
                    + getPs_10_price_reserv().replace(",", ".") + "','"
                    + getPs_35_reserv().replace(",", ".") + "','"
                    + getPs_35_price_reserv().replace(",", ".") + "','"
                    + getPs_110_reserv().replace(",", ".") + "','"
                    + getPs_110_price_reserv().replace(",", ".") + "','"
                    + getInv_num_04() + "','"
                    + getInv_num_rec_10() + "','"
                    + getInv_num_tp() + "','"
                    + getFid_04_type_lep() + "','"
                    + getPs_10_inc_rez().replace(",", ".") + "','"
                    + getPs_10_pow_after_rec().replace(",", ".") + "','"
                    + getPs_35_pow_after_rec().replace(",", ".") + "','"
                    + getPs_110_pow_after_rec().replace(",", ".") + "')";
            // + getPs_10_pow_after_rec().replace(",", ".") + "','"
            // + getPs_10_pow_before_rec().replace(",", ".") + "')";
            //  + getPs_10_sum_pow().replace(",", ".") + "','"
            //   + getPs_10_k_vuk().replace(",", ".") + "','"
            //    + getPs_10_inc_rez().replace(",", ".") + "')";
            //formatDate(getchange_date_tc())+","+
            pstmt = Conn.prepareCall(SQL);
            pstmt.execute();
            //Conn.commit();
            // pstmt.close();
            // Conn.close();
            // ic.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(Conn);
            try {
                ic.close();
            } catch (NamingException ex) {
                ex.printStackTrace();
            }
        }
    }

    public void Set(String id) {
        PreparedStatement pstmt = null;
        Connection Conn = null;
        ResultSet rs = null;
        InitialContext ic = null;

        try {
            ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup(db_name);
            Conn = ds.getConnection();
            String qry = "select * from [SUPPLYCH] where id='" + id + "'";
            pstmt = Conn.prepareStatement(qry);
            rs = pstmt.executeQuery();
            rs.next();

            this.id = rs.getInt("id");
            join_point = rs.getString("join_point");
            selecting_point = rs.getString("selecting_point");

            //ЛЕП, 0,4 кВ
            opor_nom_04 = rs.getString("opor_nom_04");
            fid_04_disp_name = rs.getString("fid_04_disp_name");
            fid_04_leng = rs.getString("fid_04_leng");
            fid_04_type_lep = rs.getString("fid_04_type_lep");
            //Підстанція ТП 10(6)/0,4 кВ
            type_source = rs.getString("type_source");
            ps_10_disp_name = rs.getString("ps_10_disp_name");
            ps_10_disp_name_tmp = rs.getString("ps_10_disp_name_tmp");
            ps_10_u_rez = rs.getString("ps_10_u_rez");
            //ЛЕП, 10(6) кВ
            opor_nom_10 = rs.getString("opor_nom_10");
            fid_10_disp_name = rs.getString("fid_10_disp_name");
            fid_10_leng = rs.getString("fid_10_leng");
            //Підстанція ПС 35/10(6) кВ
            ps_35_disp_name = rs.getString("ps_35_disp_name");
            ps_35_u_rez = rs.getString("ps_35_u_rez");
            //ЛЕП, 35 кВ
            opor_nom_35 = rs.getString("opor_nom_35");
            fid_35_disp_name = rs.getString("fid_35_disp_name");
            fid_35_leng = rs.getString("fid_35_leng");
            //Підстанція 110/35/10(6) кВ
            ps_110_disp_name = rs.getString("ps_110_disp_name");
            ps_110_u_rez = rs.getString("ps_110_u_rez");
            //ЛЕП, 110 кВ
            fid_110_disp_name = rs.getString("fid_110_disp_name");
            fid_110_leng = rs.getString("fid_110_leng");
            power = rs.getString("power");
            ps_10_reserv = rs.getString("ps_10_reserv");
            ps_10_price_reserv = rs.getString("ps_10_price_reserv");
            ps_35_reserv = rs.getString("ps_35_reserv");
            ps_35_price_reserv = rs.getString("ps_35_price_reserv");
            ps_110_reserv = rs.getString("ps_110_reserv");
            ps_110_price_reserv = rs.getString("ps_110_price_reserv");
            inv_num_04 = rs.getString("inv_num_04");
            inv_num_rec_10 = rs.getString("inv_num_rec_10");
            inv_num_tp = rs.getString("inv_num_tp");
            //ps_10_sum_pow=rs.getString("ps_10_sum_pow");
            // ps_10_k_vuk=rs.getString("ps_10_k_vuk");
            ps_10_pow_after_rec = rs.getString("ps_10_pow_after_rec");
            ps_35_pow_after_rec = rs.getString("ps_35_pow_after_rec");
            ps_110_pow_after_rec = rs.getString("ps_110_pow_after_rec");
            // ps_10_pow_after_rec=rs.getString("ps_10_pow_before_rec");
            ps_10_inc_rez = rs.getString("ps_10_inc_rez");

            //   rs.close();
            //  pstmt.close();
            //   Conn.close();
            //   ic.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(Conn);
            try {
                ic.close();
            } catch (NamingException ex) {
                ex.printStackTrace();
            }
        }
    }

    public void Update(String id) {
        PreparedStatement pstmt = null;
        Connection Conn = null;
        InitialContext ic = null;
        try {
            ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup(db_name);
            Conn = ds.getConnection();
            String qry = "UPDATE [SUPPLYCH] "
                    + " SET [join_point] = '" + join_point + "'"
                    + ",[selecting_point] = '" + selecting_point + "'"
                    + ",[opor_nom_04] = '" + opor_nom_04 + "'"
                    + ",[fid_04_disp_name] = '" + fid_04_disp_name + "'"
                    + ",[fid_04_leng] = '" + fid_04_leng.replace(",", ".") + "'"
                    + ",[type_source] = '" + type_source + "'"
                    + ",[ps_10_disp_name] = '" + ps_10_disp_name + "'"
                    + ",[ps_10_disp_name_tmp] = '" + ps_10_disp_name_tmp + "'"
                    + ",[ps_10_u_rez] = '" + ps_10_u_rez.replace(",", ".") + "'"
                    + ",[opor_nom_10] = '" + opor_nom_10 + "'"
                    + ",[fid_10_disp_name] = '" + fid_10_disp_name + "'"
                    + ",[fid_10_leng] = '" + fid_10_leng.replace(",", ".") + "'"
                    + ",[ps_35_disp_name] = '" + ps_35_disp_name + "'"
                    + ",[ps_35_u_rez] = '" + ps_35_u_rez.replace(",", ".") + "'"
                    + ",[opor_nom_35] = '" + opor_nom_35 + "'"
                    + ",[fid_35_disp_name] = '" + fid_35_disp_name + "'"
                    + ",[fid_35_leng] = '" + fid_35_leng.replace(",", ".") + "'"
                    + ",[ps_110_disp_name] = '" + ps_110_disp_name + "'"
                    + ",[ps_110_u_rez] = '" + ps_110_u_rez.replace(",", ".") + "'"
                    + ",[fid_110_disp_name] = '" + fid_110_disp_name + "'"
                    + ",[fid_110_leng] = '" + fid_110_leng.replace(",", ".") + "'"
                    + ",[power] = '" + power.replace(",", ".") + "'"
                    + ",[ps_10_reserv] = '" + ps_10_reserv.replace(",", ".") + "'"
                    + ",[ps_10_price_reserv] = '" + ps_10_price_reserv.replace(",", ".") + "'"
                    + ",[ps_35_reserv] = '" + ps_35_reserv.replace(",", ".") + "'"
                    + ",[ps_35_price_reserv] = '" + ps_35_price_reserv.replace(",", ".") + "'"
                    + ",[ps_110_reserv] = '" + ps_110_reserv.replace(",", ".") + "'"
                    + ",[ps_110_price_reserv] = '" + ps_110_price_reserv.replace(",", ".") + "'"
                    + ",[fid_04_type_lep] = '" + fid_04_type_lep + "'"
                    + ",[inv_num_04]='" + inv_num_04 + "'"
                    + ",[inv_num_rec_10]='" + inv_num_rec_10 + "'"
                    + ",[inv_num_tp]='" + inv_num_tp + "'"
                    //+ ",[ps_10_sum_pow] = '"+ps_10_sum_pow.replace(",", ".") + "'"
                    //+ ",[ps_10_k_vuk] = '"+ps_10_k_vuk.replace(",", ".") + "'"
                    + ",[ps_10_pow_after_rec] = '" + ps_10_pow_after_rec.replace(",", ".") + "'"
                    + ",[ps_35_pow_after_rec] = '" + ps_35_pow_after_rec.replace(",", ".") + "'"
                    + ",[ps_110_pow_after_rec] = '" + ps_110_pow_after_rec.replace(",", ".") + "'"
                    //  + ",[ps_10_pow_before_rec] = '"+ps_10_pow_before_rec.replace(",", ".") + "'"
                    + ",[ps_10_inc_rez] = '" + ps_10_inc_rez.replace(",", ".") + "'"
                    + " WHERE [id]='" + id + "' ";

            pstmt = Conn.prepareStatement(qry);


            pstmt.executeUpdate();
            // pstmt.close();
            // Conn.close();

        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(Conn);
            try {
                ic.close();
            } catch (NamingException ex) {
                ex.printStackTrace();
            }
        }
    }

    public void Delete(String id) {
        InitialContext ic = null;
        Connection Conn = null;
        PreparedStatement pstmt = null;
        try {
            ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup(db_name);
            Conn = ds.getConnection();
            String qry = "DELETE FROM  [SUPPLYCH] WHERE [id]='" + id + "' ";
            pstmt = Conn.prepareStatement(qry);
            pstmt.executeUpdate();
            //pstmt.close();
            // Conn.close();
            // ic.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(Conn);
            try {
                ic.close();
            } catch (NamingException ex) {
                ex.printStackTrace();
            }
        }

    }

    public void Clear() {
        //tu_id = null;
        join_point = null;
        selecting_point = null;
        opor_nom_04 = null;
        fid_04_disp_name = null;
        fid_04_leng = null;
        fid_04_type_lep = null;
        type_source = null;
        ps_10_disp_name = null;
        ps_10_disp_name_tmp = null;
        ps_10_u_rez = null;
        opor_nom_10 = null;
        fid_10_disp_name = null;
        fid_10_leng = null;
        ps_35_disp_name = null;
        ps_35_u_rez = null;
        opor_nom_35 = null;
        fid_35_disp_name = null;
        fid_35_leng = null;
        ps_110_disp_name = null;
        ps_110_u_rez = null;
        fid_110_disp_name = null;
        fid_110_leng = null;
        power = null;
        ps_10_reserv = null;
        ps_10_price_reserv = null;
        ps_35_reserv = null;
        ps_35_price_reserv = null;
        ps_110_reserv = null;
        ps_110_price_reserv = null;
        inv_num_04 = null;
        inv_num_rec_10 = null;
        inv_num_tp = null;
        ///*ps_10_sum_pow=null;
        //ps_10_k_vuk=null;
        ps_10_pow_after_rec = null;
        ps_35_pow_after_rec = null;
        ps_110_pow_after_rec = null;
        // ps_10_pow_before_rec=null;
        ps_10_inc_rez = null;
    }
}
