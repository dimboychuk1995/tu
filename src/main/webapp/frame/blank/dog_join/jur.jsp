<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.*,java.text.NumberFormat"%>
<%  response.setHeader("Content-Disposition", "inline;filename=jur.doc");
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
        String qry = "SELECT "
                + "TC_V2.customer_soc_status as customer_soc_status_1 "
                + ",TC_V2.number as number"
                + ",TC_V2.customer_type"
                + ",isnull(TC_V2.customer_telephone,'') as customer_telephone "
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
                + ",isnull(convert (varchar(10),TC_V2.initial_registration_date_rem_tu,104),'___.___.____') as initial_date"
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
                + ",isnull([contacts],'') as  contacts"
                + ",[rek_bank] "
                + ",[rem_licality]"
                + ",isnull(convert(varchar,TC_O.date_contract,104),'__.__.____') as TC_Odate_contract "
                + ",isnull(TC_O.number,'') as TC_Onumber "
                + " ,case when SUPPLYCH.join_point=1 then '0.4' "
                + "     when SUPPLYCH.join_point=11 then '0.23' "
                + "     when SUPPLYCH.join_point=2 then '0.4' "
                + "     when SUPPLYCH.join_point=21 then '0.23' "
                + "     when SUPPLYCH.join_point=3 then '10' "
                + "     when SUPPLYCH.join_point=4 then '10' "
                + "     when SUPPLYCH.join_point=5 then '35'"
                + "     when SUPPLYCH.join_point=6 then '35' "
                + "     when SUPPLYCH.join_point=7 then '110' "
                + "    else '' end as joint_point "
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
                + ",isnull(tj.name,'___________________') as type_join,"
                + " CAST(ISNULL(CAST(TC_V2.request_power AS FLOAT),'') AS VARCHAR) as request_power,"
                + " CASE"
                + " WHEN TC_V2.reliabylity_class_3='true' THEN 'III'"
                + " ELSE '____' END AS reliabylity_class_3,"
                + " isnull(convert(varchar,TC_V2.date_intro_eksp,104),'___.___.____') as date_intro_eksp"
                + ",isnull( dbo.TC_V2.point_zab_power,'') as point_zab_power"
                + ",isnull(dbo.TC_V2.price_join,'0') as price_join"
                + " ,isnull(convert(varchar, dbo.TC_V2.end_dohovoru_tu,104),'___.___.____') as end_dohovoru_tu "
                + " ,isnull(dbo.TC_V2.term_for_joining, 0) as term_for_joining "
                + " from TC_V2 "
                + " left join [TC_LIST_locality] objadr on objadr.id=TC_V2.name_locality"
                + " left join [TC_LIST_locality] cusadr on cusadr.id=TC_V2.customer_locality"
                + " left join [TUweb].[dbo].[TC_LIST_customer_soc_status] soc_status on soc_status.id=TC_V2.customer_soc_status "
                + " left join [TUweb].[dbo].[rem] rem on TC_V2.department_id=rem.rem_id "
                + " left join TC_V2 TC_O on TC_V2.main_contract=TC_O.id "
                + " left join SUPPLYCH on SUPPLYCH.tc_id=TC_V2.id"
                + " left join [TUweb].[dbo].[type_join] tj on TC_V2.type_join=tj.id"
                + " where TC_V2.id=" + request.getParameter("tu_id");
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
        <jsp:include page="../word_page_format.jsp"/>
        <style type="text/css">
            <!--
            body,td,th {
                font-size: 8pt;
            }
            li,ul {
                margin-top: 0; /* Отступ сверху */
                margin-bottom: 0; /* Отступ снизу */    
            }
            -->
        </style>
    </head>
    <body>
        <div class="Section1">
            <p align="right"><SPAN lang="UK">ОП 4.1-Б</SPAN></p>
            <p align="center"><strong>Договір № <%= rs.getString("number")%></strong><br />
                <strong>про стандартне приєднання до електричних мереж</strong></p>
            <table width="100%"><tr><td width="50%"><%=rs.getString("rem_licality").substring(0, rs.getString("rem_licality").indexOf(','))%></td><td align="right"><%=rs.getString("date_customer_contract_tc")%> р.</td></tr></table><br >

            <div align="justify" style="text-align:justify; text-indent:20pt"><strong>ПАТ  «Прикарпаттяобленерго»</strong>, що здійснює ліцензовану діяльність з передачі  електроенергії,  в особі директора філії <strong>&quot;<%= rs.getString("rem_name")%> РЕМ&quot;</strong> <strong><%= rs.getString("director_rod")%></strong>, який діє  на підставі довіреності <%= rs.getString("dovirenist")%> року, далі - Виконавець послуг з однієї сторони, та &nbsp;<strong><%if (!rs.getString("customer_soc_status_1").equals("9")
                        && !rs.getString("customer_soc_status_1").equals("12")) {%> <%= rs.getString("customer_soc_status")%><%}%> 
                    <%= rs.getString("name")%></strong>, надалі ―
                Замовник, <%if ((!rs.getString("customer_soc_status_1").equals("15")
                            && !rs.getString("customer_soc_status_1").equals("11")) && (rs.getString("customer_type").equals("1"))) {%> в особі  <strong><%= rs.getString("customer_post")%>&nbsp;<%= rs.getString("PIP")%></strong>,<%}
                                if (rs.getString("customer_type").equals("1")) {%> який (яка) діє на підставі<%}%> <strong><%= rs.getString("constitutive_documents")%></strong>
                , з іншої сторони,  уклали цей Договір про  приєднання електроустановок Замовника до електричних мереж (далі ―  Договір).<br>
            </div>
            <div align="justify" style="text-align:justify; text-indent:20pt">При виконанні умов цього  Договору, а також вирішенні всіх питань, що не обумовлені цим Договором,  сторони зобов'язуються керуватися Законом України "Про електроенергетику"  та іншими нормативно-правовими актами у сфері приєднання електроустановок до електромереж.<br> 
            </div>
            <div align="justify" style="text-align:justify; text-indent:20pt"></div>
            <div align="center"><strong>1. Загальні положення </strong></div>
            <div align="justify" style="text-align:justify">
                <dl>
                    <dt>1.1  За цим Договором до електричних мереж Виконавця послуг або іншого Власника приєднується:<strong><u> <%= rs.getString("object_name")%></u></strong>, який знаходиться за адресою: <strong><u><%=rs.getString("type_o")%> <%= rs.getString("object_adress")%></u></strong> (далі - об'єкт Замовника). </dt>
                    <dt>1.2 Місце забезпечення потужності об’єкта Замовника  встановлюється: <strong><u><%= rs.getString("point_zab_power")%></u></strong></dt>
                    <dt>1.3 Точка приєднання (межа балансової належності  об’єкта Замовника) встановлюється:<strong><u><%= rs.getString("connection_treaty_number")%></u></strong></dt>
                    <dt>1.4 Тип приєднання об’єкта Замовника: <u><strong> <%= rs.getString("type_join")%></strong></u>.</dt>
                    <dt>1.5. Замовлено до приєднання потужність в точці приєднання <strong><%= rs.getString("request_power").replace(".", ",")%></strong> кВт.</dt>
                    <dt>1.6. Категорія з надійності електропостачання <strong><%= rs.getString("reliabylity_class_3")%></strong>.</dt>
                    <dt>1.7. Ступінь напруги в точці приєднання визначається напругою на межі  балансової належності і буде становити <strong><%= rs.getString("joint_point").replace(".", ",")%></strong> кВ, <strong><%= rs.getString("class_joint_point")%></strong> клас.</dt>
                </dl>
            </div>
            <div align="center"><strong>2. Предмет договору </strong></div>
            <div align="justify" style="text-align:justify">
                <dl>
                    <dt>2.1. Виконавець послуг забезпечує приєднання електроустановок  об’єкта Замовника (будівництво, реконструкція, технічне переоснащення та  введення в експлуатацію електричних мереж зовнішнього електропостачання об’єкта  Замовника від місця забезпечення потужності до точки приєднання) відповідно до  схеми зовнішнього електропостачання та проектної документації на зовнішнє  електропостачання, розробленої згідно з технічними умовами від <strong><%= rs.getString("initial_date")%></strong> року № <strong><%= rs.getString("number")%></strong>,  які є додатком до цього Договору, а також здійснює підключення об’єкта  Замовника до електричних мереж на умовах цього Договору.</dt>
                    <dt>2.2. Замовник оплачує Виконавцю послуг вартість приєднання.</dt>
                </dl>
            </div>
            <div align="center"><strong>3. Права та обов'язки сторін</strong></div>
            <div align="justify" style="text-align:justify"><dl>
                    <dt>3.1. Виконавець послуг зобов’язаний:</dt>
                    <dt>3.1.1. Забезпечити в установленому порядку  приєднання об’єкта Замовника (будівництво та введення в експлуатацію  електричних мереж зовнішнього електропостачання об’єкта Замовника від місця  забезпечення потужності до точки приєднання) у терміни відповідно до  домовленості сторін та визначених СНИП 1.04.03-85 термінів будівництва після  виконання Замовником зобов`язань визначених п.3.2 Договору.</dt>
                    <dt>3.1.2. Підключити електроустановки Замовника до  електричних мереж протягом 10 робочих днів після представлення Замовником ЕО документів про введення в експлуатацію  об’єкту Замовника, в порядку, встановленому законодавством у сфері  містобудування, та після виконання наступних етапів:</dt>
                    <ul type="square">
                        <li>Оплати       Замовником вартості приєднання;</li>
                        <li>введення в       експлуатацію електричних мереж зовнішнього електропостачання об’єкта       Замовника;</li>
                        <li>надання       документів, що підтверджують готовність до експлуатації електроустановки       об’єкта Замовника;</li>
                        <li>узгодження між сторонами акту розмежування балансової належності електроустановок та       експлуатаційної відповідальності сторін.</li>
                    </ul>
                    <dt>3.1.3 Виконавець послуг  зобов’язується здійснити у відповідності до Закону України «Про захист  персональних даних» заходи щодо організації захисту персональних даних та не  розголошувати відомості стосовно персональних даних Замовника.</dt>
                    <% if (rs.getInt("term_for_joining") <= 15) {%>
                    <dt>3.1.4 Термін надання послуги із стандартного приєднання становить 15 робочих днів з дня оплати Замовником плати за приєднання.</dt> <%}%>
                    <% if (rs.getInt("term_for_joining") > 15) {%>
                    <dt>3.1.4 Строк надання послуги з приєднання від дня оплати плати за приєднання становить <%= rs.getString("term_for_joining")%> робочих днів, відповідно до вимог СОУ-Н МЕВ 42.2-37471933-45:2011.</dt><%}%>
                    <dt>3.1.5 Тривалість надання послуги зі стандартного приєднання може бути продовжена на строк необхідний для погодження та оформлення права користування земельними ділянками під електроустановки зовнішнього електрозабезпечення відповідно до закону. Повідомлення власників земельних ділянок та Замовника є невід'ємною частиною даного Договору</dt>
                    <dt>3.2. Замовник зобов'язаний:</dt>
                    <dt>3.2.1. Оплатити на умовах цього Договору вартість  наданих Виконавецем послуг з приєднання електроустановок Замовника в точці  приєднання.</dt>
                    <dt>3.2.2. Дата <strong><%= rs.getString("date_intro_eksp")%></strong>  року введення в експлуатацію власного об’єкту та електроустановки зовнішнього забезпечення від точки приєднання до об’єкта.</dt>
                    <dt>3.2.3. Письмово повідомити Виконавця послуг протягом двох днів про введення в експлуатацію власного об’єкту та електроустановки зовнішнього забезпечення від точки приєднання до об’єкта.</dt>
                    <dt>3.3. Виконавець послуг має право:</dt>
                    <dt>3.3.1. Прийняти рішення щодо надання послуги з  приєднання як господарським, так і підрядним способом.</dt>
                    <dt>3.3.2. У разі порушення Замовником порядку  розрахунків за цим Договором, призупинити виконання зобов’язань за цим  Договором до належного виконання Замовником відповідних умов Договору та/або  ініціювати перегляд Сторонами істотних умов цього Договору.</dt>
                    <dt>3.4. Замовник має право:</dt>
                    <dt>3.4.1. Контролювати виконання Виконавецем послуг зобов`язань  щодо будівництва електричних мереж зовнішнього електропостачання об’єкта  Замовника від місця забезпечення потужності до точки приєднання, у тому числі  шляхом письмових запитів до Виконавеця послуг про хід виконання приєднання.</dt>
                    <dt>3.5. Після введення в експлуатацію електричних мереж  зовнішнього електропостачання Виконавець послуг набуває право власності на  збудовані електричні мережі зовнішнього електропостачання.</dt></p>
                    <dt> 3.6. Підключення електроустановки Замовника до електричних мереж  електропередавальної організації здійснюється на підставі заяви протягом 5  робочих днів, якщо підключення не потребує  припинення електропостачання інших споживачів, або 10 робочих днів, якщо  підключення потребує припинення електропостачання інших споживачів, після  введення в експлуатацію об’єкту Замовника в порядку, встановленому  законодавством у сфері містобудування.</dt>

                </dl>
            </div>
            <div align="center"><strong>4. Плата  за приєднання та порядок розрахунків</strong></div>
            <div align="justify" style="text-align:justify">
                <dl>
                    <dt>4.1. Плата за приєднання за цим Договором відповідно  до Постанови НКРЕ № 81 від 26.01.2017 «Про затвердження ставок плати за приєднання електроустановок для Автономної Республіки Крим, областей, міст Києва та Севастополя на 2016 рік», становить <strong>  <%= rs.getString("price_join").replace(".", ",")%></strong> грн. з ПДВ.</dt>
                    <div align="justify" style="text-align:justify; text-indent:20pt">Плата за приєднання вказується з урахуванням  діючих ставок та податку на додану вартість на день  здійснення платежу.<br></div>
                    <dt>4.2. Замовник сплачує плату за приєднання,визначену в пункті 4.1 цього Договору, на поточний рахунок Виконавця послуг: п/р 26000011732450 в філії Івано-Франківське обласне управління ПАТ «Укрсоцбанк», Код ЄДРПОУ 00131564, в  термін до ____ днів з дня укладання Договору.</dt>

                </dl>
            </div>
            <div align="center"><strong>5.  Відповідальність сторін</strong></div>
            <div align="justify" style="text-align:justify"><dl>
                    <dt>5.1. У випадку порушення своїх зобов'язань за цим  Договором Сторони несуть відповідальність, визначену цим Договором та чинним  законодавством. Порушення зобов'язання є його невиконання або неналежне  виконання, тобто виконання з порушенням умов, визначених змістом зобов'язання.</dt>
                    <dt>5.2. Виконавець послуг несе відповідальність за зміст  та обґрунтованість виданих технічних умов та правильність розрахунку плати за  приєднання за цим Договором.</dt>
                    <dt>5.3. За порушення строків виконання зобов'язання  за цим Договором винна сторона сплачує іншій Стороні пеню у розмірі 0,1  відсотка вартості приєднання за кожний день прострочення, а за прострочення  понад тридцять днів додатково стягується штраф у розмірі семи відсотків  вказаної вартості.</dt>
                    <div align="justify" style="text-align:justify; text-indent:20pt">За порушення умов зобов'язання щодо якості  (повноти та комплектності) надання послуги з приєднання стягується штраф у  розмірі семи відсотків вартості приєднання.<br></div>
                    <dt>5.4. Сторони не відповідають за невиконання умов цього Договору, якщо це  спричинено дією обставин непереборної сили. Факт дії обставин непереборної сили  підтверджується відповідними документами.</dt>

                </dl>
            </div><br><br>
            <div align="center"><strong>6. Порядок вирішення спорів</strong></div>
            <div align="justify" style="text-align:justify"><dl>
                    <dt>6.1. Усі спірні питання, пов’язані з виконанням  цього Договору, вирішуються шляхом переговорів між сторонами.</dt>
                    <dt>6.2. У разі недосягнення згоди спір вирішується в судовому порядку  відповідно до законодавства України.</dt>

                </dl>
            </div>
            <div align="center"><strong>7. Строк дії Договору</strong></div>
            <div align="justify" style="text-align:justify">
                <dt>7.1. Цей Договір набирає чинності з моменту його підписання і діє до повного виконання Сторонами передбачених ним зобов'язань (до завершення будівництва об’єкту архітектури).</dt>
                <dt> 7.2. Договір може бути змінено або розірвано і в  іншій термін за ініціативою будь-якої із сторін у порядку, визначеному  законодавством України.</dt>
                <dt>7.3. Строк дії Договору може бути продовжений за  вмотивованим зверненням однієї із Сторін у передбаченому законодавством  порядку.</dt>
                <dt>7.4. Договір може бути розірвано у разі відсутності розробленої  проектно-кошторисної документації та виконання будівництва в терміни, зазначені  в заяві.</dt></div>
            <div align="center"><strong>8. Інші умови Договору</strong></div>
            <div align="justify" style="text-align:justify">
                <dt>8.1 Після одержання проекту Договору Замовник у 20-ти  денний термін повертає підписаний примірник Договору. У разі наявності  заперечень до умов Договору у цей же термін надсилає протокол розбіжностей чи  повідомляє Виконавця послуг про відмову від укладення Договору.</dt>
                <dt>8.2 У разі недотримання порядку зазначеному в п. 8.1  цього Договору, Договір вважається неукладеним (таким, що не відбувся).</dt>
                <dt>8.3. Фактом  виконання зобов`язання Виконавця послуг з приєднання об`єкта Замовника  (будівництва електричних мереж зовнішнього електропостачання об’єкта Замовника  від місця забезпечення потужності до точки приєднання) Сторони вважатимуть факт  подачі напруги в узгоджену точку приєднання, підтверджену підписаним двома Сторонами &quot;Акт приймання-передачі виконаних робіт (наданих послуг)&quot;.</dt>
                <dt>8.4.Перелік  невід’ємних додатків до цього Договору:<dt>
                <div align="justify" style="text-align:justify; text-indent:20pt">1.Технічні умови № <strong><%= rs.getString("number")%></strong>  від <strong><%= rs.getString("initial_date")%></strong> року.</div>
                <dt>8.5 Цей Договір укладений у двох примірниках, які  мають однакову юридичну силу для Замовника та Виконавця послуг.</dt>
                <dt>8.6 Виконавець послуг здійснює  обробку персональних даних Замовника на підставі його письмової згоди для  проведення розрахунків по договору про приєднання до електричних мереж та  оформлення документів пов’язаних з виконанням умов по договору з метою  забезпечення реалізації податкових відносин, відносин у сфері бухгалтерського  обліку, адміністративно-правових та інших відносин, які вимагають обробки  персональних даних відповідно до Конституції України, Цивільного кодексу  України, Податкового кодексу України, Законів України «Про бухгалтерський облік  та фінансову звітність в Україні», Закону України «Про електроенергетику» та  інших нормативно-правових документів у сфері приєднання до електричних мереж.</dt>
                <dt>8.7 Виконавець послуг відповідно  до Закону України «Про захист персональних даних» повідомляє, що персональні  дані Замовника будуть включені до бази персональних даних «Фізичні особи,  персональні дані, яких обробляються в ході ведення господарської діяльності».  Вказана база розміщена за адресою: 76014, м. Івано-Франківськ, вул.  Індустріальна, 34.</dt>
                <dt>8.8 Виконавець послуг  повідомляє, що Замовник має права, визначені Законом України «Про захист  персональних даних», зокрема передбачені ст. 8 цього Закону:</dt>
                <ul type="square">
                    <li>  знати про місцезнаходження бази персональних даних, яка містить його  персональні дані, її призначення та найменування, місцезнаходження та / або  місце проживання (перебування) володільця чи розпорядника персональних даних  або дати відповідне доручення щодо отримання цієї інформації уповноваженим ним  особам, крім випадків, встановлених законом; </li>
                    <li>  отримувати інформацію про умови надання доступу до персональних даних, зокрема  інформацію про третіх осіб, яким передаються його персональні дані; </li>
                    <li>  на доступ до своїх персональних даних;</li>
                    <li>  отримувати не пізніш як за тридцять календарних днів з дня надходження запиту,  крім випадків, передбачених законом, відповідь про те, чи зберігаються його  персональні дані у відповідній базі персональних даних, а також отримувати  зміст його персональних даних, які зберігаються;</li>
                    <li>  пред'являти вмотивовану вимогу володільцю персональних даних із запереченням  проти обробки своїх персональних даних;</li>
                    <li>  пред'являти вмотивовану вимогу щодо зміни або знищення своїх персональних даних  будь-яким володільцем та розпорядником персональних даних, якщо ці дані  обробляються незаконно чи є недостовірними; </li>
                    <li>  на захист своїх персональних даних від незаконної обробки та випадкової втрати,  знищення, пошкодження у зв'язку з умисним приховуванням, ненаданням чи  несвоєчасним їх наданням, а також на захист від надання відомостей, що є  недостовірними чи ганьблять честь, гідність та ділову репутацію фізичної особи;</li>
                    <li>  звертатися із скаргами на обробку своїх персональних даних до органів державної  влади та посадових осіб, до повноважень яких належить забезпечення захисту  персональних даних, або до суду;</li>

                    <li> застосовувати засоби правового захисту в разі порушення законодавства про  захист персональних даних; </li>
                    <li>  вносити застереження стосовно обмеження права на обробку своїх персональних  даних під час надання згоди;</li>
                    <li>  відкликати згоду на обробку персональних даних;</li>
                    <li>  знати механізм автоматичної обробки персональних даних;</li>
                    <li> на захист від автоматизованого рішення, яке має  для нього правові наслідки.</li>
                </ul>
                </dl>
                <dt>&nbsp;</dt>
            </div>

            <div align="center"><strong>9. Місцезнаходження сторін</strong></div>
            <div><br></div>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="355" valign="top"><span>Виконавець послуг :</span></td>
                    <td width="355" valign="top"><span>Замовник:</span></td>
                </tr>
                <tr>
                    <td width="328" valign="top"><p>ПАТ «Прикарпаттяобленерго»<br>
                            <u>м. Івано-Франківськ, вул. Індустріальна, 34</u><br>
                        Код ЄДРПОУ 00131564<br>
                        п/р 26000011732450 в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                        Код МФО 300023<br>
                        тел: <%= rs.getString("contacts").replace("тел. (", "").replace(")", "")%><br><br>
                            Директор філії ПАТ «Прикарпаттяобленерго»<br>
                            “<%= rs.getString("rem_name")%> РЕМ”<br>
                        </p></td>
                            <td width="355" valign="top"><%if (rs.getString("customer_type").equals("1")) {%><strong><%if (!rs.getString("customer_soc_status_1").equals("9")
                                && !rs.getString("customer_soc_status_1").equals("12")) {%> <%= rs.getString("customer_soc_status")%><br><%}%><%= rs.getString("name")%></strong>
                        <br>
                        <%=rs.getString("type_c")%> <%= rs.getString("customer_adress")%><br>
                        р/р <%= rs.getString("bank_account")%> МФО <%= rs.getString("bank_mfo")%><br>
                        <strong>_____________________________________</strong><br>
                        Код ЄДРПОУ    <%= rs.getString("bank_identification_number")%><br>
                        Свідоцтво платника ПДВ № _____________________<br>
                        Індивідуальний податковий №    ___________________<br>
                        <%} else {%>
                        <br><strong><%=rs.getString("PIP")%></strong><br>
                        <%=rs.getString("type_c")%> <%=rs.getString("customer_adress")%><br>
                        <%--<strong><u><%=rs.getString("constitutive_documents").substring(0,rs.getString("constitutive_documents").indexOf("виданий"))%></u></strong><br>
                        <strong><u><%=rs.getString("constitutive_documents").substring(rs.getString("constitutive_documents").indexOf("виданий"))%></u> </strong><br>--%>
                        <%=rs.getString("constitutive_documents")%><br>
                        Ідентифікаційний код <%=rs.getString("bank_identification_number")%><br>

                        Громадянин (ка)<br><br>
                        <%}%>
                        тел: <%=rs.getString("customer_telephone")%><br><%=rs.getString("customer_post")%><br>
                    </td>
                </tr>
                <tr>
                    <td>________________        <u><%=rs.getString("Director")%></u><br>
                                                           <br>_____________________20___ року</td>
                    <td>_______________       <u><%=rs.getString("PIP")%></u><br>
                                                           <br>_____________________20___ року</td>
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

