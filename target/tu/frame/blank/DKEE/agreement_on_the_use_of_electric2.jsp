<%--
  Created by IntelliJ IDEA.
  User: us9522
  Date: 24.05.2016
  Time: 11:30
  To change this template use File | Settings | File Templates.
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
  String db;
  if (!ses.getAttribute("db_name").equals(null)) {
    db = (String) ses.getAttribute("db_name");
  } else {
    db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
  }
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
  try {
    c = ds.getConnection();
    String qry = "SELECT TOP 1" +
            "ISNULL(TUWeb.dbo.rem.Director,'') AS Director," +
            "ISNULL(TUWeb.dbo.rem.rem_name,'') AS rem_name," +
            "ISNULL(TUWeb.dbo.rem.contacts,'') AS contacts," +
            "ISNULL(TUWeb.dbo.rem.rem_licality,'') AS rem_licality," +
            "ISNULL(TUWeb.dbo.rem.dovirenist,'') AS dovirenist," +
            "ISNULL(TUWeb.dbo.rem.rek_bank_withOut_spec,'') AS rek_bank_withOut_spec," +
            "ISNULL(TUWeb.dbo.rem.rek_bank_with_spec,'') AS rek_bank_with_spec," +
            "ISNULL(TUWeb.dbo.rem.city_town_village, '') AS city_town_village," +
            "ISNULL(dbo.TC_V2.id,'') AS id," +
            "ISNULL(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'') AS full_name," +
            "ISNULL(dbo.TC_V2.object_adress,'') AS object_adress," +
            "ISNULL(CONVERT(VARCHAR,dbo.TC_V2.power_plit,104),'') AS power_plit," +
            "CASE WHEN power_plit <> 0 THEN 'стаціонарною електроплитою' ELSE ' ' END AS power_plit_prod," +
            "ISNULL(CONVERT(VARCHAR,dbo.TC_V2.request_power,104),'') AS request_power," +
            "CASE WHEN TC_V2.reliabylity_class_3_val IS NOT NULL " +
            "THEN 'третя категорія надійності'" +
            "ELSE 'друга категорія надійності'" +
            "END AS kategory," +
            "        ISNULL(dbo.TC_V2.voltage,'') AS voltage," +
            "CASE WHEN dbo.TC_V2.voltage = 220 AND dbo.TC_V2.request_power > 2.1 AND dbo.TC_V2.request_power <= 3 THEN '16'" +
            "WHEN dbo.TC_V2.voltage = 220 AND dbo.TC_V2.request_power > 3.1 AND dbo.TC_V2.request_power <= 4 THEN '20'" +
            "WHEN dbo.TC_V2.voltage = 220 AND dbo.TC_V2.request_power > 4.1 AND dbo.TC_V2.request_power <= 5 THEN '25'" +
            "WHEN dbo.TC_V2.voltage = 220 AND dbo.TC_V2.request_power > 5.1 AND dbo.TC_V2.request_power <= 6 THEN '32'" +
            "WHEN dbo.TC_V2.voltage = 220 AND dbo.TC_V2.request_power > 6.1 AND dbo.TC_V2.request_power <= 8 THEN '40'" +
            "WHEN dbo.TC_V2.voltage = 220 AND dbo.TC_V2.request_power > 8.1 AND dbo.TC_V2.request_power <= 10 THEN '50'" +
            "WHEN dbo.TC_V2.voltage = 220 AND dbo.TC_V2.request_power > 10.1 AND dbo.TC_V2.request_power <= 11 THEN '63'" +
            "WHEN dbo.TC_V2.voltage = 380 AND dbo.TC_V2.request_power > 0.1 AND dbo.TC_V2.request_power <= 3 THEN '16'" +
            "WHEN dbo.TC_V2.voltage = 380 AND dbo.TC_V2.request_power > 3.1 AND dbo.TC_V2.request_power <= 4.9 THEN '20'" +
            "WHEN dbo.TC_V2.voltage = 380 AND dbo.TC_V2.request_power > 5 AND dbo.TC_V2.request_power <= 8.4 THEN '25'" +
            "WHEN dbo.TC_V2.voltage = 380 AND dbo.TC_V2.request_power > 8.5 AND dbo.TC_V2.request_power <= 10.5 THEN '32'" +
            "WHEN dbo.TC_V2.voltage = 380 AND dbo.TC_V2.request_power > 10.6 AND dbo.TC_V2.request_power <= 13 THEN '40'" +
            "WHEN dbo.TC_V2.voltage = 380 AND dbo.TC_V2.request_power > 13.1 AND dbo.TC_V2.request_power <= 15.5 THEN '50'" +
            "WHEN dbo.TC_V2.voltage = 380 AND dbo.TC_V2.request_power > 15.6 AND dbo.TC_V2.request_power <= 19.5 THEN '63'" +
            "WHEN dbo.TC_V2.voltage = 380 AND dbo.TC_V2.request_power > 19.6 AND dbo.TC_V2.request_power <= 24.5 THEN '80'" +
            "WHEN dbo.TC_V2.voltage = 380 AND dbo.TC_V2.request_power > 24.6 AND dbo.TC_V2.request_power <= 31 THEN '100'" +
            "WHEN dbo.TC_V2.voltage = 380 AND dbo.TC_V2.request_power > 31.1 AND dbo.TC_V2.request_power <= 39 THEN '120'" +
            "WHEN dbo.TC_V2.voltage = 380 AND dbo.TC_V2.request_power > 39.1 AND dbo.TC_V2.request_power <= 49 THEN '160'" +
            " ELSE '-'" +
            "END AS amperage," +
            "        ISNULL(dbo.TC_V2.connection_treaty_number,'') AS connection_treaty_number," +
            "ISNULL(dbo.TC_V2.constitutive_documents,'') AS constitutive_documents," +
            "ISNULL(dbo.TC_V2.bank_identification_number,'') AS bank_identification_number," +
            "ISNULL(dbo.TC_LIST_locality.name,'') AS customer_locality," +
            "CASE" +
            "  WHEN dbo.TC_LIST_locality.type = '1' THEN 'м. ' + CAST(dbo.TC_LIST_locality.name AS VARCHAR(150))" +
            "  WHEN dbo.TC_LIST_locality.type = '2' THEN 'c. ' + CAST(dbo.TC_LIST_locality.name AS VARCHAR(150))" +
            "  WHEN dbo.TC_LIST_locality.type = '3' THEN 'смт. ' + CAST(dbo.TC_LIST_locality.name AS VARCHAR(150))" +
            "END AS name_locality," +
            "ISNULL(dbo.TC_V2.customer_adress,'') AS customer_adress," +
            "ISNULL(dbo.TC_V2.customer_telephone,'') AS customer_telephone," +
            " ISNULL(dbo.TC_V2.customer_zipcode,'') AS customer_zipcode," +

            " CASE" +
            "  WHEN dbo.TC_V2.department_id = 190 THEN 'Богородчанський р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 200 THEN 'Верховинський р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 210 THEN 'Галицький р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 220 THEN 'Городенківський р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 230 THEN 'Долинський р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 240 THEN ''" +
            "  WHEN dbo.TC_V2.department_id = 250 THEN 'Калуський р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 260 THEN ''" +
            "  WHEN dbo.TC_V2.department_id = 270 THEN 'Коломийський р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 280 THEN 'Косівський р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 290 THEN 'Тисминецький р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 300 THEN 'Надвірнянський р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 310 THEN 'Рогатинський р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 320 THEN 'Рожнятівський р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 330 THEN 'Снятинський р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 340 THEN 'Тлумацький р-н, '" +
            "  WHEN dbo.TC_V2.department_id = 350 THEN 'Яремчанський р-н, '" +
            "  END AS customer_ray_center," +

            "          CASE" +
            "  WHEN dbo.TC_LIST_locality.type = '1' THEN 'м. ' + CAST(dbo.TC_LIST_locality.name AS VARCHAR(150)) + ', ' + dbo.TC_V2.customer_adress" +
            "  WHEN dbo.TC_LIST_locality.type = '2' THEN 'c. ' + CAST(dbo.TC_LIST_locality.name AS VARCHAR(150)) + ', ' + dbo.TC_V2.customer_adress" +
            "  WHEN dbo.TC_LIST_locality.type = '1' THEN 'смт. ' + CAST(dbo.TC_LIST_locality.name AS VARCHAR(150)) + ', ' + dbo.TC_V2.customer_adress" +
            " END AS customer_adress_new" +

            " FROM TUWeb.dbo.rem, dbo.TC_V2" +
            " JOIN dbo.TC_LIST_locality ON dbo.TC_V2.customer_locality = dbo.TC_LIST_locality.id" +
            " and  dbo.TC_V2.name_locality = dbo.TC_LIST_locality.id" +
            " where TC_V2.id=" + request.getParameter("tu_id") +
            " and dbo.TC_V2.department_id = TUWeb.dbo.rem.rem_id ";
    System.out.println(qry);
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title>JSP Page</title>
<jsp:include page="../word_page_format.jsp"/>


</head>
<body>
<div class="Section1">
  <table width="100%">
    <tr>
      <td colspan="2" align="center">
        <strong>ДОГОВІР про користування електричною енергією №___________</strong>
      </td>
    </tr>
    <tr>
      <td align="left"><%=rs.getString("city_town_village")%></td>
      <td align="right">"___"________20__p.</td>
    </tr>
    <tr>
      <td colspan="2">
          <%=rs.getString("full_name")%>, об'єкт якого розташований за
        адресою <%=rs.getString("customer_ray_center")%>,  <%=rs.getString("name_locality")%>, вул.<%=rs.getString("object_adress")%>,<br/> далі іменується
        Споживач, з однієї сторони та ПАТ "Прикарпаттяобленерго", в особі директора філії <%=rs.getString("rem_name")%> РЕМ
          <%=rs.getString("Director")%>, який діє на підставі Положення та довіреності <%=rs.getString("dovirenist")%>
        далі іменується Енергопостачальник, з іншої сторони, уклали цей договір про користування
        електричною енергією.
      </td>
    </tr>
    <tr>
      <td colspan="2" align="center"><strong>Предмет договору</strong></td>
    </tr>
    <tr>
      <td colspan="2">
        1. За цим договором Енергопостачальник бере на себе зобов’язання надійно постачати
        Споживачеві електричну енергію у необхідних йому обсягах відповідно до потужності <u><%=rs.getString("request_power")%></u> кВт
        електроустановок Споживача, з гарантованим рівнем надійності, безпеки і якості, а
        Споживач зобов’язується оплачувати одержану електричну енергію за обумовленими тарифами
        (цінами) у терміни, передбачені цим договором.<br/>
        2. Категорія надійності струмоприймачів Споживача <u><%=rs.getString("kategory")%></u>.<br/>
        3. Параметри якості електричної енергії повинні відповідати державним стандартам.<br/>
        4. Встановлені запобіжники чи запобіжні автомати типу <u> AB</u>, на напругу <u><%=rs.getString("voltage")%></u>В,
        струм <u><%=rs.getString("amperage")%></u>А .<br/>
        5. Номер однофазного (трифазного) приладу обліку _________________________________ , дата повірки ____________________ .
        Показники приладу обліку на момент укладення договору ___________________.
        При заміні приладу обліку  або пломб на ньому, складається відповідний документ,
        який підписується Споживачем, та в якому вказується характер проведених робіт.
        Схема підключення однофазного (трифазного) електролічильника перевірена при укладенні цього договору і відповідає вимогам ПУЕ.<br/>
        6. Наявність трифазного електрообладнання дозволено для застосування: _________________________________________.<br/>
        7. Приміщення Споживача обладнані:<u><%=rs.getString("power_plit_prod")%></u><br/>
        8. Межа розподілу встановлюється: <u><%=rs.getString("connection_treaty_number")%></u><br/>
      </td>
    </tr>
    <tr>
      <td colspan="2" align="center"><strong>Права та обов'язки Споживача</strong></td>
    </tr>
    <tr>
      <td colspan="2">
        9. Споживач має право на:<br/>
        •	вибір постачальника електричної енергії;<br/>
        •	підключення до електромережі за умови дотримання правил користування електричною енергією;<br/>
        •	отримання інформації щодо якості електричної енергії, тарифів (цін), порядку оплати, умов та режимів її споживання;<br/>
        •	отримання електричної енергії, якісні характеристики якої визначені державними стандартами;<br/>
        •	відшкодування згідно із законодавством збитків, заподіяних внаслідок порушення його прав;<br/>
        •	якісне обслуговування електричних мереж, розрахункових приладів обліку.<br/>
        Відповідно до статті 8 Закону України «Про захист персональних даних» Споживач має право:<br/>
        знати про джерела збирання, місцезнаходження своїх персональних даних, мету їх обробки,
        місцезнаходження або місце перебування володільця чи розпорядника персональних даних або дати відповідне
        доручення щодо отримання цієї інформації уповноваженим ним особам, крім випадків, встановлених законом;
        отримувати інформацію про умови надання доступу до персональних даних, зокрема інформацію про третіх осіб,
        яким передаються його персональні дані; на доступ до своїх персональних даних; отримувати не пізніш як за
        тридцять календарних днів з дня надходження запиту, крім випадків, передбачених законом, відповідь про те,
        чи обробляються його персональні дані, а також отримувати зміст таких персональних даних; пред'являти
        вмотивовану вимогу володільцю персональних даних із запереченням проти обробки своїх персональних даних;
        пред'являти вмотивовану вимогу щодо зміни або знищення своїх персональних даних будь-яким володільцем та
        розпорядником персональних даних, якщо ці дані обробляються незаконно чи є недостовірними; на захист своїх
        персональних даних від незаконної обробки та випадкової втрати, знищення, пошкодження у зв'язку з умисним
        приховуванням, ненаданням чи несвоєчасним їх наданням, а також на захист від надання відомостей, що є
        недостовірними чи ганьблять честь, гідність та ділову репутацію фізичної особи; звертатися із скаргами
        на обробку своїх персональних даних до Уповноважений або до суду; застосовувати засоби правового захисту
        в разі порушення законодавства про захист персональних даних; вносити застереження стосовно обмеження
        права на обробку своїх персональних даних під час надання згоди; відкликати згоду на обробку персональних даних;
        знати механізм автоматичної обробки персональних даних; на захист від автоматизованого рішення, яке має для нього правові наслідки.<br/>
        10. Споживач електричної енергії зобов’язується:<br/>
        •	дотримуватися вимог нормативно-технічних документів та договору про користування електричною енергією;<br/>
        •	забезпечувати належний технічний стан та безпечну експлуатацію своїх внутрішніх електромереж, електроустановок та побутових електроприладів;<br/>
        •	забезпечувати збереження приладів обліку і пломб на них у разі розміщення приладу обліку у квартирі, або на іншому об’єкті Споживача;ф<br/>
        •	невідкладно повідомляти Енергопостачальника про недоліки в роботі приладу обліку;<br/>
        •	оплачувати електроенергію відповідно до умов договору;<br/>
        •	вносити оплату за спожиту електричну енергію виключно на поточний рахунок зі спеціальним режимом використання в уповноваженому банку;<br/>
        •	узгоджувати з Енергопостачальником нові підключення та переобладнання внутрішньої електропроводки,
            здійснювані з метою збільшення споживання електричної потужності;<br/>
        •	забезпечувати доступ представникам Енергопостачальника, які пред’явили свої службові посвідчення,
            до квартири (будинку) або іншого об’єкта для обстеження приладу обліку, електроустановок та
            електропроводки та надавати розрахункові (платіжні) документи, а також підтверджуючі документи
            про користування пільгами і субсидіями на вимогу представників Енергопостачальника для перевірки правильності оплати;<br/>
      •	не перешкоджати обрізуванню гілок дерев, які ростуть на території, що належить Споживачу,
      для забезпечення відстані не менше 1 метра від проводів повітряної лінії електромережі напругою
      0,4 кВ та на відстані 2 м для електричних ліній напругою 10 кВ та не садити дерева в охоронній зоні
      ліній електропередач (2 метри по обидві сторони ліній);<br/>
      •	не пізніше ніж за 7 днів до припинення користування електричною енергією у квартирі або на
      іншому об'єкті письмово повідомити Енергопостачальника про розірвання договору та розрахуватися
      за спожиту електричну енергію, включаючи день виїзду;<br/>
      •	у разі отримання житлової субсидії на оплату електричної енергії своєчасно повідомляти
      енергопостачальника про своє право на зменшення розміру плати за спожиту електричну енергію
      відповідно до порядку призначення та надання населенню субсидій для відшкодування витрат на
      оплату житлово-комунальних послуг, придбання скрапленого газу, твердого та рідкого пічного побутового палива;<br/>
      •	у  разі  виявлення  в  платіжному  документі  помилкових  показів приладу  обліку  повідомляти  про  це  Енергопостачальника;<br/>
      •	встановити  один  прилад  обліку  незалежно  від  кількості  господарських  будівель, розташованих  за  однією  адресою;<br/>
      •	у разі повторного підключення Споживача до електромереж Енергопостачальника,
      вимкнення якого проводилось з вини Споживача, сплатити вартість робіт з підключення;<br/>
      •	при пошкоджені приладів обліку чи відсутності пломб на них з вини споживача,
      оплачувати вартість ремонту і держповірки приладів обліку, або встановлення нового приладу обліку;<br/>
      •	повідомляти  Енергопостачальника про зміну своїх персональних даних, що підлягають обробці, протягом 10 днів після їх зміни.<br/>
      11. Споживач доручає проводити оплату, одержувати документи, підписувати
      відомості про зняття контрольних показників, Акти про пломбування засобів
      обліку та Акти про порушення, також здійснювати інші дії, пов’язані з виконанням
      прав та обов’язків Споживача по даному договору членам сім’ї: __________________________________________________________.<br/>
      </td>
    </tr>
      <tr>
          <td colspan="2" align="center">
              <strong>Права та обов'язки Енергопостачальника</strong>
          </td>
      </tr>
      <tr>
          <td colspan="2">
              12.  Енергопостачальник має право:<br/>
              •	пропонувати Споживачу  надання додаткових послуг, пов’язаних з постачанням електричної енергії;<br/>
              •	перевіряти стан приладів обліку та проводити обстеження електроустановок, знімати показники відповідно до умов договору;<br/>
              •	встановлювати технічні засоби, які обмежують постачання електричної енергії Споживачу у межах, передбачених договором;<br/>
              •	вимагати від Споживача відшкодування збитків, завданих порушеннями, допущеними Споживачем під час користування електричною енергією;<br/>
              •	робити перерву в постачанні електричної енергії, або відключати Споживача без його згоди у випадках,
              передбачених Правилами користування електричною енергією для населення, в.т.ч: заниженні показників якості
              електричної енергії з вини Споживача, невиконанні приписів державної інспекції енергонагляду, самовільному
              підключенні до електромережі, навмисному пошкоджені приладу обліку та зриву пломби (зривом пломби
              вважається її повна відсутність, неналежна фіксація, невідповідність Держстандартам пломби та
              закріплюючого матеріалу, інші відхилення, що свідчать про несанкціоноване втручання до пломбування);<br/>
              •	контролювати правильність зняття показників приладів обліку та оформлення платіжних документів споживачем;<br/>
              •	за власним рішенням  самостійно знімати показання приладів обліку у споживача.<br/>
              13. Енергопостачальник зобов'язується:<br/>
              •	забезпечувати надійне постачання електричної енергії згідно з умовами ліцензій та договором про користування   електричною енергією;<br/>
              •	надавати інформацію про послуги, пов'язані з електропостачанням, та про терміни обмежень і відключень;<br/>
              •	гарантувати безпечне користування послугами, пов'язаними з електропостачанням, за умови дотримання
              Споживачем вимог правил безпечної експлуатації внутрішньої електромережі, електроустановок  та  побутових електроприладів;<br/>
              •	у разі перерахування Споживачем коштів за електричну енергію на інші рахунки повернути ці кошти
              за заявою споживача або за власною ініціативою в триденний термін з моменту їх отримання;<br/>
              •	повідомляти Споживача письмово або через засоби масової інформації та в місцях оплати за
              електричну енергію про зміни тарифів не пізніше, ніж за 5 днів до їх запровадження;<br/>
              •	проводити не менше як один раз на 6 місяців контрольне зняття показників приладів обліку у Споживача відповідно до затверджених  графіків;<br/>
              •	розглядати звернення Споживача щодо надання послуг, пов'язаних з постачанням електричної
              енергії та приймати з цього приводу рішення у терміни, передбачені Правилами користування електричною енергією для населення;<br/>
              •	проводити планові повірку, ремонт і заміну приладів обліку в терміни, встановлені нормативно-технічними документами та договором;<br/>
              •	ознайомити Споживача з ПКЕЕн та провести інструктаж щодо умов безпечної експлуатації приладів обліку;<br/>
              •	відповідно до Закону України “Про захист персональних даних” забезпечити захист персональних даних
              споживача, що стали відомі Енергопостачальнику,  від  несанкціонованого доступу та незаконного використання.<br/>
              14.  Представник Енергопостачальника під час зняття показників приладів обліку, заміни приладів обліку,
              виписування платіжних документів за електричну енергію та інших дій, що виконуються відповідно до договору,
              зобов'язаний пред'являти своє службове посвідчення.<br/>
              15. Енергопостачальник безплатно:<br/>
              •	здійснює планові повірку, обслуговування та ремонт приладів обліку;<br/>
              •	дає рекомендації щодо можливості та доцільності використання електричної енергії для опалення,
              а також щодо     енергозбереження та режимів споживання електричної енергії;<br/>
              •	надає інформацію щодо якості електричної енергії, умов та режимів її споживання, тарифів (цін), порядку оплати;<br/>
              •	видає бланки типових договорів, розрахункові книжки з бланками квитанцій або платіжні документи,
              електронну картку оплату електричної енергії.<br/>
          </td>
      </tr>
      <tr>
          <td colspan="2" align="center">
              <strong>Умови та порядок оплати</strong>
          </td>
      </tr>
      <tr>
          <td colspan="2">
              16.Оплата спожитої електричної енергії може здійснюватися:<br/>
              <strong>16.1 За платіжними документами, які виписуються Енергопостачальником.</strong><br/>
              Оплата проводиться відповідно до термінів, які зазначені в платіжних документах, виписаних Енергопостачальником,
              і які є невід’ємною частиною цього договору. У разі зняття показів не на дату закінчення розрахункового періоду
              або зміни тарифу, зафіксовані в інший день покази коригуються Енергопостачальником до визначеного дня шляхом
              додавання  (віднімання) середньодобового обсягу споживання, помноженого на кількість днів відхилення від дати
              зняття показів. Якщо доступ до приладу обліку неможливий, Енергопостачальник надає платіжний документ на
              підставі даних про середньомісячне споживання попереднього розрахункового періоду.Плановий обсяг споживання
              електричної енергії визначається за середньомісячним обсягом споживання за попередні 12 місяців
              (відповідно за зимовий та літні періоди), або за фактичний  період споживання, якщо він менший 12 місяців.
              Величина місячного планового обсягу розраховується на рік і щорічно, на початку року, Енергопостачальник
              письмово  повідомляє  про неї Споживача. При застосуванні планових платежів Енергопостачальник періодично
              проводить перерахунок за фактично спожиту електричну енергію та надає споживачу рахунок. У разі неотримання
              або втрати споживачем платіжного документа, він зобов’язується повідомити про це енергопостачальника та
              провести оплату за спожиту електроенергію  до кінця  календарного місяця наступного за розрахунковим періодом.
              В разі отримання від Споживача повідомлення про втрату або неотримання ним платіжного документа
              Постачальник електричної енергії зобов’язується за власним рішенням на протязі 7 днів надіслати поштою
              або вручити нарочно Споживачу дублікат платіжного документа. Споживач має можливість отримати суму до
              оплат за використану електроенергію в будь-який час в кол-центрі в телефонному режимі або через sms
              повідомлення, інформаційно-платіжну систему для населення з 20 по 01 число наступного місяця включно.<br/>
              <strong>16.2 За розрахунковими книжками.</strong><br/>
              Розрахунковим періодом є календарний місяць. Споживач знімає показник лічильника на дату закінчення
              розрахункового місяця і самостійно проводить розрахунок за електроенергію шляхом віднімання показників
              лічильника за попередній і розрахунковий місяці. Сума до оплати визначається добутком місячного обсягу
              споживання в розрізі блоків на відповідні тарифи згідно чинного законодавства. Оплата вноситься щомісячно
              до 10 числа, наступного за розрахунковим, місяця. З метою звірки розрахунків за електричну енергію
              Енергопостачальник має право вручити споживачу рахунок-повідомлення.<br/>
              <strong>16.3  За карткою передоплати.</strong><br/>
              Оплата електроенергії за допомогою картки попередньої оплати передбачає встановлення обліку електричної енергії з передоплатою.<br/>
              <strong>Сторони дійшли згоди, що оплата спожитої електричної енергії відповідно до показань приладу обліку
                  проводиться за діючими тарифами для населення згідно п. ______________ договору.</strong><br/>
              16.4 У разі несплати за спожиту електричну енергію у терміни, визначені договором,
              Споживачу нараховується пеня у розмірі та порядку,  визначеному діючим законодавством.<br/>
              16.5 Оплата здійснюється на поточний рахунок із спеціальним режимом використання.
              Енергопостачальник безплатно видає  споживачу  платіжні  документи  для  оплати  електричної  енергії.<br/>
              16.6 Споживач може проводити оплату за електроенергію через мережу платіжних терміналів,
              центрів самообслуговування  та корпоративний сайт компанії, що діє за адресою: www.oe.if.ua з
              використанням  платіжної картки будь-якого банку, попередньо зареєструвавшись там  чи скористатися
              сервісом на Вашому мобільному телефоні *135#, надавши показник лічильника з 20 по 01 число наступного місяця включно<br/>
              17. У разі отримання житлової субсидії на оплату електричної енергії розмір плати споживача за використану
              електричну енергію визначається відповідно до порядку призначення та надання населенню субсидій для
              відшкодування витрат на оплату житлово-комунальних послуг, придбання скрапленого газу, твердого та
              рідкого пічного побутового палива.<br/>
              18. У разі заборгованості, що існує на час укладення договору, та при виникненні заборгованості та
              неплатоспроможності боржника,  Споживач має право звернутися до Енергопостачальника з письмовою
              заявою для укладення графіку її погашення, що є невід’ємною частиною договору, та за умови обов'язкової оплати поточних платежів.
              Заборгованість станом на ________________ рік  становить __________ гривень, ________ кВт*год., показник ___________ .<br/>
          </td>
      </tr>
      <tr>
          <td colspan="2" align="center">
              <strong>Відповідальність сторін</strong>
          </td>
      </tr>
      <tr>
          <td colspan="2">
              19.  Енергопостачальник несе відповідальність:<br/>
              •	за шкоду, заподіяну Споживачу або його майну, в розмірі і порядку, визначених законодавством;<br/>
              •	у разі тимчасового припинення електропостачання з вини Енергопостачальника - у розмірі двократної
              вартості недовідпущеної споживачу електричної енергії;<br/>
              •	у разі відпуску Споживачу електричної енергії, параметри якості якої знаходяться поза межами
              показників, зазначених  у  договорі - сплачує  25 відсотків вартості такої енергії;<br/>
              •	у разі порушення прав Споживача (відмова в реалізації його прав, у наданні необхідної інформації,
              надання послуг, що за якістю не відповідають вимогам нормативно-технічних документів, ухилення від
              перевірки якості електричної енергії тощо).
              Енергопостачальник не несе відповідальності за тимчасове припинення постачання електричної
              енергії, відпуск електричної енергії, параметри якості якої не відповідають показникам,
              зазначеним у договорі, або за шкоду, заподіяну Споживачу, якщо доведе, що вони виникли
              не з його вини, а з вини Споживача або внаслідок дії обставин непереборної сили.<br/>
              20.  Споживач несе відповідальність за:<br/>
              •	прострочення внесення платежів за електричну енергію  в  т.ч.  порушення  умов  договору  про  погашення  заборгованості;<br/>
              •	порушення правил користування електричною енергією;<br/>
              •	ухилення від виконання або несвоєчасне виконання рішень і приписів Державної інспекції з енергетичного нагляду за режимами споживання електричної енергії<br/>
              •	розкрадання електричної енергії у разі самовільного підключення до електромереж і споживання
              її без  приладів обліку;<br/>
              •	пошкодження приладів обліку;<br/>
              •	розукомплектування та пошкодження об’єктів електроенергетики, розкрадання майна цих об’єктів;<br/>
              •	насильницькі дії, що перешкоджають посадовим особам Енергопостачальника виконувати свої службові обов’язки,
              в тому  числі за відмову надати доступ представникам Енергопостачальника до розрахункового приладу обліку,
              ввідного кабелю та електроустановок Споживача для обстеження.<br/>
          </td>
      </tr>
      <tr>
          <td colspan="2" align="center">
              <strong>Інші умови</strong>
          </td>
      </tr>
      <tr>
          <td colspan="2">
              21.  Взаємовідносини сторін, не врегульовані цим договором, регламентуються  законодавством.<br/>
              Споживач відповідно до Закону України «Про захист персональних даних» надає згоду публічному акціонерному товариству
              «Прикарпаттяобленерго» на обробку його персональних даних (прізвище, ім’я, по-батькові, ідентифікаційний код,
              серія та номер паспорта, ким та коли виданий паспорт,  дата народження,  склад  сім’ї, при наявності пільгового посвідчення
              його серія та номер, адреса проживання, електронна адреса, контактні номера телефонів для надання (отримання) різного роду
              повідомлень Споживачу, реєстрації, обслуговування в інформаційно-платіжній системі для населення (персональному кабінеті споживача),
              отримання інформаційно-кунсультативних послуг, зворотнього зв’язку, супутніх та інших послуг, пов’язаних з обробкою персональних даних
              документ, що підтверджує право власності на об'єкт Споживача) для проведення розрахунків за спожиту електричну енергію з метою забезпечення
              реалізації товариством адміністративно-правових та інших відносин, які вимагають обробки персональних даних.<br/>
              Персональні дані Споживача будуть внесені в базу даних «Побутові споживачі».<br/>
              22. Спори та розбіжності, що можуть виникнути під час користування електричною енергією, якщо вони не
              будуть узгоджені шляхом переговорів між сторонами, вирішуються в судовому порядку.<br/>
              23. Розбіжності з технічних питань під час виконання умов цього договору регулюються органами
              Держенергонагляду згідно з правилами користування електричною енергією, правилами улаштування
              електроустановок, правилами безпечної експлуатації електроустановок Споживача, правилами технічної експлуатації установок Споживача.<br/>
              24.  Розбіжності щодо застосування тарифів вирішуються НКРЕ.<br/>
              25. У разі порушення Енергопостачальником умов договору Споживач викликає представника
              Енергопостачальника для складання та підписання акта-претензії Споживача, в якому зазначаються терміни,
              види, показники порушень тощо (бланк типового акта-претензії надає Енергопостачальник). Акт-претензія
              складається Споживачем та представником Енергопостачальника і скріплюється їхніми підписами.
              У разі неприбуття представника Енергопостачальника у встановлений термін Споживач має право скласти
              акт-претензію у довільній формі. У разі відмови представника Енергопостачальника від підписання акт
              вважається дійсним, якщо його підписали не менше ніж три споживачі, або Споживач і виборна особа
              будинкового, вуличного, квартального чи іншого органу самоврядування.<br/>
              26. Акт-претензія Споживача подається Енергопостачальнику, який у десятиденний термін усуває недоліки
              або надає Споживачеві обгрунтовану відмову щодо задоволення його претензій. Енергопостачальник може
              відмовити в задоволенні претензій Споживача щодо відхилення показників якості електричної енергії від
              встановлених державними стандартами на підставі даних реєстраційних технічних засобів, атестованих і
              опломбованих територіальними органами Держстандарту.<br/>
          </td>
      </tr>
      <tr>
          <td colspan="2" align="center">
              <strong>Дії обставин непереборної сили</strong>
          </td>
      </tr>
      <tr>
          <td colspan="2">
              27. Енергопостачальник та Споживач не відповідають за невиконання умов договору, якщо це спричинено
              дією обставин непереборної сили. Факт дії обставин непереборної сили підтверджується відповідними документами.
          </td>
      </tr>
      <tr>
          <td colspan="2" align="center">
              <strong>Термін дії договору</strong>
          </td>
      </tr>
      <tr>
          <td colspan="2">
              28. Цей договір укладається на три роки, набирає чинності з дня його підписання та вважається продовженим щорічно,
              якщо за місяць до закінчення терміну його дії жодна із сторін не висловила наміру внести до нього зміни або доповнення.
              З дня набрання чинності даним договором всі укладені раніше договори (додаткові правочини) та домовленості щодо постачання електричної енергії Споживачу,
              якщо такі були, втрачають свою чинність.<br/>
              29. Договір може бути розірваний достроково у випадках: зміни Споживачем місця проживання та остаточного
              припинення користування електричною енергією, смерті Споживача.<br/>
              30.  Цей Договір складено у двох примірниках, один з них зберігається у Енергопостачальника, а другий у Споживача.<br/>
              31.  Споживач з Правилами користування електричною енергією для населення ознайомлений ___________________________.<br/>
              32.  Юридичні адреси сторін та їхні рахунки:<br/>
              <u>Енергопостачальник :  ПАТ “Прикарпаттяобленерго” філія “<%=rs.getString("rem_name")%> РЕМ”.</u><br/>
              Адреса, телефон :<u><%=rs.getString("rem_licality")%>  <%=rs.getString("contacts")%></u>.<br/>
              Номер поточного рахунку із спец.режимом  <u><%=rs.getString("rek_bank_with_spec")%></u>.<br/>
              Номер поточного рахунку для інших платежів  <u><%=rs.getString("rek_bank_withOut_spec")%></u>.<br/>
              Споживач: <u><%=rs.getString("full_name")%>,
                  <%=rs.getString("constitutive_documents")%>,
                  <%=rs.getString("customer_zipcode")%></u>.<br/>
              Адреса, телефон: <u><%=rs.getString("customer_telephone")%>, <%=rs.getString("customer_ray_center")%>,
              , <%=rs.getString("customer_adress_new")%></u>.<br/>
              Ідентифікаційний номер <u><%=rs.getString("bank_identification_number")%></u><br/>
              Електронна адреса _________________________________________________.<br/>
              Підпис Споживача про згоду отримувати від
              Енергопостачальника на електронну адресу рахунки на оплату за електроенергію та інші повідомлення   __________________.<br/>
              Сторони зобов'язуються своєчасно письмово сповіщати про всі зміни реквізитів (найменування організації, рахунки тощо).<br/>
          </td>
      </tr>
      <tr>
          <td align="left">
              <strong>Енергопостачальник</strong>
          </td>
          <td align="center">
              <strong>Споживач</strong>
          </td>
      </tr>
      <tr>
          <td align="left">
              Директор філії <u><%=rs.getString("Director")%></u>
              ______________<br/>
              "____"__________________________ 20__p.
          </td>
          <td align="center">
              <u><%=rs.getString("full_name")%></u>
              ______________<br/>
              "____"__________________________ 20__p.
          </td>
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
