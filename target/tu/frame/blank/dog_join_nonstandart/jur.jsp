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
                + ",isnull(TC_V2.customer_telephone,'_________') as customer_telephone"
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
                + ",isnull(nullif(TC_V2.[taxpayer],''),'_______________') as [taxpayer]"
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
                + " ,case when SUPPLYCH.join_point=1 then '0.4' "
                + "     when SUPPLYCH.join_point=11 then '0.23' "
                + "     when SUPPLYCH.join_point=2 then '0.4' "
                + "     when SUPPLYCH.join_point=21 then '0.23' "
                + "     when SUPPLYCH.join_point=3 then '10' "
                + "     when SUPPLYCH.join_point=4 then '10' "
                + "     when SUPPLYCH.join_point=5 then '35'"
                + "     when SUPPLYCH.join_point=6 then '35' "
                + "     when SUPPLYCH.join_point=7 then '110' "
                + "    else '____' end as joint_point "
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
                font-size: 9pt;
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
            <p align="right"><SPAN lang="UK">ОП 4.1-Е</SPAN></p>
            <p align="center"><strong>Договір № <%= rs.getString("number")%></strong><br />
                <strong>про нестандартне приєднання до електричних мереж</strong></p>
            <table width="100%"><tr><td width="50%">м. Івано-Франківськ</td>
                    <td align="right"><%=rs.getString("date_customer_contract_tc")%> р.</td></tr></table><br >

            <div align="justify" style="text-align:justify;"><strong>ПАТ «Прикарпаттяобленерго»</strong>, в особі технічного директора ПАТ «Прикарпаттяобленерго» <strong>Сеника Олега Степановича</strong>,&nbsp;який  діє на підставі довіреності № 927 від 25.08.2015 з  однієї сторони (далі - Виконавець послуг), та <strong>
                    <%if (!rs.getString("customer_soc_status_1").equals("9")
                                && !rs.getString("customer_soc_status_1").equals("12")) {%> <%= rs.getString("customer_soc_status")%><%}%> 
                    <%= rs.getString("name")%></strong>, (далі ―
                <strong>Замовник)</strong>, 
                <%if ((!rs.getString("customer_soc_status_1").equals("15")
                            && !rs.getString("customer_soc_status_1").equals("11")) && (rs.getString("customer_type").equals("1"))) {%> в особі  <strong><%= rs.getString("customer_post")%>&nbsp;<%= rs.getString("PIP")%></strong>,<%}
                                if (rs.getString("customer_type").equals("1")) {%> який (яка) діє на підставі<%}%> <strong><%= rs.getString("constitutive_documents")%></strong>, з іншої сторони (далі – Сторони), уклали цей  договір про нестандартне приєднання електроустановок Замовника до електричних мереж (далі –  Договір).
            </div>
            <div align="justify" style="text-align:justify; text-indent:20pt">
                При виконанні умов цього Договору  Сторони зобов'язуються діяти відповідно до чинного законодавства, зокрема,  Правил приєднання електроустановок до електричних мереж, затверджених  постановою Національної комісії, що здійснює державне регулювання у сфері  енергетики № 32 від 17.01.2013 року, Методики розрахунку плати за приєднання,  затвердженою Постановою НКРЕ № 115 від 28.02.2013 року, Закону України «Про  електроенергетику», Закону України «Про регулювання містобудівної діяльності».</p>
                <br> 
            </div>
            <div align="justify" style="text-align:justify; text-indent:20pt"></div>
            <div align="center"><strong>1. Загальні положення </strong></div>
            <div align="justify" style="text-align:justify">
                <dl>
                    <dt>1.1  За цим Договором до електричних мереж Виконавця  послуг або іншого власника мереж приєднується об’єкт Замовника: <strong><u><%= rs.getString("object_name")%></u></strong>, який знаходиться за адресою: <strong><u><%=rs.getString("type_o")%> <%= rs.getString("object_adress")%></u></strong>.</dt>
                    <dt>1.2 Місце забезпечення потужності об’єкта Замовника  встановлюється: <strong><u><%= rs.getString("point_zab_power")%></u></strong></dt>
                    <dt>1.3 Точка приєднання (межа балансової належності  об’єкта Замовника) встановлюється: <strong><u><%= rs.getString("connection_treaty_number")%></u></strong></dt>
                    <dt>1.4 Тип приєднання об’єкта Замовника: <u><strong> <%= rs.getString("type_join")%></strong></u>.</dt>
                    <dt>1.5. Замовлено до приєднання потужність в точці приєднання <strong><%= rs.getString("request_power").replace(".", ",")%></strong> кВт.</dt>
                    <dt>1.6. Категорія з надійності електропостачання <strong><%= rs.getString("reliabylity_class_1")%><%= rs.getString("reliabylity_class_2")%><%= rs.getString("reliabylity_class_3")%></strong>.</dt>
                    <dt>1.7. Ступінь напруги в точці приєднання визначається напругою на межі  балансової належності і буде становити <strong><%= rs.getString("joint_point").replace(".", ",")%></strong> кВ, <strong><%= rs.getString("class_joint_point")%></strong> клас.</dt>
                </dl>
            </div>
            <div align="center"><strong>2. Предмет договору </strong></div>
            <div align="justify" style="text-align:justify">
                <dl>
                    <dt>2.1. Виконавець послуг забезпечує приєднання  електроустановок об'єкта Замовника (будівництво, реконструкція, технічне переоснащення та введення в експлуатацію електричних мереж зовнішнього електропостачання об'єкта Замовника від місця забезпечення потужності до точки  приєднання) відповідно до схеми зовнішнього електропостачання і проектної  документації, розробленої згідно з технічними умовами <strong>№ <%= rs.getString("number")%></strong> від <strong><%= rs.getString("initial_date")%></strong> року (Додаток № 1 до Договору) та здійснює  підключення об'єкта Замовника до електричних мереж на умовах цього Договору.</dt>
                    <dt>2.2. Замовник оплачує Виконавцю послуг вартість приєднання.</dt>
                </dl>
            </div>
            <div align="center"><strong>3. Права та обов'язки сторін</strong></div>
            <div align="justify" style="text-align:justify">
                <dl>
                    <dt>3.1. Виконавець послуг зобов’язаний:</dt>
                    <dt>3.1.1. Забезпечити в установленому порядку приєднання  об’єкта Замовника (будівництво та введення в експлуатацію електричних мереж  зовнішнього електропостачання об’єкта Замовника від місця забезпечення  потужності до точки приєднання) у строки відповідно до домовленості сторін та  після виконання Замовником зобов`язань визначених п.3.2 Договору.</dt>
                    <dt>3.1.2. Підключити електроустановки Замовника до  електричних мереж протягом _____ днів після введення в експлуатацію об'єкта Замовника  в порядку, встановленому законодавством у сфері містобудування, та після  виконання таких етапів:</dt>
                    <ul type="square">
                        <li>оплати Замовником вартості приєднання;</li>
                        <li>введення в експлуатацію електричних мереж зовнішнього електропостачання об'єкта Замовника та письмового повідомлення Виконавця послуг протягом 2 днів</li>
                        <li>надання документів, що підтверджують готовність до експлуатації електроустановки об'єкта Замовника;</li>
                    </ul>
                    <dt>3.1.3 Строк надання послуги з нестандартного приєднання встановлюється  відповідно до термінів будівництва/реконструкції, визначених в  проектно-кошторисній документації, і зазначається в додатковій угоді до даного  Договору.</dt>
                    <dt>3.2. Замовник зобов'язаний:</dt>
                    <dt>3.2.1. Розробити на підставі технічних  умов <strong>№ <%= rs.getString("number")%></strong> від <strong><%= rs.getString("initial_date")%></strong> року, які є  додатком до цього Договору, проектну документацію, протягом 60 днів з дня  укладення даного договору, та погодити її з Виконавцем послуг. </dt>
                    <dt>При наявності у Виконавця послуг зауважень та рекомендацій до проектної  документації, які викладені окремим розділом у технічному рішенні, доопрацювати  проектну документацію у строк, який не може перевищувати 30 робочих днів від  дня отримання зауважень до неї.</dt>
                    <dt>При необхідності продовжити строк доопрацювання проектної документації подати Виконавцю послуг заяву не пізніше ніж за 2 робочі дні до закінчення строку на доопрацювання.</dt>
                    <dt>3.2.2. Узгодити із землевласниками (землекористувачами) та  усіма зацікавленими організаціями траси проходження запроектованих мереж на  стадії проектування.</dt>
                    <dt>3.2.3. Оплатити на умовах цього Договору вартість наданих  Виконавцем послуг з приєднання електроустановок Замовника в точці приєднання. </dt>
                    <dt>3.2.4. Передати Виконавцю послуг проектну документацію на  зовнішнє електропостачання у 4 примірниках для виконання ним зобов'язань за  Договором.</dt>
                    <dt>3.2.5. Дата <strong><%= rs.getString("date_intro_eksp")%></strong>  року введення в експлуатацію власного об’єкту та електроустановки зовнішнього забезпечення від точки приєднання до об’єкта.</dt>
                    <dt>3.2.6. Ввести електроустановки зовнішнього забезпечення від точки приєднання до об'єкта, про що письмово повідомити Виконавця послуг протягом двох днів.</dt>
                    <dt>3.2.7. У разі виникнення потреби у перенесенні існуючих мереж Виконавця послуг звернутися за складанням додаткової угоди щодо надання послуг з перенесення вищезазначених мереж відповідно до частини четвертої статті 18 Закону України "Про електроенергетику".</dt>
                    <dt>3.3. Виконавець послуг має право:</dt>
                    <dt>3.3.1. Прийняти рішення щодо надання послуги з  приєднання як господарським, так і підрядним способом.</dt>
                    <dt>3.3.2. У разі порушення Замовником  порядку розрахунків за цим Договором призупинити виконання зобов'язань за цим  Договором до належного виконання Замовником відповідних умов Договору та/або  ініціювати перегляд Сторонами істотних умов цього Договору.</dt>
                    <dt>3.4. Замовник має право  контролювати виконання Виконавцем послуг зобов'язань щодо будівництва  електричних мереж зовнішнього електропостачання об'єкта Замовника від місця  забезпечення потужності до точки приєднання, у тому числі шляхом письмових  запитів до Виконавця послуг про хід виконання приєднання.</dt>
                    <dt> 3.5. Після введення в експлуатацію  електричних мереж зовнішнього електропостачання Виконавець послуг набуває право  власності на збудовані електричні мережі зовнішнього електропостачання.</dt>
                    <dt>3.6. Підключення електроустановки  Замовника до електричних мереж електропередавальної організації здійснюється на  підставі заяви протягом 5 днів, якщо підключення не потребує припинення  електропостачання інших споживачів, або 10 днів, якщо підключення потребує  припинення електропостачання інших споживачів, після введення в експлуатацію  об'єкта Замовника в порядку, встановленому законодавством у сфері  містобудування.</dt>
                </dl>
            </div>
            <div align="center"><strong>4. Плата  за приєднання та порядок розрахунків</strong></div>
            <div align="justify" style="text-align:justify">
                <dt>4.1. Плата за нестандартне  приєднання остаточно узгоджується після погодження електропередавальною  організацією проектної документації та оформляється додатковою угодою до даного  Договору № <strong><%= rs.getString("number")%></strong>,  у тому числі вартість проектної документації на зовнішнє електрозабезпечення,  яка передана Замовником Виконавцю послуг за актом приймання-передавання в  рахунок плати за приєднання. </dt>
                <dt>4.2  Замовник сплачує плату за приєднання на поточний рахунок Виконавця послуг до дати визначеної у додатковій угоді. У випадку несплати Замовником плати за приєднання у вказаний термін, Виконавець послуг перераховує вартість послуги з приєднання відповідно до діючої на момент перерахунку вартості проектно-кошторисної документації. При цьому кошторисна вартість робіт підлягає уточненню та коригуванню у зв'язку із зміною цін на матеріали, тарифів на послуги, інших складових структури кошторисної вартості.</dt>
            </div>
            <div align="center"><strong>5.  Відповідальність сторін</strong></div>
            <div align="justify" style="text-align:justify"><dl>
                    <dt>5.1. У випадку порушення своїх  зобов'язань за цим Договором Сторони несуть відповідальність, визначену цим  Договором та чинним законодавством. Порушенням зобов'язання є його невиконання  або неналежне виконання, тобто виконання з порушенням умов, визначених змістом  зобов'язання.</dt>
                    <dt>5.2. Виконавець послуг несе  відповідальність за зміст та обґрунтованість виданих технічних умов та  правильність розрахунку плати за приєднання за цим Договором.</dt>
                    <dt>5.3. Замовник несе  відповідальність за своєчасне та належне виконання вимог технічних умов,  розроблення проектної документації, своєчасне узгодження цієї документації з  Виконавцем послуг.</dt>
                    <dt>5.4. За порушення строків  виконання зобов'язання за цим Договором винна Сторона сплачує іншій Стороні  пеню у розмірі 0,1 відсотка вартості приєднання за кожний день прострочення, а  за прострочення понад 30 днів додатково стягується штраф у розмірі 0,1 відсотка  від вказаної вартості.</dt>
                    <dt>За порушення умов зобов'язання  щодо якості (повноти та комплектності) надання послуги з приєднання стягується  штраф у розмірі 0,1 відсотка від вартості приєднання.</dt>
                    <dt>5.5. Сторони не відповідають за невиконання умов цього Договору, якщо це  спричинено дією обставин непереборної сили. Факт дії обставин непереборної сили  підтверджується відповідними документами.</dt>

                </dl>
            </div>
            <div align="center"><strong>6. Порядок вирішення спорів</strong></div>
            <div align="justify" style="text-align:justify"><dl>
                    <dt>6.1. Усі спірні питання, пов’язані з виконанням  цього Договору, вирішуються шляхом переговорів між Сторонами.</dt>
                    <dt>6.2. У разі недосягнення згоди спір вирішується в судовому порядку  відповідно до законодавства України.</dt>

                </dl>
            </div>
            <div align="center"><strong>7. Строк дії Договору</strong></div>
            <div align="justify" style="text-align:justify"> 
                <dt>7.1. Цей Договір набирає чинності з моменту його підписання і діє до повного виконання Сторонами передбачених ним зобов'язань (до завершення будівництва об’єкту архітектури).</dt>
                <dt>7.2. Договір може бути змінено або  розірвано і в інший строк за ініціативою будь-якої зі Сторін у порядку, визначеному  законодавством України.</dt>
                <dt>7.3. Строк дії Договору може бути  продовжений за вмотивованим зверненням однієї зі Сторін у передбаченому  законодавством порядку.</dt>
                <dt>7.4. Договір може бути розірвано у  разі відсутності (ненадання) розробленої проектно-кошторисної документації у  терміни передбачені даним договором або неврахування зауважень наданих  Виконавцем послуг до проектно-кошторисної документації, або відсутності  звернення Замовника за продовженням строку доопрацювання проектно-кошторисної  документації, та виконання будівництва в строки, зазначені в заяві.</dt></div>
            <div align="center"><strong>8. Інші умови Договору</strong></div>
            <div align="justify" style="text-align:justify">
                <dt>8.1 Після одержання проекту Договору  Замовник у 20-ти денний термін повертає підписаний примірник Договору. У разі  наявності заперечень до умов Договору у цей же термін надсилає протокол  розбіжностей чи повідомляє Виконавця послуг про відмову від укладення Договору. </dt>
                <dt>8.2 У разі недотримання порядку зазначеному в п. 8.1  цього Договору, Договір вважається неукладеним (таким, що не відбувся).</dt>
                <dt>8.3.Фактом виконання зобов'язання Виконавця послуг з приєднання об'єкта Замовника (будівництва електричних мереж зовнішнього електропостачання об'єкта Замовника від місця забезпечення потужності до точки приєднання) Сторони вважатимуть дату подачі напруги в узгоджену точку приєднання, підтверджену підписаним двома Сторонами «Актом приймання-здачі виконаних робіт (наданих послуг)».</dt>
                <dt>8.4.Перелік  невід’ємних додатків до цього Договору:<dt>
                <div align="justify" style="text-align:justify; text-indent:20pt">1.Технічні умови № <strong><%= rs.getString("number")%></strong>  від <strong><%= rs.getString("initial_date")%></strong> року.</div>
                <dt>8.5 Цей Договір укладено у двох примірниках, які мають однакову юридичну силу для Замовника та Виконавця послуг.</dt>           
                </dl>
                
            </div>

            <div align="center"><strong>9. Місцезнаходження сторін</strong></div>
            
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
                        Свідоцтво платника ПДВ № <%= rs.getString("taxpayer")%><br>
                        Індивідуальний податковий <%= rs.getString("bank_identification_number")%><br>
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
                    <td>_______________       <strong><%=rs.getString("PIP")%><strong><br>
                                                                </td>
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

