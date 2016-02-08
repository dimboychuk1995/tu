<%--
  Created by IntelliJ IDEA.
  User: us9522
  Date: 04.02.2016
  Time: 10:42
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
    String qry = "SELECT TOP 1" +
      "ISNULL(TUWeb.dbo.rem.Director,'') AS Director," +
      "ISNULL(TUWeb.dbo.rem.contacts,'') AS contacts," +
      "ISNULL(TUWeb.dbo.rem.rem_licality,'') AS rem_licality," +
      "ISNULL(TUWeb.dbo.rem.dovirenist,'') AS dovirenist," +
      "ISNULL(TUWeb.dbo.rem.rek_bank_withOut_spec,'') AS rek_bank_withOut_spec," +
      "ISNULL(TUWeb.dbo.rem.rek_bank_with_spec,'') AS rek_bank_with_spec," +
      "ISNULL(TUWeb.dbo.rem.city_town_village, '') AS city_town_village," +
      "ISNULL(dbo.TC_V2.id,'') AS id," +
      "ISNULL(TC_V2.[f_name],'')+' '+isnull(TC_V2.[s_name],'')+' '+isnull(TC_V2.[t_name],'') AS full_name," +
      "ISNULL(dbo.TC_V2.name_locality,'') AS name_locality," +
      "ISNULL(dbo.TC_V2.object_adress,'') AS object_adress," +
      "ISNULL(CONVERT(VARCHAR,dbo.TC_V2.request_power,104),'') AS request_power," +
      "CASE WHEN TC_V2.reliabylity_class_3_val IS NOT NULL THEN 'третя категорія надійності'" +
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
      "END AS amperage," +
      "        ISNULL(dbo.TC_V2.connection_treaty_number,'') AS connection_treaty_number," +
      "ISNULL(dbo.TC_V2.constitutive_documents,'') AS constitutive_documents," +
      "ISNULL(dbo.TC_V2.bank_identification_number,'') AS bank_identification_number," +
      "ISNULL(dbo.TC_V2.customer_locality,'') AS customer_locality," +
      "ISNULL(dbo.TC_V2.customer_adress,'') AS customer_adress," +
      "ISNULL(dbo.TC_V2.customer_telephone,'') AS customer_telephone," +
      " ISNULL(dbo.TC_V2.customer_zipcode,'') AS customer_zipcode" +

      " FROM TUWeb.dbo.rem, TUWeb190.dbo.TC_V2" +
            " where TC_V2.id=" + request.getParameter("tu_id");
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
<p align="right"><SPAN lang="UK"></SPAN></p>
<p align="center"><strong>Договір про користування електричною енергією №</strong></p>
    <table width="100%">
      <tr>
        <td align="left" width="50%">Some text</td>
        <td align="left" width="50%">
          <table width="100%">
            <tr>
              <td align="left"><%=rs.getString("city_town_village")%></td>
              <td align="right">"___"________20__p.</td>
            </tr>
            <tr>
              <td colspan="2"><%=rs.getString("full_name")%>, об'єкт якого розташований за
                адресою <%=rs.getString("customer_locality")%> <%=rs.getString("customer_adress")%>, далі іменується
                Споживач, з однієї сторони та ПАТ "Прикарпаттяобленерго", в особі директора філії _____________РЕМ
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
                (цінами) у терміни, передбачені цим договором.<br>
                2. Категорія надійності струмоприймачів Споживача <u><%=rs.getString("kategory")%></u>.<br>
                3. Параметри якості електричної енергії повинні відповідати державним стандартам.<br>
                4. Встановлені запобіжники чи запобіжні автомати типу <u> AB</u>, на напругу <u><%=rs.getString("voltage")%></u>В, струм <u><%=rs.getString("amperage")%></u>А .<br>
                5. Номер однофазного (трифазного) приладу обліку _________________________________ , дата повірки ____________________ .
                Показники приладу обліку на момент укладення договору ___________________.
                  При заміні приладу обліку  або пломб на ньому, складається відповідний документ,
                який підписується Споживачем, та в якому вказується характер проведених робіт.
                Схема підключення однофазного (трифазного) електролічильника перевірена при укладенні цього договору і відповідає вимогам ПУЕ.<br>
                6.Наявність трифазного електрообладнання дозволено для застосування: ________________________________________________.<br>
                7. Приміщення Споживача обладнані:
                стаціонарною електроплитою _____________________________________________________________________________________<br>
                8. Межа розподілу встановлюється: <%=rs.getString("connection_treaty_number")%><br>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="center"><strong>Права та обов'язки Споживача</strong></td>
            </tr>
            <tr>
              <td colspan="2">
                9. Споживач має право на:<br>
                •	вибір постачальника електричної енергії;<br>
                •	підключення до електромережі за умови дотримання правил користування електричною енергією;<br>
                •	отримання інформації щодо якості електричної енергії, тарифів (цін), порядку оплати, умов та режимів її споживання;<br>
                •	отримання електричної енергії, якісні характеристики якої визначені державними стандартами;<br>
                •	відшкодування згідно із законодавством збитків, заподіяних внаслідок порушення його прав;<br>
                •	якісне обслуговування електричних мереж, розрахункових приладів обліку.<br>
                Відповідно до статті 8 Закону України «Про захист персональних даних» Споживач має право:<br>
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
                знати механізм автоматичної обробки персональних даних; на захист від автоматизованого рішення, яке має для нього правові наслідки.<br>
                10. Споживач електричної енергії зобов’язується:<br>
                •	дотримуватися вимог нормативно-технічних документів та договору про користування електричною енергією;<br>
                •	забезпечувати належний технічний стан та безпечну експлуатацію своїх внутрішніх електромереж, електроустановок та побутових електроприладів;<br>
                •	забезпечувати збереження приладів обліку і пломб на них у разі розміщення приладу обліку у квартирі, або на іншому об’єкті Споживача;ф<br>
                •	невідкладно повідомляти Енергопостачальника про недоліки в роботі приладу обліку;<br>
                •	оплачувати електроенергію відповідно до умов договору;<br>
                •	вносити оплату за спожиту електричну енергію виключно на поточний рахунок зі спеціальним режимом використання в уповноваженому банку;<br>
              </td>
            </tr>
          </table>
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
