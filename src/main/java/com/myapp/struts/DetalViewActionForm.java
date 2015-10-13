/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.struts;

import org.apache.log4j.Logger;
import ua.ifr.oe.tc.list.MailSender;
import ua.ifr.oe.tc.list.SQLUtils;
import ua.ifr.oe.tc.list.ListMaker;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.sql.*;
import java.util.List;
import java.util.Arrays;

public class DetalViewActionForm extends org.apache.struts.action.ActionForm {
    final static Logger logger = Logger.getLogger(DetalViewActionForm.class);

    private String tu_id;
    //Customer
    private String type_contract;
    private List type_contract_list;
    private String main_contract;
    private List main_contract_list;
    private String blanc_tc;
    private List blanc_tc_list;
    private String egistration_date;
    private String no_zvern;
    private String customer_type;
    private String customer_soc_status;
    private List customer_soc_status_list;
    private String juridical;
    private String customer_name;
    private String f_name;
    private String s_name;
    private String t_name;
    private String customer_post;
    private List Constitutive_documents_list;
    private String constitutive_documents;
    private String bank_account;
    private String bank_mfo;
    private String bank_identification_number;
    private String customer_locality;
    private String customer_zipcode;
    private String object_zipcode;
    private List locality_list;
    private List locality_list1;
    private String customer_adress;
    private String customer_telephone;
    //Dataobjects
    private String reason_tc;
    private List reason_tc_list;
    private String object_name;
    private String functionality;
    private List functionality_list;
    private String projected_year_operation;
    private List Projected_year_operation_list;
    private String name_locality;
    private String object_adress;
    private String executor_company;
    private String connection_price;
    private String tc_pay_date;
    private String connection_treaty_number;
    private String reliabylity_class_1_val;
    private String reliabylity_class_2_val;
    private String reliabylity_class_3_val;
    private String reliabylity_class_1_val_build;
    private String reliabylity_class_2_val_build;
    private String reliabylity_class_3_val_build;
    private String reliabylity_class_1_val_old;
    private String reliabylity_class_2_val_old;
    private String reliabylity_class_3_val_old;
    private boolean reliabylity_class_1;
    private boolean reliabylity_class_2;
    private boolean reliabylity_class_3;
    private boolean reliabylity_class_1_build;
    private boolean reliabylity_class_2_build;
    private boolean reliabylity_class_3_build;
    private boolean reliabylity_class_1_old;
    private boolean reliabylity_class_2_old;
    private boolean reliabylity_class_3_old;
    private boolean ch_rez1;
    private boolean ch_rez2;
    private boolean ch_1033;
    private boolean ch_1044;
    private String request_power;
    private String build_strum_power;
    private String power_for_electric_devices;
    private String power_for_environmental_reservation;
    private String power_for_emergency_reservation;
    private String power_for_technology_reservation;
    private String power_boil;
    private String power_plit;
    private String power_old;
    private String bearing_number;
    private String nom_data_dog;
    ////////////////////////////////////
    private String power_source;
    private String after_admission_number_of_tp;
    //dataobj2
    private String do1;
    private String do2;
    private String do3;
    private String do4;
    private String do5;
    private String do6;
    private String do7;
    private String do8;
    private String do9;//Вимоги до технічного узгодження електроустановок Замовника та електропередавальної організації
    private String do10;//Вимоги до електропостачання приладів та пристроїв, які використовуються для будівництва та реконструкції об’єктів електромереж
    private String do11;//Вимоги до ізоляції, захисту від перенапруги
    private String do13;//Додаткові технічні умови приєднання будівельних струмоприймачів, у разі необхідності, одержати
    private String do14;//Рекомендації щодо використання типових проектів електрозабезпечення електроустановок
    private String do15;//Рекомендації щодо регулювання добового графіка навантаження
    private String do16;//Встановлення засобів вимірювальної техніки для контролю якості електричної енергії
    private String do17;//Вимоги до компенсації реактивної потужності
    private String do18;//Вимоги до кошторисної частини проекту
    private String do19;//Вимоги до оформлення проектно-кошторисної документації
    //VTS
    private String number;
    private String in_no_application_office;
    //private String registration_date;
    private String date_transfer_affiliate;
    private String date_return_from_affiliate;
    //////////////////////////////////
    private String initial_registration_date_rem_tu;
    private String input_number_application_vat;
    private String end_dohovoru_tu;
    //Tund
    private String date_customer_contract_tc;
    private String otz_no;
    private String registration_no_contract;
    private String term_tc;
    private List term_tc_list;
    private String date_contract;
    private String payment_for_join;
    //private String time_connect;
    //private String planned_date;
    //private String actual_date;
    private String state_contract;
    private List state_contract_list;
    private String performance_data_tc_no;
    private String date_manufacture;
    //Admission
    private String type_project;
    private List performer_list;
    private String date_admission_consumer;
    private String date_connect_consumers;
    private String performer_proect_to_point;
    private String performer_proect_after_point;
    ///////////////////
    private String estimated_cost_execution_to_point_tu;
    private String estimated_after_execution_to_point_tu;
    private String estimated_total_lump_pitch_tu;
    private String number_tp_after_admission;
    //Design
    private String develloper_company;
    private String developer_begin_date;
    private String develloper_end_date;
    //private String devellopment_price;
    private String pay_date_devellopment;
    private String agreement_price;
    private String pay_date_agreement;
    private String agreement_date;
    //Supplychain
    private List brList;
    private String name;
    private String join_point;
    private List join_point_list;
    private String status;
    private String title;
    private List title_list;
    private String number_of_support;
    private String voltage_class;
    private List Ps_110_disp_name_list;
    private List Fid_110_disp_name_list;
    private List Ps_35_disp_name_list;
    private List Fid_35_disp_name_list;
    private List Fid_10_disp_name_list;
    private String type_source;
    private String independent_source;
    private String connection_fees;
    private String selecting_point;
    private String ps_10_disp_name_tmp;
    private String ps_10_disp_name;
    private List Ps_10_disp_name_list;
    private String fid_10_disp_name;
    private String ps_35_disp_name;
    private String point_zab_power;
    private String type_join;
    private String stage_join;
    private String date_of_submission;
    private String rate_choice;
    private String price_join;
    private String date_pay_join;
    private String price_join_ns;
    private String date_intro_eksp;
    private String functional_target;
    private String geo_cord_1;//Географічні координати точки підключення
    private String geo_cord_2;//Географічні координати точки забезпечення потужності
    private String sum_other_price;//Сума оплати у випадку відмінності від вартості плати за приєднання
    private String date_filling_voltage; //Дата подання напруги
    private String date_kill_voltage; //Дата подання заявки на відключення
    private String rated_current_machine;//Номінальний струм ввідного автомата
    private String taxpayer;
    private String date_z_proj;
    private List rate_join_list;
    private String term_for_joining;
    private String unmount_devices_price;
    private String date_start_bmr;
    private String date_giving_akt;
    private String date_admission_akt;
    //ВКБ
    private String type_jobs_vkb;
    private String executor_vkb;
    private String date_of_reception;
    private String develop_price_proj;
    private String other_date_of_reception;
    private String other_develop_price_proj;
    private String approved_price;
    private String type_lep_vkb;
    private String need_to_build;
    private String l_build_04;
    private String l_build_10;
    private String l_build_35;
    private String l_build_110;
    private String exec_jobs_vkb;
    private String date_of_reception_bmr;
    private String develop_price_akt;
    private String counter_price;
    private String commissioning_date;
    private String commissioning_price;
    private String l_built_pl_04;
    private String l_built_kl_04;
    private String tp_built_power;
    private String l_built_pl_10;
    private String tp_built_count;
    private String l_build_kl_10;
    private List executor_vkb_list;
    private List executor_build_vkb_list;
    private List reusable_project_list;
    private String time_close_nar;
    private String devellopment_price;
    private String price_rec_build;
    private String rez_pow_for_date;
    private String cap_costs_build;
    private String fact_costs_build;
    private String price_rec_tp;
    private String sum_join_pow;
    private String price_visit_obj;
    private String reusable_project;
    private String[] selectedValues;
    private List selectedValuesList;
    private String date_pay_ns;
    private String sum_other_price_ns;
    private String date_issue_contract_o;
    private String date_contract_o;
    private String date_connect_object_o;
    private String power_contract_o;
    private String date_issue_contract_bm;
    private String date_contract_bm;
    private String date_connect_object_bm;
    private String power_contract_bm;
    private String number_adm;
    private String compatible_wire;
    private String additional_wire;
    private String replace_wire;
    private String replace_opora;
    private String counter_type;
    private String counter_number;
    private String type_object;
    private boolean offer_state;
    private boolean visible_state;
    private boolean no_offer_state;
    private String ntypical_agreement_date;
    private List stageJoinList;
    private String db_name;
    private String user_name;
    private HttpServletRequest request;
    private List typeJoinList;


    private void initLists(ListMaker listMaker){
        rate_join_list = listMaker.getRateJoinList();
        main_contract_list = listMaker.getMain_contract_list();
        locality_list = listMaker.getLocality_list();
        locality_list1 = listMaker.getLocality_list1();
        Constitutive_documents_list = listMaker.getConstitutive_documents_list();
        join_point_list = listMaker.getJoin_point_list();
        performer_list = listMaker.getPerformer_list();
        type_contract_list = listMaker.getType_contract_list();
        reason_tc_list = listMaker.getReason_tc_list();
        term_tc_list = listMaker.getTerm_tc_list();
        customer_soc_status_list = listMaker.getCustomer_soc_status_list();
        state_contract_list = listMaker.getState_contract_list();
        Ps_110_disp_name_list = listMaker.getPs_110_disp_name_list();
        Fid_110_disp_name_list = listMaker.getFid_110_disp_name_list();
        Fid_35_disp_name_list = listMaker.getFid_35_disp_name_list();
        Ps_35_disp_name_list = listMaker.getPs_35_disp_name_list();
        Ps_10_disp_name_list = listMaker.getPs_10_disp_name_list();
        Fid_10_disp_name_list = listMaker.getFid_10_disp_name_list();
        executor_vkb_list = listMaker.getExecutor_vkb_list();
        executor_build_vkb_list = listMaker.getExecutor_build_vkb_list();
        reusable_project_list = listMaker.getReusable_project_list();
        selectedValuesList = listMaker.getSelectedValuesList();
        stageJoinList = listMaker.getStageJoinList();
        typeJoinList = listMaker.getTypeJoinList();
    }

    public void initCustomer(HttpServletRequest request) {

        HttpSession session = request.getSession();
        String rem_id = (String) session.getAttribute("rem_id");
        this.request = request;
        this.user_name = (String) session.getAttribute("user_name");
        this.db_name = "java:comp/env/jdbc/" + (String) session.getAttribute("db_name");

        try {
            ListMaker listMaker = new ListMaker(db_name, rem_id);
            listMaker.make();
            initLists(listMaker);
        } catch (NamingException nex) {
            logger.error(nex.getMessage(),nex);
        }
    }

    public void initSearch(HttpServletRequest request) {

        HttpSession session = request.getSession();
        String rem_id = (String) session.getAttribute("rem_id");
        this.request = request;
        this.user_name = (String) session.getAttribute("user_name");
        this.db_name = "java:comp/env/jdbc/" + (String) session.getAttribute("db_name");
        this.tu_id = "-1";

        try {
            ListMaker listMaker = new ListMaker(db_name, rem_id);
            listMaker.make();
            initLists(listMaker);
        } catch (NamingException nex) {
            logger.error(nex.getMessage(),nex);
        }
    }
// </editor-fold>

    public void InsertCustomer() {
        InitialContext ic = null;
        Connection Conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            HttpSession ses = request.getSession();
            loginActionForm log = (loginActionForm) ses.getAttribute("log");
            ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup(db_name);
            Conn = ds.getConnection();
            String qry = "INSERT INTO [TC_V2]"
                    + "([version]"
                    + ",[department_id]"
                    + ",[type_contract]"
                    + ",[customer_type]"
                    + ",[blanc_tc]"
                    + ",[main_contract]"
                    + ",[registration_date]"
                    + ",[no_zvern]"
                    + ",[customer_soc_status]"
                    + ",[juridical]"
                    + ",[customer_name]"
                    + ",[f_name]"
                    + ",[s_name]"
                    + ",[t_name]"
                    + ",[constitutive_documents]"
                    + ",[bank_account]"
                    + ",[bank_mfo]"
                    + ",[bank_identification_number]"
                    + ",[customer_locality]"
                    + ",[customer_adress]"
                    + ",[reason_tc]"
                    + ",[object_name]"
                    + ",[functionality]"
                    + ",[projected_year_operation]"
                    + ",[name_locality]"
                    + ",[object_adress]"
                    + ",[executor_company]"
                    + ",[connection_price]"
                    + ",[tc_pay_date]"
                    + ",[connection_treaty_number]"
                    + ",[reliabylity_class_1]" + ",[reliabylity_class_2]" + ",[reliabylity_class_3]"
                    + ",[ch_rez1]" + ",[ch_rez2]"
                    + ",[ch_1033]" + ",[ch_1044]"
                    + ",[reliabylity_class_1_val]" + ",[reliabylity_class_2_val]" + ",[reliabylity_class_3_val]"
                    + ",[reliabylity_class_1_old]" + ",[reliabylity_class_2_old]" + ",[reliabylity_class_3_old]"
                    + ",[reliabylity_class_1_val_old]" + ",[reliabylity_class_2_val_old]" + ",[reliabylity_class_3_val_old]"
                    + ",[reliabylity_class_1_build]" + ",[reliabylity_class_2_build]" + ",[reliabylity_class_3_build]"
                    + ",[reliabylity_class_1_val_build]" + ",[reliabylity_class_2_val_build]" + ",[reliabylity_class_3_val_build]"
                    + ",[request_power]"
                    + ",[build_strum_power]"
                    + ",[power_plit]"
                    + ",[power_boil]"
                    + ",[power_old]"
                    + ",[power_for_electric_devices]"
                    + ",[power_for_environmental_reservation]"
                    + ",[power_for_emergency_reservation]"
                    + ",[power_for_technology_reservation]"
                    + ",[power_source]"
                    + ",[after_admission_number_of_tp]"
                    + ",[do1]" + ",[do2]" + ",[do3]" + ",[do4]" + ",[do5]" + ",[do6]" + ",[do7]" + ",[do8]"
                    + ",[number]"
                    + ",[in_no_application_office]"
                    + ",[date_transfer_affiliate]"
                    + ",[date_return_from_affiliate]"
                    + ",[initial_registration_date_rem_tu]"
                    + ",[input_number_application_vat]"
                    + ",[end_dohovoru_tu]"
                    + ",[date_customer_contract_tc]"
                    + ",[registration_no_contract]"
                    + ",[otz_no]"
                    + ",[term_tc]"
                    + ",[date_contract]"
                    + ",[state_contract]"
                    + ",[performance_data_tc_no]"
                    + ",[date_admission_consumer]"
                    + ",[date_connect_consumers]"
                    + ",[performer_proect_to_point]"
                    + ",[performer_proect_after_point]"
                    + ",[estimated_cost_execution_to_point_tu]"
                    + ",[estimated_after_execution_to_point_tu]"
                    + ",[estimated_total_lump_pitch_tu]"
                    + ",[develloper_company]"
                    + ",[developer_begin_date]"
                    + ",[develloper_end_date]"
                    + ",[pay_date_devellopment]"
                    + ",[agreement_price]"
                    + ",[pay_date_agreement]"
                    + ",[agreement_date]"
                    + ",[ntypical_agreement_date]"
                    + ",[join_point]"
                    + ",[status]"
                    + ",[title]"
                    + ",[bearing_number]"
                    + ",[number_tp_after_admission]"
                    + ",[payment_for_join]"
                    + ",[type_source]"
                    + ",[independent_source]"
                    + ",[connection_fees]"
                    + ",[selecting_point]"
                    + ",[customer_post]"
                    + ",[date_manufacture]"
                    + ",[customer_telephone]"
                    + ",[nom_data_dog]"
                    + ",[user_name]"
                    + ",[point_zab_power]"
                    + ",[type_join]"
                    + ",[stage_join]"
                    + ",[type_project]"
                    + ",[date_of_submission]"
                    + ",[rate_choice]"
                    + ",[price_join]"
                    + ",[date_pay_join]"
                    + ",[price_join_ns]"
                    + ",[date_intro_eksp]"
                    + ",[functional_target]"
                    + ",[do9]"
                    + ",[do10]"
                    + ",[geo_cord_1]"
                    + ",[geo_cord_2]"
                    + ",[sum_other_price]"
                    + ",[date_filling_voltage]"
                    + ",[date_kill_voltage]"
                    + ",[rated_current_machine]"
                    + ",[date_z_proj]"
                    + ",[visible_state]"
                    + ",[offer_state]"
                    + ",[no_offer_state]"
                    + ",[term_for_joining]"
                    + ",[unmount_devices_price]"
                    + ",[date_start_bmr]"
                    + ",[date_giving_akt]"
                    + ",[date_admission_akt]"
                    + ",[do11]"
                    + ",[do13]"
                    + ",[do14]"
                    + ",[do15]"
                    + ",[do16]"
                    + ",[do17]"
                    + ",[do18]"
                    + ",[do19]"
                    + ",[type_jobs_vkb]"
                    + ",[executor_vkb]"
                    + ",[date_of_reception] "
                    + ",[develop_price_proj] "
                    + ",[other_date_of_reception] "
                    + ",[other_develop_price_proj] "
                    + ",[approved_price] "
                    + ",[type_lep_vkb]"
                    + ",[need_to_build]"
                    + ",[l_build_04]"
                    + ",[l_build_10] "
                    + ",[l_build_35]"
                    + ",[l_build_110]"
                    + ",[exec_jobs_vkb]"
                    + ",[date_of_reception_bmr]"
                    + ",[develop_price_akt] "
                    + ",[counter_price]"
                    + ",[commissioning_date]"
                    + ",[date_pay_ns]"
                    + ",[commissioning_price]"
                    + ",[devellopment_price]"
                    + ",[price_rec_build]"
                    + ",[cap_costs_build]"
                    + ",[fact_costs_build]"
                    + ",[price_rec_tp]"
                    + ",[sum_join_pow]"
                    + ",[rez_pow_for_date]"
                    + ",[l_built_pl_04] "
                    + ",[l_built_kl_04]"
                    + ",[tp_built_power]"
                    + ",[l_built_pl_10]"
                    + ",[tp_built_count] "
                    + ",[l_build_kl_10]"
                    + ",[reusable_project] "
                    + ",[price_visit_obj]"
                    + ",[sum_other_price_ns]"
                    + ",[time_close_nar]"
                    + ",[selectedValues]"
                    + ",date_issue_contract_o"
                    + ",date_contract_o"
                    + ",date_connect_object_o"
                    + ",power_contract_o"
                    + ",compatible_wire"
                    + ",additional_wire"
                    + ",replace_wire"
                    + ",replace_opora"
                    + ",date_issue_contract_bm"
                    + ",date_contract_bm"
                    + ",date_connect_object_bm"
                    + ",power_contract_bm"
                    + ",number_adm"
                    + ",customer_zipcode"
                    + ",object_zipcode"
                    + ",counter_type"
                    + ",type_object"
                    + ",counter_number"
                    + ",[taxpayer]) VALUES "
                    + "('1','"
                    + log.getId_rem() + "'" + ","
                    + formatData(type_contract, 0) + ","
                    + formatData(customer_type, 0) + ","
                    + formatData(blanc_tc, 0) + ","
                    + formatData(main_contract, 0) + ","
                    + formatData(egistration_date, 0) + ","
                    + formatData(no_zvern, 0) + ","
                    + formatData(customer_soc_status, 0) + ","
                    + formatData(juridical, 0) + ","
                    + formatData(customer_name, 0) + ","
                    + formatData(f_name, 0) + ","
                    + formatData(s_name, 0) + ","
                    + formatData(t_name, 0) + ","
                    + formatData(constitutive_documents, 0) + ","
                    + formatData(bank_account, 0) + ","
                    + formatData(bank_mfo, 0) + ","
                    + formatData(bank_identification_number, 0) + ","
                    + formatData(customer_locality, 0) + ","
                    + formatData(customer_adress, 0) + ","
                    + formatData(reason_tc, 0) + ","
                    + formatData(object_name, 0) + ","
                    + formatData(functionality, 0) + ","
                    + formatData(projected_year_operation, 0) + ","
                    + formatData(name_locality, 0) + ","
                    + formatData(object_adress, 0) + ","
                    + formatData(executor_company, 0) + ","
                    + formatData(connection_price, 1) + ","
                    + formatData(tc_pay_date, 0) + ","
                    + formatData(connection_treaty_number, 0) + ","
                    + formatbool(reliabylity_class_1) + ","
                    + formatbool(reliabylity_class_2) + ","
                    + formatbool(reliabylity_class_3) + ","
                    + formatbool(ch_rez1) + ","
                    + formatbool(ch_rez2) + ","
                    + formatbool(ch_1033) + ","
                    + formatbool(ch_1044) + ","
                    + formatData(reliabylity_class_1_val, 1) + ","
                    + formatData(reliabylity_class_2_val, 1) + ","
                    + formatData(reliabylity_class_3_val, 1) + ","
                    + formatbool(reliabylity_class_1_old) + ","
                    + formatbool(reliabylity_class_2_old) + ","
                    + formatbool(reliabylity_class_3_old) + ","
                    + formatData(reliabylity_class_1_val_old, 1) + ","
                    + formatData(reliabylity_class_2_val_old, 1) + ","
                    + formatData(reliabylity_class_3_val_old, 1) + ","
                    + formatbool(reliabylity_class_1_build) + ","
                    + formatbool(reliabylity_class_2_build) + ","
                    + formatbool(reliabylity_class_3_build) + ","
                    + formatData(reliabylity_class_1_val_build, 1) + ","
                    + formatData(reliabylity_class_2_val_build, 1) + ","
                    + formatData(reliabylity_class_3_val_build, 1) + ","
                    + formatData(request_power, 1) + ","
                    + formatData(build_strum_power, 1) + ","
                    + formatData(power_plit, 1) + ","
                    + formatData(power_boil, 1) + ","
                    + formatData(power_old, 1) + ","
                    + formatData(power_for_electric_devices, 1) + ","
                    + formatData(power_for_environmental_reservation, 1) + ","
                    + formatData(power_for_emergency_reservation, 1) + ","
                    + formatData(power_for_technology_reservation, 1) + ","
                    + formatData(power_source, 0) + ","
                    + formatData(after_admission_number_of_tp, 0) + ","
                    + formatData(do1, 0) + "," + formatData(do2, 0) + ","
                    + formatData(do3, 0) + "," + formatData(do4, 0) + ","
                    + formatData(do5, 0) + "," + formatData(do6, 0) + ","
                    + formatData(do7, 0) + ","
                    + formatData(do8, 0) + ","
                    + formatData(number, 0) + ","
                    + formatData(in_no_application_office, 0) + ","
                    + formatData(date_transfer_affiliate, 0) + ","
                    + formatData(date_return_from_affiliate, 0) + ","
                    + formatData(initial_registration_date_rem_tu, 0) + ","
                    + formatData(input_number_application_vat, 0) + ","
                    + formatData(end_dohovoru_tu, 0) + ","
                    + formatData(date_customer_contract_tc, 0) + ","
                    + formatData(registration_no_contract, 0) + ","
                    + formatData(otz_no, 0) + ","
                    + formatData(term_tc, 0) + ","
                    + formatData(date_contract, 0) + ","
                    + formatData(state_contract, 0) + ","
                    + formatData(performance_data_tc_no, 0) + ","
                    + formatData(date_admission_consumer, 0) + ","
                    + formatData(date_connect_consumers, 0) + ","
                    + formatData(performer_proect_to_point, 0) + ","
                    + formatData(performer_proect_after_point, 0) + ","
                    + formatData(estimated_cost_execution_to_point_tu, 0) + ","
                    + formatData(estimated_after_execution_to_point_tu, 0) + ","
                    + formatData(estimated_total_lump_pitch_tu, 0) + ","
                    + formatData(develloper_company, 0) + ","
                    + formatData(developer_begin_date, 0) + ","
                    + formatData(develloper_end_date, 0) + ","
                    + formatData(pay_date_devellopment, 0) + ","
                    + formatData(agreement_price, 1) + ","
                    + formatData(pay_date_agreement, 0) + ","
                    + formatData(agreement_date, 0) + ","
                    + formatData(ntypical_agreement_date, 0) + ","
                    + formatData(join_point, 0) + ","
                    + formatData(status, 0) + "," + formatData(title, 0) + ","
                    + formatData(bearing_number, 0) + ","
                    + formatData(number_tp_after_admission, 0) + ","
                    + formatData(payment_for_join, 1) + ","
                    + formatData(type_source, 0) + ","
                    + formatData(independent_source, 0) + ","
                    + formatData(connection_fees, 0) + ","
                    + formatData(selecting_point, 0) + ","
                    + formatData(customer_post, 0) + ","
                    + formatData(date_manufacture, 0) + ","
                    + formatData(customer_telephone, 0) + ","
                    + formatData(nom_data_dog, 0) + ","
                    + formatData(user_name, 0) + ","
                    + formatData(point_zab_power, 0) + ","
                    + formatData(type_join, 0) + ","
                    + formatData(stage_join, 0) + ","
                    + formatData(type_project, 0) + ","
                    + formatData(date_of_submission, 0) + ","
                    + formatData(rate_choice, 0) + ","
                    + formatData(price_join, 0) + ","
                    + formatData(date_pay_join, 0) + ","
                    + formatData(price_join_ns, 1) + ","
                    + formatData(date_intro_eksp, 0) + ","
                    + formatData(functional_target, 0) + ","
                    + formatData(do9, 0) + ","
                    + formatData(do10, 0) + ","
                    + formatData(geo_cord_1, 0) + ","
                    + formatData(geo_cord_2, 0) + ","
                    + formatData(sum_other_price, 0) + ","
                    + formatData(date_filling_voltage, 0) + ","
                    + formatData(date_kill_voltage, 0) + ","
                    + formatData(rated_current_machine, 0) + ","
                    + formatData(date_z_proj, 0) + ","
                    + formatbool(visible_state) + ","
                    + formatbool(offer_state) + ","
                    + formatbool(no_offer_state) + ","
                    + formatData(term_for_joining, 0) + ","
                    + formatData(unmount_devices_price, 1) + ","
                    + formatData(date_start_bmr, 0) + ","
                    + formatData(date_giving_akt, 0) + ","
                    + formatData(date_admission_akt, 0) + ","
                    + formatData(do11, 0) + ","
                    + formatData(do13, 0) + ","
                    + formatData(do14, 0) + ","
                    + formatData(do15, 0) + ","
                    + formatData(do16, 0) + ","
                    + formatData(do17, 0) + ","
                    + formatData(do18, 0) + ","
                    + formatData(do19, 0) + ","
                    + formatData(type_jobs_vkb, 0) + ","
                    + formatData(executor_vkb, 0) + ","
                    + formatData(date_of_reception, 0) + ","
                    + formatData(develop_price_proj, 1) + ","
                    + formatData(other_date_of_reception, 0) + ","
                    + formatData(other_develop_price_proj, 1) + ","
                    + formatData(approved_price, 1) + ","
                    + formatData(type_lep_vkb, 0) + ","
                    + formatData(need_to_build, 0) + ","
                    + formatData(l_build_04, 1) + ","
                    + formatData(l_build_10, 1) + ","
                    + formatData(l_build_35, 1) + ","
                    + formatData(l_build_110, 1) + ","
                    + formatData(exec_jobs_vkb, 0) + ","
                    + formatData(date_of_reception_bmr, 0) + ","
                    + formatData(develop_price_akt, 1) + ","
                    + formatData(counter_price, 1) + ","
                    + formatData(commissioning_date, 0) + ","
                    + formatData(date_pay_ns, 0) + ","
                    + formatData(commissioning_price, 1) + ","
                    + formatData(devellopment_price, 1) + ","
                    + formatData(price_rec_build, 1) + ","
                    + formatData(cap_costs_build, 1) + ","
                    + formatData(fact_costs_build, 1) + ","
                    + formatData(price_rec_tp, 1) + ","
                    + formatData(sum_join_pow, 1) + ","
                    + formatData(rez_pow_for_date, 1) + ","
                    + formatData(l_built_pl_04, 1) + ","
                    + formatData(l_built_kl_04, 1) + ","
                    + formatData(tp_built_power, 1) + ","
                    + formatData(l_built_pl_10, 1) + ","
                    + formatData(tp_built_count, 0) + ","
                    + formatData(l_build_kl_10, 1) + ","
                    + formatData(reusable_project, 0) + ","
                    + formatData(price_visit_obj, 1) + ","
                    + formatData(sum_other_price_ns, 1) + ","
                    + formatData(time_close_nar, 0) + ","
                    + formatData(request.getParameterValues("selectedValues")==null ? null :Arrays.toString(request.getParameterValues("selectedValues")).replaceAll("\\[|\\]", ""), 0) + ","
                    + formatData(date_issue_contract_o, 0) + ","
                    + formatData(date_contract_o, 0) + ","
                    + formatData(date_connect_object_o, 0) + ","
                    + formatData(power_contract_o, 1) + ","
                    + formatData(compatible_wire, 1) + ","
                    + formatData(additional_wire, 1) + ","
                    + formatData(replace_wire, 1) + ","
                    + formatData(replace_opora, 0) + ","
                    + formatData(date_issue_contract_bm, 0) + ","
                    + formatData(date_contract_bm, 0) + ","
                    + formatData(date_connect_object_bm, 0) + ","
                    + formatData(power_contract_bm, 1) + ","
                    + formatData(number_adm, 0) + ","
                    + formatData(customer_zipcode, 0) + ","
                    + formatData(object_zipcode, 0) + ","
                    + formatData(counter_type, 0) + ","
                    + (type_object == null || "0".equals(type_object) ? "NULL" : "'" + type_object + "'") + ","
                    + formatData(counter_number, 0) + ","
                    + formatData(taxpayer, 0) + ")";
            pstmt = Conn.prepareStatement(qry, Statement.RETURN_GENERATED_KEYS);
            History his = new History();
            his.setTc_id(getTu_id());
            his.setLogstring(getHisStr());
            his.HistorySave(request);
            pstmt.executeUpdate();
            if (/*log != null && !*/log.getId_rem().equals("360")) {
                int id = -1;
                if (pstmt.getGeneratedKeys().next()) {
                    id = pstmt.getGeneratedKeys().getInt(1);
                }

                pstmt = Conn.prepareStatement("SELECT "
                        + "isnull(tv.f_name+' '+tv.s_name+' '+tv.t_name,'-') as full_name "
                        + ",case when lc.type=1 then 'м.' "
                        + "when lc.type=2 then 'с.' "
                        + "when lc.type=3 then 'смт.' "
                        + "else '' end "
                        + "+case when nullif(lc.id,0) is null and nullif([object_adress],'') is not null then ISNULL([object_adress],'') "
                        + "when nullif(lc.id,0) is not null and nullif([object_adress],'') is not null then isnull(lc.name,'')+', вул.'+isnull([object_adress],'') "
                        + "when nullif(lc.id,0) is not null and nullif([object_adress],'') is null then isnull(lc.name,'') "
                        + "else '-' end as object_adress "
                        + ",isnull(tv.customer_telephone,'-') as customer_telephone "
                        + ",CASE tv.type_join "
                        + "WHEN 1 THEN 'Стандартне' "
                        + "WHEN 2 THEN 'Нестандартне' "
                        + "ELSE '-' end as type_join "
                        + ",isnull(cast(request_power as varchar) ,'-') as request_power "
                        + " FROM [TC_V2] tv "
                        + " left join TC_LIST_locality lc on (lc.id =tv.name_locality)"
                        + " WHERE tv.id=" + id);

                rs = pstmt.executeQuery();
                while (rs.next()) {
                    String name = rs.getString("full_name");
                    String address = rs.getString("object_adress");
                    String telephone = rs.getString("customer_telephone");
                    String type_join = rs.getString("type_join");
                    String pow = rs.getString("request_power");

                    String body = "<b>Прізвище І.П.:</b> " + name.replace("\"", "\\\"") + "<br><b>Адреса об'єкту:</b> " + address.replace("\"", "\\\"")
                            + "<br><b>Телефон Замовника:</b> " + telephone + "<br><b>Тип приєднання:</b> " + type_join
                            + "<br><b>Замовлена потужність:</b> " + pow + " кВт.";
                    //MailSender.sendHTMLEmail("aeg.info1@gmail.com", "test@oe.if.ua", "Повідомлення з ПЗ ТУ", body, "10.93.1.63");

                    MailSender.sendHTMLEmail("aeg.info1@gmail.com", "tu_mail@oe.if.ua", "Повідомлення з ПЗ ТУ", body, "10.93.1.63");
                    MailSender.sendHTMLEmail("tu_mail@oe.if.ua", "tu_mail@oe.if.ua", "Повідомлення з ПЗ ТУ", body, "10.93.1.63");
                    MailSender.sendHTMLEmail("dimboychuk1995@gmail.com", "tu_mail@oe.if.ua", "Повідомлення з ПЗ ТУ", body, "10.93.1.63");
                    MailSender.sendHTMLEmail("Dmytro.Boychuk@oe.if.ua", "tu_mail@oe.if.ua", "Повідомлення з ПЗ ТУ", body, "10.93.1.63");

                }
            }
        } catch (SQLException sqle) {
            logger.error(sqle.getMessage(), sqle);
        } catch (NamingException ne) {
            logger.error(ne.getMessage(), ne);
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(Conn);

            try {
                ic.close();
            } catch (NamingException ne) {
                logger.error(ne.getMessage(), ne);
            }
        }
    }

    public String UpdateCustomer(String tu_id) throws NamingException, SQLException {
        String sql = null;
        InitialContext ic = null;
        Connection Conn = null;
        PreparedStatement pstmt = null;
        try {
            ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup(db_name);
            Conn = ds.getConnection();
            sql = "UPDATE TC_V2 set"
                    + " type_contract=" + formatData(type_contract, 0) + " ,"
                    + " customer_type=" + formatData(customer_type, 0) + ","
                    + " main_contract=" + formatData(main_contract, 0) + " ,"
                    + " registration_date=" + formatData(egistration_date, 0) + " , "
                    + " no_zvern=" + formatData(no_zvern, 0) + " , "
                    + " customer_soc_status=" + formatData(customer_soc_status, 0) + " , "
                    + " juridical=" + formatData(juridical, 0) + " , "
                    + " f_name=" + formatData(f_name, 0) + " , "
                    + " s_name=" + formatData(s_name, 0) + " , "
                    + " t_name=" + formatData(t_name, 0) + " , "
                    + " customer_post=" + formatData(customer_post, 0) + " ,"
                    + " constitutive_documents=" + formatData(constitutive_documents, 0) + " , "
                    + " bank_account=" + formatData(bank_account, 0) + " , "
                    + " bank_mfo=" + formatData(bank_mfo, 0) + " , "
                    + " bank_identification_number=" + formatData(bank_identification_number, 0) + " , "
                    + " customer_locality=" + formatData(customer_locality, 0) + " , "
                    + " customer_adress=" + formatData(customer_adress, 0) + ",  "
                    + " customer_telephone=" + formatData(customer_telephone, 0) + ", "
                    + " reason_tc=" + formatData(reason_tc, 0) + " , "
                    + " object_name=" + formatData(object_name, 0) + " , "
                    + " functionality=" + formatData(functionality, 0) + " , "
                    + " projected_year_operation=" + formatData(projected_year_operation, 0) + " , "
                    + " name_locality=" + formatData(name_locality, 0) + " , "
                    + " object_adress=" + formatData(object_adress, 2) + " , "
                    + " executor_company=" + formatData(executor_company, 0) + ", "
                    + " connection_price=" + formatData(connection_price, 1) + " , "
                    + " tc_pay_date=" + formatData(tc_pay_date, 0) + ", "
                    + " connection_treaty_number=" + formatData(connection_treaty_number, 0) + " , "
                    + " reliabylity_class_1= " + formatbool(reliabylity_class_1) + " ,"
                    + " reliabylity_class_2= " + formatbool(reliabylity_class_2) + " ,"
                    + " reliabylity_class_3= " + formatbool(reliabylity_class_3) + " ,"
                    + " ch_rez1= " + formatbool(ch_rez1) + " ,"
                    + " ch_rez2= " + formatbool(ch_rez2) + " ,"
                    + " ch_1033= " + formatbool(ch_1033) + " ,"
                    + " ch_1044= " + formatbool(ch_1044) + " ,"
                    + " reliabylity_class_1_val=" + formatData(reliabylity_class_1_val, 1) + ", "
                    + " reliabylity_class_2_val=" + formatData(reliabylity_class_2_val, 1) + ", "
                    + " reliabylity_class_3_val=" + formatData(reliabylity_class_3_val, 1) + ", "
                    + " reliabylity_class_1_old= " + formatbool(reliabylity_class_1_old) + " ,"
                    + " reliabylity_class_2_old= " + formatbool(reliabylity_class_2_old) + " ,"
                    + " reliabylity_class_3_old= " + formatbool(reliabylity_class_3_old) + " ,"
                    + " reliabylity_class_1_val_old=" + formatData(reliabylity_class_1_val_old, 1) + ", "
                    + " reliabylity_class_2_val_old=" + formatData(reliabylity_class_2_val_old, 1) + ", "
                    + " reliabylity_class_3_val_old=" + formatData(reliabylity_class_3_val_old, 1) + ", "
                    + " reliabylity_class_1_build= " + formatbool(reliabylity_class_1_build) + " ,"
                    + " reliabylity_class_2_build= " + formatbool(reliabylity_class_2_build) + " ,"
                    + " reliabylity_class_3_build= " + formatbool(reliabylity_class_3_build) + " ,"
                    + " reliabylity_class_1_val_build=" + formatData(reliabylity_class_1_val_build, 1) + ", "
                    + " reliabylity_class_2_val_build=" + formatData(reliabylity_class_2_val_build, 1) + ", "
                    + " reliabylity_class_3_val_build=" + formatData(reliabylity_class_3_val_build, 1) + ", "
                    + " request_power=" + formatData(request_power, 1) + " , "
                    + " build_strum_power=" + formatData(build_strum_power, 1) + " , "
                    + " power_for_electric_devices=" + formatData(power_for_electric_devices, 1) + " , "
                    + " power_for_environmental_reservation=" + formatData(power_for_environmental_reservation, 1) + " , "
                    + " power_for_emergency_reservation=" + formatData(power_for_emergency_reservation, 1) + " , "
                    + " power_for_technology_reservation=" + formatData(power_for_technology_reservation, 1) + " ,"
                    + " power_source=" + formatData(power_source, 0) + " ,"
                    + " power_plit=" + formatData(power_plit, 1) + " ,"
                    + " power_boil=" + formatData(power_boil, 1) + " ,"
                    + " power_old=" + formatData(power_old, 1) + " ,"
                    + " nom_data_dog=" + formatData(nom_data_dog, 0) + " ,"
                    + " after_admission_number_of_tp=" + formatData(after_admission_number_of_tp, 0) + " ,"
                    + " bearing_number=" + formatData(bearing_number, 0) + " ,"
                    + " do1=" + formatData(do1, 0) + " ,"
                    + " do2=" + formatData(do2, 0) + " ,"
                    + " do3=" + formatData(do3, 0) + " ,"
                    + " do4=" + formatData(do4, 0) + " ,"
                    + " do5=" + formatData(do5, 0) + " ,"
                    + " do6=" + formatData(do6, 0) + " ,"
                    + " do7=" + formatData(do7, 0) + " ,"
                    + " do8=" + formatData(do8, 0) + " , "
                    + " number=" + formatData(number, 0) + " , "
                    + " in_no_application_office=" + formatData(in_no_application_office, 0) + " , "
                    + " date_transfer_affiliate=" + formatData(date_transfer_affiliate, 0) + " ,"
                    + " date_return_from_affiliate=" + formatData(date_return_from_affiliate, 0) + " ,"
                    + " initial_registration_date_rem_tu=" + formatData(initial_registration_date_rem_tu, 0) + " ,"
                    + " input_number_application_vat=" + formatData(input_number_application_vat, 0) + " ,"
                    + " end_dohovoru_tu=" + formatData(end_dohovoru_tu, 0) + " ,"
                    + " date_customer_contract_tc=" + formatData(date_customer_contract_tc, 0) + " , "
                    + " registration_no_contract=" + formatData(registration_no_contract, 0) + " , "
                    + " otz_no=" + formatData(otz_no, 0) + " , "
                    + " term_tc=" + formatData(term_tc, 0) + " ,"
                    + " date_contract=" + formatData(date_contract, 0) + " , "
                    + " state_contract=" + formatData(state_contract, 0) + " ,"
                    + " performance_data_tc_no=" + formatData(performance_data_tc_no, 0) + " ,"
                    + " payment_for_join= " + formatData(payment_for_join, 0) + " ,"
                    + " date_admission_consumer=" + formatData(date_admission_consumer, 0) + " , "
                    + " date_connect_consumers=" + formatData(date_connect_consumers, 0) + ", "
                    + " performer_proect_to_point=" + formatData(performer_proect_to_point, 0) + ", "
                    + " performer_proect_after_point=" + formatData(performer_proect_after_point, 0) + " , "
                    + " estimated_cost_execution_to_point_tu=" + formatData(estimated_cost_execution_to_point_tu, 1) + " , "
                    + " estimated_after_execution_to_point_tu=" + formatData(estimated_after_execution_to_point_tu, 1) + " , "
                    + " estimated_total_lump_pitch_tu=" + formatData(estimated_total_lump_pitch_tu, 1) + " , "
                    + " number_tp_after_admission = " + formatData(number_tp_after_admission, 0) + ","
                    + " connection_fees=" + formatData(connection_fees, 1) + " ,"
                    + " develloper_company= " + formatData(develloper_company, 0) + ", "
                    + " developer_begin_date=" + formatData(developer_begin_date, 0) + " , "
                    + " develloper_end_date=" + formatData(develloper_end_date, 0) + " , "
                    + " pay_date_devellopment=" + formatData(pay_date_devellopment, 0) + " ,"
                    + " agreement_price=" + formatData(agreement_price, 1) + " , "
                    + " pay_date_agreement=" + formatData(pay_date_agreement, 0) + " , "
                    + " date_manufacture=" + formatData(date_manufacture, 0) + " , "
                    + " agreement_date=" + formatData(agreement_date, 0) + " , "
                    + " ntypical_agreement_date=" + formatData(ntypical_agreement_date, 0) + " , "
                    + " user_name=" + formatData(user_name, 0) + " , "
                    + " point_zab_power=" + formatData(point_zab_power, 0) + " , "
                    + " type_join=" + formatData(type_join, 0) + " , "
                    + " stage_join=" + formatData(stage_join, 0) + " , "
                    + " type_project=" + formatData(type_project, 0) + " , "
                    + " date_of_submission=" + formatData(date_of_submission, 0) + " , "
                    + " rate_choice=" + formatData(rate_choice, 0) + " , "
                    + " price_join=" + formatData(price_join, 0) + " , "
                    + " date_pay_join=" + formatData(date_pay_join, 0) + " , "
                    + " price_join_ns=" + formatData(price_join_ns, 1) + " , "
                    + " date_intro_eksp=" + formatData(date_intro_eksp, 0) + " , "
                    + " functional_target=" + formatData(functional_target, 0) + " , "
                    + " do9=" + formatData(do9, 0) + " , "
                    + " do10=" + formatData(do10, 0) + " , "
                    + " geo_cord_1=" + formatData(geo_cord_1, 0) + " , "
                    + " geo_cord_2=" + formatData(geo_cord_2, 0) + " , "
                    + " sum_other_price=" + formatData(sum_other_price, 0) + " , "
                    + " date_filling_voltage=" + formatData(date_filling_voltage, 0) + " , "
                    + " date_kill_voltage=" + formatData(date_kill_voltage, 0) + " , "
                    + " rated_current_machine=" + formatData(rated_current_machine, 0) + " , "
                    + " date_z_proj=" + formatData(date_z_proj, 0) + " , "
                    + " visible_state=" + formatbool(visible_state) + " ,"
                    + " offer_state=" + formatbool(offer_state) + " ,"
                    + " no_offer_state=" + formatbool(no_offer_state) + " ,"
                    + " term_for_joining=" + formatData(term_for_joining, 0) + " ,"
                    + " unmount_devices_price=" + formatData(unmount_devices_price, 1) + " , "
                    + " date_start_bmr=" + formatData(date_start_bmr, 0) + ","
                    + " date_giving_akt=" + formatData(date_giving_akt, 0) + ","
                    + " date_admission_akt=" + formatData(date_admission_akt, 0) + ","
                    + " do11=" + formatData(do11, 0) + " , "
                    + " do13=" + formatData(do13, 0) + " , "
                    + " do14=" + formatData(do14, 0) + " , "
                    + " do15=" + formatData(do15, 0) + " , "
                    + " do16=" + formatData(do16, 0) + " , "
                    + " do17=" + formatData(do17, 0) + " , "
                    + " do18=" + formatData(do18, 0) + " , "
                    + " do19=" + formatData(do19, 0) + " , "
                    + " type_jobs_vkb=" + formatData(type_jobs_vkb, 0) + ","
                    + " executor_vkb=" + formatData(executor_vkb, 0) + ","
                    + " date_of_reception=" + formatData(date_of_reception, 0) + ","
                    + " develop_price_proj=" + formatData(develop_price_proj, 1) + ","
                    + " other_date_of_reception=" + formatData(other_date_of_reception, 0) + ","
                    + " other_develop_price_proj=" + formatData(other_develop_price_proj, 1) + ","
                    + " approved_price=" + formatData(approved_price, 1) + ","
                    + " type_lep_vkb=" + formatData(type_lep_vkb, 0) + ","
                    + " need_to_build=" + formatData(need_to_build, 0) + ","
                    + " l_build_04=" + formatData(l_build_04, 1) + ","
                    + " l_build_10=" + formatData(l_build_10, 1) + ","
                    + " l_build_35=" + formatData(l_build_35, 1) + ","
                    + " l_build_110=" + formatData(l_build_110, 1) + ","
                    + " exec_jobs_vkb=" + formatData(exec_jobs_vkb, 0) + ","
                    + " date_of_reception_bmr=" + formatData(date_of_reception_bmr, 0) + ","
                    + " develop_price_akt=" + formatData(develop_price_akt, 1) + ","
                    + " counter_price=" + formatData(counter_price, 1) + ","
                    + " commissioning_date=" + formatData(commissioning_date, 0) + ","
                    + " date_pay_ns=" + formatData(date_pay_ns, 0) + ","
                    + " commissioning_price=" + formatData(commissioning_price, 1) + ","
                    + " devellopment_price=" + formatData(devellopment_price, 1) + ","
                    + " price_rec_build=" + formatData(price_rec_build, 1) + ","
                    + " cap_costs_build=" + formatData(cap_costs_build, 1) + ","
                    + " fact_costs_build=" + formatData(fact_costs_build, 1) + ","
                    + " price_rec_tp=" + formatData(price_rec_tp, 1) + ","
                    + " sum_join_pow=" + formatData(sum_join_pow, 1) + ","
                    + " rez_pow_for_date=" + formatData(rez_pow_for_date, 1) + ","
                    + " l_built_pl_04=" + formatData(l_built_pl_04, 1) + ","
                    + " l_built_kl_04=" + formatData(l_built_kl_04, 1) + ","
                    + " tp_built_power=" + formatData(tp_built_power, 1) + ","
                    + " l_built_pl_10=" + formatData(l_built_pl_10, 1) + ","
                    + " tp_built_count=" + formatData(tp_built_count, 0) + ","
                    + " l_build_kl_10=" + formatData(l_build_kl_10, 1) + ","
                    + " reusable_project=" + formatData(reusable_project, 0) + ","
                    + " price_visit_obj=" + formatData(price_visit_obj, 1) + ","
                    + " sum_other_price_ns=" + formatData(sum_other_price_ns, 1) + ","
                    + " time_close_nar=" + formatData(time_close_nar, 0) + ","
                    + " date_issue_contract_o=" + formatData(date_issue_contract_o, 0) + ","
                    + " date_contract_o=" + formatData(date_contract_o, 0) + ","
                    + " date_connect_object_o=" + formatData(date_connect_object_o, 0) + ","
                    + " power_contract_o=" + formatData(power_contract_o, 1) + ","
                    + " date_issue_contract_bm=" + formatData(date_issue_contract_bm, 0) + ","
                    + " date_contract_bm=" + formatData(date_contract_bm, 0) + ","
                    + " date_connect_object_bm=" + formatData(date_connect_object_bm, 0) + ","
                    + " power_contract_bm=" + formatData(power_contract_bm, 1) + ","
                    + " number_adm=" + formatData(number_adm, 0) + ","
                    + " customer_zipcode=" + formatData(customer_zipcode, 0) + ","
                    + " object_zipcode=" + formatData(object_zipcode, 0) + ","
                    + " compatible_wire=" + formatData(compatible_wire, 1) + ","
                    + " additional_wire=" + formatData(additional_wire, 1) + ","
                    + " replace_wire=" + formatData(replace_wire, 1) + ","
                    + " replace_opora=" + formatData(replace_opora, 0) + ","
                    + " counter_type=" + formatData(counter_type, 0) + ","
                    + " type_object=" + (type_object == null || "0".equals(type_object) ? "NULL" : "'" + type_object + "'") + ","
                    + " counter_number=" + formatData(counter_number, 0) + ","
                    + " selectedValues=" +
                    formatData(request.getParameterValues("selectedValues")==null ? null :Arrays.toString(request.getParameterValues("selectedValues")).replaceAll("\\[|\\]", ""), 0) + ","
                    + " taxpayer=" + formatData(taxpayer, 0) + " " + " WHERE id=" + tu_id;

            //System.out.println(Arrays.toString(request.getParameterValues("selectedValues")).replaceAll("\\[|\\]", ""));
            pstmt = Conn.prepareStatement(sql);
            History his = new History();
            his.setTc_id(getTu_id());
            his.setLogstring(getHisStr());
            his.HistorySave(request);
            pstmt.executeUpdate();
            //return sql;
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
        return sql;
    }

    public void SetCustomer(String tu_id) {

        InitialContext ic = null;
        Connection Conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup(db_name);
            Conn = ds.getConnection();
            String sql = "SELECT "
                    + "id"
                    + ",isnull(type_contract,'') as type_contract"
                    + ",isnull(customer_type,'') as customer_type"
                    + ",isnull(blanc_tc,'') as blanc_tc"
                    + ",isnull(main_contract,'') as main_contract"
                    + ",isnull(convert (varchar(15),registration_date,104),'') as registration_date"
                    + ",isnull(no_zvern,'') as no_zvern"
                    + ",isnull(customer_soc_status,'') as customer_soc_status"
                    + ",isnull(juridical,'') as juridical"
                    + ",isnull(customer_name,'') as customer_name"
                    + ",isnull(rtrim(f_name),'') as f_name"
                    + ",isnull(rtrim(s_name),'') as s_name"
                    + ",isnull(rtrim(t_name),'') as t_name"
                    + ",isnull(customer_post,'') as customer_post"
                    + ",isnull(constitutive_documents,'') as constitutive_documents"
                    + ",isnull(bank_account,'') as bank_account"
                    + ",isnull(bank_mfo,'') as bank_mfo"
                    + ",isnull(bank_identification_number,'') as bank_identification_number"
                    + ",isnull(customer_locality,'') as customer_locality"
                    + ",isnull(customer_adress,'') as customer_adress"
                    + ",isnull(customer_telephone,'') as customer_telephone"
                    + ",isnull(reason_tc,'') as reason_tc"
                    + ",isnull(object_name,'') as object_name"
                    + ",isnull(functionality,'') as functionality"
                    + ",isnull(projected_year_operation,'') as projected_year_operation"
                    + ",isnull(name_locality,'') as name_locality"
                    + ",isnull(object_adress,'') as object_adress"
                    + ",isnull(executor_company,'') as executor_company"
                    + ",isnull( cast (connection_price as varchar(15)),'') as connection_price"
                    + ",isnull(convert (varchar(15),tc_pay_date,104),'') as tc_pay_date"
                    + ",isnull(connection_treaty_number,'') as connection_treaty_number"
                    + ",isnull(reliabylity_class_1,'') as reliabylity_class_1"
                    + ",isnull(reliabylity_class_2,'') as reliabylity_class_2"
                    + ",isnull(reliabylity_class_3,'') as reliabylity_class_3"
                    + ",isnull(ch_rez1,'') as ch_rez1"
                    + ",isnull(ch_rez2,'') as ch_rez2"
                    + ",isnull(ch_1033,'') as ch_1033"
                    + ",isnull(ch_1044,'') as ch_1044"
                    + ",isnull( cast(reliabylity_class_1_val as varchar(15)),'') as reliabylity_class_1_val"
                    + ",isnull( cast(reliabylity_class_2_val as varchar(15)),'') as reliabylity_class_2_val"
                    + ",isnull( cast(reliabylity_class_3_val as varchar(15)),'') as reliabylity_class_3_val"
                    + ",isnull(reliabylity_class_1_old,'') as reliabylity_class_1_old"
                    + ",isnull(reliabylity_class_2_old,'') as reliabylity_class_2_old"
                    + ",isnull(reliabylity_class_3_old,'') as reliabylity_class_3_old"
                    + ",isnull( cast(reliabylity_class_1_val_old as varchar(15)),'') as reliabylity_class_1_val_old"
                    + ",isnull( cast(reliabylity_class_2_val_old as varchar(15)),'') as reliabylity_class_2_val_old"
                    + ",isnull( cast(reliabylity_class_3_val_old as varchar(15)),'') as reliabylity_class_3_val_old"
                    + ",isnull(reliabylity_class_1_build,'') as reliabylity_class_1_build"
                    + ",isnull(reliabylity_class_2_build,'') as reliabylity_class_2_build"
                    + ",isnull(reliabylity_class_3_build,'') as reliabylity_class_3_build"
                    + ",isnull( cast(reliabylity_class_1_val_build as varchar(15)),'') as reliabylity_class_1_val_build"
                    + ",isnull( cast(reliabylity_class_2_val_build as varchar(15)),'') as reliabylity_class_2_val_build"
                    + ",isnull( cast(reliabylity_class_3_val_build as varchar(15)),'') as reliabylity_class_3_val_build"
                    + ",isnull( cast(request_power as varchar(15)),'') as request_power"
                    + ",isnull( cast(build_strum_power as varchar(15)),'') as build_strum_power"
                    + ",isnull( cast(power_plit as varchar(15)),'') as power_plit"
                    + ",isnull( cast(power_boil as varchar(15)),'') as power_boil"
                    + ",isnull( cast(power_old as varchar(15)),'') as power_old"
                    + ",isnull( cast(power_for_electric_devices as varchar(15)),'') as power_for_electric_devices"
                    + ",isnull( cast(power_for_environmental_reservation as varchar(15)),'') as power_for_environmental_reservation"
                    + ",isnull( cast(power_for_emergency_reservation as varchar(15)),'') as power_for_emergency_reservation"
                    + ",isnull( cast(power_for_technology_reservation as varchar(15)),'') as power_for_technology_reservation"
                    + ",isnull(power_source,'') as power_source"
                    + ",isnull(nom_data_dog,'') as nom_data_dog"
                    + ",isnull(after_admission_number_of_tp,'') as after_admission_number_of_tp"
                    + ",isnull(do1,'') as do1"
                    + ",isnull(do2,'') as do2"
                    + ",isnull(do3,'') as do3"
                    + ",isnull(do4,'') as do4"
                    + ",isnull(do5,'') as do5"
                    + ",isnull(do6,'') as do6"
                    + ",isnull(do7,'') as do7"
                    + ",isnull(do8,'') as do8"
                    + ",isnull(number,'') as number"
                    + ",isnull(in_no_application_office,'') as in_no_application_office"
                    + ",isnull(convert (varchar(15),date_transfer_affiliate,104),'') as date_transfer_affiliate"
                    + ",isnull(convert (varchar(15),date_return_from_affiliate,104),'') as date_return_from_affiliate"
                    + ",isnull(convert (varchar(15),initial_registration_date_rem_tu,104),'') as initial_registration_date_rem_tu"
                    + ",isnull(input_number_application_vat,'') as input_number_application_vat"
                    + ",isnull(convert (varchar(15),end_dohovoru_tu,104),'') as end_dohovoru_tu"
                    + ",isnull(convert (varchar(15),date_customer_contract_tc,104),'') as date_customer_contract_tc"
                    + ",isnull(registration_no_contract,'') as registration_no_contract"
                    + ",isnull(otz_no,'') as otz_no"
                    + ",isnull(term_tc,'') as term_tc"
                    + ",isnull(convert (varchar(15),date_contract,104),'') as date_contract"
                    + ",isnull(state_contract,'') as state_contract"
                    + ",isnull(performance_data_tc_no,'') as performance_data_tc_no"
                    + ",isnull(convert (varchar(15),date_admission_consumer,104),'') as date_admission_consumer"
                    + ",isnull(convert (varchar(15),date_connect_consumers,104),'') as date_connect_consumers"
                    + ",isnull(performer_proect_to_point,'') as performer_proect_to_point"
                    + ",isnull(performer_proect_after_point,'') as performer_proect_after_point"
                    + ",isnull(convert (varchar(15),estimated_cost_execution_to_point_tu),'') as estimated_cost_execution_to_point_tu"
                    + ",isnull(convert (varchar(15),estimated_after_execution_to_point_tu),'') as estimated_after_execution_to_point_tu"
                    + ",isnull(convert (varchar(15),estimated_total_lump_pitch_tu),'') as estimated_total_lump_pitch_tu"
                    + ",isnull(develloper_company,'') as develloper_company"
                    + ",isnull(convert (varchar(15),developer_begin_date,104),'') as developer_begin_date"
                    + ",isnull(convert (varchar(15),develloper_end_date,104),'') as develloper_end_date"
                    + ",isnull(convert (varchar(15),pay_date_devellopment,104),'') as pay_date_devellopment"
                    + ",isnull(convert (varchar(15),agreement_price),'') as agreement_price"
                    + ",isnull(convert (varchar(15),pay_date_agreement,104),'') as pay_date_agreement"
                    + ",isnull(convert (varchar(15),agreement_date,104),'') as agreement_date"
                    + ",isnull(convert (varchar(15),ntypical_agreement_date,104),'') as ntypical_agreement_date"
                    + ",isnull(join_point,'') as join_point"
                    + ",isnull(status,'') as status"
                    + ",isnull(title,'') as title"
                    + ",isnull(number_of_support,'') as number_of_support"
                    + ",isnull(voltage_class,'') as voltage_class"
                    + ",isnull(convert (varchar(50),(select isnull(ps_nav,0) from TUweb.dbo.ps_tu_web where ps_10_disp_name=ps_id)),'') as ps_10_u"
                    + ",isnull(convert (varchar(50),(select isnull(ps_nom_nav,0)+isnull(ps_nom_nav_2,0) from TUweb.dbo.ps_tu_web where ps_10_disp_name=ps_id)),'') as ps_10_nom"
                    + ",isnull(version,'') as version"
                    + ",isnull(department_id,'') as department_id"
                    + " ,isnull(bearing_number,'') as bearing_number"
                    + " ,isnull(number_tp_after_admission,'') as number_tp_after_admission"
                    + ",isnull(cast (payment_for_join as varchar(15)),'') as payment_for_join"
                    + ",isnull(type_source,'') as type_source"
                    + " ,isnull(cast (independent_source as varchar(15)),'') as independent_source"
                    + " ,isnull(cast (connection_fees as varchar(15)),'') as connection_fees"
                    + " ,isnull(selecting_point,'') as selecting_point"
                    + ",isnull(convert (varchar(15),date_manufacture,104),'') as date_manufacture"
                    + " ,isnull(ps_10_disp_name_tmp,'') as ps_10_disp_name_tmp "
                    + " ,isnull(point_zab_power,'') as point_zab_power "
                    + " ,isnull(type_join,'') as type_join "
                    + " ,isnull(stage_join,'') as stage_join "
                    + " ,isnull(type_project,'') as type_project "
                    + ",isnull(convert (varchar(15),date_of_submission,104),'') as date_of_submission"
                    + ",isnull(convert (varchar(15),rate_choice),'') as rate_choice "
                    + ",isnull(convert (varchar(15),price_join),'') as price_join "
                    + ",isnull(convert (varchar(15),date_pay_join,104),'') as date_pay_join"
                    + ",isnull(convert (varchar(15),price_join_ns),'') as price_join_ns "
                    + ",isnull(convert (varchar(15),date_intro_eksp,104),'') as date_intro_eksp"
                    + ",isnull(functional_target,'') as functional_target"
                    + ",isnull(do9,'') as do9"
                    + ",isnull(do10,'') as do10"
                    + ",isnull(geo_cord_1,'') as geo_cord_1"
                    + ",isnull(geo_cord_2,'') as geo_cord_2"
                    + ",isnull(convert (varchar(15),sum_other_price),'') as sum_other_price "
                    + ",isnull(convert (varchar(15),date_filling_voltage,104),'') as date_filling_voltage"
                    + ",isnull(convert (varchar(15),date_kill_voltage,104),'') as date_kill_voltage"
                    + ",isnull(convert (varchar(15),rated_current_machine,104),'') as rated_current_machine"
                    + ",isnull(taxpayer,'') as taxpayer"
                    + ",isnull(convert (varchar(15),date_z_proj,104),'') as date_z_proj"
                    + ",isnull(visible_state,'') as visible_state"
                    + ",isnull(offer_state,'') as offer_state"
                    + ",isnull(no_offer_state,'') as no_offer_state"
                    + ",isnull(cast(term_for_joining as varchar(20)),'') as term_for_joining"
                    + ",isnull(convert (varchar(15),unmount_devices_price),'') as unmount_devices_price"
                    + ",isnull(convert (varchar(15),date_start_bmr,104),'') as date_start_bmr"
                    + ",isnull(convert (varchar(15),date_giving_akt,104),'') as date_giving_akt"
                    + ",isnull(convert (varchar(15),date_admission_akt,104),'') as date_admission_akt"
                    + ",isnull(do11,'') as do11"
                    + ",isnull(do13,'') as do13"
                    + ",isnull(do14,'') as do14"
                    + ",isnull(do15,'') as do15"
                    + ",isnull(do16,'') as do16"
                    + ",isnull(do17,'') as do17"
                    + ",isnull(do18,'') as do18"
                    + ",isnull(do19,'') as do19"
                    + ",isnull(type_jobs_vkb,0) as type_jobs_vkb"
                    + ",isnull(executor_vkb,'') as executor_vkb"
                    + ",isnull(convert (varchar(15),date_of_reception,104),'') as date_of_reception"
                    + ",isnull(convert (varchar(15),develop_price_proj),'') as develop_price_proj"
                    + ",isnull(convert (varchar(15),other_date_of_reception,104),'') as other_date_of_reception"
                    + ",isnull(convert (varchar(15),other_develop_price_proj),'') as other_develop_price_proj"
                    + ",isnull(convert (varchar(15),approved_price),'') as approved_price"
                    + ",isnull(type_lep_vkb,'') as type_lep_vkb"
                    + ",isnull(need_to_build,'') as need_to_build"
                    + ",isnull(convert(varchar(15),l_build_04),'') as l_build_04 "
                    + ",isnull(convert(varchar(15),l_build_10),'') as l_build_10 "
                    + ",isnull(convert(varchar(15),l_build_35),'') as l_build_35 "
                    + ",isnull(convert(varchar(15),l_build_110),'') as l_build_100 "
                    + ",isnull(exec_jobs_vkb,'') as exec_jobs_vkb"
                    + ",isnull(convert (varchar(15),date_of_reception_bmr,104),'') as date_of_reception_bmr"
                    + ",isnull(convert (varchar(15),develop_price_akt),'') as  develop_price_akt"
                    + ",isnull(convert (varchar(15),counter_price),'') as counter_price"
                    + ",isnull(convert (varchar(15),commissioning_date,104),'') as commissioning_date"
                    + ",isnull(convert (varchar(15),date_pay_ns,104),'') as date_pay_ns"
                    + ",isnull(convert (varchar(15),commissioning_price),'') as commissioning_price"
                    + ",isnull(convert (varchar(15),devellopment_price),'') as devellopment_price"
                    + ",isnull(convert (varchar(15),price_rec_build),'') as price_rec_build"
                    + ",isnull(convert (varchar(15),cap_costs_build),'') as cap_costs_build"
                    + ",isnull(convert (varchar(15),fact_costs_build),'') as fact_costs_build"
                    + ",isnull(convert (varchar(15),price_rec_tp),'') as price_rec_tp"
                    + ",isnull(convert (varchar(15),sum_join_pow),'') as sum_join_pow"
                    + ",isnull(convert (varchar(15),rez_pow_for_date),'') as rez_pow_for_date"
                    + ",isnull(convert(varchar(15),l_built_pl_04),'') as  l_built_pl_04"
                    + ",isnull(convert(varchar(15),l_built_kl_04),'') as l_built_kl_04"
                    + ",isnull(convert(varchar(15),tp_built_power),'') as tp_built_power"
                    + ",isnull(convert(varchar(15),l_built_pl_10),'') as l_built_pl_10"
                    + ",isnull(cast(tp_built_count as varchar(20)),'') as tp_built_count"
                    + ",isnull(convert(varchar(15),l_build_kl_10),'') as l_build_kl_10"
                    + ",isnull(cast(reusable_project as varchar(20)),'') as reusable_project"
                    + ",isnull(convert(varchar(15),price_visit_obj),'') as price_visit_obj"
                    + ",isnull(convert(varchar(15),sum_other_price_ns),'') as sum_other_price_ns"
                    + ",isnull(convert (varchar(5),time_close_nar,108),'') as time_close_nar"
                    + ",isnull(selectedValues,'0') as selectedValues"
                    + ",isnull(convert (varchar(15),date_issue_contract_o,104),'') as date_issue_contract_o"
                    + ",isnull(convert (varchar(15),date_contract_o,104),'') as date_contract_o"
                    + ",isnull(convert (varchar(15),date_connect_object_o,104),'') as date_connect_object_o"
                    + ",isnull(convert(varchar(15),power_contract_o),'') as power_contract_o"
                    + ",isnull(convert (varchar(15),date_issue_contract_bm,104),'') as date_issue_contract_bm"
                    + ",isnull(convert (varchar(15),date_contract_bm,104),'') as date_contract_bm"
                    + ",isnull(convert (varchar(15),date_connect_object_bm,104),'') as date_connect_object_bm"
                    + ",isnull(convert(varchar(15),power_contract_bm),'') as power_contract_bm"
                    + ",isnull(number_adm,'') as number_adm"
                    + ",isnull(customer_zipcode,'') as customer_zipcode"
                    + ",isnull(object_zipcode,'') as object_zipcode"
                    + ",isnull(convert(varchar(15),compatible_wire),'') as compatible_wire "
                    + ",isnull(convert(varchar(15),additional_wire),'') as additional_wire "
                    + ",isnull(convert(varchar(15),replace_wire),'') as replace_wire "
                    + ",isnull(convert(varchar(15),replace_opora),'') as replace_opora "
                    + ",isnull(convert(varchar(15),counter_type),'') as counter_type "
                    + ",isnull(convert(varchar(15),type_object),'') as type_object "
                    + ",isnull(convert(varchar(15),counter_number),'') as counter_number   "
                    + " FROM TC_V2 WHERE " + tu_id + "=id";

            pstmt = Conn.prepareStatement(sql);
            //PreparedStatement pstmt = Conn.prepareStatement("{call dbo.TC_GET_DV_XP(?)}");
            //pstmt.setString(1, tu_id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                selectedValues = (rs.getString("selectedValues")).split(", ");
                this.tu_id = rs.getString("id");
                type_contract = (rs.getString("type_contract"));
                main_contract = (rs.getString("main_contract"));
                //setBlanc_tc(rs.getString("blanc_tc"));
                egistration_date = (rs.getString("registration_date"));
                no_zvern = (rs.getString("no_zvern"));
                customer_type = (rs.getString("customer_type"));
                customer_soc_status = (rs.getString("customer_soc_status"));
                juridical = (rs.getString("juridical"));
                f_name = (rs.getString("f_name"));
                s_name = (rs.getString("s_name"));
                t_name = (rs.getString("t_name"));
                constitutive_documents = (rs.getString("constitutive_documents"));
                bank_account = (rs.getString("bank_account"));
                bank_mfo = (rs.getString("bank_mfo"));
                bank_identification_number = (rs.getString("bank_identification_number"));
                customer_locality = (rs.getString("customer_locality"));
                customer_adress = (rs.getString("customer_adress"));
                customer_telephone = (rs.getString("customer_telephone"));
                //Р”Р°РЅС– РїСЂРѕ РѕР±вЂ™С”РєС‚
                reason_tc = (rs.getString("reason_tc"));
                object_name = (rs.getString("object_name"));
                projected_year_operation = (rs.getString("projected_year_operation"));
                name_locality = (rs.getString("name_locality"));
                object_adress = (rs.getString("object_adress"));
                executor_company = (rs.getString("executor_company"));
                connection_price = (rs.getString("connection_price"));
                tc_pay_date = (rs.getString("tc_pay_date"));
                connection_treaty_number = (rs.getString("connection_treaty_number"));
                reliabylity_class_1 = (rs.getBoolean("reliabylity_class_1"));
                reliabylity_class_2 = (rs.getBoolean("reliabylity_class_2"));
                reliabylity_class_3 = (rs.getBoolean("reliabylity_class_3"));
                ch_rez1 = (rs.getBoolean("ch_rez1"));
                ch_rez2 = (rs.getBoolean("ch_rez2"));
                ch_1033 = (rs.getBoolean("ch_1033"));
                ch_1044 = (rs.getBoolean("ch_1044"));
                reliabylity_class_1_old = (rs.getBoolean("reliabylity_class_1_old"));
                reliabylity_class_2_old = (rs.getBoolean("reliabylity_class_2_old"));
                reliabylity_class_3_old = (rs.getBoolean("reliabylity_class_3_old"));
                reliabylity_class_1_build = (rs.getBoolean("reliabylity_class_1_build"));
                reliabylity_class_2_build = (rs.getBoolean("reliabylity_class_2_build"));
                reliabylity_class_3_build = (rs.getBoolean("reliabylity_class_3_build"));
                request_power = (rs.getString("request_power"));
                build_strum_power = (rs.getString("build_strum_power"));
                power_plit = (rs.getString("power_plit"));
                power_boil = (rs.getString("power_boil"));
                power_old = (rs.getString("power_old"));
                nom_data_dog = (rs.getString("nom_data_dog"));
                power_for_electric_devices = (rs.getString("power_for_electric_devices"));
                power_for_environmental_reservation = (rs.getString("power_for_environmental_reservation"));
                power_for_emergency_reservation = (rs.getString("power_for_emergency_reservation"));
                power_for_technology_reservation = (rs.getString("power_for_technology_reservation"));
                reliabylity_class_1_val = (rs.getString("reliabylity_class_1_val"));
                reliabylity_class_2_val = (rs.getString("reliabylity_class_2_val"));
                reliabylity_class_3_val = (rs.getString("reliabylity_class_3_val"));
                reliabylity_class_1_val_old = (rs.getString("reliabylity_class_1_val_old"));
                reliabylity_class_2_val_old = (rs.getString("reliabylity_class_2_val_old"));
                reliabylity_class_3_val_old = (rs.getString("reliabylity_class_3_val_old"));
                reliabylity_class_1_val_build = (rs.getString("reliabylity_class_1_val_build"));
                reliabylity_class_2_val_build = (rs.getString("reliabylity_class_2_val_build"));
                reliabylity_class_3_val_build = (rs.getString("reliabylity_class_3_val_build"));
                power_source = (rs.getString("power_source"));
                after_admission_number_of_tp = (rs.getString("after_admission_number_of_tp"));
                bearing_number = (rs.getString("bearing_number"));
                number_tp_after_admission = (rs.getString("number_tp_after_admission"));
                do1 = (rs.getString("do1"));
                do2 = (rs.getString("do2"));
                do3 = (rs.getString("do3"));
                do4 = (rs.getString("do4"));
                do5 = (rs.getString("do5"));
                do6 = (rs.getString("do6"));
                do7 = (rs.getString("do7"));
                do8 = (rs.getString("do8"));
                //Р’РўРЎ
                number = (rs.getString("number"));
                in_no_application_office = (rs.getString("in_no_application_office"));
                egistration_date = (rs.getString("registration_date"));
                date_transfer_affiliate = (rs.getString("date_transfer_affiliate"));
                date_return_from_affiliate = (rs.getString("date_return_from_affiliate"));
                initial_registration_date_rem_tu = (rs.getString("initial_registration_date_rem_tu"));
                input_number_application_vat = (rs.getString("input_number_application_vat"));
                payment_for_join = (rs.getString("payment_for_join"));
                end_dohovoru_tu = (rs.getString("end_dohovoru_tu"));
                //РўРµС…РЅС–С‡РЅС– СѓРјРѕРІРё
                date_customer_contract_tc = (rs.getString("date_customer_contract_tc")); //Р”Р°С‚Р° РІРёРґР°С‡С– Р·Р°РјРѕРІРЅРёРєСѓ РўРЈ С‚Р° РґРѕРіРѕРІРѕСЂСѓ
                otz_no = (rs.getString("otz_no")); //РћРўР— в„–
                registration_no_contract = (rs.getString("registration_no_contract")); //Р РµС”СЃС‚СЂР°С†С–Р№РЅРёР№ РЅРѕРјРµСЂ РґРѕРіРѕРІРѕСЂСѓ
                term_tc = (rs.getString("term_tc")); //РўРµСЂРјС–РЅ РґС–С— РґРѕРіРѕРІРѕСЂСѓ С‚Р° РўРЈ
                date_contract = (rs.getString("date_contract")); //Р”Р°С‚Р° СѓРєР»Р°РґРµРЅРЅСЏ РґРѕРіРѕРІРѕСЂСѓ
                state_contract = (rs.getString("state_contract")); //РЎС‚Р°РЅ РґРѕРіРѕРІРѕСЂСѓ
                performance_data_tc_no = (rs.getString("performance_data_tc_no")); //Р’РёРєРѕРЅР°РЅРЅСЏ РґР°РЅРёС… РўРЈ СЃРїС–Р»СЊРЅРѕ Р· РўРЈ в„–
                //Р”РѕРїСѓСЃРє
                date_admission_consumer = (rs.getString("date_admission_consumer")); //Р”Р°С‚Р° РґРѕРїСѓСЃРєСѓ СЃРїРѕР¶РёРІР°С‡Р°
                date_connect_consumers = (rs.getString("date_connect_consumers")); //Р”Р°С‚Р° РїС–РґРєР»СЋС‡РµРЅРЅСЏ СЃРїРѕР¶РёРІР°С‡Р°
                performer_proect_to_point = (rs.getString("performer_proect_to_point")); //Р’РёРєРѕРЅР°РІРµС†СЊ РїСЂРѕРµС‚Сѓ РґРѕ С‚РѕС‡РєРё РїСЂРёС”РґРЅР°РЅРЅСЏ
                performer_proect_after_point = (rs.getString("performer_proect_after_point")); //Р’РёРєРѕРЅР°РІРµС†СЊ РїСЂРѕРµС‚Сѓ РїС–СЃР»СЏ С‚РѕС‡РєРё РїСЂРёС”РґРЅР°РЅРЅСЏ
                estimated_cost_execution_to_point_tu = (rs.getString("estimated_cost_execution_to_point_tu"));
                estimated_after_execution_to_point_tu = (rs.getString("estimated_after_execution_to_point_tu"));
                estimated_total_lump_pitch_tu = (rs.getString("estimated_total_lump_pitch_tu"));
                customer_post = (rs.getString("customer_post"));
                //РџСЂРѕРµРєС‚СѓРІР°РЅРЅСЏ
                develloper_company = (rs.getString("develloper_company")); //Р’РёРєРѕРЅР°РІРµС†СЊ
                developer_begin_date = (rs.getString("developer_begin_date")); //Р”Р°С‚Р° РїРѕС‡Р°С‚РєСѓ
                develloper_end_date = (rs.getString("develloper_end_date")); //Р”Р°С‚Р° Р·Р°РІРµСЂС€РµРЅРЅСЏ
                pay_date_devellopment = (rs.getString("pay_date_devellopment")); //Р”Р°С‚Р° РѕРїР»Р°С‚Рё
                agreement_price = (rs.getString("agreement_price")); //Р’Р°СЂС‚С–СЃС‚СЊ РїРѕРіРѕРґР¶РµРЅРЅСЏ РџРљР”, РіСЂРЅ
                pay_date_agreement = (rs.getString("pay_date_agreement"));
                agreement_date = (rs.getString("agreement_date")); //Р”Р°С‚Р° РїРѕРіРѕРґР¶РµРЅРЅСЏ
                ntypical_agreement_date = (rs.getString("ntypical_agreement_date")); //Р”Р°С‚Р° РїРѕРіРѕРґР¶РµРЅРЅСЏ
                type_source = (rs.getString("type_source"));
                independent_source = (rs.getString("independent_source"));
                connection_fees = (rs.getString("connection_fees"));
                selecting_point = (rs.getString("selecting_point"));
                //Р•Р»РµРјРµРЅС‚Рё СЃС…РµРјРё РµР»РµРєС‚СЂРѕРїРѕСЃС‚Р°С‡Р°РЅРЅСЏ
                join_point = (rs.getString("join_point"));
                status = (rs.getString("status"));
                title = (rs.getString("title"));
                number_of_support = (rs.getString("number_of_support"));
                voltage_class = (rs.getString("voltage_class"));
                date_manufacture = (rs.getString("date_manufacture"));
                point_zab_power = (rs.getString("point_zab_power"));
                type_join = (rs.getString("type_join"));
                stage_join = (rs.getString("stage_join"));
                type_project = (rs.getString("type_project"));
                date_of_submission = (rs.getString("date_of_submission"));
                rate_choice = (rs.getString("rate_choice"));
                price_join = (rs.getString("price_join"));
                date_pay_join = (rs.getString("date_pay_join"));
                price_join_ns = (rs.getString("price_join_ns"));
                date_intro_eksp = (rs.getString("date_intro_eksp"));
                functional_target = (rs.getString("functional_target"));
                do9 = (rs.getString("do9"));
                do10 = (rs.getString("do10"));
                geo_cord_1 = (rs.getString("geo_cord_1"));
                geo_cord_2 = (rs.getString("geo_cord_2"));
                sum_other_price = (rs.getString("sum_other_price"));
                date_filling_voltage = (rs.getString("date_filling_voltage"));
                date_kill_voltage = (rs.getString("date_kill_voltage"));
                rated_current_machine = (rs.getString("rated_current_machine"));
                taxpayer = (rs.getString("taxpayer"));
                date_z_proj = (rs.getString("date_z_proj"));
                visible_state = (rs.getBoolean("visible_state"));
                offer_state = (rs.getBoolean("offer_state"));
                no_offer_state = (rs.getBoolean("no_offer_state"));
                term_for_joining = (rs.getString("term_for_joining"));
                unmount_devices_price = (rs.getString("unmount_devices_price"));
                date_start_bmr = (rs.getString("date_start_bmr"));
                date_giving_akt = (rs.getString("date_giving_akt"));
                date_admission_akt = (rs.getString("date_admission_akt"));
                do11 = (rs.getString("do11"));
                do13 = (rs.getString("do13"));
                do14 = (rs.getString("do14"));
                do15 = (rs.getString("do15"));
                do16 = (rs.getString("do16"));
                do17 = (rs.getString("do17"));
                do18 = (rs.getString("do18"));
                do19 = (rs.getString("do19"));
                //ВКБ
                type_jobs_vkb = (rs.getString("type_jobs_vkb"));
                executor_vkb = (rs.getString("executor_vkb"));
                date_of_reception = (rs.getString("date_of_reception"));
                develop_price_proj = (rs.getString("develop_price_proj"));
                other_date_of_reception = (rs.getString("other_date_of_reception"));
                other_develop_price_proj = (rs.getString("other_develop_price_proj"));
                approved_price = (rs.getString("approved_price"));
                type_lep_vkb = (rs.getString("type_lep_vkb"));
                need_to_build = (rs.getString("need_to_build"));
                l_build_04 = (rs.getString("l_build_04"));
                l_build_10 = (rs.getString("l_build_10"));
                l_build_35 = (rs.getString("l_build_35"));
                l_build_110 = (rs.getString("l_build_100"));
                exec_jobs_vkb = (rs.getString("exec_jobs_vkb"));
                date_of_reception_bmr = (rs.getString("date_of_reception_bmr"));
                develop_price_akt = (rs.getString("develop_price_akt"));
                counter_price = (rs.getString("counter_price"));
                commissioning_date = (rs.getString("commissioning_date"));
                commissioning_price = (rs.getString("commissioning_price"));
                price_rec_build = (rs.getString("price_rec_build"));
                cap_costs_build = (rs.getString("cap_costs_build"));
                fact_costs_build = (rs.getString("fact_costs_build"));
                price_rec_tp = (rs.getString("price_rec_tp"));
                sum_join_pow = (rs.getString("sum_join_pow"));
                rez_pow_for_date = (rs.getString("rez_pow_for_date"));
                devellopment_price = (rs.getString("devellopment_price"));
                l_built_pl_04 = (rs.getString("l_built_pl_04"));
                l_built_kl_04 = (rs.getString("l_built_kl_04"));
                tp_built_power = (rs.getString("tp_built_power"));
                l_built_pl_10 = (rs.getString("l_built_pl_10"));
                tp_built_count = (rs.getString("tp_built_count"));
                l_build_kl_10 = (rs.getString("l_build_kl_10"));
                reusable_project = (rs.getString("reusable_project"));
                price_visit_obj = (rs.getString("price_visit_obj"));
                sum_other_price_ns = (rs.getString("sum_other_price_ns"));
                time_close_nar = (rs.getString("time_close_nar"));
                date_pay_ns = (rs.getString("date_pay_ns"));
                date_issue_contract_o = (rs.getString("date_issue_contract_o"));
                date_contract_o = (rs.getString("date_contract_o"));
                date_connect_object_o = (rs.getString("date_connect_object_o"));
                power_contract_o = (rs.getString("power_contract_o"));
                date_issue_contract_bm = (rs.getString("date_issue_contract_bm"));
                date_contract_bm = (rs.getString("date_contract_bm"));
                date_connect_object_bm = (rs.getString("date_connect_object_bm"));
                power_contract_bm = (rs.getString("power_contract_bm"));
                number_adm = (rs.getString("number_adm"));
                customer_zipcode = rs.getString("customer_zipcode");
                object_zipcode = rs.getString("object_zipcode");
                compatible_wire = rs.getString("compatible_wire");
                additional_wire = rs.getString("additional_wire");
                replace_wire = rs.getString("replace_wire");
                replace_opora = rs.getString("replace_opora");
                counter_number = rs.getString("counter_number");
                counter_type = rs.getString("counter_type");
                type_object = rs.getString("type_object");
            }

        } catch (SQLException sqle) {
            logger.error(sqle.getMessage(), sqle);
        } catch (NamingException ne) {
            logger.error(ne.getMessage(), ne);
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(Conn);
            try {
                ic.close();
            } catch (NamingException ne) {
                logger.error(ne.getMessage(),ne);
            }
        }
    }

    public String getcustomer_name() {
        String customer_name = "f_name=" + f_name + "s_name=" + s_name + "t_name=" + t_name;
        return customer_name;
    }

    public String getHisStr() {
        String st = "<tc>"
                + getcustomer()
                + getDataobjects()
                + getVTS()
                + getTund()
                + getAdmission()
                + getDesign()
                //                + getConnection_Scheme1()
                + getJoin_price()
                + "</tc>";
        return st;
    }

    public String getcustomer() {
        String customer = "<Замовник>"
                + "type_contract=" + (type_contract)
                + "customer_post=" + (customer_post)
                + "main_contract=" + main_contract
                + "blanc_tc=" + blanc_tc
                + "registration_date=" + egistration_date
                + "no_zvern=" + no_zvern
                + "customer_type=" + (customer_type)
                + "customer_soc_status=" + customer_soc_status
                + "juridical=" + juridical
                + getcustomer_name()
                + "constitutive_documents=" + constitutive_documents
                + "bank_account=" + bank_account
                + "bank_mfo=" + bank_mfo
                + "bank_identification_number=" + bank_identification_number
                + "customer_locality=" + customer_locality
                + "customer_adress=" + customer_adress
                + "type_join=" + type_join
                + "stage_join=" + stage_join
                + "</Замовник>";
        return customer;
    }

    public String getDataobjects() {
        String dataobjects;
        dataobjects = "<Дані про обєкт>"
                + "reason_tc=" + (reason_tc)
                + "object_name=" + object_name
                + "functionality=" + (functionality)
                + "projected_year_operation=" + (projected_year_operation)
                + "name_locality=" + (name_locality)
                + "object_adress=" + object_adress
                + "functional_target=" + functional_target
                + "executor_company=" + (executor_company)
                + "connection_price=" + connection_price
                + "bearing_number=" + bearing_number
                + "tc_pay_date=" + tc_pay_date
                + "connection_treaty_number=" + connection_treaty_number
                + "point_zab_power=" + point_zab_power
                + "reliabylity_class_1=" + reliabylity_class_1
                + "reliabylity_class_1_val=" + reliabylity_class_1_val
                + "reliabylity_class_2=" + reliabylity_class_2
                + "reliabylity_class_2_val=" + reliabylity_class_2_val
                + "reliabylity_class_3=" + reliabylity_class_3
                + "reliabylity_class_3_val=" + reliabylity_class_3_val
                + "request_power=" + request_power
                + "power_for_electric_devices=" + power_for_electric_devices
                + "power_for_environmental_reservation=" + power_for_environmental_reservation
                + "power_for_emergency_reservation=" + power_for_emergency_reservation
                + "power_for_technology_reservation=" + power_for_technology_reservation
                + "power_source=" + power_source
                + "after_admission_number_of_tp=" + after_admission_number_of_tp
                + "</Дані про обєкт>";
        return dataobjects;
    }

    public String getVTS() {
        String vts = "<vts>"
                + "number=" + number
                + "in_no_application_office=" + in_no_application_office
                + "date_transfer_affiliate=" + date_transfer_affiliate
                + "date_return_from_affiliate=" + date_return_from_affiliate
                + "initial_registration_date_rem_tu=" + initial_registration_date_rem_tu
                + "input_number_application_vat=" + input_number_application_vat
                + "end_dohovoru_tu=" + end_dohovoru_tu
                + "</vts>";
        return vts;
    }

    public String getTund() {
        String tund = "<tund>"
                + "date_customer_contract_tc=" + date_customer_contract_tc
                + "registration_no_contract=" + registration_no_contract
                + "otz_no=" + otz_no
                + "term_tc=" + (term_tc)
                + "date_contract=" + date_contract
                + "payment_for_join=" + payment_for_join
                + "state_contract=" + (state_contract)
                + "performance_data_tc_no=" + performance_data_tc_no
                + "</tund>";
        return tund;
    }

    public String getJoin_price() {
        String join_price = "<join_price>"
                + "rate_choice=" + rate_choice
                + "price_join=" + price_join
                + "date_pay_join=" + date_pay_join
                + "price_join_ns=" + price_join_ns
                + "sum_other_price_ns=" + sum_other_price_ns
                + "rez_pow_for_date=" + rez_pow_for_date
                + "/join_price=";
        return join_price;
    }

    public String getAdmission() {
        String Admission = "<admission>"
                + "date_admission_consumer=" + date_admission_consumer
                + "date_connect_consumers=" + date_connect_consumers
                + "number_tp_after_admission=" + number_tp_after_admission
                + "performer_proect_to_point=" + (performer_proect_to_point)
                + "connection_fees=" + connection_fees
                + "performer_proect_after_point=" + (performer_proect_after_point)
                + "estimated_cost_execution_to_point_tu=" + estimated_cost_execution_to_point_tu
                + "estimated_after_execution_to_point_tu=" + estimated_after_execution_to_point_tu
                + "estimated_total_lump_pitch_tu=" + estimated_total_lump_pitch_tu
                + "type_project=" + type_project
                + "price_rec_build=" + price_rec_build
                + "</admission>";
        return Admission;
    }

    public String getDesign() {
        String design = "<design>"
                + "develloper_company=" + develloper_company
                + "developer_begin_date=" + developer_begin_date
                + "develloper_end_date=" + develloper_end_date
                + "pay_date_devellopment=" + pay_date_devellopment
                + "agreement_price=" + agreement_price
                + "pay_date_agreement=" + pay_date_agreement
                + "agreement_date=" + agreement_date
                + "ntypical_agreement_date=" + ntypical_agreement_date
                + "date_of_submission=" + date_of_submission
                + "offer_state=" + offer_state
                + "no_offer_state=" + no_offer_state
                + "</design>";
        return design;
    }

    public String getConnection_Scheme1() {
        String Connection_Scheme1 = "<Connection_Scheme>" + "<Connection_Scheme1>"
                + "<join_point>" + join_point + "</join_point>"
                + "<ps_10_disp_name_tmp>" + ps_10_disp_name_tmp + "</ps_10_disp_name_tmp>"
                + "<status>" + status + "</status>"
                + "<title>" + title + "</title>"
                + "<type_source>" + type_source + "</type_source>"
                + "<independent_source>" + independent_source + "</independent_source>"
                + "<selecting_point>" + selecting_point + "</selecting_point>"
                + "<number_of_support>" + number_of_support + "</number_of_support>"
                + "<voltage_class>" + voltage_class + "</voltage_class>"
                + "<ps_10_disp_name>" + ps_10_disp_name + "</ps_10_disp_name>"
                + "</Connection_Scheme1>"
                + "</Connection_Scheme>";
        return Connection_Scheme1;
    }

    public String formatData(String data, int type) {
        String result = "NULL";
        if (data != null) {
            if (!data.equals("")) {
                if (type == 1) {
                    result = "replace('" + data + "',',','.')";
                } else {
                    result = "'" + data.replaceAll("'", "''") + "'";
                }
            }
        }
        return result;
    }

    public String formatbool(boolean data) {
        String result = "'FALSE'";
        if (data) {
            result = "'TRUE'";
        }
        return result;
    }

    public void DeleteCustomer(String tu_id) {
        InitialContext ic = null;
        Connection Conn = null;
        PreparedStatement pstmt = null;
        try {
            ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup(db_name);
            Conn = ds.getConnection();
            String qry = ""
                    + "IF ( EXISTS (SELECT * "
                    + "             FROM   dbo.Changestc "
                    + "             WHERE  id_tc =" + tu_id + ") ) "
                    + "  BEGIN "
                    + "      DELETE FROM dbo.Changestc "
                    + "      WHERE  id_tc =" + tu_id + " "
                    + "  END "
                    + "IF ( EXISTS (SELECT * "
                    + "             FROM   dbo.SUPPLYCH "
                    + "             WHERE  tc_id =" + tu_id + ") ) "
                    + "  BEGIN "
                    + "      DELETE FROM dbo.SUPPLYCH "
                    + "      WHERE  tc_id =" + tu_id + " "
                    + "  END "
                    + "DELETE FROM dbo.TC_V2 "
                    + "WHERE  id = " + tu_id + " ";
            pstmt = Conn.prepareStatement(qry);
            pstmt.executeUpdate();
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

    public void ClirBean() {
        type_contract = null;
        main_contract = null;
        egistration_date = null;
        no_zvern = null;
        customer_type = null;
        customer_soc_status = null;
        juridical = null;
        f_name = null;
        s_name = null;
        t_name = null;
        customer_post = null;
        constitutive_documents = null;
        bank_account = null;
        bank_mfo = null;
        bank_identification_number = null;
        customer_locality = null;
        customer_adress = null;
        customer_telephone = null;

        reason_tc = null;
        object_name = null;
        functionality = null;
        projected_year_operation = null;
        name_locality = null;
        object_adress = null;
        executor_company = null;
        connection_price = null;
        tc_pay_date = null;
        connection_treaty_number = null;
        reliabylity_class_1_val = null;
        reliabylity_class_2_val = null;
        reliabylity_class_3_val = null;
        reliabylity_class_1_val_old = null;
        reliabylity_class_2_val_old = null;
        reliabylity_class_3_val_old = null;
        reliabylity_class_1_val_build = null;
        reliabylity_class_2_val_build = null;
        reliabylity_class_3_val_build = null;
        request_power = null;
        build_strum_power = null;
        power_for_electric_devices = null;
        power_for_environmental_reservation = null;
        power_for_emergency_reservation = null;
        power_for_technology_reservation = null;
        power_plit = null;
        power_boil = null;
        power_old = null;
        bearing_number = null;

        power_source = null;
        after_admission_number_of_tp = null;

        do1 = null;
        do2 = null;
        do3 = null;
        do4 = null;
        do5 = null;
        do6 = null;
        do7 = null;
        do8 = null;
        do9 = null;
        do10 = null;
        do11 = null;
        do13 = null;
        do14 = null;
        do15 = null;
        do16 = null;
        do17 = null;
        do18 = null;
        do19 = null;

        number = null;
        in_no_application_office = null;

        date_transfer_affiliate = null;
        date_return_from_affiliate = null;

        initial_registration_date_rem_tu = null;
        input_number_application_vat = null;
        end_dohovoru_tu = null;

        date_customer_contract_tc = null;
        otz_no = null;
        registration_no_contract = null;
        term_tc = null;
        date_contract = null;
        payment_for_join = null;
        state_contract = null;
        performance_data_tc_no = null;

        date_admission_consumer = null;
        date_connect_consumers = null;
        performer_proect_to_point = null;
        performer_proect_after_point = null;

        estimated_cost_execution_to_point_tu = null;
        estimated_after_execution_to_point_tu = null;
        estimated_total_lump_pitch_tu = null;
        number_tp_after_admission = null;

        develloper_company = null;
        developer_begin_date = null;
        develloper_end_date = null;
        pay_date_devellopment = null;
        agreement_price = null;
        pay_date_agreement = null;
        agreement_date = null;
        point_zab_power = null;
        type_join = null;
        stage_join = null;
        type_project = null;
        date_of_submission = null;
        rate_choice = null;
        price_join = null;
        date_pay_join = null;
        price_join_ns = null;
        date_intro_eksp = null;
        functional_target = null;
        geo_cord_1 = null;
        geo_cord_2 = null;
        sum_other_price = null;
        date_filling_voltage = null;
        date_kill_voltage = null;
        rated_current_machine = null;
        taxpayer = null;
        date_z_proj = null;
        term_for_joining = null;
        unmount_devices_price = null;
        date_start_bmr = null;
        date_giving_akt = null;
        date_admission_akt = null;
        type_jobs_vkb = null;
        executor_vkb = null;
        date_of_reception = null;
        develop_price_proj = null;
        other_date_of_reception = null;
        other_develop_price_proj = null;
        approved_price = null;
        type_lep_vkb = null;
        need_to_build = null;
        l_build_04 = null;
        l_build_10 = null;
        l_build_35 = null;
        l_build_110 = null;
        exec_jobs_vkb = null;
        date_of_reception_bmr = null;
        develop_price_akt = null;
        counter_price = null;
        commissioning_date = null;
        commissioning_price = null;
        devellopment_price = null;
        l_built_pl_04 = null;
        l_built_kl_04 = null;
        tp_built_power = null;
        l_built_pl_10 = null;
        tp_built_count = null;
        l_build_kl_10 = null;
        time_close_nar = null;
        price_rec_build = null;
        rez_pow_for_date = null;
        cap_costs_build = null;
        fact_costs_build = null;
        price_rec_tp = null;
        sum_join_pow = null;
        reusable_project = null;
        price_visit_obj = null;
        selectedValues = null;
        sum_other_price_ns = null;
        date_pay_ns = null;
        date_issue_contract_o = null;
        date_contract_o = null;
        date_connect_object_o = null;
        power_contract_o = null;
        date_issue_contract_bm = null;
        date_contract_bm = null;
        date_connect_object_bm = null;
        power_contract_bm = null;
        number_adm = null;
        customer_zipcode = null;
        object_zipcode = null;
        compatible_wire = null;
        additional_wire = null;
        replace_wire = null;
        replace_opora = null;
        counter_type = null;
        counter_number = null;
        type_object = null;
        ntypical_agreement_date = null;
        reliabylity_class_2 = false;
        reliabylity_class_3 = false;
        reliabylity_class_1_build = false;
        reliabylity_class_2_build = false;
        reliabylity_class_3_build = false;
        reliabylity_class_1_old = false;
        reliabylity_class_2_old = false;
        reliabylity_class_3_old = false;
        ch_rez1 = false;
        ch_rez2 = false;
        ch_1033 = false;
        ch_1044 = false;
        offer_state = false;
        visible_state = false;
        no_offer_state = false;
    }

    public String getNtypical_agreement_date() {
        return ntypical_agreement_date;
    }

    public void setNtypical_agreement_date(String ntypical_agreement_date) {
        this.ntypical_agreement_date = ntypical_agreement_date;
    }

    public boolean isNo_offer_state() {
        return no_offer_state;
    }

    public void setNo_offer_state(boolean no_offer_state) {
        this.no_offer_state = no_offer_state;
    }

    public boolean isOffer_state() {
        return offer_state;
    }

    public void setOffer_state(boolean offer_state) {
        this.offer_state = offer_state;
    }

    public String getType_object() {
        return type_object;
    }

    public void setType_object(String type_object) {
        this.type_object = type_object;
    }

    public String getReplace_opora() {
        return replace_opora;
    }

    public void setReplace_opora(String replace_opora) {
        this.replace_opora = replace_opora;
    }

    public String getCounter_type() {
        return counter_type;
    }

    public void setCounter_type(String counter_type) {
        this.counter_type = counter_type;
    }

    public String getCounter_number() {
        return counter_number;
    }

    public void setCounter_number(String counter_number) {
        this.counter_number = counter_number;
    }

    public String getOther_date_of_reception() {
        return other_date_of_reception;
    }

    public void setOther_date_of_reception(String other_date_of_reception) {
        this.other_date_of_reception = other_date_of_reception;
    }

    public String getOther_develop_price_proj() {
        return other_develop_price_proj;
    }

    public void setOther_develop_price_proj(String other_develop_price_proj) {
        this.other_develop_price_proj = other_develop_price_proj;
    }

    public String getCompatible_wire() {
        return compatible_wire;
    }

    public void setCompatible_wire(String compatible_wire) {
        this.compatible_wire = compatible_wire;
    }

    public String getAdditional_wire() {
        return additional_wire;
    }

    public void setAdditional_wire(String additional_wire) {
        this.additional_wire = additional_wire;
    }

    public String getReplace_wire() {
        return replace_wire;
    }

    public void setReplace_wire(String replace_wire) {
        this.replace_wire = replace_wire;
    }

    public String getCustomer_zipcode() {
        return customer_zipcode;
    }

    public void setCustomer_zipcode(String customer_zipcode) {
        this.customer_zipcode = customer_zipcode;
    }

    public String getObject_zipcode() {
        return object_zipcode;
    }

    public void setObject_zipcode(String object_zipcode) {
        this.object_zipcode = object_zipcode;
    }

    public String getNumber_adm() {
        return number_adm;
    }

    public void setNumber_adm(String number_adm) {
        this.number_adm = number_adm;
    }

    public String getDate_issue_contract_o() {
        return date_issue_contract_o;
    }

    public void setDate_issue_contract_o(String date_issue_contract_o) {
        this.date_issue_contract_o = date_issue_contract_o;
    }

    public String getDate_contract_o() {
        return date_contract_o;
    }

    public void setDate_contract_o(String date_contract_o) {
        this.date_contract_o = date_contract_o;
    }

    public String getDate_connect_object_o() {
        return date_connect_object_o;
    }

    public void setDate_connect_object_o(String date_connect_object_o) {
        this.date_connect_object_o = date_connect_object_o;
    }

    public String getPower_contract_o() {
        return power_contract_o;
    }

    public void setPower_contract_o(String power_contract_o) {
        this.power_contract_o = power_contract_o;
    }

    public String getDate_issue_contract_bm() {
        return date_issue_contract_bm;
    }

    public void setDate_issue_contract_bm(String date_issue_contract_bm) {
        this.date_issue_contract_bm = date_issue_contract_bm;
    }

    public String getDate_contract_bm() {
        return date_contract_bm;
    }

    public void setDate_contract_bm(String date_contract_bm) {
        this.date_contract_bm = date_contract_bm;
    }

    public String getDate_connect_object_bm() {
        return date_connect_object_bm;
    }

    public void setDate_connect_object_bm(String date_connect_object_bm) {
        this.date_connect_object_bm = date_connect_object_bm;
    }

    public String getPower_contract_bm() {
        return power_contract_bm;
    }

    public void setPower_contract_bm(String power_contract_bm) {
        this.power_contract_bm = power_contract_bm;
    }

    public String getSum_other_price_ns() {
        return sum_other_price_ns;
    }

    public void setSum_other_price_ns(String sum_other_price_ns) {
        this.sum_other_price_ns = sum_other_price_ns;
    }

    public String getStage_join() {
        return stage_join;
    }

    public void setStage_join(String stage_join) {
        this.stage_join = stage_join;
    }

    public String getDate_pay_ns() {
        return date_pay_ns;
    }

    public void setDate_pay_ns(String date_pay_ns) {
        this.date_pay_ns = date_pay_ns;
    }

    public boolean isCh_1033() {
        return ch_1033;
    }

    public void setCh_1033(boolean ch_1033) {
        this.ch_1033 = ch_1033;
    }

    public boolean isCh_1044() {
        return ch_1044;
    }

    public void setCh_1044(boolean ch_1044) {
        this.ch_1044 = ch_1044;
    }

    public List getSelectedValuesList() {
        return selectedValuesList;
    }

    public void setSelectedValuesList(List selectedValuesList) {
        this.selectedValuesList = selectedValuesList;
    }

    public String[] getSelectedValues() {
        return selectedValues;
    }

    public void setSelectedValues(String[] selectedValues) {
        this.selectedValues = selectedValues;
    }

    public boolean isCh_rez1() {
        return ch_rez1;
    }

    public void setCh_rez1(boolean ch_rez1) {
        this.ch_rez1 = ch_rez1;
    }

    public boolean isCh_rez2() {
        return ch_rez2;
    }

    public void setCh_rez2(boolean ch_rez2) {
        this.ch_rez2 = ch_rez2;
    }

    public String getPrice_visit_obj() {
        return price_visit_obj;
    }

    public void setPrice_visit_obj(String price_visit_obj) {
        this.price_visit_obj = price_visit_obj;
    }

    public String getReusable_project() {
        return reusable_project;
    }

    public void setReusable_project(String reusable_project) {
        this.reusable_project = reusable_project;
    }

    public List getReusable_project_list() {
        return reusable_project_list;
    }

    public void setReusable_project_list(List reusable_project_list) {
        this.reusable_project_list = reusable_project_list;
    }

    public String getSum_join_pow() {
        return sum_join_pow;
    }

    public void setSum_join_pow(String sum_join_pow) {
        this.sum_join_pow = sum_join_pow;
    }

    public String getCap_costs_build() {
        return cap_costs_build;
    }

    public void setCap_costs_build(String cap_costs_build) {
        this.cap_costs_build = cap_costs_build;
    }

    public String getFact_costs_build() {
        return fact_costs_build;
    }

    public void setFact_costs_build(String fact_costs_build) {
        this.fact_costs_build = fact_costs_build;
    }

    public String getPrice_rec_tp() {
        return price_rec_tp;
    }

    public void setPrice_rec_tp(String price_rec_tp) {
        this.price_rec_tp = price_rec_tp;
    }

    public String getRez_pow_for_date() {
        return rez_pow_for_date;
    }

    public void setRez_pow_for_date(String rez_pow_for_date) {
        this.rez_pow_for_date = rez_pow_for_date;
    }

    public String getPrice_rec_build() {
        return price_rec_build;
    }

    public void setPrice_rec_build(String price_rec_build) {
        this.price_rec_build = price_rec_build;
    }

    public String getDevellopment_price() {
        return devellopment_price;
    }

    public void setDevellopment_price(String devellopment_price) {
        this.devellopment_price = devellopment_price;
    }

    public String getType_project() {
        return type_project;
    }

    public void setType_project(String type_project) {
        this.type_project = type_project;
    }

    public String getTime_close_nar() {
        return time_close_nar;
    }

    public void setTime_close_nar(String time_close_nar) {
        this.time_close_nar = time_close_nar;
    }

    public String getType_jobs_vkb() {
        return type_jobs_vkb;
    }

    public void setType_jobs_vkb(String type_jobs_vkb) {
        this.type_jobs_vkb = type_jobs_vkb;
    }

    public String getExecutor_vkb() {
        return executor_vkb;
    }

    public void setExecutor_vkb(String executor_vkb) {
        this.executor_vkb = executor_vkb;
    }

    public String getDate_of_reception() {
        return date_of_reception;
    }

    public void setDate_of_reception(String date_of_reception) {
        this.date_of_reception = date_of_reception;
    }

    public String getDevelop_price_proj() {
        return develop_price_proj;
    }

    public void setDevelop_price_proj(String develop_price_proj) {
        this.develop_price_proj = develop_price_proj;
    }

    public String getApproved_price() {
        return approved_price;
    }

    public void setApproved_price(String approved_price) {
        this.approved_price = approved_price;
    }

    public String getType_lep_vkb() {
        return type_lep_vkb;
    }

    public void setType_lep_vkb(String type_lep_vkb) {
        this.type_lep_vkb = type_lep_vkb;
    }

    public String getNeed_to_build() {
        return need_to_build;
    }

    public void setNeed_to_build(String need_to_build) {
        this.need_to_build = need_to_build;
    }

    public String getL_build_04() {
        return l_build_04;
    }

    public void setL_build_04(String l_build_04) {
        this.l_build_04 = l_build_04;
    }

    public String getL_build_10() {
        return l_build_10;
    }

    public void setL_build_10(String l_build_10) {
        this.l_build_10 = l_build_10;
    }

    public String getL_build_35() {
        return l_build_35;
    }

    public void setL_build_35(String l_build_35) {
        this.l_build_35 = l_build_35;
    }

    public String getL_build_110() {
        return l_build_110;
    }

    public void setL_build_110(String l_build_110) {
        this.l_build_110 = l_build_110;
    }

    public String getExec_jobs_vkb() {
        return exec_jobs_vkb;
    }

    public void setExec_jobs_vkb(String exec_jobs_vkb) {
        this.exec_jobs_vkb = exec_jobs_vkb;
    }

    public String getDate_of_reception_bmr() {
        return date_of_reception_bmr;
    }

    public void setDate_of_reception_bmr(String date_of_reception_bmr) {
        this.date_of_reception_bmr = date_of_reception_bmr;
    }

    public String getDevelop_price_akt() {
        return develop_price_akt;
    }

    public void setDevelop_price_akt(String develop_price_akt) {
        this.develop_price_akt = develop_price_akt;
    }

    public String getCounter_price() {
        return counter_price;
    }

    public void setCounter_price(String counter_price) {
        this.counter_price = counter_price;
    }

    public String getCommissioning_date() {
        return commissioning_date;
    }

    public void setCommissioning_date(String commissioning_date) {
        this.commissioning_date = commissioning_date;
    }

    public String getCommissioning_price() {
        return commissioning_price;
    }

    public void setCommissioning_price(String commissioning_price) {
        this.commissioning_price = commissioning_price;
    }

    public String getL_built_pl_04() {
        return l_built_pl_04;
    }

    public void setL_built_pl_04(String l_built_pl_04) {
        this.l_built_pl_04 = l_built_pl_04;
    }

    public String getL_built_kl_04() {
        return l_built_kl_04;
    }

    public void setL_built_kl_04(String l_built_kl_04) {
        this.l_built_kl_04 = l_built_kl_04;
    }

    public String getTp_built_power() {
        return tp_built_power;
    }

    public void setTp_built_power(String tp_built_power) {
        this.tp_built_power = tp_built_power;
    }

    public String getL_built_pl_10() {
        return l_built_pl_10;
    }

    public void setL_built_pl_10(String l_built_pl_10) {
        this.l_built_pl_10 = l_built_pl_10;
    }

    public String getTp_built_count() {
        return tp_built_count;
    }

    public void setTp_built_count(String tp_built_count) {
        this.tp_built_count = tp_built_count;
    }

    public String getL_build_kl_10() {
        return l_build_kl_10;
    }

    public void setL_build_kl_10(String l_build_kl_10) {
        this.l_build_kl_10 = l_build_kl_10;
    }

    public List getExecutor_vkb_list() {
        return executor_vkb_list;
    }

    public void setExecutor_vkb_list(List executor_vkb_list) {
        this.executor_vkb_list = executor_vkb_list;
    }

    public List getExecutor_build_vkb_list() {
        return executor_build_vkb_list;
    }

    public void setExecutor_build_vkb_list(List executor_build_vkb_list) {
        this.executor_build_vkb_list = executor_build_vkb_list;
    }

    public String getBuild_strum_power() {
        return build_strum_power;
    }

    public void setBuild_strum_power(String build_strum_power) {
        this.build_strum_power = build_strum_power;
    }

    public boolean isReliabylity_class_1_build() {
        return reliabylity_class_1_build;
    }

    public void setReliabylity_class_1_build(boolean reliabylity_class_1_build) {
        this.reliabylity_class_1_build = reliabylity_class_1_build;
    }

    public String getReliabylity_class_1_val_build() {
        return reliabylity_class_1_val_build;
    }

    public void setReliabylity_class_1_val_build(String reliabylity_class_1_val_build) {
        this.reliabylity_class_1_val_build = reliabylity_class_1_val_build;
    }

    public boolean isReliabylity_class_2_build() {
        return reliabylity_class_2_build;
    }

    public void setReliabylity_class_2_build(boolean reliabylity_class_2_build) {
        this.reliabylity_class_2_build = reliabylity_class_2_build;
    }

    public String getReliabylity_class_2_val_build() {
        return reliabylity_class_2_val_build;
    }

    public void setReliabylity_class_2_val_build(String reliabylity_class_2_val_build) {
        this.reliabylity_class_2_val_build = reliabylity_class_2_val_build;
    }

    public boolean isReliabylity_class_3_build() {
        return reliabylity_class_3_build;
    }

    public void setReliabylity_class_3_build(boolean reliabylity_class_3_build) {
        this.reliabylity_class_3_build = reliabylity_class_3_build;
    }

    public String getReliabylity_class_3_val_build() {
        return reliabylity_class_3_val_build;
    }

    public void setReliabylity_class_3_val_build(String reliabylity_class_3_val_build) {
        this.reliabylity_class_3_val_build = reliabylity_class_3_val_build;
    }

    public String getDo17() {
        return do17;
    }

    public void setDo17(String do17) {
        this.do17 = do17;
    }

    public String getDo18() {
        return do18;
    }

    public void setDo18(String do18) {
        this.do18 = do18;
    }

    public String getDo19() {
        return do19;
    }

    public void setDo19(String do19) {
        this.do19 = do19;
    }

    public String getReliabylity_class_1_val_old() {
        return reliabylity_class_1_val_old;
    }

    public void setReliabylity_class_1_val_old(String reliabylity_class_1_val_old) {
        this.reliabylity_class_1_val_old = reliabylity_class_1_val_old;
    }

    public String getReliabylity_class_2_val_old() {
        return reliabylity_class_2_val_old;
    }

    public void setReliabylity_class_2_val_old(String reliabylity_class_2_val_old) {
        this.reliabylity_class_2_val_old = reliabylity_class_2_val_old;
    }

    public String getReliabylity_class_3_val_old() {
        return reliabylity_class_3_val_old;
    }

    public void setReliabylity_class_3_val_old(String reliabylity_class_3_val_old) {
        this.reliabylity_class_3_val_old = reliabylity_class_3_val_old;
    }

    public boolean isReliabylity_class_1_old() {
        return reliabylity_class_1_old;
    }

    public void setReliabylity_class_1_old(boolean reliabylity_class_1_old) {
        this.reliabylity_class_1_old = reliabylity_class_1_old;
    }

    public boolean isReliabylity_class_2_old() {
        return reliabylity_class_2_old;
    }

    public void setReliabylity_class_2_old(boolean reliabylity_class_2_old) {
        this.reliabylity_class_2_old = reliabylity_class_2_old;
    }

    public boolean isReliabylity_class_3_old() {
        return reliabylity_class_3_old;
    }

    public void setReliabylity_class_3_old(boolean reliabylity_class_3_old) {
        this.reliabylity_class_3_old = reliabylity_class_3_old;
    }

    public String getDo13() {
        return do13;
    }

    public void setDo13(String do13) {
        this.do13 = do13;
    }

    public String getDo14() {
        return do14;
    }

    public void setDo14(String do14) {
        this.do14 = do14;
    }

    public String getDo15() {
        return do15;
    }

    public void setDo15(String do15) {
        this.do15 = do15;
    }

    public String getDo16() {
        return do16;
    }

    public void setDo16(String do16) {
        this.do16 = do16;
    }

    public String getDo11() {
        return do11;
    }

    public void setDo11(String do11) {
        this.do11 = do11;
    }

    public String getDate_start_bmr() {
        return date_start_bmr;
    }

    public void setDate_start_bmr(String date_start_bmr) {
        this.date_start_bmr = date_start_bmr;
    }

    public String getDate_giving_akt() {
        return date_giving_akt;
    }

    public void setDate_giving_akt(String date_giving_akt) {
        this.date_giving_akt = date_giving_akt;
    }

    public String getDate_admission_akt() {
        return date_admission_akt;
    }

    public void setDate_admission_akt(String date_admission_akt) {
        this.date_admission_akt = date_admission_akt;
    }

    public String getUnmount_devices_price() {
        return unmount_devices_price;
    }

    public void setUnmount_devices_price(String unmount_devices_price) {
        this.unmount_devices_price = unmount_devices_price;
    }

    public String getTerm_for_joining() {
        return term_for_joining;
    }

    public void setTerm_for_joining(String term_for_joining) {
        this.term_for_joining = term_for_joining;
    }

    public List getRate_join_list() {
        return rate_join_list;
    }

    public void setRate_join_list(List rate_join_list) {
        this.rate_join_list = rate_join_list;
    }

    public boolean isVisible_state() {
        return visible_state;
    }

    public void setVisible_state(boolean visible_state) {
        this.visible_state = visible_state;
    }

    public String getDate_z_proj() {
        return date_z_proj;
    }

    public void setDate_z_proj(String date_z_proj) {
        this.date_z_proj = date_z_proj;
    }

    public String getTaxpayer() {
        return taxpayer;
    }

    public void setTaxpayer(String taxpayer) {
        this.taxpayer = taxpayer;
    }

    public String getDate_filling_voltage() {
        return date_filling_voltage;
    }

    public void setDate_filling_voltage(String date_filling_voltage) {
        this.date_filling_voltage = date_filling_voltage;
    }

    public String getDate_kill_voltage() {
        return date_kill_voltage;
    }

    public void setDate_kill_voltage(String date_kill_voltage) {
        this.date_kill_voltage = date_kill_voltage ;
    }

    public String getRated_current_machine(){
        return rated_current_machine;
    }

    public void setRated_current_machine(String rated_current_machine){
        this.rated_current_machine = rated_current_machine;
    }

    public String getDo9() {
        return do9;
    }

    public void setDo9(String do9) {
        this.do9 = do9;
    }

    public String getDo10() {
        return do10;
    }

    public void setDo10(String do10) {
        this.do10 = do10;
    }

    public String getGeo_cord_1() {
        return geo_cord_1;
    }

    public void setGeo_cord_1(String geo_cord_1) {
        this.geo_cord_1 = geo_cord_1;
    }

    public String getGeo_cord_2() {
        return geo_cord_2;
    }

    public void setGeo_cord_2(String geo_cord_2) {
        this.geo_cord_2 = geo_cord_2;
    }

    public String getSum_other_price() {
        return sum_other_price;
    }

    public void setSum_other_price(String sum_other_price) {
        this.sum_other_price = sum_other_price;
    }

    public String getDate_intro_eksp() {
        return date_intro_eksp;
    }

    public void setDate_intro_eksp(String date_intro_eksp) {
        this.date_intro_eksp = date_intro_eksp;
    }

    public String getFunctional_target() {
        return functional_target;
    }

    public void setFunctional_target(String functional_target) {
        this.functional_target = functional_target;
    }

    public String getPrice_join() {
        return price_join;
    }

    public void setPrice_join(String price_join) {
        this.price_join = price_join;
    }

    public String getPrice_join_ns() {
        return price_join_ns;
    }

    public void setPrice_join_ns(String price_join_ns) {
        this.price_join_ns = price_join_ns;
    }

    public String getNom_data_dog() {
        return nom_data_dog;
    }

    public void setNom_data_dog(String nom_data_dog) {
        this.nom_data_dog = nom_data_dog;
    }

    public String getDate_manufacture() {
        return date_manufacture;
    }

    public String getCustomer_telephone() {
        return customer_telephone;
    }

    public void setCustomer_telephone(String customer_telephone) {
        this.customer_telephone = customer_telephone;
    }

    public void setDate_manufacture(String date_manufacture) {
        this.date_manufacture = date_manufacture;
    }

    public String getFid_10_disp_name() {
        return fid_10_disp_name;
    }

    public void setFid_10_disp_name(String fid_10_disp_name) {
        this.fid_10_disp_name = fid_10_disp_name;
    }

    public String getPs_35_disp_name() {
        return ps_35_disp_name;
    }

    public void setPs_35_disp_name(String ps_35_disp_name) {
        this.ps_35_disp_name = ps_35_disp_name;
    }

    public String getPower_old() {
        return power_old;
    }

    public void setPower_old(String power_old) {
        this.power_old = power_old;
    }

    public String getPower_boil() {
        return power_boil;
    }

    public void setPower_boil(String power_boil) {
        this.power_boil = power_boil;
    }

    public String getPower_plit() {
        return power_plit;
    }

    public void setPower_plit(String power_plit) {
        this.power_plit = power_plit;
    }

    public String getPs_10_disp_name_tmp() {
        return ps_10_disp_name_tmp;
    }

    public void setPs_10_disp_name_tmp(String ps_10_disp_name_tmp) {
        this.ps_10_disp_name_tmp = ps_10_disp_name_tmp;
    }

    public String getConnection_fees() {
        return connection_fees;
    }

    public void setConnection_fees(String connection_fees) {
        this.connection_fees = connection_fees;
    }

    public String getIndependent_source() {
        return independent_source;
    }

    public void setIndependent_source(String independent_source) {
        this.independent_source = independent_source;
    }

    public String getSelecting_point() {
        return selecting_point;
    }

    public void setSelecting_point(String selecting_point) {
        this.selecting_point = selecting_point;
    }

    public String getType_source() {
        return type_source;
    }

    public void setType_source(String type_source) {
        this.type_source = type_source;
    }

    public String getPayment_for_join() {
        return payment_for_join;
    }

    public void setPayment_for_join(String payment_for_join) {
        this.payment_for_join = payment_for_join;
    }

    public String getBearing_number() {
        return bearing_number;
    }

    public void setBearing_number(String bearing_number) {
        this.bearing_number = bearing_number;
    }

    public String getNumber_tp_after_admission() {
        return number_tp_after_admission;
    }

    public void setNumber_tp_after_admission(String number_tp_after_admission) {
        this.number_tp_after_admission = number_tp_after_admission;
    }

    public List getConstitutive_documents_list() {
        return Constitutive_documents_list;
    }

    public void setConstitutive_documents_list(List Constitutive_documents_list) {
        this.Constitutive_documents_list = Constitutive_documents_list;
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

    public List getProjected_year_operation_list() {
        return Projected_year_operation_list;
    }

    public void setProjected_year_operation_list(List Projected_year_operation_list) {
        this.Projected_year_operation_list = Projected_year_operation_list;
    }

    public List getPs_10_disp_name_list() {
        return Ps_10_disp_name_list;
    }

    public void setPs_10_disp_name_list(List Ps_10_disp_name_list) {
        this.Ps_10_disp_name_list = Ps_10_disp_name_list;
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

    public String getAgreement_date() {
        return agreement_date;
    }

    public void setAgreement_date(String agreement_date) {
        this.agreement_date = agreement_date;
    }

    public String getAgreement_price() {
        return agreement_price;
    }

    public void setAgreement_price(String agreement_price) {
        this.agreement_price = agreement_price;
    }

    public String getBank_account() {
        return bank_account;
    }

    public void setBank_account(String bank_account) {
        this.bank_account = bank_account;
    }

    public String getBank_identification_number() {
        return bank_identification_number;
    }

    public void setBank_identification_number(String bank_identification_number) {
        this.bank_identification_number = bank_identification_number;
    }

    public String getBank_mfo() {
        return bank_mfo;
    }

    public void setBank_mfo(String bank_mfo) {
        this.bank_mfo = bank_mfo;
    }

    public String getBlanc_tc() {
        return blanc_tc;
    }

    public void setBlanc_tc(String blanc_tc) {
        this.blanc_tc = blanc_tc;
    }

    public List getBlanc_tc_list() {
        return blanc_tc_list;
    }

    public void setBlanc_tc_list(List blanc_tc_list) {
        this.blanc_tc_list = blanc_tc_list;
    }

    public List getBrList() {
        return brList;
    }

    public void setBrList(List brList) {
        this.brList = brList;
    }

    public String getConnection_price() {
        return connection_price;
    }

    public void setConnection_price(String connection_price) {
        this.connection_price = connection_price;
    }

    public String getConnection_treaty_number() {
        return connection_treaty_number;
    }

    public void setConnection_treaty_number(String connection_treaty_number) {
        this.connection_treaty_number = connection_treaty_number;
    }

    public String getConstitutive_documents() {
        return constitutive_documents;
    }

    public void setConstitutive_documents(String constitutive_documents) {
        this.constitutive_documents = constitutive_documents;
    }

    public String getCustomer_adress() {
        return customer_adress;
    }

    public void setCustomer_adress(String customer_adress) {
        this.customer_adress = customer_adress;
    }

    public String getCustomer_locality() {
        return customer_locality;
    }

    public void setCustomer_locality(String customer_locality) {
        this.customer_locality = customer_locality;
    }

    public String getCustomer_name() {
        return customer_name;
    }

    public void setCustomer_name(String customer_name) {
        this.customer_name = customer_name;
    }

    public String getCustomer_post() {
        return customer_post;
    }

    public void setCustomer_post(String customer_post) {
        this.customer_post = customer_post;
    }

    public String getCustomer_soc_status() {
        return customer_soc_status;
    }

    public void setCustomer_soc_status(String customer_soc_status) {
        this.customer_soc_status = customer_soc_status;
    }

    public List getCustomer_soc_status_list() {
        return customer_soc_status_list;
    }

    public void setCustomer_soc_status_list(List customer_soc_status_list) {
        this.customer_soc_status_list = customer_soc_status_list;
    }

    public String getCustomer_type() {
        return customer_type;
    }

    public void setCustomer_type(String customer_type) {
        this.customer_type = customer_type;
    }

    public String getDate_admission_consumer() {
        return date_admission_consumer;
    }

    public void setDate_admission_consumer(String date_admission_consumer) {
        this.date_admission_consumer = date_admission_consumer;
    }

    public List getLocality_list1() {
        return locality_list1;
    }

    public void setLocality_list1(List locality_list1) {
        this.locality_list1 = locality_list1;
    }

    public String getDate_connect_consumers() {
        return date_connect_consumers;
    }

    public void setDate_connect_consumers(String date_connect_consumers) {
        this.date_connect_consumers = date_connect_consumers;
    }

    public String getDate_contract() {
        return date_contract;
    }

    public void setDate_contract(String date_contract) {
        this.date_contract = date_contract;
    }

    public String getDate_customer_contract_tc() {
        return date_customer_contract_tc;
    }

    public void setDate_customer_contract_tc(String date_customer_contract_tc) {
        this.date_customer_contract_tc = date_customer_contract_tc;
    }

    public String getDate_return_from_affiliate() {
        return date_return_from_affiliate;
    }

    public void setDate_return_from_affiliate(String date_return_from_affiliate) {
        this.date_return_from_affiliate = date_return_from_affiliate;
    }

    public String getDate_transfer_affiliate() {
        return date_transfer_affiliate;
    }

    public void setDate_transfer_affiliate(String date_transfer_affiliate) {
        this.date_transfer_affiliate = date_transfer_affiliate;
    }

    public String getDevelloper_company() {
        return develloper_company;
    }

    public void setDevelloper_company(String develloper_company) {
        this.develloper_company = develloper_company;
    }

    public String getDevelloper_end_date() {
        return develloper_end_date;
    }

    public void setDevelloper_end_date(String develloper_end_date) {
        this.develloper_end_date = develloper_end_date;
    }

    public String getDeveloper_begin_date() {
        return developer_begin_date;
    }

    public void setDeveloper_begin_date(String developer_begin_date) {
        this.developer_begin_date = developer_begin_date;
    }

    public String getExecutor_company() {
        return executor_company;
    }

    public void setExecutor_company(String executor_company) {
        this.executor_company = executor_company;
    }

    public String getF_name() {
        return f_name;
    }

    public void setF_name(String f_name) {
        this.f_name = f_name;
    }

    public String getFunctionality() {
        return functionality;
    }

    public void setFunctionality(String functionality) {
        this.functionality = functionality;
    }

    public List getFunctionality_list() {
        return functionality_list;
    }

    public void setFunctionality_list(List functionality_list) {
        this.functionality_list = functionality_list;
    }

    public String getIn_no_application_office() {
        return in_no_application_office;
    }

    public void setIn_no_application_office(String in_no_application_office) {
        this.in_no_application_office = in_no_application_office;
    }

    public String getJoin_point() {
        return join_point;
    }

    public void setJoin_point(String join_point) {
        this.join_point = join_point;
    }

    public List getJoin_point_list() {
        return join_point_list;
    }

    public void setJoin_point_list(List join_point_list) {
        this.join_point_list = join_point_list;
    }

    public String getJuridical() {
        return juridical;
    }

    public void setJuridical(String juridical) {
        this.juridical = juridical;
    }

    public List getLocality_list() {
        return locality_list;
    }

    public void setLocality_list(List locality_list) {
        this.locality_list = locality_list;
    }

    public String getMain_contract() {
        return main_contract;
    }

    public void setMain_contract(String main_contract) {
        this.main_contract = main_contract;
    }

    public List getMain_contract_list() {
        return main_contract_list;
    }

    public void setMain_contract_list(List main_contract_list) {
        this.main_contract_list = main_contract_list;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName_locality() {
        return name_locality;
    }

    public void setName_locality(String name_locality) {
        this.name_locality = name_locality;
    }

    public String getNo_zvern() {
        return no_zvern;
    }

    public void setNo_zvern(String no_zvern) {
        this.no_zvern = no_zvern;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getNumber_of_support() {
        return number_of_support;
    }

    public void setNumber_of_support(String number_of_support) {
        this.number_of_support = number_of_support;
    }

    public String getObject_adress() {
        return object_adress;
    }

    public void setObject_adress(String object_adress) {
        this.object_adress = object_adress;
    }

    public String getObject_name() {
        return object_name;
    }

    public void setObject_name(String object_name) {
        this.object_name = object_name;
    }

    public String getOtz_no() {
        return otz_no;
    }

    public void setOtz_no(String otz_no) {
        this.otz_no = otz_no;
    }

    public String getPay_date_agreement() {
        return pay_date_agreement;
    }

    public void setPay_date_agreement(String pay_date_agreement) {
        this.pay_date_agreement = pay_date_agreement;
    }

    public String getPay_date_devellopment() {
        return pay_date_devellopment;
    }

    public void setPay_date_devellopment(String pay_date_devellopment) {
        this.pay_date_devellopment = pay_date_devellopment;
    }

    public String getPerformance_data_tc_no() {
        return performance_data_tc_no;
    }

    public void setPerformance_data_tc_no(String performance_data_tc_no) {
        this.performance_data_tc_no = performance_data_tc_no;
    }

    public List getPerformer_list() {
        return performer_list;
    }

    public void setPerformer_list(List performer_list) {
        this.performer_list = performer_list;
    }

    public String getPerformer_proect_after_point() {
        return performer_proect_after_point;
    }

    public void setPerformer_proect_after_point(String performer_proect_after_point) {
        this.performer_proect_after_point = performer_proect_after_point;
    }

    public String getPerformer_proect_to_point() {
        return performer_proect_to_point;
    }

    public void setPerformer_proect_to_point(String performer_proect_to_point) {
        this.performer_proect_to_point = performer_proect_to_point;
    }

    public String getPower_for_electric_devices() {
        return power_for_electric_devices;
    }

    public void setPower_for_electric_devices(String power_for_electric_devices) {
        this.power_for_electric_devices = power_for_electric_devices;
    }

    public String getPower_for_emergency_reservation() {
        return power_for_emergency_reservation;
    }

    public void setPower_for_emergency_reservation(String power_for_emergency_reservation) {
        this.power_for_emergency_reservation = power_for_emergency_reservation;
    }

    public String getPower_for_environmental_reservation() {
        return power_for_environmental_reservation;
    }

    public void setPower_for_environmental_reservation(String power_for_environmental_reservation) {
        this.power_for_environmental_reservation = power_for_environmental_reservation;
    }

    public String getPower_for_technology_reservation() {
        return power_for_technology_reservation;
    }

    public void setPower_for_technology_reservation(String power_for_technology_reservation) {
        this.power_for_technology_reservation = power_for_technology_reservation;
    }

    public String getProjected_year_operation() {
        return projected_year_operation;
    }

    public void setProjected_year_operation(String projected_year_operation) {
        this.projected_year_operation = projected_year_operation;
    }

    public String getPs_10_disp_name() {
        return ps_10_disp_name;
    }

    public void setPs_10_disp_name(String ps_10_disp_name) {
        this.ps_10_disp_name = ps_10_disp_name;
    }

    public String getReason_tc() {
        return reason_tc;
    }

    public void setReason_tc(String reason_tc) {
        this.reason_tc = reason_tc;
    }

    public List getReason_tc_list() {
        return reason_tc_list;
    }

    public void setReason_tc_list(List reason_tc_list) {
        this.reason_tc_list = reason_tc_list;
    }

    public String getEgistration_date() {
        return egistration_date;
    }

    public void setEgistration_date(String egistration_date) {
        this.egistration_date = egistration_date;
    }

    public String getRegistration_no_contract() {
        return registration_no_contract;
    }

    public void setRegistration_no_contract(String registration_no_contract) {
        this.registration_no_contract = registration_no_contract;
    }

    public boolean isReliabylity_class_1() {
        return reliabylity_class_1;
    }

    public void setReliabylity_class_1(boolean reliabylity_class_1) {
        this.reliabylity_class_1 = reliabylity_class_1;
    }

    public String getReliabylity_class_1_val() {
        return reliabylity_class_1_val;
    }

    public void setReliabylity_class_1_val(String reliabylity_class_1_val) {
        this.reliabylity_class_1_val = reliabylity_class_1_val;
    }

    public boolean isReliabylity_class_2() {
        return reliabylity_class_2;
    }

    public void setReliabylity_class_2(boolean reliabylity_class_2) {
        this.reliabylity_class_2 = reliabylity_class_2;
    }

    public String getReliabylity_class_2_val() {
        return reliabylity_class_2_val;
    }

    public void setReliabylity_class_2_val(String reliabylity_class_2_val) {
        this.reliabylity_class_2_val = reliabylity_class_2_val;
    }

    public boolean isReliabylity_class_3() {
        return reliabylity_class_3;
    }

    public void setReliabylity_class_3(boolean reliabylity_class_3) {
        this.reliabylity_class_3 = reliabylity_class_3;
    }

    public String getReliabylity_class_3_val() {
        return reliabylity_class_3_val;
    }

    public void setReliabylity_class_3_val(String reliabylity_class_3_val) {
        this.reliabylity_class_3_val = reliabylity_class_3_val;
    }

    public String getRequest_power() {
        return request_power;
    }

    public void setRequest_power(String request_power) {
        this.request_power = request_power;
    }

    public String getS_name() {
        return s_name;
    }

    public void setS_name(String s_name) {
        this.s_name = s_name;
    }

    public String getState_contract() {
        return state_contract;
    }

    public void setState_contract(String state_contract) {
        this.state_contract = state_contract;
    }

    public List getState_contract_list() {
        return state_contract_list;
    }

    public void setState_contract_list(List state_contract_list) {
        this.state_contract_list = state_contract_list;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getT_name() {
        return t_name;
    }

    public void setT_name(String t_name) {
        this.t_name = t_name;
    }

    public String getTc_pay_date() {
        return tc_pay_date;
    }

    public void setTc_pay_date(String tc_pay_date) {
        this.tc_pay_date = tc_pay_date;
    }

    public String getTerm_tc() {
        return term_tc;
    }

    public void setTerm_tc(String term_tc) {
        this.term_tc = term_tc;
    }

    public List getTerm_tc_list() {
        return term_tc_list;
    }

    public void setTerm_tc_list(List term_tc_list) {
        this.term_tc_list = term_tc_list;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List getTitle_list() {
        return title_list;
    }

    public void setTitle_list(List title_list) {
        this.title_list = title_list;
    }

    public String getTu_id() {
        return tu_id;
    }

    public void setTu_id(String tu_id) {
        this.tu_id = tu_id;
    }

    public String getType_contract() {
        return type_contract;
    }

    public void setType_contract(String type_contract) {
        this.type_contract = type_contract;
    }

    public List getType_contract_list() {
        return type_contract_list;
    }

    public void setType_contract_list(List type_contract_list) {
        this.type_contract_list = type_contract_list;
    }

    public String getVoltage_class() {
        return voltage_class;
    }

    public void setVoltage_class(String voltage_class) {
        this.voltage_class = voltage_class;
    }

    public String getDo1() {
        return do1;
    }

    public void setDo1(String do1) {
        this.do1 = do1;
    }

    public String getDo2() {
        return do2;
    }

    public void setDo2(String do2) {
        this.do2 = do2;
    }

    public String getDo3() {
        return do3;
    }

    public void setDo3(String do3) {
        this.do3 = do3;
    }

    public String getDo4() {
        return do4;
    }

    public void setDo4(String do4) {
        this.do4 = do4;
    }

    public String getDo5() {
        return do5;
    }

    public void setDo5(String do5) {
        this.do5 = do5;
    }

    public String getDo6() {
        return do6;
    }

    public void setDo6(String do6) {
        this.do6 = do6;
    }

    public String getDo7() {
        return do7;
    }

    public void setDo7(String do7) {
        this.do7 = do7;
    }

    public String getDo8() {
        return do8;
    }

    public void setDo8(String do8) {
        this.do8 = do8;
    }

    public String getPower_source() {
        return power_source;
    }

    public void setPower_source(String power_source) {
        this.power_source = power_source;
    }

    public String getAfter_admission_number_of_tp() {
        return after_admission_number_of_tp;
    }

    public void setAfter_admission_number_of_tp(String after_admission_number_of_tp) {
        this.after_admission_number_of_tp = after_admission_number_of_tp;
    }

    public String getEnd_dohovoru_tu() {
        return end_dohovoru_tu;
    }

    public void setEnd_dohovoru_tu(String end_dohovoru_tu) {
        this.end_dohovoru_tu = end_dohovoru_tu;
    }

    public String getEstimated_after_execution_to_point_tu() {
        return estimated_after_execution_to_point_tu;
    }

    public void setEstimated_after_execution_to_point_tu(String estimated_after_execution_to_point_tu) {
        this.estimated_after_execution_to_point_tu = estimated_after_execution_to_point_tu;
    }

    public String getEstimated_cost_execution_to_point_tu() {
        return estimated_cost_execution_to_point_tu;
    }

    public void setEstimated_cost_execution_to_point_tu(String estimated_cost_execution_to_point_tu) {
        this.estimated_cost_execution_to_point_tu = estimated_cost_execution_to_point_tu;
    }

    public String getEstimated_total_lump_pitch_tu() {
        return estimated_total_lump_pitch_tu;
    }

    public void setEstimated_total_lump_pitch_tu(String estimated_total_lump_pitch_tu) {
        this.estimated_total_lump_pitch_tu = estimated_total_lump_pitch_tu;
    }

    public String getInitial_registration_date_rem_tu() {
        return initial_registration_date_rem_tu;
    }

    public void setInitial_registration_date_rem_tu(String initial_registration_date_rem_tu) {
        this.initial_registration_date_rem_tu = initial_registration_date_rem_tu;
    }

    public String getInput_number_application_vat() {
        return input_number_application_vat;
    }

    public void setInput_number_application_vat(String input_number_application_vat) {
        this.input_number_application_vat = input_number_application_vat;
    }

    public String getPoint_zab_power() {
        return point_zab_power;
    }

    public void setPoint_zab_power(String point_zab_power) {
        this.point_zab_power = point_zab_power;
    }

    public String getType_join() {
        return type_join;
    }

    public void setType_join(String type_join) {
        this.type_join = type_join;
    }

    public String getDate_of_submission() {
        return date_of_submission;
    }

    public void setDate_of_submission(String date_of_submission) {
        this.date_of_submission = date_of_submission;
    }

    public String getRate_choice() {
        return rate_choice;
    }

    public void setRate_choice(String rate_choice) {
        this.rate_choice = rate_choice;
    }

    public String getDate_pay_join() {
        return date_pay_join;
    }

    public void setDate_pay_join(String date_pay_join) {
        this.date_pay_join = date_pay_join;
    }

    public List getStageJoinList() {
        return stageJoinList;
    }

    public void setStageJoinList(List stageJoinList) {
        this.stageJoinList = stageJoinList;
    }

    public List getTypeJoinList() {
        return typeJoinList;
    }

    public void setTypeJoinList(List typeJoinList) {
        this.typeJoinList = typeJoinList;
    }
}
