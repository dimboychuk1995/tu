<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>

<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%
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
        String ss = ""
                + "SELECT number, "
                + "       Isnull(CONVERT (VARCHAR(10), date_contract, 104), '') AS date_contract, "
                + "       Isnull(CASE "
                + "                WHEN customer_type = 0 "
                + "                    THEN Isnull(f_name, '') + ' ' "
                + "                         + Isnull(Substring(s_name, 1, 1), '') + '. ' "
                + "                         + Isnull(Substring(t_name, 1, 1), '') + '.' "
                + "                ELSE Juridical "
                + "              END, '')                                                                                                                                                                                                                                                                                                                                                                                                                                                                      AS zamovnyk, "
                + "       CASE "
                + "         WHEN TC_V2.[customer_locality] IS NOT NULL "
                + "              AND TC_V2.[customer_locality] > 0 THEN (SELECT CASE "
                + "                                                               WHEN [type] = 1 THEN 'м.' "
                + "                                                               WHEN [type] = 2 THEN 'c.' "
                + "                                                               WHEN [type] = 3 THEN 'cмт.' "
                + "                                                             END AS [type] "
                + "                                                      FROM   TC_LIST_locality t "
                + "                                                      WHERE  t.id = cust.id) "
                + "                                                     + Isnull(cust.name, '') + ', вул.' "
                + "                                                     + Isnull(TC_V2.[customer_adress], '') "
                + "         WHEN TC_V2.[customer_locality] IS NULL "
                + "               OR TC_V2.[customer_locality] = 0 THEN Isnull(TC_V2.customer_adress, '') "
                + "         ELSE (SELECT CASE "
                + "                        WHEN [type] = 1 THEN 'м.' "
                + "                        WHEN [type] = 2 THEN 'c.' "
                + "                        WHEN [type] = 3 THEN 'cмт.' "
                + "                      END AS [type] "
                + "               FROM   TC_LIST_locality t "
                + "               WHERE  t.id = cust.id) "
                + "              + Isnull(cust.name, '') "
                + "       END  AS customer_adress, "
                + "      ISNULL('&nbsp;'+customer_telephone,'') as customer_telephone, "
                + "       CASE WHEN lc.type = 1 THEN 'м.' WHEN lc.type = 2 THEN 'с.' WHEN lc.type = 3 THEN 'смт.' ELSE '' END + CASE WHEN NULLIF(lc.id, 0) IS NULL AND NULLIF([object_adress], '') IS NOT NULL THEN Isnull([object_adress], '') WHEN NULLIF(lc.id, 0) IS NOT NULL AND NULLIF([object_adress], '') IS NOT NULL THEN Isnull(lc.name, '') + ', вул.' + Isnull([object_adress], '') WHEN NULLIF(lc.id, 0) IS NOT NULL AND NULLIF([object_adress], '') IS NULL THEN Isnull(lc.name, '') ELSE '' END AS object_adress, "
                + "       Isnull(Replace(CONVERT(VARCHAR(20), request_power), '.', ','), '') AS request_power, "
                + "       Replace(Isnull("
                + "       Cast(CASE  "
                + "	 WHEN YEAR(registration_date)=2013 then [rate] "
                + "	 WHEN YEAR(registration_date)=2014 and registration_date<'29.04.2014' THEN rate2014 "
                + "	 WHEN registration_date>='29.04.2014' and "
                + "           registration_date<'23.01.2015'  THEN rate2014_2 "
                + "	 WHEN registration_date>='23.01.2015' THEN rate2015 "
                + "	 ELSE 0 "
                + "	 END AS VARCHAR(20)), ''), '.', ',') AS rate, "
                + "       Replace(Isnull(Cast((cast(price_join as float)/1000.0) AS VARCHAR(20)), ''), '.', ',') AS price_join, "
                + "       CASE "
                + "         WHEN SUPPLYCH.join_point = 1 THEN '0,4' "
                + "         WHEN SUPPLYCH.join_point = 2 THEN '0,4' "
                + "         WHEN SUPPLYCH.join_point = 21 THEN '0,23' "
                + "         WHEN SUPPLYCH.join_point = 11 THEN '0,23' "
                + "         WHEN SUPPLYCH.join_point = 3 THEN '10' "
                + "         WHEN SUPPLYCH.join_point = 4 THEN '10' "
                + "         WHEN SUPPLYCH.join_point = 5 THEN '35' "
                + "         WHEN SUPPLYCH.join_point = 6 THEN '35' "
                + "         WHEN SUPPLYCH.join_point = 7 THEN '110' "
                + "         ELSE '' "
                + "       END AS joint_point, "
                + "       Isnull(dbo.TC_V2.point_zab_power, '') AS point_zab_power "
                + "       ,replace(isnull(cast(l_build_110 as varchar(20)),''),'.',',') as l_build_110"
                + "       ,replace(isnull(cast(l_build_35 as varchar(20)),''),'.',',') as l_build_35"
                + "       ,replace(isnull(cast(l_build_10 as varchar(20)),''),'.',',') as l_build_10"
                + "       ,replace(isnull(cast(l_build_04 as varchar(20)),''),'.',',') as l_build_04"
                + "       ,replace(isnull(cast(develop_price_akt as varchar(20)),''),'.',',') as develop_price_akt "
                + "       ,replace(isnull(cast(develop_price_proj as varchar(20)),''),'.',',') as develop_price_proj "
                + "       ,''  as price "
                + "       ,replace(isnull(convert (varchar(15), unmount_devices_price),''),'.',',') as unmount_devices_price"
                + "       ,replace(isnull(convert (varchar(15), ptw.ps_nav),''),'.',',') as zavant"
                + ",replace(isnull(cast(case \n"
                + "	  when ptw.ps_nom_nav_2 IS NULL THEN 0.92*ptw.ps_nom_nav  \n"
                + "	  WHEN ptw.ps_nom_nav>=ptw.ps_nom_nav_2 THEN 0.92*ptw.ps_nom_nav_2*1.4  \n"
                + "	  WHEN ptw.ps_nom_nav<ptw.ps_nom_nav_2 THEN 0.92*ptw.ps_nom_nav*1.4 \n"
                + "	  ELSE 0 END  \n"
                + "      * 1 /nullif(CASE  \n"
                + "		WHEN cnt BETWEEN 1 AND 10 THEN 0.9 \n"
                + "		WHEN cnt BETWEEN 11 AND 50 THEN 0.67 \n"
                + "		WHEN cnt BETWEEN 51 AND 100 THEN 0.53 \n"
                + "		WHEN cnt BETWEEN 101 AND 250 THEN 0.43 \n"
                + "		WHEN cnt BETWEEN 251 AND 500 THEN 0.36 \n"
                + "		WHEN cnt BETWEEN 501 AND 750 THEN 0.29 \n"
                + "		WHEN cnt BETWEEN 751 AND 1000 THEN 0.24 \n"
                + "		WHEN cnt BETWEEN 1001 AND 10000 THEN 0.2 \n"
                + "		WHEN cnt BETWEEN 10001 AND 100000 THEN 0.16 \n"
                + "		WHEN cnt BETWEEN 100001 AND 1000000 THEN 0.12 \n"
                + "		WHEN cnt >1000001 THEN 0.12 \n"
                + "		ELSE 0 \n"
                + "    END,0) - rt.SumPow \n"
                + "    - (SELECT Cast(Sum(A.[Power]) AS NUMERIC(10,2) ) FROM (SELECT  \n"
                + "                 Isnull(CASE WHEN (SELECT Count(id) FROM SUPPLYCH WHERE SUPPLYCH.tc_id=TC_V2.id GROUP BY supplych.tc_id)>1  \n"
                + "                				AND Upper(reliabylity_class_1) LIKE 'FALSE'  \n"
                + "               					AND Upper(reliabylity_class_2) LIKE 'FALSE'  \n"
                + "                				AND Upper(reliabylity_class_3) LIKE 'TRUE'  \n"
                + "                                               AND (sp.[power]<>0 and sp.[power] IS NOT NULL)  \n"
                + "                	THEN sp.[POWER]  \n"
                + "               		ELSE TC_V2.request_power END,'') AS [power]  \n"
                + "                       FROM TC_V2  \n"
                + "                           LEFT JOIN SUPPLYCH sp ON sp.tc_id=TC_V2.id  \n"
                + "                            LEFT JOIN [TUweb].[dbo].[status_document] ON ([TUweb].[dbo].[status_document].status_id=TC_V2.state_contract)  \n"
                + "                       WHERE TC_V2.type_contract=1  \n"
                + "                	AND NULLIF(date_admission_consumer,'') IS NULL  \n"
                + "                		AND Isnull(state_contract,0)<>8  \n"
                + "                	AND Isnull(state_contract,0)<>2  \n"
                + "                		AND Isnull(state_contract,0)<>5  \n"
                + "                        AND Isnull(state_contract,0)<>7  \n"
                + "                		AND sp.ps_10_disp_name=SUPPLYCH.ps_10_disp_name )A) +TC_V2.request_power AS NUMERIC(10,2)),0),'.',',') AS rezerv"
                + "       ,'' AS diff   "
                + " FROM   TC_V2 "
                + "       LEFT JOIN [" + db + "].[dbo].TC_LIST_locality cust "
                + "              ON [" + db + "].[dbo].TC_V2.customer_locality = cust.id "
                + "       LEFT JOIN TC_LIST_locality lc "
                + "              ON ( lc.id = TC_V2.name_locality ) "
                + "       LEFT JOIN [TUWeb].[dbo].rate_of_payment rtpay "
                + "              ON ( rtpay.id = TC_V2.rate_choice ) "
                + "       LEFT JOIN SUPPLYCH "
                + "              ON SUPPLYCH.tc_id = TC_V2.id "
                + "       LEFT JOIN TUWeb.dbo.ps_tu_web ptw ON SUPPLYCH.ps_10_disp_name=ptw.ps_id"
                + "       LEFT JOIN ResultTP rt ON ptw.ps_name=rt.tp_name"
                + " where registration_date>='" + request.getParameter("FromDate") + "' and  registration_date<='" + request.getParameter("TillDate") + "'"
                + "       AND date_filling_voltage IS NOT NULL";

        pstmt = c.prepareStatement(ss);
        rs = pstmt.executeQuery();
        String tmp = "";
        int inz = 1;

%>
<style type="text/css">
    <!--
    td.vertical{
        writing-mode:tb-rl;
        filter:flipH flipV;
    }
    -->
</style>
<table border="1" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">№п/п</td>
        <td colspan="2" rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Номер та дата договору про приєднання (технічних умов)</td>
        <td colspan="3" rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Замовник/Споживач електричної енергії (найменування, адреса,    контактний телефон)</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Адреса обєкту</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Приєднана потужність,    Pp, кВт</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Ставка плати (для    стандартного приєднання) або доля участі замовника в розвитку мереж для    нестандартного приєднання</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Надходження коштів за    договором про приєднання, тис.грн</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Рівень напруги в    точці приєднання, кВ</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Точка забезпечення    потужності назва лінії електропередач та номер опори (відстань до кабельної    врізки) та/або  назва (номер)    підстанції  згідно системи кодифікації    назв</td>
        <td colspan="4" rowspan="0" align="center" valign="middle"  bgcolor="#CCCCCC">Необхідність будівництва (реконструкції, переоснащення,    модернізації) підстанції напругою в кВ<br />
            (з переліком відповідних робіт: заміна трансформатора, вимикача,    розподільчого пристрою тощо)</td>
        <td colspan="4" rowspan="0" align="center" valign="middle"  bgcolor="#CCCCCC">Необхідність будівництва чи реконструкції ЛЕП у км напругою, кВ    (із зазначенням типу ЛЕП: ПЛ або КЛ)</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Фактичні капітальні витрати на приєднання Bфакт.кап, тис. грн</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Фактичні витрати на приєднання, що формують виробничу собівартість Bфакт.соб, тис. грн</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Вартість розвитку мереж згідно з проектною документацією, тис. грн</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Балансова вартість    демонтованого устаткування та обладнання, яке підлягає подальшому    використанню, тис. грн.</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Завантаженість заміри</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Абонована приєднана потужність за результатами надання послуги з приєднання, кВт</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Мінімальне значення резерву потужності за джерелом живлення, кВт</td>
    </tr>
    <tr>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">110/35/10(6)</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">110/10(6)</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">35/10(6)</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">10(6)/0,4</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">110</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">35</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">10(6)</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">0,4</td>
    </tr>

    <% while (rs.next()) {%>
    <tr>
        <td height="21" align="center" valign="middle"> <%out.print(inz++);%></td>
        <td align="center" valign="middle"><%= rs.getString(1)%></td>
        <td align="center" valign="middle"> <%= rs.getString(2)%></td>
        <td align="center" valign="middle"> <%= rs.getString(3)%></td>
        <td align="center" valign="middle"> <%= rs.getString(4)%></td>
        <td align="center" valign="middle"> <%= rs.getString(5)%></td>
        <td align="center" valign="middle"> <%= rs.getString(6)%></td>
        <td align="center" valign="middle"> <%= rs.getString(7)%></td>
        <td align="center" valign="middle"> <%= rs.getString(8)%></td>
        <td align="center" valign="middle"> <%= rs.getString(9)%></td>
        <td align="center" valign="middle"> <%= rs.getString(10)%></td>
        <td align="center" valign="middle"> <%= rs.getString(11)%></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="center" valign="middle"> <%= rs.getString(12)%></td>
        <td align="center" valign="middle"> <%= rs.getString(13)%></td>
        <td align="center" valign="middle"> <%= rs.getString(14)%></td>
        <td align="center" valign="middle"> <%= rs.getString(15)%></td>
        <td align="center" valign="middle"> <%= rs.getString(16)%></td>
        <td align="center" valign="middle"> <%= rs.getString(17)%></td>
        <td align="center" valign="middle"> <%= rs.getString(18)%></td>
        <td align="center" valign="middle"> <%= rs.getString(19)%></td>
        <td align="center" valign="middle"> <%= rs.getString(20)%></td>
        <td align="center" valign="middle"> <%= rs.getString(21)%></td>
        <td align="center" valign="middle"> <%= rs.getString(22)%></td>
    </tr>
    <%}
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(c);
            ic.close();
        }
    %>
</table>

