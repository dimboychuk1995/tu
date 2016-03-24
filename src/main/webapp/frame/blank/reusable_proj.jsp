<%--
    Document   : fiz
    Created on : 29 бер 2011, 11:15:06
    Author     : asupv
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.*,java.text.NumberFormat"%>
<%  response.setHeader("Content-Disposition", "inline;filename=reusable_project.doc");
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    NumberFormat nf = NumberFormat.getInstance();
    HttpSession ses = request.getSession();
    String db = new String();
    if (ses.getAttribute("db_name") != null) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try {
        c = ds.getConnection();
        String qry = "SELECT  isnull(rp.code,'') as code \n"
                + ",isnull(convert(varchar,tv.initial_registration_date_rem_tu,104),'') as initial_registration_date_rem_tu \n"
                + ",isnull(tv.registration_no_contract,'') AS registration_no_contract \n"
                + ",rem.rem_name \n"
                + ",rated_current_machine"
                + ",case tv.type_join "
                + "     when 1 then isnull(convert (varchar(15),tv.date_pay_join,104),'___.___.____')"
                + "     when 2 then isnull(convert (varchar(15),tv.date_pay_ns,104),'___.___.____')"
                + "     else '___.___.____' end as date_pay_join"
                + ",isnull(tv.number,'') as number"
                + ",ISNULL(cast(tv.term_for_joining AS VARCHAR(20)),'_______') AS term_for_joining"
                + ",isnull(tv.do1,'') as do1 "
                + ",isnull(tv.do2,'') as do2 "
                + ",isnull(tv.do3,'') as do3 "
                + ",isnull(tv.do4,'') as do4 "
                + ",isnull(tv.do5,'') as do5 "
                + ",isnull(tv.do6,'') as do6 "
                + ",isnull(tv.do7,'') as do7 "
                + ",isnull(tv.do8,'') as do8 "
                + ",tv.customer_telephone"
                + ",CASE WHEN tv.customer_type=1"
                + "THEN  isnull(tv.juridical,'')"
                + "WHEN tv.customer_type=0"
                + "THEN isnull(tv.[f_name],'')+' '+isnull(tv.[s_name],'')+' '+isnull(tv.[t_name],'')"
                + "ELSE '' end as [name]"
                + ",isnull(s.inv_num_tp,'') AS inv_num_tp"
                + ",isnull(s.inv_num_rec_10,'') AS inv_num_rec_10"
                + ",isnull(s.inv_num_04,'') AS inv_num_04 "
                + ",CAST(ISNULL(CAST(tv.request_power AS FLOAT),'') AS VARCHAR) as request_power"
                + ",isnull(tv.[reliabylity_class_1],'') as reliabylity_class_1"
                + ",isnull(tv.[reliabylity_class_2],'') as reliabylity_class_2"
                + ",isnull(tv.[reliabylity_class_3],'') as reliabylity_class_3"
                + ",isnull(tv.[reliabylity_class_1_val],0.00) as reliabylity_class_1_val"
                + ",isnull(tv.[reliabylity_class_2_val],0.00) as reliabylity_class_2_val"
                + ",isnull(tv.[reliabylity_class_3_val],0.00) as reliabylity_class_3_val"
                + ",isnull(cast(tv.[power_for_electric_devices] as varchar),'_________') as power_for_electric_devices"
                + ",isnull(tv.power_old,0.00) as power_old "
                + ",isnull(tv.nom_data_dog,'') as nom_data_dog "
                + ",isnull(cast(tv.power_plit as varchar),'_____') as power_plit "
                + ",isnull(cast(tv.power_boil as varchar),'_____') as power_boil "
                + ",isnull(cast(tv.power_old as varchar),'_____') as power_old "
                + ",isnull(tv.[power_for_environmental_reservation],0.00) as power_for_environmental_reservation"
                + ",isnull(tv.[power_for_emergency_reservation],0.00) as power_for_emergency_reservation"
                + ",isnull(cast(tv.[power_for_technology_reservation] as varchar),'____________') as power_for_technology_reservation"

                + ",isnull(tv.point_zab_power,'') as point_zab_power"
                + ",isnull(tv.[connection_treaty_number],'') as [connection_treaty_number] "
                + ",case when lc.type=1 then 'м.' \n"
                + "		when lc.type=2 then 'с.' \n"
                + "		when lc.type=3 then 'смт.' \n"
                + "		else '' end  \n"
                + "	    +case when nullif(lc.id,0) is null and nullif([object_adress],'') is not null then ISNULL([object_adress],'') \n"
                + "		when nullif(lc.id,0) is not null and nullif([object_adress],'') is not null then isnull(lc.name,'')+', вул.'+isnull([object_adress],'') \n"
                + "		when nullif(lc.id,0) is not null and nullif([object_adress],'') is null then isnull(lc.name,'') \n"
                + "		else '' end as object_adress \n"
                + "		,isnull(tv.[object_name],'') as [object_name] \n"
                + "        ,ISNULL(s.opor_nom_04,'') AS opor_nom_04 \n"
                + "        ,ISNULL(s.fid_04_disp_name,'') AS fid_04_disp_name \n"
                + "        ,isnull(cast(s.fid_04_leng as varchar(20)),'') AS fid_04_leng \n"
                + "        ,ISNULL(ptw.ps_name,'') AS ps_name \n"
                + ",isnull (s.type_source,'') as type_source"
                + ",ltrim (case when ps35.ps_name not like '' or ps35.ps_name is not null "
                + "            then isnull(ps35.ps_name,'') "
                + "     when ps110.ps_name not like '' or ps110.ps_name is not null "
                + "             then isnull(ps110.ps_name,'') "
                + "     else '________ ___' end) as ps35110_name "
                + ",case when ps10.ps_name not like '' and ps10.ps_name is not null then "
                + "isnull (ps10.ps_name,'_____') "
                + "    when s.ps_10_disp_name_tmp not like '' and s.ps_10_disp_name_tmp is not null "
                + "         then isnull (s.ps_10_disp_name_tmp,'_____') "
                + "else '_________________' end as ps10_name "
                + ",isnull (ps10.ps_nom_nav,'') as ps10_nom_nav "
                + ",isnull (ps10.ps_nom_nav_2,'') as ps10_nom_nav_2 "
                + ",case when ps10.ps_nom_nav_2=0 or ps10.ps_nom_nav_2 is null "
                + " then 1 else 2 end as kilkist10 "
                + ",isnull(s.power,'') as power "
                + "             from   [TC_V2] tv  \n"
                + "                   LEFT JOIN TUWeb.dbo.[Reusable_project] rp \n"
                + "                        ON  rp.id = tv.reusable_project \n"
                + "                   LEFT JOIN SUPPLYCH s ON s.tc_id = tv.id \n"
                + "                   LEFT JOIN TUWeb.dbo.ps_tu_web ptw ON s.ps_10_disp_name=ptw.ps_id \n"
                + "                   LEFT JOIN [TUweb].[dbo].[rem] rem  \n"
                + "                        ON  tv.department_id = rem.rem_id \n"
                + "                   left join TC_LIST_locality lc  \n"
                + "                        on (lc.id =tv.name_locality)"
                + " left join [TUweb].[dbo].[ps_tu_web] ps35 on s.ps_35_disp_name=ps35.ps_id "
                + "	left join [TUweb].[dbo].[ps_tu_web] ps110 on s.ps_110_disp_name=ps110.ps_id "
                + " left join [TUweb].[dbo].[ps_tu_web] ps10 on s.ps_10_disp_name=ps10.ps_id "
                + " where tv.id=" + request.getParameter("tu_id");
        pstmt = c.prepareStatement(qry);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCdls = rsmd.getColumnCount();
        rs.next();
        int i = 1;
        String tmp = "";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="word_page_format_12pt.jsp"/>
        <style type="">
            .parag{margin:0;}
            .style1{margin:0;}
        </style>
    </head>
    <body>
        <center><p><strong><em>Аркуш змін до типового проекту шифр  <strong><%= rs.getString("code")%></strong></p></em></strong></center>
    <center>Згідно ТУ №<%=rs.getString("number")%>(<%=rs.getString("name")%><%if(rs.getString("customer_telephone")!=null){%> - тел: <%=rs.getString("customer_telephone")%><%}%>)</center>
    <p>&nbsp;</p>
    <p>Дата поступлення коштів від замовника: <%= rs.getString("date_pay_join")%> року.</p>
    <p class="parag"><strong>1. Стор. 5,  п. 1.1 «Пояснювальної записки» викласти в  наступній редакції: </strong><br />
    <strong>Технічні умови № <%= rs.getString("number")%>  від <%= rs.getString("initial_registration_date_rem_tu")%> № <%= rs.getString("registration_no_contract")%> </strong><br />
    <strong>Видані: <%= rs.getString("rem_name")%> РЕМ</strong><br />
    <strong>Адреса об’єкта: <%= rs.getString("object_adress")%></strong><br/>
    <strong><%= rs.getString("object_name")%></strong><br/>
    <strong>Вкажіть тип будівлі або споруди: цегляна, дерев’яна, металева, інше. Наявність утеплення: Так / НІ. (підкресліть необхідне).</strong><br/>
    <strong>2. Величина максимального розрахункового навантаження <%= rs.getString("request_power").replace(".", ",")%> кВт, у тому числі для:</strong><br>
    <strong>існуюча потужність <%= rs.getString("power_old")%> кВт, договір №<%= rs.getString("nom_data_dog")%></strong>
        <%--<%if (rs.getString("reliabylity_class_1").toUpperCase().equals("TRUE")) {%>
        <strong>I категорія</strong><br>
        <%}%>
        <%if (rs.getString("reliabylity_class_2").toUpperCase().equals("TRUE")) {%>
        <strong>II категорія</strong><br>
        <%}%> --%>
    <%if (rs.getString("reliabylity_class_3").toUpperCase().equals("TRUE")) {%>

    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="347" valign="top">
                <span class="style1">III категорія </span></td>
            <td width="340" valign="top"><span class="style1"><%= rs.getString("request_power").replace(".", ",")%> кВт,</span></td>
        </tr>
        <%if ((!rs.getString("power_plit").equals("_____")) || (!rs.getString("power_boil").equals("_____")) || (!rs.getString("power_for_electric_devices").equals("_________"))) {%><tr>
        <td width="347" valign="top"><span class="style1">Встановлена потужність електронагрівальних установок:</span></td>
    </tr><%}%>
    </table>
    <%}%>
    <table border="0" cellspacing="0" cellpadding="0">
        <%if (!rs.getString("power_plit").equals("_____")) {%><tr>
        <td width="347" valign="top">
            <span class="style1">стаціонарної електричної плити </span></td>
        <td width="340" valign="top"><p class="style1"><%=nf.format(rs.getFloat("power_plit"))%> кВт,</p></td>
    </tr><%}%>
        <%if (!rs.getString("power_boil").equals("_____")) {%><tr>
        <td width="347" valign="top"><p class="style1">електричного підігріву води</p></td>
        <td width="340" valign="top"><p class="style1"><%=nf.format(rs.getFloat("power_boil"))%> кВт,</p></td>
    </tr><%}%>
        <%if (!rs.getString("power_for_electric_devices").equals("_________")) {%><tr>
        <td width="347" valign="top"><p class="style1">опалення приміщень</p></td>
        <td width="340" valign="top"><p class="style1"><%=nf.format(rs.getFloat("power_for_electric_devices"))%> кВт.</p></td>
    </tr><%}%>
    </table>
    <strong>Точка забезпечення потужності: <%= rs.getString("point_zab_power")%></strong><br>
    <strong>Точка приєднання: <%= rs.getString("connection_treaty_number")%></strong><br>
    <strong>2. Стор. 10, розділ  «Загальні вказівки» викласти в наступній редакції:</strong><br />
    <strong>Проект  електропостачання <%= rs.getString("object_name")%>, розроблений на основі вихідних даних:</strong><br />
    <strong>- технічних  умов № <%= rs.getString("number")%>  від <%= rs.getString("initial_registration_date_rem_tu")%> № <%= rs.getString("registration_no_contract")%></strong><br />
    <strong>Джерело живлення: <%//do {
        if ((!rs.getString("ps35110_name").equals(tmp)) || (i == 1)) {%>
        ПС "<%=rs.getString("ps35110_name")%> кВ"<%i++;
        }
            tmp = rs.getString("ps35110_name");
            //}//while (rs.next());
            //rs.first();%>,
        <%i = 1;
            //do{//if ((!rs.getString("ps35110_name").equals(tmp)) || (i==1)) {
        %>
            <%=rs.getString("type_source")%>-<%=rs.getString("ps10_name")%>&nbsp;
        <%if (rs.getFloat("ps10_nom_nav") != 0.00 || rs.getFloat("ps10_nom_nav_2") != 0.00) {
        %>(<%
            if (rs.getFloat("ps10_nom_nav") == rs.getFloat("ps10_nom_nav_2") && rs.getFloat("ps10_nom_nav_2") != 0.00) {
        %>2x<%=nf.format(rs.getFloat(("ps10_nom_nav")))%><%
            }%><%
            if (rs.getFloat("ps10_nom_nav") != rs.getFloat("ps10_nom_nav_2") && rs.getFloat("ps10_nom_nav_2") != 0.00) {
        %>1x<%=nf.format(rs.getFloat("ps10_nom_nav"))%>1x<%=nf.format(rs.getFloat(("ps10_nom_nav_2")))%><%
            }%><%
            if (rs.getFloat("ps10_nom_nav_2") == 0.00) {
        %>1x<%=nf.format(rs.getFloat("ps10_nom_nav"))%><%
            }%> кВА)
        <%}
            //}//while(rs.next());
            //rs.first();%>
        .</strong><br />
    <strong>3. Аркуш «Відгалуження від ПЛ. Ситуаційний план.» викласти в наступній редакції:</strong><br />
    <strong>Ситуаційний план мереж 0,4 кВ</strong></p>
    <table width="410" height="218" style="border-style:solid; border-width:1px; " align="center">
    <tr>
        <td colspan="3"><br/><br/><br/><br/><br/><br/><br/><br/><br/></td>
    </tr>
</table>
    <p><strong>4.Аркуш «Однолінійна схема живлення» викласти в наступній редакції:</strong><br />
    <strong>Опора № <%= rs.getString("opor_nom_04")%></strong><br />
    <strong><%= rs.getString("fid_04_disp_name")%> від  ТП-<%= rs.getString("ps_name")%> </strong><br />
    <strong>Ін = __ А</strong><br />
    <strong>Довжина, L= <%= rs.getString("fid_04_leng")%> км</strong><br />
    <strong>Стор.13.  «Специфікація обладнання, виробів і матеріалів» викласти в наступній редакції:</strong><br />
    <strong>1.2 Автоматичний  вимикач Ін= <%= rs.getString("rated_current_machine")%> А</strong><br />
    <strong>2.1 Самоутримний  ізольований провід з алюмінієвою жилою AsXSn  _x___мм2 довжиною <%= rs.getString("fid_04_leng")%> км.</strong><br />
    <strong>3.1 Труба гофрована діаметром 25 мм, довжиною <%= rs.getString("fid_04_leng")%> км.</strong></p>
    <strong>Додаткові матеріали:</strong>
    <dt><strong>Для приєднання замовника  необхідно виконати проектування та будівництво, реконструкцію об’єктів: </strong></dt>

    <%= rs.getString("do1").replace("7.1.1", "<br>-").replace("7.1.2", "<br>-").replace("7.1.3", "<br>-").replace("7.1.4", "<br>-").replace("7.1.5", "<br>-").replace("7.1.6", "<br>-").replace("7.1.7", "<br>-")%>
    <dl><dt> <%= rs.getString("do2").replace("7.2.1", "<br>-").replace("7.2.2", "<br>-").replace("7.2.3", "<br>-").replace("7.2.4", "<br>-").replace("7.2.5", "<br>-").replace("7.2.6", "<br>-").replace("7.2.7", "<br>-")%>
        <%= rs.getString("do3").replace("7.2.1", "<br>-").replace("7.2.2", "<br>-").replace("7.2.3", "<br>-").replace("7.2.4", "<br>-").replace("7.2.5", "<br>-").replace("7.2.6", "<br>-").replace("7.2.7", "<br>-")%></dt>
</dl>
    <dt><strong>Інвентарні номера об’єктів (ТП, ЛЕП) що підлягають реконструкції; ЛЕП до  якої здійснюється приєднання: </strong>
    <%if (!rs.getString("inv_num_04").equals("")) {%><%=rs.getString("inv_num_04")%>;&nbsp;<%}%><%if (!rs.getString("inv_num_rec_10").equals("")) {%><%=rs.getString("inv_num_rec_10")%>;&nbsp;<%}%><%if (!rs.getString("inv_num_tp").equals("")) {%><%=rs.getString("inv_num_tp")%>.&nbsp;<%}%></dt>
    <dt><strong>Орієнтовні терміни завершення робіт: </strong><%=rs.getString("term_for_joining")%> днів(день).</dt>
    <p align="center"><strong>Підготував  інженер ВТГ    </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                            _____________________________</p>
    <p align="center"><strong>Погоджено Головний інженер </strong>&nbsp;                                                                _____________________________</p>

    <br/>
    <br/>
    <br/>

    <table style="font-weight: bold;" border="1" >
        <tr align="center">
            <th>Найменування</th>
            <th>Од.вим</th>
            <th>Кількість</th>
        </tr>
        <tr align="left">
            <td>Опора СВ 10,5-5</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Опора СВ 10,5-3,6</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Опора СВ 9,5-2</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Опора дерев'яна</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Приставка ПТ до дерев'яної опори</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Кріплення підкоса н.в</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Кріплення підкоса в.в</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Відтяжка ВО-1</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Кроештейн КМ-005</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Якір</td>
            <td>м</td>
            <td></td>
        </tr>
        <tr>
            <td>Провід СІП</td>
            <td>м</td>
            <td></td>
        </tr>
        <tr>
            <td>Провід СІП</td>
            <td>м</td>
            <td></td>
        </tr>
        <tr>
            <td>Провід АВВГ</td>
            <td>м</td>
            <td></td>
        </tr>
        <tr>
            <td>Провід А</td>
            <td>кг</td>
            <td></td>
        </tr>
        <tr>
            <td>Провід ПВ-3х</td>
            <td>м</td>
            <td></td>
        </tr>
        <tr>
            <td>Ковпачки К-</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Ковпачок кінцевий</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Траверса</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Трубостійка</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Кронштейн фасадний</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Гак для дерев’яних опор</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Гак для дерев’яних опор</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Гак що накручується</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Гак для плоских поверхонь</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Гак для опор без отворів</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Стрічка бандажна</td>
            <td>м</td>
            <td></td>
        </tr>
        <tr>
            <td>Скрепа до стрічки</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Ізолятор</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Обмежувач перенапруг</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Комплект тимчасового переносного зазамлення</td>
            <td>комплект.</td>
            <td></td>
        </tr>
        <tr>
            <td>Затискач  відгалужувальний NTD</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Затискач  відгалужувальний TTD</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Затискач  підтримуючий</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Затискач натяжний</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Затискач натяжний</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Затискач плашковий  ПС 1-1</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Затискач плашковий  ПА 1-1</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Затискач плашковий  ПА 1-1</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Кріплення шафи обліку (КДЕ) на опорі</td>
            <td>комплект.</td>
            <td></td>
        </tr>
        <tr>
            <td>Корпус КДЕ</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Бокс </td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Авт.вимикач</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Авт.вимикач</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Рейка DIN оцинкована</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Штир заземлення н/в</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Катанка 6,5</td>
            <td>кг</td>
            <td></td>
        </tr>
        <tr>
            <td>Арматура 18 мм </td>
            <td>кг</td>
            <td></td>
        </tr>
        <tr>
            <td>Смуга 40х4</td>
            <td>кг</td>
            <td></td>
        </tr>
        <tr>
            <td>Короб</td>
            <td>м</td>
            <td></td>
        </tr>
        <tr>
            <td>Метал.рукав</td>
            <td>м</td>
            <td></td>
        </tr>
        <tr>
            <td>Труба гофр.</td>
            <td>м</td>
            <td></td>
        </tr>
        <tr>
            <td>Обойма для труб </td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Наконечник </td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Дюбель з шурупом 12*120</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Дюбель з шурупом 10/6,0*80</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Електроди</td>
            <td>шт.</td>
            <td></td>
        </tr>
        <tr>
            <td>Лист плоский</td>
            <td>кг/шт</td>
            <td></td>
        </tr>
    </table>

    <dt align="justify">&nbsp;</dt>
    <dt align="justify">&nbsp;</dt>
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
