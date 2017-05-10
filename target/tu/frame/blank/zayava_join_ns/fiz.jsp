<%--
    Document   : jur
    Created on : 31 бер 2011, 10:32:58
    Author     : asupv
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.*,java.text.NumberFormat"%>
<%
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    NumberFormat nf = NumberFormat.getInstance();
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
        String SQL = ""
                + "SELECT Isnull(soc_status.full_name, '')                                AS customer_soc_status, "
                + "       CASE "
                + "         WHEN TC_V2.customer_type = 1 THEN Isnull(TC_V2.juridical, '') "
                + "         WHEN TC_V2.customer_type = 0 THEN Isnull(TC_V2.[f_name], '') + ' ' "
                + "                                           + Isnull(TC_V2.[s_name], '') + ' ' "
                + "                                           + Isnull(TC_V2.[t_name], '') "
                + "         ELSE '' "
                + "       END                                                             AS [name], "
                + "       Isnull(TC_V2.constitutive_documents, '')                        AS constitutive_documents, "
                + "       Isnull(TC_V2.customer_post, '')                                 AS customer_post, "
                + "       Isnull(TC_V2.[f_name], '') + ' ' "
                + "       + Isnull(TC_V2.[s_name], '') + ' ' "
                + "       + Isnull(TC_V2.[t_name], '')                                    AS PIP, "
                + "       Isnull(TC_V2.[object_name], '')                                 AS [object_name], "
                + "       Isnull(res.NAME, '')                                            AS reason_tc, "
                + "       CASE "
                + "         WHEN objadr.type = 1 THEN 'м.' "
                + "         WHEN objadr.type = 2 THEN 'с.' "
                + "         WHEN objadr.type = 3 THEN 'смт.' "
                + "         ELSE '' "
                + "       END                                                             AS type_o, "
                + "       CASE "
                + "         WHEN NULLIF(TC_V2.[object_adress], '') IS NOT NULL THEN Isnull(objadr.name, '') + ', вул.' "
                + "                                                                 + Isnull(TC_V2.[object_adress], '') "
                + "         ELSE Isnull(objadr.name, '') "
                + "       END                                                             AS object_adress, "
                + "       CASE "
                + "         WHEN cusadr.type = 1 THEN 'м.' "
                + "         WHEN cusadr.type = 2 THEN 'с.' "
                + "         WHEN cusadr.type = 3 THEN 'смт.' "
                + "         ELSE '' "
                + "       END                                                             AS type_c, "
                + "       Isnull(cusadr.name, '') + ', вул. ' "
                + "       + Isnull(TC_V2.[customer_adress], '')                           AS customer_adress, "
                + "       Isnull(TC_V2.[bank_account], '')                                AS [bank_account], "
                + "       Isnull(TC_V2.[bank_mfo], '')                                    AS [bank_mfo], "
                + "       Isnull(TC_V2.[bank_identification_number], '')                  AS [bank_identification_number], "
                + "       Isnull(Cast(dbo.TC_V2.power_old AS FLOAT), '')                  AS power_old, "
                + "       Isnull(dbo.TC_V2.nom_data_dog, '')                              AS nom_data_dog, "
                + "       Isnull(Cast(tc_v2.reliabylity_class_1_val AS float), '')        AS reliabylity_class_1_val, "
                + "       Isnull(Cast(tc_v2.reliabylity_class_2_val AS float), '')        AS reliabylity_class_2_val, "
                + "       Isnull(Cast(TC_V2.reliabylity_class_3_val AS float), '')       AS reliabylity_class_3_val, "
                + "       [rem_name], "
                + "       [director_dav], "
                + "       Isnull(CONVERT(VARCHAR, TC_O.date_contract, 104), '')           AS TC_Odate_contract, "
                + "       Isnull(TC_O.number, '')                                         AS TC_Onumber, "
                + "       Cast(Isnull(Cast(TC_V2.request_power AS FLOAT), '') AS VARCHAR) AS request_power, "
                + "       Isnull(Year(TC_V2.date_intro_eksp), '-1')                         AS date_intro_eksp, "
                + "       Isnull(dbo.TC_V2.point_zab_power, '')                           AS point_zab_power "
                + " ,case when SUPPLYCH.join_point=1 then '0,4' "
                + "     when SUPPLYCH.join_point=11 then '0,23' "
                + "     when SUPPLYCH.join_point=2 then '0,4' "
                + "     when SUPPLYCH.join_point=21 then '0,23' "
                + "     when SUPPLYCH.join_point=3 then '10' "
                + "     when SUPPLYCH.join_point=4 then '10' "
                + "     when SUPPLYCH.join_point=5 then '35'"
                + "     when SUPPLYCH.join_point=6 then '35' "
                + "     when SUPPLYCH.join_point=7 then '110' "
                + "    else '' end as joint_point "
                + "     ,isnull(TC_V2.customer_telephone,'') as customer_telephone"
                + " FROM   TC_V2 "
                + "       LEFT JOIN [TC_LIST_locality] objadr "
                + "              ON objadr.id = TC_V2.name_locality "
                + "       LEFT JOIN [TC_LIST_locality] cusadr "
                + "              ON cusadr.id = TC_V2.customer_locality "
                + "       LEFT JOIN [TUweb].[dbo].[TC_LIST_customer_soc_status] soc_status "
                + "              ON soc_status.id = TC_V2.customer_soc_status "
                + "       LEFT JOIN [TUweb].[dbo].[rem] rem "
                + "              ON TC_V2.department_id = rem.rem_id "
                + "       LEFT JOIN TC_V2 TC_O "
                + "              ON TC_V2.main_contract = TC_O.id "
                + "       LEFT JOIN SUPPLYCH "
                + "              ON SUPPLYCH.tc_id = TC_V2.id "
                + "       LEFT JOIN TUWeb.dbo.TC_LIST_reason_tc res "
                + "              ON res.id = tc_v2.reason_tc "
                + " where TC_V2.id=" + request.getParameter("tu_id");
        pstmt = c.prepareStatement(SQL);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCdls = rsmd.getColumnCount();
        rs.next();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="../newtemplate.jsp"/>
        <style type="text/css">
            <!--
            body,td,th {
                font-size: 9pt;
            }
            .стиль3 {
                font-size: 9px;
                font-style: italic;
            }
            p{
                margin: 0;padding: 0;
            }
            -->
        </style>
    </head>
    <body>
        <p align="right"><strong>ОП 4.1-А</strong> </p>
        <p align="right">Технічному директору<br>АТ"Прикарпаттяобленерго"<br/>Сенику О.С.</p>
        <div align="center"><strong>ЗАЯВА</strong><br>
            <strong>про приєднання електроустановки певної потужності</strong><br></div>
        <div align="center"><u>Громадянин(ка) <%=rs.getString("PIP")%></u><br>
            <u><%=rs.getString("constitutive_documents")%></u><br>
            <u>Ідентифікаційний номер <%=rs.getString("bank_identification_number")%></u><br>
            <u><%=rs.getString("type_o")%><%=rs.getString("object_adress")%></u> <br>
            <span class="стиль3">(місце розташування об’єкта Замовника)</span><br>
            <u><%=rs.getString("reason_tc")%>, <%=rs.getString("object_name")%></u><br>
            <span class="стиль3">(мета приєднання та назва об'єкту)</span><br>
            <%if (!rs.getString("power_old").equals("0.0")) {%>
            <u><%=nf.format(rs.getFloat("power_old"))%> кВт, №<%=rs.getString("nom_data_dog")%></u> <br>
            <span class="стиль3">(існуюча дозволена (приєднана) потужність  відповідно до договору про постачання (користування) електричної енергії)</span><br>
            <%}%>
            <u><%=nf.format(rs.getFloat("request_power"))%> кВт, <%=rs.getString("joint_point")%> кВ,
                <%if (!rs.getString("reliabylity_class_1_val").equals("0.0")) {%> І- <%=nf.format(rs.getFloat("reliabylity_class_1_val"))%> кВт<%}%> 
                <%if (!rs.getString("reliabylity_class_2_val").equals("0.0")) {%> ІІ- <%=nf.format(rs.getFloat("reliabylity_class_2_val"))%> кВт<%}%> 
                <%if (!rs.getString("reliabylity_class_3_val").equals("0.0")) {%> ІІІ - <%=nf.format(rs.getFloat("reliabylity_class_3_val"))%> кВт<%}%></u><br>
            <span class="стиль3">(величина максимального  розрахункового  (категорія надійності електропостачання)
                (прогнозованого) навантаження з урахуванням існуючої дозволеної (приєднаної)  потужності)</span>          <br>
        </div>*Графік уведення потужностей за роками:      

        <div align="center">
            <table border="1" cellspacing="0" cellpadding="0" width="600">
                <tr>
                    <td width="94" rowspan="2" valign="top"><div align="center"><br>
                            Рік     введення потужності </div></td>
                    <td width="211" rowspan="2" valign="top"><p align="center">Величина максимального розрахункового    (прогнозованого) навантаження з урахуванням існуючої дозволеної (приєднаної)    потужності), кВт</p></td>
                    <td height="40" colspan="3" valign="top"><div align="center"><strong>Категорія надійності електропостачання</strong></div></td>
                </tr>
                <tr>
                    <td width="83" height="59" valign="top">
                        <p align="center">&nbsp;</p>
                        <p align="center">І</p></td>
                    <td width="110" valign="top">
                        <p align="center">&nbsp;</p>
                        <p align="center">ІІ</p></td>
                    <td width="90" valign="top">
                        <p align="center">&nbsp;</p>
                        <p align="center">ІІІ</p></td>
                </tr>
                <tr>
                    <td width="94" valign="top"><p>&nbsp;</p></td>
                    <td width="211" valign="top"><p>&nbsp;</p></td>
                    <td width="83" valign="top"><p>&nbsp;</p></td>
                    <td width="110" valign="top"><p>&nbsp;</p></td>
                    <td width="90" valign="top"><p>&nbsp;</p></td>
                </tr>
            </table></div> 

        <div align="center"><u><%=rs.getString("date_intro_eksp").replace("-1", "_____")%></u></div>
        <div align="center" class="стиль3">(прогнозований рік уведення об’єкта в експлуатацію)*<br>
            ________________________________________________________________<br>
            (режим роботи електроустановок)<br>
            __________________________________________________________________<br>
            (відомості щодо встановленої потужності електроопалювальних установок  та кухонних електроплит)<br>
            _______________________________________________________________<br>
            (додаткова інформація, яка  може бути надана Замовником за його згодоюю, у тому числі необхідність  приєднання будівельних механізмів)<br></div>
        <div align="justify" style="text-align:justify; text-indent:20pt">
            <p>Прошу здійснити комплекс заходів з приєднання та підключення електроустановок до електричних мереж.<u1:p></u1:p></p>

        <p>Оплату отриманих послуг гарантую.<u1:p></u1:p></p>

    <p>*** Надаю АТ"Прикарпаттяобленерго" добровільну згоду на обробку моїх персональних даних (прізвище, ім’я, по-батькові, ідентифікаційний код, серія та номер паспорта, ким та коли виданий паспорт, адреса проживання, електронна адреса, контактні номера телефонів для надання різного роду повідомлень Замовнику, документ, що підтверджує право власності на земельну ділянку/об'єкт Замовника) у базі персональних даних «Фізичні особи, персональні дані, яких обробляються в ході ведення господарської діяльності» для оформлення договору про приєднання, договору про користування електричної енергії та інших документів для виконання комплексу заходів з приєднання електроустановки до електричних мереж з метою забезпечення реалізації податкових відносин, відносин у сфері бухгалтерського обліку, адміністративно-правових та інших відносин, які вимагають обробки персональних даних (відповідно до Конституції України, Цивільного кодексу України, Податкового кодексу України, Статуту товариства, Законів України «Про бухгалтерський облік та фінансову звітність в Україні», Закону України «Про електроенергетику» та інших нормативно-правових документів у сфері приєднання до електричних мереж).<u1:p></u1:p></p>

<p>Повідомлений, що згідно зі статтею 14 Закону Набувач послуг має право на передання персональних даних без повідомлення мене про це у випадках: <u1:p></u1:p></p>

<p>- якщо передача персональних даних прямо передбачена законодавством України, і лише в інтересах національної безпеки, економічного добробуту та прав людини; <u1:p></u1:p></p>

<p>- отримання запиту від органів державної влади і місцевого самоврядування, що діють у межах повноважень, наданих законодавством України.<u1:p></u1:p></p>

<p>В інших випадках, доступ до моїх персональних даних надається третім особам лише за моєї письмової згоди по кожному запиту окремо.<u1:p></u1:p></p>

<p>Зобов’язуюсь повідомляти Виконавця послуг про будь-які зміни моїх персональних даних, зазначених у пункті 1 цієї згоди, протягом 5 календарних днів з наданням оригіналів відповідних документів.<u1:p></u1:p></p>

<p>До заяви Замовника додаються:<u1:p></u1:p></p>

<p>1. Ситуаційний план із зазначенням місця розташування електроустановки та викопіювання з топографо-геодезичного плану в масштабі 1:2000 із зазначенням місця розташування електроустановки, земельної ділянки або прогнозованої точки приєднання.<u1:p></u1:p></p>

<p>2. Копія документа, який підтверджує право власності чи користування цим об’єктом або, за відсутності об’єкта, право власності чи користування земельною ділянкою.<u1:p></u1:p></p>

<p>3. Копія довіреності оформленої належним чином або іншого документа на право укладати договори особі, яка уповноважена підписувати договори (за потреби).<u1:p></u1:p></p>

<p>Примітки.<u1:p></u1:p></p>

<p>1. Позначення «*» стосується винятково Замовників – юридичних осіб та фізичних осіб – підприємців.<u1:p></u1:p></p>

<p>2. Позначення «**» – заповнюється за наявності споживачів.<u1:p></u1:p></p>

<p>3. Позначення «***» стосується Замовників – фізичних осіб –населення та фізичних осіб-підприємців.<u1:p></u1:p></p>

<p>4. Очікуваний обсяг споживання електроенергії на розрахунковий період визначається Замовником і не повинен перевищувати дозволений до використання обсяг споживання електроенергії, що визначений як добуток дозволеної до використання електричної потужності та годин роботи об'єкта. Очікуваний обсяг споживання електричної енергії вказується без урахування очікуваних величин споживання електроенергії субспоживачем, якщо такий є.<u1:p></u1:p></p>
<p class="MsoNormal" style="margin-right:-7.15pt;text-align:justify;tab-stops:
   14.2pt list 53.45pt left 2.0cm 574.1pt"><span lang="RU">&nbsp;&nbsp;&nbsp;&nbsp; </span><span lang="RU" style="font-size:9.0pt">Очікуваний обсяг
        споживання електричної енергії (<b>крім
            населення</b>):<o:p></o:p></span></p>       
</div>
<div align="center">

    <u1:p></u1:p><table class="MsoNormalTable" border="1" cellspacing="0" cellpadding="0" width="609" style="border-collapse:collapse;mso-table-layout-alt:fixed;border:none;
                        mso-border-alt:solid windowtext .5pt;mso-yfti-tbllook:1184;mso-padding-alt:
                        0cm 1.4pt 0cm 1.4pt;mso-border-insideh:.5pt solid windowtext;mso-border-insidev:
                        .5pt solid windowtext">
        <tbody><tr style="mso-yfti-irow:0;mso-yfti-firstrow:yes;page-break-inside:avoid;
                   height:16.6pt">
                <td width="609" colspan="13" style="width:456.75pt;border:solid windowtext 1.0pt;
                    mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:16.6pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">Обсяги постачання електроенергії
                            на розрахункові періоди 20___р., тис. кВт∙год<u1:p></u1:p></span></p>
                </td>
            </tr>
            <tr style="mso-yfti-irow:1;page-break-inside:avoid;height:86.35pt">
                <td width="47" style="width:35.2pt;border:solid windowtext 1.0pt;border-top:
                    none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
                    padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">січень<u1:p></u1:p></span></p>
                </td>
                <td width="46" style="width:34.55pt;border-top:none;border-left:none;
                    border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
                    mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
                    mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:
                    90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">лютий<u1:p></u1:p></span></p>
                </td>
                <td width="48" style="width:36.0pt;border-top:none;border-left:none;border-bottom:
                    solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
                    solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
                    solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">березень<u1:p></u1:p></span></p>
                </td>
                <td width="44" style="width:33.2pt;border-top:none;border-left:none;border-bottom:
                    solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
                    solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
                    solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">квітень<u1:p></u1:p></span></p>
                </td>
                <td width="45" style="width:33.5pt;border-top:none;border-left:none;border-bottom:
                    solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
                    solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
                    solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">травень<u1:p></u1:p></span></p>
                </td>
                <td width="45" style="width:33.7pt;border-top:none;border-left:none;border-bottom:
                    solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
                    solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
                    solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">червень<u1:p></u1:p></span></p>
                </td>
                <td width="45" style="width:33.75pt;border-top:none;border-left:none;
                    border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
                    mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
                    mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:
                    90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">липень<u1:p></u1:p></span></p>
                </td>
                <td width="45" style="width:33.8pt;border-top:none;border-left:none;border-bottom:
                    solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
                    solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
                    solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">серпень<u1:p></u1:p></span></p>
                </td>
                <td width="45" style="width:33.85pt;border-top:none;border-left:none;
                    border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
                    mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
                    mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:
                    90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">вересень<u1:p></u1:p></span></p>
                </td>
                <td width="45" style="width:33.85pt;border-top:none;border-left:none;
                    border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
                    mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
                    mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:
                    90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">жовтень<u1:p></u1:p></span></p>
                </td>
                <td width="45" style="width:33.85pt;border-top:none;border-left:none;
                    border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
                    mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
                    mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:
                    90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">листопад<u1:p></u1:p></span></p>
                </td>
                <td width="45" style="width:33.85pt;border-top:none;border-left:none;
                    border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
                    mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
                    mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:
                    90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">грудень<u1:p></u1:p></span></p>
                </td>
                <td width="64" style="width:47.65pt;border-top:none;border-left:none;
                    border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
                    mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
                    mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;mso-rotate:
                    90;height:86.35pt">
                    <p class="MsoNormal" align="center" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:
                       auto;text-align:center;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU">Всього, рік</span></p>
                </td>
            </tr>

            <tr style="mso-yfti-irow:2;mso-yfti-lastrow:yes;page-break-inside:avoid;
                height:13.45pt">
                <td width="47" valign="top" style="width:35.2pt;border:solid windowtext 1.0pt;
                    border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
                    padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
                    <p class="MsoNormal" align="right" style="margin-top:0cm;margin-right:7.0pt;
                       margin-bottom:0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:right;
                       text-indent:-7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span><o:p></o:p></p>
        </td>
        <td width="46" valign="top" style="width:34.55pt;border-top:none;border-left:
            none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
            mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
            mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
            <p class="MsoNormal" align="right" style="margin-top:0cm;margin-right:7.0pt;
               margin-bottom:0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:right;
               text-indent:-7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span><o:p></o:p></p>
        </td>
        <td width="48" valign="top" style="width:36.0pt;border-top:none;border-left:none;
            border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
            mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
            mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
            <p class="MsoNormal" align="right" style="margin-top:0cm;margin-right:7.0pt;
               margin-bottom:0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:right;
               text-indent:-7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span><o:p></o:p></p>
        </td>
        <td width="44" valign="top" style="width:33.2pt;border-top:none;border-left:none;
            border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
            mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
            mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
            <p class="MsoNormal" align="right" style="margin-top:0cm;margin-right:7.0pt;
               margin-bottom:0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:right;
               text-indent:-7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span><o:p></o:p></p>
        </td>
        <td width="45" valign="top" style="width:33.5pt;border-top:none;border-left:none;
            border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
            mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
            mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
            <p class="MsoNormal" align="right" style="margin-top:0cm;margin-right:7.0pt;
               margin-bottom:0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:right;
               text-indent:-7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span><o:p></o:p></p>
        </td>
        <td width="45" valign="top" style="width:33.7pt;border-top:none;border-left:none;
            border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
            mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
            mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
            <p class="MsoNormal" align="right" style="margin-top:0cm;margin-right:7.0pt;
               margin-bottom:0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:right;
               text-indent:-7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span><o:p></o:p></p>
        </td>
        <td width="45" valign="top" style="width:33.75pt;border-top:none;border-left:
            none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
            mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
            mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
            <p class="MsoNormal" align="right" style="margin-top:0cm;margin-right:7.0pt;
               margin-bottom:0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:right;
               text-indent:-7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span><o:p></o:p></p>
        </td>
        <td width="45" valign="top" style="width:33.8pt;border-top:none;border-left:none;
            border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
            mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
            mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
            <p class="MsoNormal" align="right" style="margin-top:0cm;margin-right:7.0pt;
               margin-bottom:0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:right;
               text-indent:-7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span><o:p></o:p></p>
        </td>
        <td width="45" valign="top" style="width:33.85pt;border-top:none;border-left:
            none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
            mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
            mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
            <p class="MsoNormal" align="right" style="margin-top:0cm;margin-right:7.0pt;
               margin-bottom:0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:right;
               text-indent:-7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span><o:p></o:p></p>
        </td>
        <td width="45" valign="top" style="width:33.85pt;border-top:none;border-left:
            none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
            mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
            mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
            <p class="MsoNormal" align="right" style="margin-top:0cm;margin-right:7.0pt;
               margin-bottom:0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:right;
               text-indent:-7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span><o:p></o:p></p>
        </td>
        <td width="45" valign="top" style="width:33.85pt;border-top:none;border-left:
            none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
            mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
            mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
            <p class="MsoNormal" align="right" style="margin-top:0cm;margin-right:7.0pt;
               margin-bottom:0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:right;
               text-indent:-7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span><o:p></o:p></p>
        </td>
        <td width="45" valign="top" style="width:33.85pt;border-top:none;border-left:
            none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
            mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
            mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
            <p class="MsoNormal" align="right" style="margin-top:0cm;margin-right:7.0pt;
               margin-bottom:0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:right;
               text-indent:-7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span><o:p></o:p></p>
        </td>
        <td width="64" valign="top" style="width:47.65pt;border-top:none;border-left:
            none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
            mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
            mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:13.45pt">
            <p class="MsoNormal" style="margin-top:0cm;margin-right:7.0pt;margin-bottom:
               0cm;margin-left:21.3pt;margin-bottom:.0001pt;text-align:justify;text-indent:
               -7.1pt;tab-stops:14.2pt 2.0cm 574.1pt"><span lang="RU" style="font-size:9.0pt;
                    mso-ansi-language:RU"><u1:p>&nbsp;</u1:p></span></p>
        </td>
        </tr>
        </tbody></table>

</div>
<br>
* М. П.<br>
____________                                             ___________________  „___” ____________ 20___ року<br>
(підпис)                                                      (П.  І. Б.)
<br>
<br>
<div align="justify" style="text-align:justify;font-size: 12pt;">№ телефону <%=rs.getString("customer_telephone")%>.</div>
<br/>
<div align="justify" style="text-align:justify;font-size: 12pt;">
Лічильник:__________ тарифи,     Опора № _______, Л-_____, ТП-______. 
Відстань від опори до будівлі _______м.
</div>
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
