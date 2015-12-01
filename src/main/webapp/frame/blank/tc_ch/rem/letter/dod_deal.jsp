<%-- 
    Document   : fiz
    Created on : 16 лют 2011, 16:18:59
    Author     : AsuSV
--%>
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.*,java.text.NumberFormat"%>
<% response.setHeader("Content-Disposition", "inline;filename=dod_deal.doc");
    NumberFormat nf = NumberFormat.getInstance();
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    HttpSession ses = request.getSession();
    String db = new String();
    if (!ses.getAttribute("db_name").equals(null)) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try {
        c = ds.getConnection();
        String qry =
                "SELECT "
                + " TC_V2.number as number"
                + ",TC_V2.customer_soc_status as customer_soc_status_1 "
                + ",TC_V2.customer_type"
                +",isnull(TC_V2.juridical,'') as juridical"
                + ",isnull(soc_status.full_name,'') as customer_soc_status"
                + ",CASE WHEN TC_V2.customer_type=1 and TC_V2.customer_soc_status<>15 and TC_V2.customer_soc_status<>11 and TC_V2.customer_soc_status<>9 and  TC_V2.customer_soc_status<>12 and  TC_V2.customer_soc_status<>8"
                + "THEN  '\"" + "'+isnull(TC_V2.juridical,'')" + "+'\"' "
                + "WHEN TC_V2.customer_type=1 and (TC_V2.customer_soc_status=15 or TC_V2.customer_soc_status=11 or TC_V2.customer_soc_status=12 or TC_V2.customer_soc_status=9 or TC_V2.customer_soc_status=8)"
                + "THEN  isnull(TC_V2.juridical,'')"
                + "WHEN TC_V2.customer_type=0"
                + "THEN isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'')"
                + "ELSE '' end as [name]"
                + ",CASE "
                + " WHEN upper(TC_V2.ch_rez1) = 'TRUE' THEN Replace(CAST(cast((((ISNULL(TC_V2.request_power, 0) - ISNULL(TC_V2.power_old, 0))*250+ISNULL(TC_V2.price_rec_build,0)+ISNULL(TC_V2.fact_costs_build,0)-isnull(TC_V2.devellopment_price,0))*1.2) as numeric(10,2)) AS VARCHAR(50)), '.', ',')"
                + " WHEN upper(TC_V2.ch_rez2) = 'TRUE' THEN Replace(ISNULL(CAST(((ISNULL(TC_V2.request_power,0)/NULLIF(TC_V2.sum_join_pow,0))*(ISNULL(TC_V2.rez_pow_for_date,0)*250+(ISNULL(TC_V2.sum_join_pow,0)-ISNULL(TC_V2.rez_pow_for_date,0))*ISNULL(((ISNULL(TC_V2.cap_costs_build,0)-ISNULL(TC_V2.unmount_devices_price,0))/NULLIF(SUPPLYCH.ps_10_inc_rez,0)),0)+ISNULL(TC_V2.price_rec_build,0)+ISNULL(TC_V2.fact_costs_build,0)-isnull(TC_V2.devellopment_price,0))*1.2)AS NUMERIC(10,2)),0), '.', ',')"
                + "ELSE '_____' end AS price_join"
                + ",isnull(TC_V2.constitutive_documents,'') as constitutive_documents"
                + ",isnull(TC_V2.customer_post,'') as customer_post"
                + ",isnull(TC_V2.customer_telephone,'_________') as customer_telephone"
                + ",isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'') as PIP"
                + ",isnull(TC_V2.[object_name],'') as [object_name]"
                + ",case when objadr.type=1 then 'м.'"
                + " when objadr.type=2 then 'с.'"
                + " when objadr.type=3 then 'смт.' end as type_o"
                + ",case when nullif(TC_V2.[object_adress],'') is not null then "
                + " isnull(objadr.name,'')+', вул.'+ isnull(TC_V2.[object_adress],'') "
                + "else isnull(objadr.name,'') end as object_adress"
                + ",isnull(convert (varchar(10),TC_V2.initial_registration_date_rem_tu,104),'___.___.____') as initial_date"
                + ",isnull(convert (varchar,ch.limit_date,104),'___.___.____') as limit_date"
                + ",isnull(convert(varchar,TC_V2.date_contract,104),'') as date_contract"
                + ",isnull(convert(varchar,TC_V2.date_customer_contract_tc,104),'___.___.2013') as date_customer_contract_tc"
                + ",case when cusadr.type=1 then 'м.'"
                + " when cusadr.type=2 then 'с.'"
                + " when cusadr.type=3 then 'смт.' end as type_c"
                + ",isnull(cusadr.name,'')+', вул. '+ isnull(TC_V2.[customer_adress],'_________') as customer_adress"
                + ",'вул. '+ isnull(TC_V2.[customer_adress],'_________')+', ' as customer_adress1"
                + ",isnull(cusadr.name,'') as customer_adress2"
                + ",isnull(TC_V2.[bank_account],'__________') as [bank_account]"
                + ",isnull(TC_V2.[bank_mfo],'_____________') as [bank_mfo]"
                + ",isnull(TC_V2.[taxpayer],'_____________') as [taxpayer]"
                + ",isnull(TC_V2.[bank_identification_number],'________') as [bank_identification_number]"
                + ",isnull(TC_V2.[connection_treaty_number],'__________') as [connection_treaty_number] "
                + ",isnull(TC_V2.voltage_class,'') as voltage_class "
                + ",[rem_name] "
                + ",[Director] "
                + ",[director_rod]"
                + ",[director_dav]"
                + ",[dovirenist]"
                + ",[contacts] "
                + ",[rek_bank] "
                + ",[rem_licality]"
                + ",isnull(cast(tc_v2.term_for_joining AS VARCHAR(5)),'') AS term_for_joining"
                + ",isnull(convert(varchar,TC_O.date_contract,104),'') as TC_Odate_contract "
                + ",isnull(TC_O.number,'') as TC_Onumber "
                + " ,case when SUPPLYCH.join_point=1 then '0,4' "
                + "     when SUPPLYCH.join_point=11 then '0,23' "
                + "     when SUPPLYCH.join_point=2 then '0,4' "
                + "     when SUPPLYCH.join_point=21 then '0,23' "
                + "     when SUPPLYCH.join_point=3 then '10' "
                + "     when SUPPLYCH.join_point=4 then '10' "
                + "     when SUPPLYCH.join_point=5 then '35'"
                + "     when SUPPLYCH.join_point=6 then '35' "
                + "     when SUPPLYCH.join_point=7 then '110' "
                + "    else '___' end as joint_point "
                + " ,case when SUPPLYCH.join_point=1 then '2'"
                + "  when SUPPLYCH.join_point=11 then '2'"
                + "  when SUPPLYCH.join_point=2 then '2'"
                + " when SUPPLYCH.join_point=21 then '2'"
                + "  when SUPPLYCH.join_point=3 then '2'"
                + " when SUPPLYCH.join_point=4 then '2'"
                + " when SUPPLYCH.join_point=5 then '1'"
                + " when SUPPLYCH.join_point=6 then '1'"
                + " when SUPPLYCH.join_point=7 then '1'"
                + " else '____' end as class_joint_point  "
                + ",isnull(tj.name,'надання доступу') as type_join,"
                + " CAST(ISNULL(CAST(TC_V2.request_power AS FLOAT),'') AS VARCHAR) as request_power,"
                + " CASE"
                + " WHEN TC_V2.reliabylity_class_1='true' THEN 'I '"
                + " ELSE '' END AS reliabylity_class_1,"
                + " CASE"
                + " WHEN TC_V2.reliabylity_class_2='true' THEN 'II '"
                + " ELSE '' END AS reliabylity_class_2,"
                + " CASE"
                + " WHEN TC_V2.reliabylity_class_3='true' THEN 'III'"
                + " ELSE ' ' END AS reliabylity_class_3,"
                + " isnull(convert(varchar,TC_V2.date_intro_eksp,104),'___.___.____') as date_intro_eksp"
                + ",isnull( dbo.TC_V2.point_zab_power,'') as point_zab_power"
                //  + ",cast(isnull( (cast(dbo.TC_V2.price_join as float)*1000),'') as varchar(20)) as price_join"
                //+ ",isnull(dbo.TC_V2.price_join,'0') as price_join"
                + " ,isnull(convert(varchar, dbo.TC_V2.end_dohovoru_tu,104),'___.___.____') as end_dohovoru_tu "
                + " ,isnull(dbo.TC_V2.term_for_joining,0) as term_for_joining "
                + " from TC_V2 "
                + " left join Changestc ch on ch.id_tc=TC_V2.id"
                + " left join [TC_LIST_locality] objadr on objadr.id=TC_V2.name_locality"
                + " left join [TC_LIST_locality] cusadr on cusadr.id=TC_V2.customer_locality"
                + " left join [TUweb].[dbo].[TC_LIST_customer_soc_status] soc_status on soc_status.id=TC_V2.customer_soc_status "
                + " left join [TUweb].[dbo].[rem] rem on TC_V2.department_id=rem.rem_id "
                + " left join TC_V2 TC_O on TC_V2.main_contract=TC_O.id "
                + " left join SUPPLYCH on SUPPLYCH.tc_id=TC_V2.id"
                + " left join [TUweb].[dbo].[type_join] tj on TC_V2.type_join=tj.id"
                + " where ch.id=" + request.getParameter("id");
        pstmt = c.prepareStatement(qry);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();
        rs.next();

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>JSP Page</title>
        <jsp:include page="../../../word_page_format.jsp"/>
        <style type="text/css">

            body,td,th {
                font-size: 12pt;
            }
            li {
                margin-top: 0; /* Отступ сверху */
                margin-bottom: 0; /* Отступ снизу */    
            }

        </style>
    </head>
    <body>     
        <p align="center"><strong>Додаткова угода до договору № <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> року<br/> про нестандартне приєднання до електричних мереж</strong></p>
        <table width="100%"><tr>
                <td width="50%">м. Івано-Франківськ</td>
                <td align="right">___.___._____ р.</td></tr></table><br >

        <div align="justify" style="text-align:justify;"><strong>ПАТ «Прикарпаттяобленерго»</strong>, в особі технічного директора <strong>Сеника Олега Степановича</strong>, який діє на підставі довіреності № 816 від 11.08.2014 з однієї сторони, та <% if (rs.getString("customer_type").equals("0")) {%>громадянин(ка) <strong><%=rs.getString("PIP")%></strong>, (далі – <strong>Замовник</strong>), <strong><%=rs.getString("constitutive_documents")%></strong>, ідентифікаційний код <%=rs.getString("bank_identification_number")%>,<%} else {
            %> <%if (!rs.getString("customer_soc_status_1").equals("9")
                        && !rs.getString("customer_soc_status_1").equals("12")) {%> <%= rs.getString("customer_soc_status")%><%}%> 
            <%= rs.getString("name")%></strong>, (далі ―
        <strong>Замовник)</strong>, 
        <%if ((!rs.getString("customer_soc_status_1").equals("15")
                    && !rs.getString("customer_soc_status_1").equals("11")) && (rs.getString("customer_type").equals("1"))) {%> в особі  <strong><%= rs.getString("customer_post")%>&nbsp;<%= rs.getString("PIP")%></strong>,<%}
                        if (rs.getString("customer_type").equals("1")) {%> який (яка) діє на підставі<%}%> <strong><%= rs.getString("constitutive_documents")%></strong>,<%}%> з іншої сторони,  названі у подальшому «Сторони», відповідно до п. 3.1.3, 4.1 укладеного між сторонами <strong><%= rs.getString("date_contract")%></strong> року Договору про приєднання до електричних мереж, Методики розрахунку плати за приєднання, уклали дану додаткову угоду про наступне:<br>
    </div>

    <div align="justify" style="text-align:justify;">
        <ol start="1" type="1">
            <li>Сторони дійшли згоди що       плата за нестандартне приєднання, обрахована відповідно до Методики       розрахунку плати за приєднання, становить <strong><%=rs.getString("price_join")%></strong> грн. </li>
            <li>Строк надання послуги з нестандартного приєднання (будівництво та введення в експлуатацію електричних мереж зовнішнього електропостачання об’єкта Замовника від місця забезпечення потужності до точки приєднання) відповідно до погодженої проектно-кошторисної документації становить <%=rs.getString("term_for_joining")%> робочих днів з дня виконання замовником зобов’язань, визначених п.3.2 Договору № <%= rs.getString("number")%> про приєднання до електричних мереж від <%= rs.getString("date_contract")%> року</li>
            <li>Дана додаткова угода набирає чинності з моменту       підписання її сторонами та є невід’ємною частиною Договору № <strong><%= rs.getString("number")%></strong> про приєднання до       електричних мереж від <strong><%= rs.getString("date_contract")%></strong> року .</li>
            <li>Замовник сплачує плату за приєднання на поточний рахунок Виконавця послуг до <%=rs.getString("limit_date")%>. У випадку несплати Замовником плати за приєднання у вказаний термін, Виконавець послуг перераховує вартість послуги з приєднання відповідно до діючої на момент перерахунку вартості проектно-кошторисної документації. При цьому кошторисна вартість робіт підлягала уточненню та коригуванню у зв'язку із зміною цін на матеріали, тарифів на послуги, інших складових структуру кошторисної вартості.</li>
        </ol>
        <p>&nbsp;</p>
    </div> <% if (rs.getString("customer_type").equals("0")) {%>
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="328" valign="top"><p>Виконавець послуг:</p></td>
            <td width="329" valign="top"><p>Замовник:</p></td>
        </tr>
        <tr>
            <td width="328" valign="top"><p><strong>ПАТ «Прикарпаттяобленерго»</strong><br>                            
                    м. Івано-Франківськ, вул. Індустріальна, 34<br>
                    Код ЄДРПОУ 00131564<br>
                    п/р 26003011732479 в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                    Код МФО 300023<br>
                    <strong>Технічний директор <br>
                        ПАТ  «Прикарпаттяобленерго»</strong><br>
                </p></td><td width="329" valign="top"><p><strong><%=rs.getString("PIP")%></strong><br>
                    <%=rs.getString("type_c")%> <%=rs.getString("customer_adress")%><br>
                    р/р <%=rs.getString("bank_account")%> МФО <%=rs.getString("bank_mfo")%><br/>
                    Свідоцтво платника ПДВ № <%=rs.getString("taxpayer")%><br/>
                    Ідентифікаційний код <%=rs.getString("bank_identification_number")%><br>
                    тел: <%=rs.getString("customer_telephone")%></p>
                <strong>Громадянин (ка)</strong><br>

            </td>
        </tr>
        <tr>
            <td>_______________<strong>Сеник Олег Степанович </strong><br>
                         <br></td>
            <td>______________<strong><%=rs.getString("PIP")%></strong><br>
                           <br></td>
        </tr>
    </table>
    <%} else {%>
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="355" valign="top"><span>Виконавець послуг :</span></td>
            <td width="355" valign="top"><span>Замовник:</span></td>
        </tr>
        <tr>
            <td width="328" valign="top"><p><strong>ПАТ «Прикарпаттяобленерго»</strong><br>
                    м. Івано-Франківськ, вул. Індустріальна, 34<br>
                    Код ЄДРПОУ 00131564<br>
                    п/р 26003011732479 в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                    Код МФО 300023<br>
                    <strong>Технічний директор <br>
                        ПАТ  «Прикарпаттяобленерго</strong><strong>»</strong><br>
                </p></td>
                    <td width="355" valign="top"><%if (rs.getString("customer_type").equals("1")) {%><strong><%if (!rs.getString("customer_soc_status_1").equals("9")
                                && !rs.getString("customer_soc_status_1").equals("12")) {%> <%= rs.getString("customer_soc_status")%><br><%}%><%= rs.getString("name")%></strong>
                <br>
                <%=rs.getString("type_c")%> <%= rs.getString("customer_adress")%><br/>
                р/р <%= rs.getString("bank_account")%> МФО <%= rs.getString("bank_mfo")%><br>
                Свідоцтво платника ПДВ № <%= rs.getString("bank_identification_number")%><br>
                Індивідуальний податковий <%= rs.getString("taxpayer")%><br>
                <%} else {%>
                <br><strong><%=rs.getString("PIP")%></strong><br>
                <%=rs.getString("type_c")%> <%=rs.getString("customer_adress")%><br>
                <%--<strong><u><%=rs.getString("constitutive_documents").substring(0,rs.getString("constitutive_documents").indexOf("виданий"))%></u></strong><br>
                <strong><u><%=rs.getString("constitutive_documents").substring(rs.getString("constitutive_documents").indexOf("виданий"))%></u> </strong><br>--%>
                <%=rs.getString("constitutive_documents")%><br>
                Ідентифікаційний код <%=rs.getString("bank_identification_number")%><br>

                Громадянин (ка)<br><br>
                <%}%>
                тел: <%=rs.getString("customer_telephone")%>

                <br><strong><%=rs.getString("customer_post")%></strong><br>                    </td>
        </tr>
        <tr>
            <td>________________  <strong> Сеник Олег Степанович</strong> <br>
                                                    <br></td>
            <td>_______________<strong><%=rs.getString("PIP")%></strong><br>
                                                </td>
        </tr>
    </table> <%}%>
    <br clear=all style="page-break-before:always">
    <p><br>
        <%if (rs.getString("customer_soc_status_1").equals("1") || rs.getString("customer_soc_status_1").equals("6")) {%>
        <strong><%=rs.getString("customer_soc_status")%></strong><br>
        <strong>п. <%=rs.getString("PIP")%></strong>
        <%}%>
        <%if (rs.getString("customer_soc_status_1").equals("2") || rs.getString("customer_soc_status_1").equals("3") || rs.getString("customer_soc_status_1").equals("4") || rs.getString("customer_soc_status_1").equals("5") || rs.getString("customer_soc_status_1").equals("14") || rs.getString("customer_soc_status_1").equals("16")) {%>
        <strong><%=rs.getString("customer_post")%>&nbsp;<%=rs.getString("customer_soc_status")%>&nbsp; "<%=rs.getString("juridical")%>"</strong><br>
        <strong>п. <%=rs.getString("PIP")%></strong>
        <%}%>
        <%if (rs.getString("customer_soc_status_1").equals("11") || rs.getString("customer_soc_status_1").equals("15")) {%>
        <strong><%=rs.getString("customer_soc_status")%></strong><br>
        <strong>п. <%=rs.getString("PIP")%></strong>
        <%}%>
        <%if (rs.getString("customer_soc_status_1").equals("7") || rs.getString("customer_soc_status_1").equals("8") || rs.getString("customer_soc_status_1").equals("9") || rs.getString("customer_soc_status_1").equals("10") || rs.getString("customer_soc_status_1").equals("12") || rs.getString("customer_soc_status_1").equals("13")) {%>
        <strong><%=rs.getString("customer_post")%><br>
            <%=rs.getString("juridical")%></strong><br>
        <strong>п. <%=rs.getString("PIP")%></strong>
        <%}%>
        <br>
        <%=rs.getString("customer_adress1")%><br/><%=rs.getString("type_c")%><%=rs.getString("customer_adress2")%></p>
    <br>
    <b>Копія:</b><br>
    <b>Директору філії</b><br> 
    <b>ПАТ «Прикарпаттяобленерго»</b><br>
    <b><%=rs.getString("rem_name")%> РЕМ</b><br>
    <b><%=rs.getString("director_dav")%></b><br><br>
    <center><b>ТЕХНІЧНЕ РІШЕННЯ</b></center>
    <center><b>про погодження проектно-кошторисної документації</b></center>
    <br>
    <div align="justify" style="text-align:justify; text-indent: 40px;">ПАТ «Прикарпаттяобленерго» розглянуло Робочий проект електропостачання <%=rs.getString("object_name")%> в <%=rs.getString("type_o")%><%=rs.getString("object_adress")%> розроблений  _________ та погоджує його.</div>
    <br><br>
    <div align="justify" style="text-align:justify;">Додаток: Додаткова угода до договору № <%= rs.getString("number")%> від <%= rs.getString("date_contract")%> року про нестандартне приєднання до електричних мереж –  на 1 арк. в 1 прим.</div>
    <br><br><br><b>О. С. Сеник<b/><br><b>Технічний директор</b><br>
        

            </body>
            <%} catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    SQLUtils.closeQuietly(rs);
                    SQLUtils.closeQuietly(pstmt);
                    SQLUtils.closeQuietly(c);
                    ic.close();
                }
            %>
            </html>
