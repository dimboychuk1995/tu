<%@page import="ua.ifr.oe.tc.list.SQLUtils" %>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource,java.sql.*" %>
<%@ page import="com.myapp.struts.loginActionForm" %>
<% response.setHeader("Content-Disposition", "inline;filename=xls.xls");
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
        pstmt = c.prepareStatement("{call dbo.TC_Short_XP_datail()}");
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();

%>
<%--=request.getParameter("number")%><%=request.getQueryString()--%>
<!DOCTYPE html>
<table border="1">
    <thead>
        <tr>
            <td rowspan="2" align="center" bgcolor="#CCCCCC">РЕМ</td>
            <td colspan="15" align="center" bgcolor="#CCCCCC">Замовник</td>
            <td colspan="24" align="center" bgcolor="#CCCCCC">Дані про об'єкт</td>
            <td colspan="8" align="center" bgcolor="#CCCCCC">Вимоги ТУ</td>
            <td colspan="13" align="center" bgcolor="#CCCCCC">Технічні умови № Договір</td>
            <td colspan="16" align="center" bgcolor="#CCCCCC">Допуск та проектування</td>
            <td colspan="11" align="center" bgcolor="#CCCCCC">Схема приєднання</td>
            <td colspan="7" align="center" bgcolor="#CCCCCC">Плата за приєднання</td>
            <td colspan="8" align="center" bgcolor="#CCCCCC">Журнал змін</td>
            <td colspan="23" align="center" bgcolor="#CCCCCC">Дані ВКБ</td>
        </tr>
        <tr>
            <td align="center" bgcolor="#CCCCCC">Соц. Статус</td>
            <td align="center" bgcolor="#CCCCCC">Споживач</td>
            <td align="center" bgcolor="#CCCCCC">Тип договору</td>
            <td align="center" bgcolor="#CCCCCC">Тип договору</td>
            <td align="center" bgcolor="#CCCCCC">Тип приєднання</td>
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
            <td align="center" bgcolor="#CCCCCC">Адреса Об'єкта</td>
            <td align="center" bgcolor="#CCCCCC">Розробник ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Сума за ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Дата оплати</td>
            <td align="center" bgcolor="#CCCCCC">Дата введення в експлуатацію</td>
            <td align="center" bgcolor="#CCCCCC">Географічні координати точки підключення</td>
            <td align="center" bgcolor="#CCCCCC">Географічні координати точки забезпечення потужності</td>
            <td align="center" bgcolor="#CCCCCC">Точка приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Точка забезпечення потужності</td>
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
            <td align="center" bgcolor="#CCCCCC">Вимоги до електромереж резервного живлення, в тому числі виділення
                відповідного електрообладнання на окремі резервні лінії живлення для збере-ження електропостачання цього
                електрообладнання у разі виникнення дефіциту потужності в об’єднаній енергосистемі
            </td>
            <td align="center" bgcolor="#CCCCCC">Влаштування захисту від пошкоджень та обмеження дозволеної потужності
            </td>
            <td align="center" bgcolor="#CCCCCC">Вимоги до релейного захисту й автоматики, захисту від коротких замикань
                та перевантажень, компенсації струмів однофазного замикання в мережах з ізольованою шиною нейтралі тощо
            </td>
            <td align="center" bgcolor="#CCCCCC">Вимоги до телемеханіки та зв’язку</td>
            <td align="center" bgcolor="#CCCCCC">Специфічні вимоги щодо живлення електроустановок замовника, які
                стосуються резервного живлення, допустимості паралельної роботи елементів електричної мережі
            </td>
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
            <td align="center" bgcolor="#CCCCCC">Виконання даних ТУ спільно з ТУ №</td>
            <td align="center" bgcolor="#CCCCCC">Дата допуску споживача</td>
            <td align="center" bgcolor="#CCCCCC">Дата подання заявки</td>
            <td align="center" bgcolor="#CCCCCC">Дата подання напруги</td>
            <td align="center" bgcolor="#CCCCCC">Дата передачі акту прийому-здачі гол.інженеру</td>
            <td align="center" bgcolor="#CCCCCC">Дата погодження гол.інж. акту прийому-здачі</td>
            <!--<td align="center" bgcolor="#CCCCCC">Вартість виконання ТУ згідно з акту виконаних робіт, грн.</td>-->
            <!--            <td align="center" bgcolor="#CCCCCC">Вартість проектних робіт згідно АВР, грн</td>
                        <td align="center" bgcolor="#CCCCCC">Вартість будівельно-монтажних робіт згідно АВР, грн</td>
                        <td align="center" bgcolor="#CCCCCC">Вартість приладу обліку згідно АВР, грн</td>-->
            <td align="center" bgcolor="#CCCCCC">Вартість демонтованого устаткування та обладнання, яке підлягає
                подальшому використання, грн.
            </td>
            <!--<td align="center" bgcolor="#CCCCCC">Вартість розробки проекту</td>-->
            <td align="center" bgcolor="#CCCCCC">Дата оплати за проект</td>
            <td align="center" bgcolor="#CCCCCC">Вартість розробки проекту, грн.</td>
            <td align="center" bgcolor="#CCCCCC">Номер проектного ТП після допуску</td>
            <td align="center" bgcolor="#CCCCCC">Виконавець робіт по виконанню ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Орієнтовна загальна вартість виконання ТУ</td>
            <td align="center" bgcolor="#CCCCCC">Виконавець</td>
            <td align="center" bgcolor="#CCCCCC">Дата подання проекту на погодження</td>
            <td align="center" bgcolor="#CCCCCC">Дата погодження</td>
            <td align="center" bgcolor="#CCCCCC">Вартість погодження ПКД грн.</td>
            <td align="center" bgcolor="#CCCCCC">Дата оплати за погодження ПКД</td>
            <td align="center" bgcolor="#CCCCCC">Точка приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Клас напруги , кВ</td>
            <td align="center" bgcolor="#CCCCCC">Точка підключення</td>
            <td align="center" bgcolor="#CCCCCC">Назва ЛЕП 0,4 (диспет. назва)</td>
            <td align="center" bgcolor="#CCCCCC">Підстанція ТП 10/0,4</td>
            <td align="center" bgcolor="#CCCCCC">Тип джерела</td>
            <td align="center" bgcolor="#CCCCCC">Назва ЛЕП 10кВ (диспет. назва)</td>
            <td align="center" bgcolor="#CCCCCC">Підстанція ПС 35/10</td>
            <td align="center" bgcolor="#CCCCCC">Назва ЛЕП 35кВ (диспет. назва)</td>
            <td align="center" bgcolor="#CCCCCC">Підстанція 110/35/10</td>
            <td align="center" bgcolor="#CCCCCC">Назва ЛЕП 110кВ (диспет. назва)</td>
            <td align="center" bgcolor="#CCCCCC">Вибір ставки плати за приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Ставка за приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Вартість приєдання, грн</td>
            <td align="center" bgcolor="#CCCCCC">Дата оплати плати за приєднання</td>
            <td align="center" bgcolor="#CCCCCC">Термін виконання робіт по приєднанню</td>
            <td align="center" bgcolor="#CCCCCC">Вартість плати за нестандартне приєднання, тис. грн.</td>
            <td align="center" bgcolor="#CCCCCC">Сума оплати у випадку відмінності від вартості плати за приєднання,
                тис. грн.
            </td>
            <td align="center" bgcolor="#CCCCCC">Номер додаткового правочину</td>
            <td align="center" bgcolor="#CCCCCC">Тип листа (провочина)</td>
            <td align="center" bgcolor="#CCCCCC">Вхідний номер</td>
            <td align="center" bgcolor="#CCCCCC">Дата заяви</td>
            <td align="center" bgcolor="#CCCCCC">Вихідний номер</td>
            <td align="center" bgcolor="#CCCCCC">Дата Відповіді</td>
            <td align="center" bgcolor="#CCCCCC">ТУ продовжено до</td>
            <td align="center" bgcolor="#CCCCCC">Короткий опис</td>
            <td align="center" bgcolor="#CCCCCC">Вид робіт</td>
            <td align="center" bgcolor="#CCCCCC">Виконавець проекту</td>
            <td align="center" bgcolor="#CCCCCC">Дата приймання проектних робіт</td>
            <td align="center" bgcolor="#CCCCCC">Вартість розробки проекту, грн.</td>
            <td align="center" bgcolor="#CCCCCC">Затверджена кошторисна вартість виконання проекту по відповідному
                об'єкту, грн.
            </td>
            <td align="center" bgcolor="#CCCCCC">Тип ЛЕП</td>
            <td align="center" bgcolor="#CCCCCC">Довжина будівництва/реконструкції ЛЕП 0,4 кВ, км.</td>
            <td align="center" bgcolor="#CCCCCC">Довжина будівництва/реконструкції ЛЕП 10 (6) кВ, км</td>
            <td align="center" bgcolor="#CCCCCC">Довжина будівництва/реконструкції ЛЕП 35 кВ, км</td>
            <td align="center" bgcolor="#CCCCCC">Довжина будівництва/ реконструкції ЛЕП 110 кВ, км</td>
            <td align="center" bgcolor="#CCCCCC">Необхідність будівництва (реконструкції, переоснащення, модернізації)
                ПС (ТП) напругою в кВ
            </td>
            <td align="center" bgcolor="#CCCCCC">Виконавець будівельно-монтажних робіт</td>
            <td align="center" bgcolor="#CCCCCC">Дата приймання БМР</td>
            <td align="center" bgcolor="#CCCCCC">Вартість будівництва згідно акту, грн</td>
            <td align="center" bgcolor="#CCCCCC">Вартість лічильника, грн</td>
            <td align="center" bgcolor="#CCCCCC">Дата введення в експлуатацію</td>
            <td align="center" bgcolor="#CCCCCC">Сума введення, грн</td>
            <td align="center" bgcolor="#CCCCCC">Довжина збудованої ПЛ-0,4кВ,км</td>
            <td align="center" bgcolor="#CCCCCC">Довжина збудованої КЛ-0,4кВ,км</td>
            <td align="center" bgcolor="#CCCCCC">Потужність збудованих ТП, кВА</td>
            <td align="center" bgcolor="#CCCCCC">Довжина збудованої ПЛ-10 кВ,км</td>
            <td align="center" bgcolor="#CCCCCC">Кількість збудованих ТП, шт</td>
            <td align="center" bgcolor="#CCCCCC">Довжина збудованої КЛ-10 кВ,км</td>
        </tr>
    </thead>
    <% while (rs.next()) {
    %>
    <tr>
        <td><%
            loginActionForm login = (loginActionForm) ses.getAttribute("log");
            String name_rem = login.getRem_name();
        %> <%= name_rem%> РЕМ
        </td>
        <%for (int i = 1; i <= numCols; i++) {%>
        <td><%= rs.getString(i)%></td><%}%>
    </tr>
    <%
            }
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