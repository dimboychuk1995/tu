<%-- 
    Document   : fiz
    Created on : 16 лют 2011, 16:18:59
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
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
        String qry = "SELECT "
                + "TC_V2.number as number"
                + ",TC_V2.customer_type"
                + ",isnull(soc_status.full_name,'') as customer_soc_status"
                + ",CASE WHEN TC_V2.customer_type=1"
                + "THEN isnull(TC_V2.juridical,'')"
                + "WHEN TC_V2.customer_type=0"
                + "THEN isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'')"
                + "ELSE '' end as [name]"
                + ",isnull(TC_V2.constitutive_documents,'') as constitutive_documents"
                + ",isnull(TC_V2.customer_post,'') as customer_post"
                + ",isnull(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'') as PIP"
                + ",isnull(TC_V2.[object_name],'') as [object_name]"
                + ",case when objadr.type=1 then 'м.'"
                + "     when objadr.type=2 then 'с.'"
                + "     when objadr.type=3 then 'смт.' end as type_o"
                + ",case when nullif(TC_V2.[object_adress],'') is not null then "
                + "         isnull(objadr.name,'')+', вул.'+ isnull(TC_V2.[object_adress],'') "
                + "     else isnull(objadr.name,'') end as object_adress"
                + ",isnull(convert(varchar,TC_V2.date_contract,104),'') as date_contract"
                + ",isnull(convert(varchar,TC_V2.date_customer_contract_tc,104),'___.___.20__') as date_customer_contract_tc"
                + ",case when cusadr.type=1 then 'м.'"
                + "     when cusadr.type=2 then 'с.'"
                + "     when cusadr.type=3 then 'смт.' end as type_c"
                + ",isnull(cusadr.name,'')+', вул. '+ isnull(TC_V2.[customer_adress],'') as customer_adress"
                + ",isnull(TC_V2.[bank_account],'') as [bank_account]"
                + ",isnull(TC_V2.[bank_mfo],'') as [bank_mfo]"
                + ",isnull(TC_V2.[bank_identification_number],'') as [bank_identification_number]"
                + ",isnull(TC_V2.[connection_treaty_number],'') as [connection_treaty_number] "
                + ",isnull(TC_V2.voltage_class,'') as voltage_class "
                + ",[rem_name] "
                + ",[Director] "
                + ",[director_rod]"
                + ",[dovirenist]"
                + ",[contacts] "
                + ",[rek_bank] "
                + ",[rem_licality]"
                + ",isnull(convert(varchar,TC_O.date_contract,104),'__.__.20__') as TC_Odate_contract "
                + ",isnull(TC_O.number,'') as TC_Onumber "
                + " ,case when SUPPLYCH.join_point=1 then 'C4.1 напруга кВ 0.4'"
                + "     when SUPPLYCH.join_point=11 then 'C4.1 напруга кВ 0.23'"
                + "     when SUPPLYCH.join_point=2 then 'C4.0 напруга кВ 0.4'"
                + "     when SUPPLYCH.join_point=21 then 'C4.0 напруга кВ 0.23'"
                + "     when SUPPLYCH.join_point=3 then 'C3.1 напруга кВ 10'"
                + "     when SUPPLYCH.join_point=4 then 'C3.0 напруга кВ 10'"
                + "     when SUPPLYCH.join_point=5 then 'C2.1 напруга кВ 35'"
                + "     when SUPPLYCH.join_point=6 then 'C2.0 напруга кВ 35'"
                + "     when SUPPLYCH.join_point=1 then 'C1.1 напруга кВ 110'"
                + "    else '_________________' end as joint_point "
                + "from TC_V2 "
                + " left join [TC_LIST_locality] objadr on objadr.id=TC_V2.name_locality"
                + " left join [TC_LIST_locality] cusadr on cusadr.id=TC_V2.customer_locality"
                + " left join [TUweb].[dbo].[TC_LIST_customer_soc_status] soc_status on soc_status.id=TC_V2.customer_soc_status "
                + " left join [TUweb].[dbo].[rem] rem on TC_V2.department_id=rem.rem_id "
                + " left join TC_V2 TC_O on TC_V2.main_contract=TC_O.id "
                + " left join SUPPLYCH on SUPPLYCH.tc_id=TC_V2.id "
                + " where TC_V2.id=" + request.getParameter("tu_id");
        pstmt = c.prepareStatement(qry);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();
        rs.next();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="../word_page_format.jsp"/>
        <style type="text/css">
            <!--
            body,td,th {
                font-size: 11pt;
            }
            -->
        </style>
    </head>
    <body>
        <div class="Section1">
            <p align="right" class="style2"><SPAN lang="UK">7.5.1-ПР-1-ТД-1.4   Г</SPAN></p>
            <p align="center"><span class="style1">Договір №  <%= rs.getString("number")%></span><br />
                <span class="style1">про надання доступу до  електричних мереж будівельних електромеханізмів</span></p>
            <table width="100%"><tr><td width="50%"><%=rs.getString("rem_licality").substring(0, rs.getString("rem_licality").indexOf(','))%></td><td align="right"><%= rs.getString("date_customer_contract_tc")%> року.</td></tr></table>

            <div style="text-align:justify; text-indent:20pt"><strong>Публічне  акціонерне товариство «Прикарпаттяобленерго»</strong>, <strong>“<u><%= rs.getString("rem_name")%></u> РЕМ”</strong>, надалі ― <strong>Електропередавальна  організація (далі – ЕО)</strong>, що здійснює ліцензовану діяльність з передачі  електроенергії, в особі в особі директора філії АТ«Прикарпаттяобленерго» “<%=rs.getString("rem_name")%> РЕМ” <strong><%= rs.getString("director_rod")%></strong>, який діє на  підставі Положення про філію та довіреності <%= rs.getString("dovirenist")%> р., з однієї сторони, та громадянин (ка) <strong><%=rs.getString("PIP")%></strong> (житель <%=rs.getString("type_c")%> <%=rs.getString("customer_adress")%>), надалі – Замовник, <u><%=rs.getString("constitutive_documents")%></u>, ідентифікаційний код <%=rs.getString("bank_identification_number")%> з іншої сторони, далі ― Сторони,  уклали цей Договір на доступ електроустановок Замовника до електричних мереж ЕО  (надалі ― Договір).</div>
            <div style="text-align:justify; text-indent:20pt">При виконанні умов цього  Договору, а також вирішенні всіх питань, що не обумовлені цим Договором,  сторони зобов'язуються керуватися Законом України “Про електроенергетику”,  Законом України &quot;Про архітектурну діяльність&quot;, Законом України “Про  основи містобудування” та іншими нормативно-правовими актами.</div>
            <div style="text-align:justify; text-indent:20pt">Підписавши  цей Договір, Сторони підтверджують, що відповідно до законодавства та  установчих документів, мають право укладати цей Договір, його укладання  відповідає справжнім намірам сторін, які ґрунтуються на правильному розумінні  предмету та всіх інших умов договору, наслідків його виконання та свідомо  бажають настання цих наслідків.</div>
            <p align="center"><strong>1 Предмет Договору</strong></p>
            <dl style="text-align:justify">
                <dt>1.1 ЕО  здійснює тимчасове надання послуги з доступу  електроустановок (<strong><u><%= rs.getString("object_name")%>,&nbsp; <%= rs.getString("type_o")%> <%=rs.getString("object_adress")%></u></strong>) Замовника до своїх електричних мереж після  виконання Замовником технічних умов, укладення Замовником договору про  користування електричною енергією та інших договорів передбачених Правилами  користування електричною енергією.</dt>
                <dt>1.2 З метою  тимчасового електрозабезпечення будівельних електромеханізмів та потреб  Замовника на об’єкті, між Замовником та ЕО укладається договір про електрозабезпечення  будівельних електромеханізмів (для населення) у  встановленому законодавством України порядку і діє до завершення терміну дії  договору про надання доступу <strong>№ <%= rs.getString("TC_Onumber")%> </strong>від<strong> <%= rs.getString("TC_Odate_contract")%></strong> року, Договір про  електрозабезпечення  будівельних електромеханізмів (для населення) укладається  після виконання Замовником умов даного Договору.</dt>
                <dt>1.3 Прогнозована  межа балансової належності електромереж встановлюється:  <strong><u><%= rs.getString("connection_treaty_number")%></u></strong></dt>
                <dt>1.4 Клас напруги в точці підключення буде становити 2 клас <%= rs.getString("joint_point").substring(16)%> кВ.</dt></dl>

            <p align="center"><strong>2 Обов'язки сторін</strong></p>
            <dl style="text-align:justify">
                <dt>2.1 ЕО зобов'язана підключити електроустановки Замовника до  своїх електромереж в термін до 5 днів після виконання Замовником вимог пункту  2.2 цього Договору в повному обсязі, прийняття електроустановки Замовника в  експлуатацію, оформлення акту допуску на підключення електроустановки  Замовника.</dt>
                <dt>2.2 Замовник зобов'язаний: </dt>
                <dt>2.2.1 Виконати вимоги технічних умов<strong> № <%= rs.getString("number")%> </strong>від <strong><%= rs.getString("date_customer_contract_tc")%></strong> року на підключення  будівельних електромеханізмів в повному обсязі до завершення терміну дії даного  Договору (додаток № 1).</dt>
                <dt>2.2.2  Розробити проектну документацію згідно з вимогами технічних умов та узгодити її  з ЕО та іншими зацікавленими організаціями. </dt>
                <dt>2.2.3 До підключення електроустановки Замовника до електричної  мережі ЕО оплатити вартість допуску та підключення, згідно виставленого рахунку  та укласти договір про постачання електричної енергії, а за необхідності ― інші  договори, передбачені Правилами користування електричною енергією.</dt></dl>
            <p align="center"><strong>3 Відповідальність сторін</strong></p>
            <dl style="text-align:justify">
                <dt>3.1 ЕО несе відповідальність за зміст та обґрунтованість  виданих технічних умов.</dt>
                <dt>3.2 Замовник несе відповідальність за достовірність наданих ЕО  документів, належне виконання вимог технічних умов, розроблення проектної  документації, своєчасне її узгодження з ЕО та іншими зацікавленими особами.</dt>
                <dt>3.3 Сторони не відповідають за невиконання умов цього  Договору, якщо це спричинено дією обставин непереборної сили. Факт дії обставин  непереборної сили підтверджується відповідними документами.</dt>
                <dt>3.4 У разі розірвання або неналежного виконання Замовником п.  2.2 цього Договору – витрати, понесені Замовником (за видачу технічних умов,  погодження проектної документації тощо) не відшкодовуються.</dt></dl>
            <p align="center"><strong>4 Порядок вирішення спорів</strong></p>
            <dl style="text-align:justify">
                <dt>4.1  Усі спірні питання,  пов'язані з виконанням цього Договору, вирішуються шляхом переговорів між  сторонами. </dt>
                <dt>4.2 У разі недосягнення згоди спір вирішується в судовому  порядку відповідно до законодавства України. Спори, що виникають при укладенні,  зміні та (або) розірванні Договору, справи у спорах про визнання договору  недійсним або пов’язаних з виконанням даного договору, розглядаються в судах за місцем знаходження ЕО.</dt></dl>

            <p align="center" class="style2"><strong>5 Строк дії Договору</strong></p>
            <dl style="text-align:justify">
                <dt>5.1 Цей Договір набирає чинності з моменту його підписання і  діє до закінчення терміну дії Договору про надання доступу до електричних мереж  № <strong><%= rs.getString("TC_Onumber")%></strong> від<strong> <%=rs.getString("TC_Odate_contract")%></strong> року.</dt>
                <dt>5.2 У разі дострокового виконання зобов’язань сторін згідно  умов Договору може мати місце дострокове  припинення Договору за згодою сторін або на підставах, передбачених чинним в  Україні законодавством.</dt>
                <dt>5.3 Договір може бути змінено або розірвано в односторонньому  порядку на вимогу ЕО у разі невиконання умов Договору про надання доступу до  електричних мереж № <strong><%= rs.getString("TC_Onumber")%></strong> від<strong> <%=rs.getString("TC_Odate_contract")%></strong> року, про що Замовника повідомляється окремим письмовим  повідомленням. Дане повідомлення вважається невід’ємною частиною даного  Договору. </dt>
                <dt>5.4 Термін дії Договору може бути продовжений за згодою сторін.</dt></dl>
            <p align="center" class="style2"><strong>6 Інші умови Договору</strong></p>
            <dl style="text-align:justify"> 
                <dt>6.1 Після одержання проекту Договору Замовник у 20-ти денний  термін повертає підписаний примірник Договору. У разі наявності заперечень до  умов Договору у цей же термін надсилає протокол розбіжностей чи повідомляє ЕО  про відмову від укладення Договору.</dt>
                <dt>6.2 У разі недотримання порядку зазначеному в п. 6.1 цього  Договору, Договір вважається неукладеним (таким, що не відбувся).</dt>
                <dt>6.3 Додатки до цього Договору є невід’ємними частинами цього  Договору. Усі зміни та доповнення Договору оформляються письмово, підписуються  уповноваженими особами та скріплюються печатками з обох сторін.</dt>
                <dt>6.4 Цей Договір укладений у двох примірниках, які мають  однакову юридичну силу для Замовника та ЕО.</dt>
                <dt>6.5 У разі, якщо на час дії даного Договору відбулися зміни в  чинному законодавстві України, ЕО в односторонньому порядку вносяться зміни,  які доводяться до Замовника окремим письмовим повідомленням. Дане повідомлення  вважається невід’ємною частиною Договору. </dt>
                <dt>6.6 Замовник має, немає  (необхідне підкреслити) статус платника податку на прибуток підприємств на  загальних умовах.</dt>
                <dt>6.7 ЕО має статус платника податку на прибуток підприємств на  загальних умовах.</dt></dl>
            <p align="center"><strong>7 Місцезнаходження сторін</strong></p>
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                <tr>
                    <td width="50%" valign="top"><p>Електропередавальна    організація:</p></td>
                    <td width="50%" valign="top"><p>Замовник:</p></td>
                </tr>
                <tr>
                    <td width="345" valign="top"><p>АТ«Прикарпаттяобленерго»<br>
                            Філія “<u><%= rs.getString("rem_name")%></u> РЕМ”<br>
                <u><%=rs.getString("rem_licality")%></u><br>
                <%=rs.getString("rek_bank").substring(0, rs.getString("rek_bank").indexOf(','))%><br>
                <%if (rs.getString("rek_bank").indexOf(",   Б") != -1) {%>
                <%=rs.getString("rek_bank").substring(rs.getString("rek_bank").indexOf(",   Б") + 1, rs.getString("rek_bank").indexOf(",   М"))%><%}%>
                <%if (rs.getString("rek_bank").indexOf(",   І") != -1) {%>
                <%=rs.getString("rek_bank").substring(rs.getString("rek_bank").indexOf(",   І") + 1, rs.getString("rek_bank").indexOf(",   М"))%><%}%><br>
                <%=rs.getString("rek_bank").substring(rs.getString("rek_bank").indexOf(",   М") + 1, rs.getString("rek_bank").indexOf(",  к"))%><br>
                <%=rs.getString("rek_bank").substring(rs.getString("rek_bank").indexOf(",  к") + 1, rs.getString("rek_bank").indexOf('.'))%><br>
                <%= rs.getString("contacts")%><br>
                Директор    філії АТ«Прикарпаттяобленерго»<br>
                “<%= rs.getString("rem_name")%> РЕМ”<br>
                _________________    <u><%=rs.getString("Director")%></u><br>
                        (підпис)                                             (П.І.Б.)</p></td>
                <td width="350" valign="top"><p><u><%=rs.getString("PIP")%></u></p>
                <p><u><%=rs.getString("type_c")%> <%=rs.getString("customer_adress")%></u><br>
                <%--<strong><u><%=rs.getString("constitutive_documents").substring(0,rs.getString("constitutive_documents").indexOf("виданий"))%></u></strong><br>
<strong><u><%=rs.getString("constitutive_documents").substring(rs.getString("constitutive_documents").indexOf("виданий"))%></u> </strong><br>--%>
                <%=rs.getString("constitutive_documents")%><br>
                Ідентифікаційний код <%=rs.getString("bank_identification_number")%><br>
                <br><br><br>
                Громадянин (ка)<br>
                _______________       <%=rs.getString("PIP")%><br>
                           (підпис)                           (П.І.Б.)</p></td>
                </tr>
            </table>
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
