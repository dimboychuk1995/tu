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
import java.util.LinkedList;
import java.util.List;

public class ListMaker {
    private String rem_id;
    private Connection Conn;
    private Connection Conn1;
    private List Main_contract_list;
    private List Locality_list;
    private List Locality_list1;
    private List Constitutive_documents_list;
    private List Join_point_list;
    private List Performer_list;
    private List Type_contract_list;
    private List Reason_tc_list;
    private List Term_tc_list;
    private List Customer_soc_status_list;
    private List State_contract_list;
    private List Ps_110_disp_name_list;
    private List Fid_110_disp_name_list;
    private List Fid_35_disp_name_list;
    private List Ps_35_disp_name_list;
    private List Ps_10_disp_name_list;
    private List Fid_10_disp_name_list;
    private List RateJoinList;
    private List Executor_vkb_list;
    private List Executor_build_vkb_list;
    private List reusable_project_list;
    private List selectedValuesList;
    private List stageJoinList;
    private List typeJoinList;
    InitialContext ic = null;
    InitialContext ic1 = null;


    public ListMaker(String datasource, String rem_id) throws NamingException {
        try {
            this.rem_id = rem_id;
            ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup(datasource);
            Conn = ds.getConnection();
            ic1 = new InitialContext();
            DataSource ds1 = (DataSource) ic1.lookup("java:comp/env/jdbc/TUWeb");
            Conn1 = ds1.getConnection();

        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        }
    }

    public List getList(String procName) {
        List list = new LinkedList();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            pstmt = Conn.prepareStatement(procName);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(new ComboBoxList(rs.getString(1), rs.getString(2)));
            }
            return list;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return list;
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            try {
                ic.close();
            } catch (NamingException ex) {
                ex.printStackTrace();
            }

        }
    }

    public List getList1(String procName) {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        List list = new LinkedList();
        try {
            pstmt = Conn1.prepareStatement(procName);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(new ComboBoxList(rs.getString(1), rs.getString(2)));
            }
            return list;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return list;
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            try {
                ic1.close();
            } catch (NamingException ex) {
                ex.printStackTrace();
            }
        }
    }

    public void make() {
        Main_contract_list = getList("{call dbo.LIST_GET_TCNO}");
        Locality_list = getList("SELECT id,name from TC_LIST_locality where parent_id <> 0 or parent_id is null order by name");
        Locality_list1 = getList("SELECT id,name from TC_LIST_locality order by name");
        RateJoinList = getList1("SELECT id,text FROM rate_of_payment");
        Performer_list = getList1("SELECT id,name FROM Performer order by name");
        Type_contract_list = getList1("{call dbo.LIST_GET_type_contract}");
        Reason_tc_list = getList1("{call dbo.LIST_GET_reason_tc}");
        Term_tc_list = getList1("{call dbo.LIST_GET_term_tc}");
        Customer_soc_status_list = getList1("{call dbo.LIST_GET_CUSTOMER_SOC_STATUS}");
        State_contract_list = getList1("SELECT * from status_document");
        Ps_110_disp_name_list = getList1("select NULL as id,'' as name union select ps_tu_web.ps_id as id,ps_tu_web.ps_name as name from ps_tu_web "
                + "left join ps_feed_rem_tu_web on (ps_tu_web.ps_id=ps_feed_rem_tu_web.ps_tu_web_id) "
                + "where ps_tu_web.ps_nominal=1 and ps_feed_rem_tu_web.rem_id=" + rem_id + " "
                + "order by name");
        Fid_110_disp_name_list = getList1("select NULL as id,'' as name union select feed_35_110_tu_web.feed_id,feed_35_110_tu_web.feed_name from feed_35_110_tu_web "
                + "left join ps_feed_rem_tu_web on (feed_35_110_tu_web.feed_id=ps_feed_rem_tu_web.feed_tu_web_id) "
                + "where feed_35_110_tu_web.feed_nominal=1 and ps_feed_rem_tu_web.rem_id=" + rem_id + " "
                + "order by name");
        Fid_35_disp_name_list = getList1("select NULL as id,'' as name union select feed_35_110_tu_web.feed_id,feed_35_110_tu_web.feed_name from feed_35_110_tu_web "
                + "left join ps_feed_rem_tu_web on (feed_35_110_tu_web.feed_id=ps_feed_rem_tu_web.feed_tu_web_id) "
                + "where feed_35_110_tu_web.feed_nominal=2 and ps_feed_rem_tu_web.rem_id=" + rem_id + " "
                + "order by name");
        Ps_35_disp_name_list = getList1("select NULL as id,'' as name union select ps_tu_web.ps_id,ps_tu_web.ps_name from ps_tu_web "
                + "left join ps_feed_rem_tu_web on (ps_tu_web.ps_id=ps_feed_rem_tu_web.ps_tu_web_id) "
                + "where ps_tu_web.ps_nominal=2 and ps_feed_rem_tu_web.rem_id=" + rem_id + " "
                + "order by name");
        Ps_10_disp_name_list = getList1("select NULL as id,'' as name union select ps_tu_web.ps_id,ps_tu_web.ps_name from ps_tu_web "
                + "left join ps_feed_rem_tu_web on (ps_tu_web.ps_id=ps_feed_rem_tu_web.ps_tu_web_id) "
                + "where ps_tu_web.ps_nominal=3 and ps_feed_rem_tu_web.rem_id=" + rem_id + " "
                + "order by name");

        String SQL_Fid_10_disp_name_list = "select NULL as id,'' as name union select feed_35_110_tu_web.feed_id,feed_35_110_tu_web.feed_name from feed_35_110_tu_web" +
                " left join ps_feed_rem_tu_web on (feed_35_110_tu_web.feed_id=ps_feed_rem_tu_web.feed_tu_web_id) " +
                " where feed_35_110_tu_web.feed_nominal=3 and ps_feed_rem_tu_web.rem_id=" + rem_id + " " +
                " order by name";
        Fid_10_disp_name_list = getList1(SQL_Fid_10_disp_name_list);

        System.out.println(SQL_Fid_10_disp_name_list);

        Executor_vkb_list = getList1("select NULL as id,'' as name union select id, name from Executor_vkb_project");
        reusable_project_list = getList1("select NULL as id,'' as code union select id, code from [Reusable_project]");
        Executor_build_vkb_list = getList1("select NULL as id,'' as name union select id, name from Executor_build_jobs_vkb");
        selectedValuesList = getList1("select id, name from classification_field");
        stageJoinList = getList1("select 0 as id,'' as name union select id, name from stage_join order by id");
        typeJoinList = getList1("select NULL as id,'' as name union select id, name from type_join");
        SQLUtils.closeQuietly(Conn);
        SQLUtils.closeQuietly(Conn1);
    }

    public List getMain_contract_list() {
        return Main_contract_list;
    }

    public List getLocality_list() {
        return Locality_list;
    }

    public List getLocality_list1() {
        return Locality_list1;
    }

    public List getConstitutive_documents_list() {
        return Constitutive_documents_list;
    }

    public List getJoin_point_list() {
        return Join_point_list;
    }

    public List getPerformer_list() {
        return Performer_list;
    }

    public List getType_contract_list() {
        return Type_contract_list;
    }

    public List getReason_tc_list() {
        return Reason_tc_list;
    }

    public List getTerm_tc_list() {
        return Term_tc_list;
    }

    public List getCustomer_soc_status_list() {
        return Customer_soc_status_list;
    }

    public List getState_contract_list() {
        return State_contract_list;
    }

    public List getPs_110_disp_name_list() {
        return Ps_110_disp_name_list;
    }

    public List getFid_110_disp_name_list() {
        return Fid_110_disp_name_list;
    }

    public List getFid_35_disp_name_list() {
        return Fid_35_disp_name_list;
    }

    public List getPs_35_disp_name_list() {
        return Ps_35_disp_name_list;
    }

    public List getPs_10_disp_name_list() {
        return Ps_10_disp_name_list;
    }

    public List getFid_10_disp_name_list() {
        return Fid_10_disp_name_list;
    }

    public List getRateJoinList() {
        return RateJoinList;
    }

    public List getExecutor_vkb_list() {
        return Executor_vkb_list;
    }

    public List getExecutor_build_vkb_list() {
        return Executor_build_vkb_list;
    }

    public List getReusable_project_list() {
        return reusable_project_list;
    }

    public List getSelectedValuesList() {
        return selectedValuesList;
    }

    public List getStageJoinList() {
        return stageJoinList;
    }

    public List getTypeJoinList() {
        return typeJoinList;
    }
}
