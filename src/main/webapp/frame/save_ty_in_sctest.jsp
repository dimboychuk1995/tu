<%-- 
    Document   : save_ty_in_sc
    Created on : 1 вер 2010, 11:41:56
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%--= request.getQueryString() --%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.Connection"%>
        <%@ page import="java.sql.PreparedStatement" %>
        <%@ page import="java.sql.ResultSet" %>
        <%
        String param1 =(String)request.getParameter("param1");
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/TUWeb240");
        Connection Conn = ds.getConnection();
        PreparedStatement pstmt = Conn.prepareStatement("{call dbo.ins_tu_in_sc(?,?,?,?,?,?,?,?,?,?"
                                                                            + ",?,?,?,?,?,?,?,?,?,?"
                                                                            + ",?,?,?,?,?,?,?,?,?,?"
                                                                            + ",?,?,?,?,?)}");
        /*String id =(String)request.getParameter("id");
        String registration_date =(String)request.getParameter("registration_date");
        String customer_soc_status =(String)request.getParameter("customer_soc_status");
        String juridical =(String)request.getParameter("juridical");
        String f_name =(String)request.getParameter("f_name");
        String customer_adress =(String)request.getParameter("customer_adress");
        String customer_type =(String)request.getParameter("customer_type");
        String number =(String)request.getParameter("number");
        String initial_registration_date_rem_tu =(String)request.getParameter("initial_registration_date_rem_tu");//
        String date_admission_consumer =(String)request.getParameter("date_admission_consumer");//
        String date_customer_contract_tc =(String)request.getParameter("date_customer_contract_tc");
        String connection_price =(String)request.getParameter("connection_price");
        String tc_pay_date =(String)request.getParameter("tc_pay_date");
        String executor_company =(String)request.getParameter("executor_company");
        String object_name =(String)request.getParameter("object_name");
        String object_adress =(String)request.getParameter("object_adress");
        String request_power =(String)request.getParameter("request_power");
        String ps_110_disp_name =(String)request.getParameter("ps_110_disp_name");//
        String reliabylity_class_1 =(String)request.getParameter("reliabylity_class_1");
        String reliabylity_class_2 =(String)request.getParameter("reliabylity_class_2");
        String reliabylity_class_3 =(String)request.getParameter("reliabylity_class_3");
        String power_source =(String)request.getParameter("power_source");
        String type_source =(String)request.getParameter("type_source");//
        String voltage_class =(String)request.getParameter("voltage_class");//       
        String independent_source =(String)request.getParameter("independent_source");//       
        String connection_treaty_number =(String)request.getParameter("connection_treaty_number");  
        String date_connect_consumers =(String)request.getParameter("date_connect_consumers");
        String connection_fees =(String)request.getParameter("connection_fees");//
        String develloper_company =(String)request.getParameter("develloper_company");
        String devellopment_price =(String)request.getParameter("devellopment_price");
        String pay_date_devellopment =(String)request.getParameter("pay_date_devellopment");
        String agreement_date =(String)request.getParameter("agreement_date");
        String agreement_price =(String)request.getParameter("agreement_price");
        String pay_date_agreement =(String)request.getParameter("pay_date_agreement");     
        String performer_proect_to_point =(String)request.getParameter("performer_proect_to_point");
        String estimated_total_lump_pitch_tu =(String)request.getParameter("estimated_total_lump_pitch_tu");*/

        String id =(String)request.getParameter("id"); 
    String customer_soc_status =(String)request.getParameter("customer_soc_status"); 
    String customer_type =(String)request.getParameter("customer_type");
    
        ///////////////////////////////////////////////////////////////////
        ////////////type_contract
    String registration_date =(String)request.getParameter("registration_date");
    String no_zvern =(String)request.getParameter("no_zvern");
    String juridical =(String)request.getParameter("juridical");
    String f_name =(String)request.getParameter("f_name");
    String customer_post =(String)request.getParameter("customer_post");
    String constitutive_documents =(String)request.getParameter("constitutive_documents");
    String bank_account =(String)request.getParameter("bank_account");
    String bank_mfo =(String)request.getParameter("bank_mfo");
    String bank_identification_number =(String)request.getParameter("bank_identification_number");
    String customer_adress =(String)request.getParameter("customer_adress");
    String reason_tc =(String)request.getParameter("reason_tc");
    String object_name =(String)request.getParameter("object_name");
    String object_adress =(String)request.getParameter("object_adress");
    String executor_company =(String)request.getParameter("executor_company");
    String connection_price =(String)request.getParameter("connection_price");
    String tc_pay_date =(String)request.getParameter("tc_pay_date");
    String initial_registration_date_rem_tu =(String)request.getParameter("initial_registration_date_rem_tu");
    String registration_no_contract =(String)request.getParameter("registration_no_contract");
    String date_customer_contract_tc =(String)request.getParameter("date_customer_contract_tc");
    String date_contract =(String)request.getParameter("date_contract");
    String date_admission_consumer =(String)request.getParameter("date_admission_consumer");
    String performer_proect_to_point =(String)request.getParameter("performer_proect_to_point");
    String estimated_total_lump_pitch_tu =(String)request.getParameter("estimated_total_lump_pitch_tu");
    String develloper_company =(String)request.getParameter("develloper_company");
    String agreement_date =(String)request.getParameter("agreement_date");    
    String number = "";
    String type_contract =(String)request.getParameter("type_contract");
    String devellopment_price = (String)request.getParameter("devellopment_price");
    String pay_date_devellopment = (String)request.getParameter("pay_date_devellopment");
    String agreement_price = (String) request.getParameter("agreement_price");
    String pay_date_agreement = (String) request.getParameter("pay_date_agreement");
    String user_name = request.getParameter("user_name");
    
    
    pstmt.setString(1,id);
    pstmt.setString(2,customer_soc_status);
    pstmt.setString(3,customer_type);
        ///////////////////////////////////////////////////////////////////
        ////////////type_contract
    pstmt.setString(4,registration_date);
    pstmt.setString(5,no_zvern);
    pstmt.setString(6,juridical);
    pstmt.setString(7,f_name);
    pstmt.setString(8,customer_post);
    pstmt.setString(9,constitutive_documents);
    pstmt.setString(10,bank_account);
    pstmt.setString(11,bank_mfo);
    pstmt.setString(12,bank_identification_number);
    pstmt.setString(13,customer_adress);
    pstmt.setString(14,reason_tc);
    pstmt.setString(15,object_name);
    pstmt.setString(16,object_adress);
    pstmt.setString(17,executor_company);
    pstmt.setString(18,connection_price);
    pstmt.setString(19,tc_pay_date);
    pstmt.setString(20,initial_registration_date_rem_tu);
    pstmt.setString(21,registration_no_contract);
    pstmt.setString(22,date_customer_contract_tc);
    pstmt.setString(23,date_contract);
    pstmt.setString(24,date_admission_consumer);
    pstmt.setString(25,performer_proect_to_point);
    pstmt.setString(26,estimated_total_lump_pitch_tu);
    pstmt.setString(27,develloper_company);
    pstmt.setString(28,agreement_date);
        
    if (executor_company.equals("1")){
           PreparedStatement pstmtnum = Conn.prepareStatement("select isnull(number,'___') as number from TC_V2 where id="+id);
           ResultSet rsnum = pstmtnum.executeQuery();
           rsnum.next();
           if (rsnum.getString("number").equals("___")){
                InitialContext icnvts = new InitialContext();
                DataSource dsnvts = (DataSource)icnvts.lookup("java:comp/env/jdbc/TUWeb");
                Connection Connnvts = dsnvts.getConnection();
                PreparedStatement pstmtnvts = Connnvts.prepareStatement("update Nomer_TU_VTS set Number=Number+1");
                pstmtnvts.executeUpdate();
                pstmtnvts.close();
                pstmtnvts = Connnvts.prepareStatement("select Number,Year from Nomer_TU_VTS ");
                ResultSet rs = pstmtnvts.executeQuery();
                rs.next();
                number = rs.getString("Number")+"/"+"24-"+no_zvern+"/"+rs.getString("Year");
                pstmtnvts.close();
                Connnvts.close();
                icnvts.close();
                rs.close();     
           }
           else{number=rsnum.getString("number");}

           pstmtnum.close();
           rsnum.close();

    } else {
        number = "24-"+no_zvern+"/2013";
    }

    pstmt.setString(29,number);
    pstmt.setString(30,type_contract);
    pstmt.setString(31,devellopment_price);
    pstmt.setString(32,pay_date_devellopment);
    pstmt.setString(33,agreement_price);
    pstmt.setString(34,pay_date_agreement);
    pstmt.setString(35,user_name);
        
        
        
        
        
        
        
        
        
        
        
        /*
        pstmt.setString(1,id);
        pstmt.setString(2,registration_date);
        pstmt.setString(3,customer_soc_status);
        pstmt.setString(4,juridical);
        pstmt.setString(5,f_name);
        pstmt.setString(6,customer_adress);
        pstmt.setString(7,customer_type);
        pstmt.setString(8,number);
        pstmt.setString(9,initial_registration_date_rem_tu);
        pstmt.setString(10,date_admission_consumer);
        pstmt.setString(11,date_customer_contract_tc);
        pstmt.setString(12,connection_price);
        pstmt.setString(13,tc_pay_date);
        pstmt.setString(14,executor_company);
        pstmt.setString(15,object_name);
        pstmt.setString(16,object_adress);
        pstmt.setString(17,request_power);
        pstmt.setString(18,ps_110_disp_name);
        pstmt.setString(19,reliabylity_class_1);
        pstmt.setString(20,reliabylity_class_2);
        pstmt.setString(21,reliabylity_class_3);
        pstmt.setString(22,power_source);
        pstmt.setString(23,type_source);
        pstmt.setString(24,voltage_class);
        pstmt.setString(25,independent_source);
        pstmt.setString(26,connection_treaty_number);
        pstmt.setString(27,date_connect_consumers);
        pstmt.setString(28,connection_fees);
        pstmt.setString(29,develloper_company);
        pstmt.setString(30,devellopment_price);
        pstmt.setString(31,pay_date_devellopment);
        pstmt.setString(32,agreement_date);
        pstmt.setString(33,agreement_price);
        pstmt.setString(34,pay_date_agreement);
        pstmt.setString(35,performer_proect_to_point);
        pstmt.setString(36,estimated_total_lump_pitch_tu);*/
        
        
        
        
        
        
        
        
        
        
        
        
        //=request.getQueryString();
        pstmt.executeUpdate();
        pstmt.close();
        Conn.close();
        ic.close();
%>
Всьо файно вийшло можна пити каву :)
    </body>
</html>
