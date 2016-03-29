<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%  response.setHeader("Content-Disposition", "inline;filename=xls_all.xls");
    int year = Integer.parseInt((String) request.getParameter("selectYear"));
    String customer = request.getParameter("customer");
    String dataobjects = request.getParameter("dataobjects");
    String dataobjects2 = request.getParameter("dataobjects2");
    String tund = request.getParameter("tund");
    String admision = request.getParameter("admision");
    String supplychain = request.getParameter("supplychain");
    String pricejoin = request.getParameter("pricejoin");
    String vkb = request.getParameter("vkb");
    String change = request.getParameter("change");
    String admision2 = request.getParameter("admision2");
    String pricejoin_ns = request.getParameter("pricejoin_ns");
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    HttpSession ses = request.getSession();
    String db = new String();
    if (ses.getAttribute("db_name") != null) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb190");
    try {
        c = ds.getConnection();
        pstmt = c.prepareStatement("{call dbo.testXLS(?,?,?,?,?,?,?,?,?,?,?,?)}");
        pstmt.setString(1, customer);
        pstmt.setString(2, dataobjects);
        pstmt.setString(3, dataobjects2);
        pstmt.setString(4, tund);
        pstmt.setString(5, admision);
        pstmt.setString(6, supplychain);
        pstmt.setString(7, pricejoin);
        pstmt.setString(8, vkb);
        pstmt.setString(9, change);
        pstmt.setString(10, admision2);
        pstmt.setString(11, pricejoin_ns);
        pstmt.setInt(12, year);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();

%>
<table border="1">
    <thead>
        <tr>
            <%if (customer.equals("true")) {%><td rowspan="3" align="center" bgcolor="#CCCCCC">РЕМ</td><%}%>
            <%if (customer.equals("true")) {%><td colspan="16" align="center" bgcolor="#CCCCCC">Замовник</td><%}%>
            <%if (dataobjects.equals("true")) {%><td colspan="26" align="center" bgcolor="#CCCCCC">Дані про об'єкт</td><%}%>
            <%if (dataobjects2.equals("true")) {%><td colspan="8" align="center" bgcolor="#CCCCCC">Вимоги ТУ</td><%}%>
            <%if (tund.equals("true")) {%><td colspan="14" align="center" bgcolor="#CCCCCC">Технічні умови № Договір</td><%}%>
            <%if (admision.equals("true")) {%><td colspan="22" align="center" bgcolor="#CCCCCC">Допуск та проектування</td><%}%>
            <%if (supplychain.equals("true")) {%><td colspan="11" align="center" bgcolor="#CCCCCC">Схема приєднання</td><%}%>
            <%if (pricejoin.equals("true")) {%><td colspan="7" align="center" bgcolor="#CCCCCC">Плата за приєднання</td><%}%>
            <%if (vkb.equals("true")) {%><td colspan="27" align="center" bgcolor="#CCCCCC">Дані ВКБ</td><%}%>
            <%if (change.equals("true")) {%><td colspan="8" align="center" bgcolor="#CCCCCC">Журнал змін</td><%}%>
            <%if (admision2.equals("true")) {%><td colspan="15" align="center" bgcolor="#CCCCCC">Допуск та підключення</td><%}%>
            <%if (pricejoin_ns.equals("true")) {%><td colspan="10" align="center" bgcolor="#CCCCCC">Плата за нестандартне приєднання</td><%}%>
        </tr>
        <tr>
            <%if (customer.equals("true")) {%>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Соц. Статус</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Споживач</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Тип договору</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Тип договору</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Тип приєднання</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Ступінь приєднання</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата звернення (реєстрації в РЕМ)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">№ звернення (реєстрації в РЕМ)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Юрид. назва Замовника</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Прізвище І.П.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Установчий документ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Розрахунковий рахунок</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">МФО, Банк</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Ідентифікаційний номер</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Адреса</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Телефон</td>
            <%}%>
            <%if (dataobjects.equals("true")) {%>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Підстава видачі ТУ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Назва</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Адреса Об'єкта</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Розробник ТУ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Сума за ТУ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата оплати</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата введення в експлуатацію</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Географічні координати точки підключення</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Географічні координати точки забезпечення потужності</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Точка приєднання</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Точка забезпечення потужності</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">І-ша кат.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">ІІ-га кат.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">ІІІ-тя кат.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">І-ша кат. кВт.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">ІІ-га кат. кВт.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">ІІІ-тя кат. кВт.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Заявлена потужність кВт.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">електронагрівальних пристроїв</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">екологічної броні</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">аварійної броні</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">технологічної броні</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Номер опори</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Джерело Живлення</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Існуюча потужність</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Потужність будівельних струмоприймачів</td>
            <%}%>
            <%if (dataobjects2.equals("true")) {%>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">У електромережах до прогнозованої межі балансової належності</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Від межі балансової належності до електроустановок Замовника</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Розрахунковий облік електричної енергії</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вимоги до електромереж резервного живлення, в тому числі виділення відповідного електрообладнання на окремі резервні лінії живлення для збере-ження електропостачання цього електрообладнання у разі виникнення дефіциту потужності в об’єднаній енергосистемі</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Влаштування захисту від пошкоджень та обмеження дозволеної потужності</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вимоги до релейного захисту й автоматики, захисту від коротких замикань та перевантажень, компенсації струмів однофазного замикання в мережах з ізольованою шиною нейтралі тощо</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вимоги до телемеханіки та зв’язку</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Специфічні вимоги щодо живлення електроустановок Замовника, які стосуються резервного живлення, допустимості паралельної роботи елементів електричної мережі</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вимоги до ізоляції захисту від перенапруги</td>
            <%}%>
            <%if (tund.equals("true")) {%>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Номер Договору (ТУ)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вихідна дата реєстрації ТУ в РЕМ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вихідний номер РЕМ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата видачі Замовнику ТУ та договору</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата вхідної заяви у ВАТ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата передачі у РЕМ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата повернення підписаного примірника з РЕМ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">ОТЗ №</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Термін дії договору та ТУ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата укладення договору</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Закінчення договору.ТУ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Стан договору</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Виконання даних ТУ спільно з ТУ №</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Термін надання послуги з приєднання, днів</td>
            <%}%>
            <%if (admision.equals("true")) {%>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата допуску споживача</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата подання заявки</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата подання напруги</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата передачі акту прийому-здачі гол.інженеру</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата погодження гол.інж. акту прийому-здачі</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вартість демонтованого устаткування та обладнання, яке підлягає
                подальшому використання, грн.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата оплати за проект</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Номер проектного ТП після допуску</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Виконавець робіт по виконанню ТУ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Орієнтовна загальна вартість виконання ТУ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Виконавець</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата подання проекту на погодження</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата погодження</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вартість погодження ПКД грн.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата оплати за погодження ПКД</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вартість реконструкції будівництва ЛЕП, грн</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Капітальні витрати на будівництво (реконструкцію) підстанції, грн</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Фактичні витрати на будівництво (реконструкцію) підстанції, грн</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Тип проекту</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Проект повторного використання</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вартість розробки проекту, грн</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Пропозиції РЕМ з реконструкцією</td>
            <%}%>
            <%if (supplychain.equals("true")) {%>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Точка приєднання</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Клас напруги , кВ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Точка підключення</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Назва ЛЕП 0,4 (диспет. назва)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Підстанція ТП 10/0,4</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Тип джерела</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Назва ЛЕП 10кВ (диспет. назва)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Підстанція ПС 35/10 </td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Назва ЛЕП 35кВ (диспет. назва)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Підстанція 110/35/10</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Назва ЛЕП 110кВ (диспет. назва)</td>
            <%}%>
            <%if (pricejoin.equals("true")) {%>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вибір ставки плати за приєднання</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Ставка за приєднання</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вартість приєдання, грн</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата оплати плати за приєднання</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Термін виконання робіт по приєднанню</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вартість плати за нестандартне приєднання, тис. грн.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Сума оплати у випадку відмінності від вартості плати за приєднання, тис. грн.</td>
            <%}%>
            <%if (vkb.equals("true")) {%>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вид робіт</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Виконавець проекту</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата приймання проектних робіт</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вартість розробки проекту, грн.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Затверджена кошторисна вартість виконання проекту по відповідному об'єкту, грн.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Тип ЛЕП</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Довжина будівництва/реконструкції ЛЕП  0,4 кВ, км.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Довжина будівництва/реконструкції ЛЕП  10 (6) кВ, км</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Довжина будівництва/реконструкції ЛЕП  35 кВ, км</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Довжина будівництва/ реконструкції ЛЕП 110 кВ, км</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Необхідність будівництва (реконструкції, переоснащення, модернізації) ПС (ТП) напругою в кВ</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Виконавець будівельно-монтажних робіт</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата приймання БМР</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вартість будівництва згідно акту, грн</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вартість лічильника, грн</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата введення в експлуатацію</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Сума введення, грн</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Довжина збудованої ПЛ-0,4кВ,км</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Довжина збудованої КЛ-0,4кВ,км</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Потужність збудованих ТП, кВА</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Довжина збудованої ПЛ-10 кВ,км</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Кількість збудованих ТП, шт</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Довжина збудованої КЛ-10 кВ,км</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Cумісна підвіска проводу</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Додатковий провід</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Заміна проводу</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Заміна опор, шт.</td>
            <%}%>
            <%if (change.equals("true")) {%>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Номер додаткового правочину</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Тип листа (провочина)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вхідний номер</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата заяви</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Вихідний номер</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата Відповіді</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">ТУ продовжено до</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Короткий опис </td>
            <%}%>
            <%if (admision2.equals("true")) {%>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Номер договору про постачання (користування)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата допуску споживача</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата подання напруги</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Час закриття наряду на подачу напруги</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата завершення БМР</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата передачі акту прийому-здачі гол.інженеру</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата погодження гол.інж. акту прийому-здачі</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата видачі договору про постачання (користування)(основні)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата укладання договору про постачання (користування)(основні)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата підключення об’єкту(основні)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Потужність за договором про постачання користування, кВт (основні)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата видачі договору про постачання (користування)(будмайданчик)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата укладання договору про постачання (користування)(будмайданчик)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата підключення об’єкту(будмайданчик)</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Потужність за договором про постачання користування, кВт (будмайданчик)</td>
            <%}%>
            <%if (pricejoin_ns.equals("true")) {%>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Резерв приєднаної потужності на дату укдадання договору</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Дата оплати</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Сума оплати у випадку відмінності від вартості плати за приєднання, тис. грн.</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Резерв більший Рзам</td>
            <td align="center" bgcolor="#CCCCCC" rowspan="2">Резерв менший Рзам</td>
            <td align="center" bgcolor="#CCCCCC" colspan="2">Резерв більший Рзам</td>
            <td align="center" bgcolor="#CCCCCC" colspan="3">Резерв менший Рзам</td>
            <%}%>
        </tr>
        
        <tr>
            <%if (pricejoin_ns.equals("true")) {%>
            <td align="center" bgcolor="#CCCCCC">Плата за приєднання електроустановки Замовника, грн.</td>
            <td align="center" bgcolor="#CCCCCC">Сума оплати, грн</td>
            <td align="center" bgcolor="#CCCCCC">Питома вартість резерву приєднаної потужності, грн.</td>
            <td align="center" bgcolor="#CCCCCC">Плата за приєднання електроустановки Замовника, грн.</td>
            <td align="center" bgcolor="#CCCCCC">Сума оплати, грн</td>
        <%}%>
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