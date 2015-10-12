/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.struts;

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
 *
 * @author AsuSV
 */
public class ChangestuForm extends org.apache.struts.action.ActionForm {

    private int id;
    private String tu_id;
    private List TCno_list;
    private String no_letter;
    private int type_letter;
    private String change_date_tc;
    private String tc_continue_to;
    private String description_change;
    private String send_date_lenner;
    private String in_namber;
    private String out_namber;
    private HttpServletRequest request;
    private String db_name;
    private String user_name;
    private String limit_date;
  
  public String getLimit_date()
  {
    return this.limit_date;
  }
  
  public void setLimit_date(String limit_date)
  {
    this.limit_date = limit_date;
  }
    public String getIn_namber() {
        return in_namber;
    }

    public void setIn_namber(String in_namber) {
        this.in_namber = in_namber;
    }

    public String getOut_namber() {
        return out_namber;
    }

    public void setOut_namber(String out_namber) {
        this.out_namber = out_namber;
    }

    public String getDb_name() {
        return db_name;
    }

    public void setDb_name(String db_name) {
        this.db_name = db_name;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public HttpServletRequest getRequest() {
        return request;
    }

    public void setRequest(HttpServletRequest request) {
        this.request = request;
    }

    public int getType_letter() {
        return type_letter;
    }

    public void setType_letter(int type_letter) {
        this.type_letter = type_letter;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSend_date_lenner() {
        return send_date_lenner;
    }

    public void setSend_date_lenner(String send_date_lenner) {
        this.send_date_lenner = send_date_lenner;
    }

    public List getTCno_list() {
        return TCno_list;
    }

    public void setTCno_list(List Ar) {
        TCno_list = Ar;
    }

    public String gettu_id() {
        return tu_id;
    }

    public void settu_id(String string) {
        tu_id = string;
    }

    public String getno_letter() {
        return no_letter;
    }

    public void setno_letter(String st) {
        no_letter = st;
    }

    public String getchange_date_tc() {
        return change_date_tc;
    }

    public void setchange_date_tc(String st) {
        change_date_tc = st;
    }

    public String gettc_continue_to() {
        return tc_continue_to;
    }

    public void settc_continue_to(String st) {
        tc_continue_to = st;
    }

    public String getdescription_change() {
        return description_change;
    }

    public void setdescription_change(String st) {
        description_change = st;
    }

    public ChangestuForm() {
        super();
        //changeTu = new ChangeTu();
    }

    public void initChangeTu(HttpServletRequest request) throws NamingException {
        HttpSession ses = request.getSession();
        String db = new String();
        if (ses.getAttribute("db_name") != null) {
            db = (String) ses.getAttribute("db_name");
        } else {
            db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
        }
        String us_name = (String) ses.getAttribute("user_name");
        this.request = request;
        this.db_name = "java:comp/env/jdbc/" + db;
        this.user_name = us_name;
        ListMaker list = new ListMaker(db_name, "");
        setTCno_list(list.getList("{call dbo.LIST_GET_TCNO}"));
        //list.close();
    }

    public void insertChangeTu() throws NamingException {
        System.out.println("INSERT NEW CHANGEST!!!");
        History his = new History();
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup(db_name);
        Connection Conn = null;
        CallableStatement pstmt = null;
        try {
            Conn = ds.getConnection();
            Conn.setAutoCommit(false);
            String SQL = "INSERT 	INTO	"
                    + "Changestc ("
                    + "id_tc,"
                    + "no_letter,"
                    + "type_letter,"
                    + "change_date_tc,"
                    + "tc_continue_to,"
                    + "description_change,"
                    + "send_date_lenner,"
                    + "limit_date,"
                    + "in_namber,"
                    + "out_namber)"
                    + "VALUES(	'"
                    + gettu_id() + "','"
                    + getno_letter() + "','"
                    + getType_letter() + "',"
                    + formatDate(getchange_date_tc()) + ","
                    + formatDate(gettc_continue_to()) + ",'"
                    + getdescription_change() + "',"
                    + formatDate(getSend_date_lenner()) + ","
                    + formatDate(getLimit_date()) + ",'"
                    + getIn_namber() + "','"
                    + getOut_namber() + "')";
            pstmt = Conn.prepareCall(SQL);
            pstmt.execute();
            Conn.commit();
            his.setTc_id(gettu_id());
            his.setLogstring(getno_letter() + getchange_date_tc() + gettc_continue_to() + getdescription_change());
            his.HistorySave(request);
            pstmt = Conn.prepareCall("{call dbo.NumberPravVts(?)}");
            pstmt.setString(1, getUser_name());
            pstmt.execute();
            Conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(Conn);
            if (ic != null) {
                ic.close();
            }
        }


    }

    public String formatDate(String date) {
        String result = null;
        if (date!=null&&!date.equals("")) {
            result = "'" + date + "'";
        }
        return result;
    }

    void UpdateChangeTu(String id) throws NamingException {
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup(db_name);
        Connection Conn = null;
        PreparedStatement pstmt = null;
        try {
            Conn = ds.getConnection();
            String qry = "UPDATE [Changestc]"
                    + "SET [id_tc] = '" + tu_id + "'"
                    + ",[no_letter] = '" + no_letter + "'"
                    + ",[type_letter] = '" + type_letter + "'"
                    + ",[change_date_tc] = " + formatDate(change_date_tc) + ""
                    + ",[tc_continue_to] = " + formatDate(tc_continue_to) + ""
                    + ",[description_change] = '" + description_change + "'"
                    + ",[send_date_lenner] = " + formatDate(send_date_lenner) + ""
                    + ",[in_namber] = '" + in_namber + "'"
                    + ",[out_namber] = '" + out_namber + "'"
                    + ",[limit_date] = " + formatDate(limit_date) + ""
                    + " WHERE [id]='" + id + "' ";
            pstmt = Conn.prepareStatement(qry);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.getMessage();
        } finally {
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(Conn);
            if (ic != null) {
                try {
                    ic.close();
                } catch (NamingException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    void Set(String parameter) {

        InitialContext ic = null;
        DataSource ds = null;
        Connection Conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            ic = new InitialContext();
            ds = (DataSource) ic.lookup(db_name);
            Conn = ds.getConnection();
            String qry = "select id_tc"
                    + ",no_letter"
                    + ",type_letter"
                    + ",isnull(convert(varchar,change_date_tc,104),'') as change_date_tc"
                    + ",isnull(convert(varchar,tc_continue_to,104),'') as tc_continue_to"
                    + ",description_change"
                    + ",isnull(convert(varchar,send_date_lenner,104),'') as send_date_lenner"
                    + ",isnull(convert(varchar,limit_date,104),'') as limit_date"
                    + ",in_namber"
                    + ",out_namber "
                    + "from [Changestc] where id='" + id + "'";
            pstmt = Conn.prepareStatement(qry);
            rs = pstmt.executeQuery();
            rs.next();

            tu_id = rs.getString("id_tc");
            no_letter = rs.getString("no_letter");
            type_letter = rs.getInt("type_letter");
            change_date_tc = rs.getString("change_date_tc");
            tc_continue_to = rs.getString("tc_continue_to");
            description_change = rs.getString("description_change");
            send_date_lenner = rs.getString("send_date_lenner");
            in_namber = rs.getString("in_namber");
            out_namber = rs.getString("out_namber");
            limit_date = rs.getString("limit_date");
        } catch (Exception e) {
            e.getMessage();
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(Conn);
            if (ic != null) {
                try {
                    ic.close();
                } catch (NamingException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    void Clear() {
        tu_id = null;
        no_letter = null;
        type_letter = 0;
        change_date_tc = null;
        tc_continue_to = null;
        description_change = null;
        send_date_lenner = null;
        in_namber = null;
        out_namber = null;
        limit_date = null;

    }
}
