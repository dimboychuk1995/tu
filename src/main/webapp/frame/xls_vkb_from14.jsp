<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%  response.setHeader("Content-Disposition", "inline;filename=vkb_standartneFrom2015.xls");
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
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb190");
  try {
    c = ds.getConnection();
    if (request.getParameter("number") == null) {
      pstmt = c.prepareStatement("{call dbo.ZvitVKB_from14()}");
    } else {
      pstmt = c.prepareStatement("{call dbo.Find_Customer_excel(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
      pstmt.setString(1, (String) request.getParameter("number"));
      pstmt.setString(2, (String) request.getParameter("juridical"));
      pstmt.setString(3, (String) request.getParameter("f_name"));
      pstmt.setString(4, (String) request.getParameter("object_name"));
      pstmt.setString(5, (String) request.getParameter("name_locality"));
      pstmt.setString(6, (String) request.getParameter("object_adress"));
      pstmt.setString(7, (String) request.getParameter("request_power_from"));
      pstmt.setString(8, (String) request.getParameter("request_power_till"));
      pstmt.setString(9, (String) request.getParameter("develloper_company"));
      pstmt.setString(10, (String) request.getParameter("performer_proect_to_point"));
      pstmt.setString(11, (String) request.getParameter("performer_proect_after_point"));
      pstmt.setString(12, (String) request.getParameter("customer_type"));
      pstmt.setString(13, (String) request.getParameter("customer_soc_status"));
      pstmt.setString(14, (String) request.getParameter("initial_registration_date_rem_tu_from"));
      pstmt.setString(15, (String) request.getParameter("initial_registration_date_rem_tu_till"));
      pstmt.setString(16, (String) request.getParameter("date_admission_consumer_from"));
      pstmt.setString(17, (String) request.getParameter("date_admission_consumer_till"));
      pstmt.setString(18, (String) request.getParameter("date_contract_from"));
      pstmt.setString(19, (String) request.getParameter("date_contract_till"));
      pstmt.setString(20, (String) request.getParameter("ps_10_disp_name"));
      pstmt.setString(21, (String) request.getParameter("ps_35_disp_name"));
      pstmt.setString(22, (String) request.getParameter("fid_10_disp_name"));
      pstmt.setString(23, (String) request.getParameter("do1"));
      pstmt.setString(24, (String) request.getParameter("do2"));
      pstmt.setString(25, (String) request.getParameter("do3"));
    }
    rs = pstmt.executeQuery();
    rsmd = rs.getMetaData();
    int numCols = rsmd.getColumnCount();

%>
<%--=request.getParameter("number")%><%=request.getQueryString()--%>
<table width="100%" border="1" align="center">
<thead>
<tr>
<%--<td rowspan="3" width="43">№ п/п</td>--%>
<td rowspan="3" align="center" bgcolor="#CCCCCC">Назва філії</td>
<td align="center" bgcolor="#CCCCCC" colspan="2" rowspan="2">Договір про приєднання</td>
<td rowspan="3" align="center" bgcolor="#CCCCCC">Тип приєднання</td>
<td rowspan="3" align="center" bgcolor="#CCCCCC">Місцевість обєкта (міська/сільська)</td>
<td align="center" bgcolor="#CCCCCC" colspan="2" rowspan="2">Надходження    коштів за договором приєднання</td>
<td align="center" bgcolor="#CCCCCC" rowspan="3">Сума оплати у випадку відмінності від вартості плати за приєднання, тис. грн.</td>
<td align="center" bgcolor="#CCCCCC" colspan="2">Замовник/Споживач електричної енергії</td>
<td rowspan="3" align="center" bgcolor="#CCCCCC">Приєднана потужність, Pp, кВт</td>
<td rowspan="3" align="center" bgcolor="#CCCCCC">Рівень напруги в точці приєднання, кВ</td>
<td rowspan="3" align="center" bgcolor="#CCCCCC">Точка забезпечення потужності </td>
<td rowspan="3" align="center" bgcolor="#CCCCCC">Для приєднання замовника необхідно виконати</td>
<td align="center" bgcolor="#CCCCCC" colspan="4" rowspan="2">Інвентарні номера обєктів реконструкції (при влаштуванні вводу - номер ПЛ 0,4кВ)</td>
<td align="center" bgcolor="#CCCCCC" colspan="4">Проектні роботи</td>
<td align="center" bgcolor="#CCCCCC" colspan="6">Будівельно-монтажні роботи</td>
<td align="center" bgcolor="#CCCCCC" colspan="2" rowspan="2">Дата і година подання напруги</td>
<td align="center" bgcolor="#CCCCCC" colspan="9">Введення в експлуатацію</td>
<td rowspan="3" align="center" bgcolor="#CCCCCC">Балансова вартість демонтованого устаткування та обладнання, яке підлягає подальшому використанню, тис. грн.</td>
<td rowspan="3" align="center" bgcolor="#CCCCCC">Термін виконання робіт по приєднанню</td>
<td rowspan="3" align="center" bgcolor="#CCCCCC">Дата укладання договору про постачання (користування)(Основні ТУ)</td>
<td rowspan="3" align="center" bgcolor="#CCCCCC">Дата укладання договору про постачання (користування)(Будівельний майданчик)</td>
<td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Типовий проект</td>
<td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Дата приймання інших витрат</td>
<td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Інші витрати, грн.</td>
<td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Cумісна підвіска проводу</td>
<td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Додатковий провід</td>
<td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Заміна проводу</td>
<td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Тип ЛЕП</td>
<td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Довжина будівництва/реконструкції ЛЕП 0,4 кВ, км</td>
<td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Довжина будівництва/реконструкції ЛЕП 10(6) кВ, км</td><td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Тип лічильника</td><td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Заводський номер лічильника №</td><td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Існуюча потужність КВт</td><td rowspan="3" align="center" valign="middle"  bgcolor="#CCCCCC">Вимоги до розрахункового обліку електричної енергії</td>
</tr>
<tr>
<td rowspan="2" align="center" bgcolor="#CCCCCC">назва</td>
<td rowspan="2" align="center" bgcolor="#CCCCCC">місце знаходження обєкта</td>
<td rowspan="2" align="center" bgcolor="#CCCCCC">підрядник</td>
<td align="center" bgcolor="#CCCCCC" colspan="3">акт виконаних робіт</td>
<td rowspan="2" align="center" bgcolor="#CCCCCC">підрядник</td>
<td rowspan="2" align="center" bgcolor="#CCCCCC">Вартість згідно проеку</td>
<td align="center" bgcolor="#CCCCCC" colspan="4">акт виконаних робіт</td>
<td rowspan="2" align="center" bgcolor="#CCCCCC">№ акту</td>
<td rowspan="2" align="center" bgcolor="#CCCCCC">дата</td>
<td rowspan="2" align="center" bgcolor="#CCCCCC">сума</td>
<td align="center" bgcolor="#CCCCCC"colspan="4">ЛЕП, км</td>
<td align="center" bgcolor="#CCCCCC" colspan="2">Трансформатор</td>
</tr>
<tr>
<td align="center" bgcolor="#CCCCCC">номер</td>
<td align="center" bgcolor="#CCCCCC">дата</td>
<td align="center" bgcolor="#CCCCCC">сума,грн</td>
<td align="center" bgcolor="#CCCCCC">дата</td>
<td align="center" bgcolor="#CCCCCC">ТП-10/0,4кВ</td>
<td align="center" bgcolor="#CCCCCC">ПЛ-10кВ</td>
<td align="center" bgcolor="#CCCCCC">КЛ-0,4кВ </td>
<td align="center" bgcolor="#CCCCCC">ПЛ-0,4кВ</td>
<td align="center" bgcolor="#CCCCCC">№</td>
<td align="center" bgcolor="#CCCCCC">дата</td>
<td align="center" bgcolor="#CCCCCC">сума</td>
<td align="center" bgcolor="#CCCCCC">№</td>
<td align="center" bgcolor="#CCCCCC">дата</td>
<td align="center" bgcolor="#CCCCCC">сума</td>
<td align="center" bgcolor="#CCCCCC">вартість лічильника</td>
<td align="center" bgcolor="#CCCCCC">Година подання напруги</td>
<td align="center" bgcolor="#CCCCCC">Дата подання напруги</td>
<td align="center" bgcolor="#CCCCCC">КЛ-10кВ</td>
<td align="center" bgcolor="#CCCCCC">ПЛ-10кВ</td>
<td align="center" bgcolor="#CCCCCC">КЛ-0,4кВ</td>
<td align="center" bgcolor="#CCCCCC">ПЛ-0,4кВ</td>
<td align="center" bgcolor="#CCCCCC">шт</td>
<td align="center" bgcolor="#CCCCCC">потужність,кВА</td>
</tr>
</thead>
<% while (rs.next()) {
%><tr>
<%for (int i = 1; i <= numCols; i++) {%>

<td><%= rs.getString(i)%></td><%}%>
</tr><%}
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
