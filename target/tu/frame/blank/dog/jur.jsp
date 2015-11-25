<%-- 
    Document   : jur
    Created on : 16 лют 2011, 16:19:37
    Author     : AsuSV
--%>
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
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
                + "TC_V2.customer_soc_status as customer_soc_status_1 "
                + ",TC_V2.number as number"
                + ",TC_V2.customer_type"
                + ",isnull(soc_status.full_name,'') as customer_soc_status "
                + ",CASE WHEN TC_V2.customer_type=1 and TC_V2.customer_soc_status<>15 and TC_V2.customer_soc_status<>11 and TC_V2.customer_soc_status<>9 and  TC_V2.customer_soc_status<>12 and  TC_V2.customer_soc_status<>8"
                + "THEN  '\"" + "'+isnull(TC_V2.juridical,'')" + "+'\"' "
                + "WHEN TC_V2.customer_type=1 and (TC_V2.customer_soc_status=15 or TC_V2.customer_soc_status=11 or TC_V2.customer_soc_status=12 or TC_V2.customer_soc_status=9 or TC_V2.customer_soc_status=8)"
                + "THEN  isnull(TC_V2.juridical,'')"
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
                + ",isnull(convert(varchar,TC_V2.date_contract,104),'___.___.____') as date_contract"
                + ",isnull(convert(varchar,TC_V2.date_customer_contract_tc,104),'___.___.____') as date_customer_contract_tc"
                + ",case when cusadr.type=1 then 'м.'"
                + "     when cusadr.type=2 then 'с.'"
                + "     when cusadr.type=3 then 'смт.' end as type_c"
                + ",isnull(cusadr.name,'')+', вул. '+ isnull(TC_V2.[customer_adress],'') as customer_adress"
                + ",isnull(nullif(TC_V2.[bank_account],''),'_______________') as [bank_account]"
                + ",isnull(nullif(TC_V2.[bank_mfo],''),'_______________') as [bank_mfo]"
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
                + ",isnull(convert(varchar,TC_O.date_contract,104),'__.__.____') as TC_Odate_contract "
                + ",isnull(TC_O.number,'') as TC_Onumber "
                + " ,case when SUPPLYCH.join_point=1 then '2 напруга 0.4 кВ' "
                + "     when SUPPLYCH.join_point=11 then '2 напруга 0.23 кВ' "
                + "     when SUPPLYCH.join_point=2 then '2 напруга 0.4 кВ' "
                + "     when SUPPLYCH.join_point=21 then '2 напруга 0.23 кВ' "
                + "     when SUPPLYCH.join_point=3 then '2 напруга 10 кВ' "
                + "     when SUPPLYCH.join_point=4 then '2 напруга 10 кВ' "
                + "     when SUPPLYCH.join_point=5 then '1 напруга 35 кВ' "
                + "     when SUPPLYCH.join_point=6 then '1 напруга 35 кВ' "
                + "     when SUPPLYCH.join_point=7 then '1 напруга 110 кВ' "
                + "    else '' end as joint_point "
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
        int numCdls = rsmd.getColumnCount();
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
            <div align="justify">
                <p align="right"><SPAN lang="UK">7.5.1-ПР-1-ТД-1.4   Г</SPAN></p>
                <p align="center"><strong>Договір №  <%= rs.getString("number")%></strong><br />
                    <strong>про надання доступу до електричних мереж</strong></p>
                <table width="100%"><tr><td width="50%">м. Івано-Франківськ </td>
                        <td align="right"><strong><%=rs.getString("date_contract")%></strong> р.</td></tr></table>

                <div style="text-align:justify; text-indent:20pt"><strong>Публічне акціонерне товариство «Прикарпаттяобленерго»</strong>,&nbsp;надалі ―
                    <strong>Електропередавальна організація (далі – ЕО)</strong>,&nbsp;що здійснює ліцензовану діяльність з передачі електроенергії, в особі технічного директора  ПАТ «Прикарпаттяобленерго»&nbsp;
                    <strong>Сеника Олега Степановича</strong>,&nbsp;який діє на підставі довіреності №
                    <strong>816</strong>&nbsp;від&nbsp;<strong>11.08.2014</strong>
                    &nbsp;року, з однієї сторони, та&nbsp;<strong><%if (!rs.getString("customer_soc_status_1").equals("9")
                                && !rs.getString("customer_soc_status_1").equals("12")) {%> <%= rs.getString("customer_soc_status")%><%}%> 
                        <%= rs.getString("name")%></strong>, надалі ―
                    <strong>Замовник</strong>, <%if ((!rs.getString("customer_soc_status_1").equals("15")
                                && !rs.getString("customer_soc_status_1").equals("11")) && (rs.getString("customer_type").equals("1"))) {%> в особі  <strong><%= rs.getString("customer_post")%>&nbsp;<%= rs.getString("PIP")%></strong>,<%}
                                    if (rs.getString("customer_type").equals("1")) {%> який (яка) діє на підставі<%}%> <strong><u><%= rs.getString("constitutive_documents")%></u></strong>
                    , з іншої сторони, далі ― Сторони, уклали цей Договір про надання доступу електроустановок Замовника до електричних мереж ЕО (надалі ― Договір).</div>
                <div style="text-align: justify; text-indent:20pt">При виконанні умов  цього Договору, а також вирішенні всіх питань, що не обумовлені цим Договором,  сторони зобов'язуються керуватися Законом України “Про електроенергетику”,  Законом України &quot;Про архітектурну діяльність&quot;, Законом України “Про  регулювання містобудівної діяльності” та іншими нормативно-правовими актами. </div>
                <div style="text-align: justify; text-indent:20pt">Підписавши цей Договір, Сторони підтверджують, що  відповідно до законодавства та установчих документів, мають право укладати цей  Договір, його укладання відповідає справжнім намірам сторін, які ґрунтуються на  правильному розумінні предмету та всіх інших умов договору, наслідків його  виконання та свідомо бажають настання цих наслідків.</div>
                <p align="center"><strong>1 Предмет Договору</strong></p>
                <dl style="text-align:justify">
                    <dt>1.1 ЕО здійснює надання послуги з доступу електроустановок (<strong><u><%= rs.getString("object_name")%>,&nbsp; <%=rs.getString("type_o")%> <%= rs.getString("object_adress")%></u></strong>) Замовника до своїх електричних мереж після виконання Замовником технічних умов, укладення Замовником договору про постачання електричної енергії та інших договорів передбачених Правилами користування електричною енергією.</dt>
                    <dt>1.2 Прогнозована межа балансової належності електромереж встановлюється: <strong><u><%= rs.getString("connection_treaty_number")%></u></strong></dt>
                    <dt>1.3 Клас напруги в точці підключення буде становити клас <%=rs.getString("joint_point")%>.</dt>
                </dl>
                <p align="center"><strong>2 Обов'язки сторін</strong></p>
                <dl style="text-align:justify">
                    <dt>2.1 ЕО зобов'язаний підключити електроустановки Замовника до своїх електромереж в термін до 5 днів після виконання Замовником вимог пункту 2.2 цього Договору в повному обсязі, прийняття електроустановки Замовника в експлуатацію, оформлення акту допуску на підключення електроустановки Замовника.</dt>
                    <dt>2.2 Замовник зобов'язаний: </dt>
                    <dt>2.2.1	Виконати вимоги технічних умов № <strong><%= rs.getString("number")%></strong> від <strong><%= rs.getString("date_customer_contract_tc")%></strong> року в повному обсязі до завершення терміну дії даного Договору (Додаток № 1).</dt>
                    <dt>2.2.2	До підключення електроустановки Замовника до електричної мережі ЕО оплатити вартість допуску та підключення згідно виставленого рахунку та укласти договори, передбачені Правилами користування електричною енергією.</dt>
                    <dt>2.2.3	У випадку прокладання ЛЕП-0,4 кВ Замовника по опорах ЕО укласти з останнім відповідний договір про спільне підвішування проводів. </dt>
                </dl>
                <p align="center"><strong>3 Відповідальність сторін</strong></p>
                <dl style="text-align:justify">
                    <dt>3.1 ЕО несе відповідальність за зміст та обґрунтованість виданих технічних умов. </dt>
                    <dt>3.2 Замовник несе відповідальність за достовірність наданих ЕО документів, належне виконання вимог технічних умов, розроблення проектної документації, своєчасне її узгодження з ЕО та іншими зацікавленими особами.</dt>
                    <dt>3.3 Сторони не відповідають за невиконання умов цього Договору, якщо це спричинено дією обставин непереборної сили. Факт дії обставин непереборної сили підтверджується відповідними документами. </dt>
                </dl>
                <p align="center"><strong>4 Порядок вирішення спорів</strong></p>
                <dl style="text-align:justify">
                    <dt>4.1  Усі спірні питання, пов'язані з виконанням цього Договору, вирішуються шляхом переговорів між сторонами.</dt>
                    <dt>4.2 У разі недосягнення згоди спір вирішується в судовому порядку відповідно до законодавства України. Спори, що виникають при укладенні, зміні та (або) розірванні Договору, справи у спорах про визнання договору недійсним або пов’язаних з виконанням даного договору, розглядаються в судах за місцем знаходження ЕО. </dt>
                </dl>
                <p align="center"><strong>5 Строк дії Договору</strong></p>
                <dl style="text-align:justify">
                    <dt>5.1 Цей Договір набирає чинності з моменту його підписання і діє протягом двох років з дати підписання.</dt>
                    <dt>5.2 Сторони мають право достроково виконати покладені на них зобов’язання по Договору. У разі дострокового виконання зобов’язань сторін згідно умов Договору може мати місце дострокове припинення Договору за згодою сторін або на підставах, передбачених чинним в Україні законодавством.</dt>
                    <dt>5.3 Договір може бути змінено або розірвано в односторонньому порядку на вимогу ЕО у разі порушення Замовником вимог п. 2.2 даного Договору, про що Замовника повідомляється окремим письмовим повідомленням. Дане повідомлення вважається невід’ємною частиною Договору. Замовник має право на протязі 20 днів з дня отримання повідомлення виконати зобов’язання по договору та повідомити про це ЕО.</dt>
                    <dt>5.4 У разі розірвання Договору згідно п. 5.3, а також в інших випадках дострокового розірвання договору, оплачені Замовником кошти за видачу технічних умов та погодження проектної документації, ЕО не повертаються.</dt>
                    <dt>5.5 Термін дії Договору може бути продовжений за згодою сторін.</dt>
                </dl>
                <p align="center"><strong>6 Інші умови Договору</strong></p>
                <dl style="text-align:justify">
                    <dt>6.1 Після одержання проекту Договору Замовник у 20-ти денний термін повертає підписаний примірник Договору. У разі наявності заперечень до умов Договору у цей же термін надсилає протокол розбіжностей чи повідомляє ЕО про відмову від укладення Договору. </dt>
                    <dt>6.2 У разі недотримання  порядку зазначеному в п. 6.1 цього Договору, Договір вважається неукладеним  (таким, що не відбувся).</dt>
                    <dt>6.3 Додатки до цього Договору є невід’ємними частинами цього Договору. Усі зміни та доповнення Договору оформляються письмово, підписуються уповноваженими особами та скріплюються печатками з обох сторін.</dt>
                    <dt>6.4 Цей Договір укладений у двох примірниках, які мають однакову юридичну силу для Замовника та ЕО.</dt>
                    <dt>6.5 У разі, якщо на час дії даного Договору відбулися зміни в чинному законодавстві України, ЕО в односторонньому порядку вносяться зміни, які доводяться до Замовника окремим письмовим повідомленням. Дане повідомлення вважається невід’ємною частиною Договору.</dt>
                    <dt>6.6  Замовник має, немає (необхідне підкреслити) статус платника податку на прибуток підприємств на загальних умовах.</dt>
                    <dt>6.7 ЕО має статус платника податку на прибуток підприємств на загальних умовах.</dt>
                </dl>
                <p align="center"><strong>7 Місцезнаходження сторін</strong></p>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="355" valign="top"><span>Електропередавальна    організація:</span></td>
                        <td width="355" valign="top"><p>Замовник:</p></td>
                    </tr>
                    <tr>
                        <td width="355" valign="top"><strong>ПАТ «Прикарпаттяобленерго»</strong> <br>
                            <strong>м.    Івано-Франківськ, вул. Індустріальна, 34</strong><br>
                            Код ЄДРПОУ 00131564<br>
                            п/р 26000011732450 в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                            Код МФО 300023<br>
                            <p><strong>Технічний    директор </strong><br>
                                <strong>ПАТ    «Прикарпаттяобленерго»</strong><br></td>
                                    <td width="355" valign="top"><%if (rs.getString("customer_type").equals("1")) {%><p><strong><%if (!rs.getString("customer_soc_status_1").equals("9")
                                                && !rs.getString("customer_soc_status_1").equals("12")) {%> <%= rs.getString("customer_soc_status")%><%}%><%= rs.getString("name")%></strong>
                                <br>
                                <strong><%=rs.getString("type_c")%> <%= rs.getString("customer_adress")%></strong><br>
                                р/р <%= rs.getString("bank_account")%> МФО <%= rs.getString("bank_mfo")%><br>
                                <strong>_____________________________________</strong><br>
                                Код ЄДРПОУ    <%= rs.getString("bank_identification_number")%><br>
                                Свідоцтво платника ПДВ № _____________________<br>
                                Індивідуальний податковий №    ___________________<br>
                            </p><%} else {%>
                            <p><strong><%=rs.getString("PIP")%></strong><br>
                                <%=rs.getString("type_c")%> <%=rs.getString("customer_adress")%><br>
                                <%--<strong><u><%=rs.getString("constitutive_documents").substring(0,rs.getString("constitutive_documents").indexOf("виданий"))%></u></strong><br>
                                <strong><u><%=rs.getString("constitutive_documents").substring(rs.getString("constitutive_documents").indexOf("виданий"))%></u> </strong><br>--%>
                                <%=rs.getString("constitutive_documents")%><br>
                                Ідентифікаційний код <%=rs.getString("bank_identification_number")%><br><br><br><br>
                                Громадянин (ка)<br>
                            </p><%}%>
                        </td>
                    </tr>
                    <tr>
                        <td><p><strong>____________Сеник Олег Степанович</strong></p></td>
                        <td><strong>____________________    <%= rs.getString("PIP")%></strong></td>


                    </tr>
                </table>
            </div>
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
