<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.Connection,java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>
<%
    HttpSession ses = request.getSession();
    String db = new String();
    if (!ses.getAttribute("db_name").equals(null)) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb190");
    Connection c = ds.getConnection();
    PreparedStatement pstmt;
    if (request.getParameter("number") == null) {
        pstmt = c.prepareStatement("{call dbo.TEST_EXEL_ALL()}");
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
    ResultSet rs = pstmt.executeQuery();
    ResultSetMetaData rsmd = rs.getMetaData();
    int numCols = rsmd.getColumnCount();

%>
<%--=request.getParameter("number")%><%=request.getQueryString()--%>
<table border="1">
    <thead>
        <tr>
            <td rowspan="2" align="center" bgcolor="#CCCCCC">РЕМ</td>
            <td colspan="15" align="center" bgcolor="#CCCCCC">Замовник</td>
            <td colspan="20" align="center" bgcolor="#CCCCCC">Дані про об'єкт</td>
            <td colspan="8" align="center" bgcolor="#CCCCCC">Вимоги ТУ</td>
            <td colspan="13" align="center" bgcolor="#CCCCCC">Технічні умови № Договір</td>
            <td colspan="9" align="center" bgcolor="#CCCCCC">Допуск та проектування</td>
            <td colspan="11" align="center" bgcolor="#CCCCCC">Схема приєднання</td>
            <td colspan="8" align="center" bgcolor="#CCCCCC">Журнал змін</td>
        </tr>
        <tr>
            <td align="center" bgcolor="#CCCCCC">Соц. Статус</td>
            <td align="center" bgcolor="#CCCCCC">Споживач</td>
            <td align="center" bgcolor="#CCCCCC">Тип договору</td>
            <td align="center" bgcolor="#CCCCCC">Тип договору</td>
            <td align="center" bgcolor="#CCCCCC">Вибір бланку договору/ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Дата звернення (реєстрації в РЕМ)</td>
            <td align="center" bgcolor="#CCCCCC">№ звернення (реєстрації в РЕМ)</td>
            <td align="center" bgcolor="#CCCCCC">Юрид. назва замовника</td>
            <td align="center" bgcolor="#CCCCCC">Прізвище І.П.</td>
            <td align="center" bgcolor="#CCCCCC">Установчий документ</td>
            <td align="center" bgcolor="#CCCCCC">Розрахунковий рахунок</td>
            <td align="center" bgcolor="#CCCCCC">МФО, Банк</td>
            <td align="center" bgcolor="#CCCCCC">Ідентифікаційний номер</td>
            <td align="center" bgcolor="#CCCCCC">Адреса</td>
            <td align="center" bgcolor="#CCCCCC">Телефон</td>
            <td align="center" bgcolor="#CCCCCC">Підстава видачі ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Назва</td>
            <%--<td align="center" bgcolor="#CCCCCC">Функціональне призначення</td>
            <td align="center" bgcolor="#CCCCCC">Прогнозований рік уведення об'єкта в експлуатацію</td>--%>
            <td align="center" bgcolor="#CCCCCC">Адреса Об'єкта</td>
            <td align="center" bgcolor="#CCCCCC">Розробник ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Сума за ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Дата оплати</td>
            <td align="center" bgcolor="#CCCCCC">Прогнозована межа балансової належності</td>
            <td align="center" bgcolor="#CCCCCC">І-ша кат.</td>
            <td align="center" bgcolor="#CCCCCC">ІІ-га кат.</td>
            <td align="center" bgcolor="#CCCCCC">ІІІ-тя кат.</td>
            <td align="center" bgcolor="#CCCCCC">І-ша кат. кВт.</td>
            <td align="center" bgcolor="#CCCCCC">ІІ-га кат. кВт.</td>
            <td align="center" bgcolor="#CCCCCC">ІІІ-тя кат. кВт.</td>
            <td align="center" bgcolor="#CCCCCC">Заявлена потужність кВт.</td>
            <td align="center" bgcolor="#CCCCCC">електронагрівальних пристроїв</td>
            <td align="center" bgcolor="#CCCCCC">екологічної броні</td>
            <td align="center" bgcolor="#CCCCCC">аварійної броні</td>
            <td align="center" bgcolor="#CCCCCC">технологічної броні</td>
            <td align="center" bgcolor="#CCCCCC">Номер опори</td>
            <td align="center" bgcolor="#CCCCCC">Джерело Живлення</td>
            <td align="center" bgcolor="#CCCCCC">У електромережах до прогнозованої межі балансової належності</td>
            <td align="center" bgcolor="#CCCCCC">Від межі балансової належності до електроустановок Замовника</td>
            <td align="center" bgcolor="#CCCCCC">Розрахунковий облік електричної енергії</td>
            <td align="center" bgcolor="#CCCCCC">Вимоги до електромереж резервного живлення, в тому числі виділення відповідного електрообладнання на окремі резервні лінії живлення для збере-ження електропостачання цього електрообладнання у разі виникнення дефіциту потужності в об’єднаній енергосистемі</td>
            <td align="center" bgcolor="#CCCCCC">Влаштування захисту від пошкоджень та обмеження дозволеної потужності</td>
            <td align="center" bgcolor="#CCCCCC">Вимоги до релейного захисту й автоматики, захисту від коротких замикань та перевантажень, компенсації струмів однофазного замикання в мережах з ізольованою шиною нейтралі тощо</td>
            <td align="center" bgcolor="#CCCCCC">Вимоги до телемеханіки та зв’язку</td>
            <td align="center" bgcolor="#CCCCCC">Специфічні вимоги щодо живлення електроустановок замовника, які стосуються резервного живлення, допустимості паралельної роботи елементів електричної мережі</td>
            <td align="center" bgcolor="#CCCCCC">Номер Договору (ТУ)</td>
            <td align="center" bgcolor="#CCCCCC">Вихідна дата реєстрації ТУ в РЕМ</td>
            <td align="center" bgcolor="#CCCCCC">Вихідний номер РЕМ</td>
            <td align="center" bgcolor="#CCCCCC">Дата видачі замовнику ТУ та договору</td>
            <td align="center" bgcolor="#CCCCCC">Дата вхідної заяви у ВАТ</td>
            <td align="center" bgcolor="#CCCCCC">Дата передачі у РЕМ</td>
            <td align="center" bgcolor="#CCCCCC">Дата повернення підписаного примірника з РЕМ</td>
            <td align="center" bgcolor="#CCCCCC">ОТЗ №</td>
            <td align="center" bgcolor="#CCCCCC">Термін дії договору та ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Дата укладення договору</td>
            <td align="center" bgcolor="#CCCCCC">Закінчення договору.ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Стан договору</td>
            <%--<td align="center" bgcolor="#CCCCCC">Дата документу</td>--%>
            <td align="center" bgcolor="#CCCCCC">Виконання даних ТУ спільно з ТУ №</td>
            <%--<td align="center" bgcolor="#CCCCCC">Плата за приеднання</td>--%>
            <td align="center" bgcolor="#CCCCCC">Дата допуску споживача</td>
            <td align="center" bgcolor="#CCCCCC">Вартість розробки проекту</td>
            <td align="center" bgcolor="#CCCCCC">Дата оплати за проект</td>
            <!--td align="center" bgcolor="#CCCCCC">Вартість проекту</td-->
            <%--<td align="center" bgcolor="#CCCCCC">Дата підключення споживача</td>--%>
            <td align="center" bgcolor="#CCCCCC">Номер проектного ТП після допуску</td>
            <%--<td align="center" bgcolor="#CCCCCC">Вартість підключення</td>--%>
            <%--<td align="center" bgcolor="#CCCCCC">Виконавець проету до точки приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Орієнтовна вартість виконання ТУ до точки приєднання</td>--%>
            <td align="center" bgcolor="#CCCCCC">Виконавець робіт по виконанню ТУ</td>
            <%--<td align="center" bgcolor="#CCCCCC">Орієнтовна вартість виконання ТУ після точки приєднання</td>--%>
            <td align="center" bgcolor="#CCCCCC">Орієнтовна загальна вартість виконання ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Виконавець</td>
            <%--<td align="center" bgcolor="#CCCCCC">Дата початку</td>
            <td align="center" bgcolor="#CCCCCC">Дата завершення</td>
            <td align="center" bgcolor="#CCCCCC">Вартість виготовлення проекту</td>
            <td align="center" bgcolor="#CCCCCC">Дата оплати</td>
            <td align="center" bgcolor="#CCCCCC">Вартість погодження ПКД</td>
            <td align="center" bgcolor="#CCCCCC">Дата оплати</td>--%>
            <td align="center" bgcolor="#CCCCCC">Дата погодження</td>
            <td align="center" bgcolor="#CCCCCC">Вартість погодження ПКД грн.</td>
            <td align="center" bgcolor="#CCCCCC">Дата оплати за погодження ПКД</td>
            <td align="center" bgcolor="#CCCCCC">Точка приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Клас напруги , кВ</td>
            <%--<td align="center" bgcolor="#CCCCCC">Стан</td>--%>
            <td align="center" bgcolor="#CCCCCC">Точка підключення</td>
            <%--<td align="center" bgcolor="#CCCCCC">Автономне джерело</td>--%>
            <td align="center" bgcolor="#CCCCCC">Назва ЛЕП 0,4 (диспет. назва)</td>
            <td align="center" bgcolor="#CCCCCC">Підстанція ТП 10/0,4</td>
            <td align="center" bgcolor="#CCCCCC">Тип джерела</td>
            <td align="center" bgcolor="#CCCCCC">Назва ЛЕП 10кВ (диспет. назва)</td>
            <td align="center" bgcolor="#CCCCCC">Підстанція ПС 35/10 </td>
            <td align="center" bgcolor="#CCCCCC">Назва ЛЕП 35кВ (диспет. назва)</td>
            <td align="center" bgcolor="#CCCCCC">Підстанція 110/35/10</td>
            <td align="center" bgcolor="#CCCCCC">Назва ЛЕП 110кВ (диспет. назва)</td>

            <td align="center" bgcolor="#CCCCCC">Номер додаткового правочину</td>
            <td align="center" bgcolor="#CCCCCC">Тип листа (провочина)</td>
            <td align="center" bgcolor="#CCCCCC">Вхідний номер</td>
            <td align="center" bgcolor="#CCCCCC">Дата заяви</td>
            <td align="center" bgcolor="#CCCCCC">Вихідний номер</td>
            <td align="center" bgcolor="#CCCCCC">Дата Відповіді</td>
            <td align="center" bgcolor="#CCCCCC">ТУ продовжено до</td>
            <td align="center" bgcolor="#CCCCCC">Короткий опис </td>

        </tr>
    </thead>
    <% while (rs.next()) {
    %><tr>

        <%for (int i = 1; i <= numCols; i++) {%>
        <td><%= rs.getString(i)%></td><%}%>
    </tr><%}

        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();

    %>*/
</table>
