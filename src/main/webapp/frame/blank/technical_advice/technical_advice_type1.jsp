
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.*,java.text.NumberFormat"%>
<%  response.setHeader("Content-Disposition", "inline;filename=dod1.doc");
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
        String qry = "select \n" +
                "\tTC_V2.id,\n" +
                "\tcase \n" +
                "\t\twhen customer_soc_status in ('1','6') then 'Громадянин (ка)'\n" +
                "\t\twhen customer_soc_status in ('15','11') then 'Приватний підприємець'\n" +
                "\t\twhen customer_soc_status in ('8','9','13','10','7','12') then (select customer_post from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ")\n" +
                "\t\twhen customer_soc_status in ('19','20','2','3','4','5','14','16') then (select customer_post from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ")\n" +
                "\tend as customer_soc_status,\n" +
                "\n" +
                "\tcase \n" +
                "\t\twhen customer_soc_status in ('1','6') then ''\n" +
                "\t\twhen customer_soc_status in ('15','11') then (select juridical from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ") \n" +
                "\t\twhen customer_soc_status in ('8','9','13','10','7','12') then (select juridical from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ") \n" +
                "\t\twhen customer_soc_status in ('19','20','2','3','4','5','14','16') then \n" +
                "\t\t\t(select  (TUWeb.dbo.TC_LIST_customer_soc_status.name collate cyrillic_general_ci_as + ' ' + dbo.TC_V2.juridical) as customer_soc_status_and_uridical_name\n" +
                "\t\t\t\tfrom dbo.TC_V2 join TUWeb.dbo.TC_LIST_customer_soc_status on dbo.TC_V2.customer_soc_status = TUWeb.dbo.TC_LIST_customer_soc_status.id\n" +
                "\t\t\twhere TC_V2.id = " + request.getParameter("tu_id") + ")\n" +
                "\tend as customer_soc_status_and_uridical_name,\n" +
                "\n" +
                "\tcase \n" +
                "\t\twhen customer_soc_status in ('1','6') then (select f_name + ' ' + s_name + ' ' + t_name from dbo.TC_V2 where id = " + request.getParameter("tu_id") +")\n" +
                "\t\twhen customer_soc_status in ('15','11') then ''\n" +
                "\t\twhen customer_soc_status in ('8','9','13','10','7','12') then (select f_name + ' ' + s_name + ' ' + t_name from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ")\n" +
                "\t\twhen customer_soc_status in ('19','20','2','3','4','5','14','16') then (select f_name + ' ' + s_name + ' ' + t_name from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ")\n" +
                "\tend as customer_full_name,\n" +
                "\n" +
                "\tcase \n" +
                "\t\twhen cus.type = 3 then 'смт. '\n" +
                "\t\twhen cus.type = 1 then 'м. '\n" +
                "\t\twhen cus.type = 2 then 'с. '\n" +
                "\tend as customer_locality_type,\n" +
                "\n" +
                "\tcus.name as customer_locality,\n" +
                "\n" +
                "\tisnull('вул. ' + customer_adress, '') as customer_adress,\n" +
                "\n" +
                "\tTUWeb.dbo.rem.rem_name as rem_name,\n" +
                "\n" +
                "\t'п. ' + TUWeb.dbo.rem.director_dav as director_dav,\n" +
                "\n" +
                "\t'№ ' + number as number_rec,\n" +
                "\n" +
                "\tTUWeb.dbo.TC_LIST_customer_soc_status.name collate cyrillic_general_ci_as + ' ' + juridical + ' ' + (select f_name + ' ' + s_name + ' ' + t_name from dbo.TC_V2 where id = " + request.getParameter("tu_id") + ") \n" +
                "\t\t+ ' ' + '(' + isnull(object_name, '') + ')' as customer_name,\n" +
                "\n" +
                "\n" +
                "\tcase \n" +
                "\t\twhen ob.type = 3 then 'смт. '\n" +
                "\t\twhen ob.type = 1 then 'м. '\n" +
                "\t\twhen ob.type = 2 then 'с. '\n" +
                "\tend as customer_object_type,\n" +
                "\n" +
                "\tob.name as object_locality,\n" +
                "\n" +
                "\tisnull(object_adress, '') as object_adress\n" +
                "\t\n" +
                "from dbo.TC_V2 \n" +
                "\tjoin dbo.TC_LIST_locality cus on convert(varchar, cus.id) = convert(varchar, TC_V2.customer_locality)\n" +
                "\tjoin TUWeb.dbo.rem on TUWeb.dbo.rem.rem_id = TC_V2.department_id \n" +
                "\tjoin TUWeb.dbo.TC_LIST_customer_soc_status on TUWeb.dbo.TC_LIST_customer_soc_status.id = TC_V2.customer_soc_status\n" +
                "\tjoin dbo.TC_LIST_locality ob on convert(varchar, ob.id) = convert(varchar, TC_V2.name_locality)\n" +
                "where TC_V2.id = " + request.getParameter("tu_id");
        pstmt = c.prepareStatement(qry);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        System.out.println(qry);
        int numCdls = rsmd.getColumnCount();
        String tmp = "";
        int i = 1;
        int k = 2;
        rs.next();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
    <title>JSP Page</title>
    <jsp:include page="../word_page_format.jsp"/>

    <style type="text/css">
        td {
            font-size: 85%;
        }

        .par {
            margin-left: 20px;
        }

        .par2{
            margin-left: 30px;
        }

    </style>

</head>
<body>

    <div class="content">
        <table width="100%">
            <tr>
                <td colspan="2" align="center" style="font-size: 100%"><b>УКРАЇНА</b></td>
            </tr>
            <tr>
                <td colspan="2" align="center" style="font-size: 100%"><b>ПАТ «ПРИКАРПАТТЯОБЛЕНЕРГО»<br/><br/></b></td>
            </tr>
            <tr>
                <td>76014,  м. Івано-Франківськ, вул. Індустріальна,34<br/> тел. 2-05-27,  факс. 2-39-38 <br/> № _______________ від ________________2017 р. <br/> <br/>
                    Дійсні протягом <b>одного</b> року.<br/><br/>

                    Обов’язковий до виконання разом із технічними умовами для <br/>
                    площадок вимірювання з приєднаною потужністю <br/>
                    електроустановок 150 кВт і більше.
                </td>

                <td>
                    <b>
                        <%=rs.getString("customer_soc_status")%><br/>
                        <%=rs.getString("customer_soc_status_and_uridical_name")%><br/>
                        <%=rs.getString("customer_full_name")%><br/>
                        <%=rs.getString("customer_locality_type")%> <%=rs.getString("customer_locality")%><br/>
                        <%=rs.getString("customer_adress")%><br/><br/>

                        Директору філії<br/>
                        ПАТ «ПРИКАРПАТТЯОБЛЕНЕРГО» <br/>
                        <%=rs.getString("rem_name")%> РЕМ<br/>
                        <%=rs.getString("director_dav")%><br/>
                    </b>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center" style="font-size: 100%"><b>ТЕХНІЧНІ РЕКОМЕНДАЦІЇ <%=rs.getString("number_rec")%><br/></b></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><b>по улаштуванню локального устаткування збору та обробки даних (ЛУЗОД) або автоматизованої<br/>
                    системи комерційного обліку електричної енергії (АСКОЕ).<br/></b></td>
            </tr>
            <tr>
                <td colspan="2">1. Назва споживача: <b><%=rs.getString("customer_name")%></b></td>
            </tr>
            <tr>
                <td colspan="2">2. Адреса: <b><%=rs.getString("customer_object_type")%><%=rs.getString("object_locality")%><%=rs.getString("object_adress")%></b></td>
            </tr>
            <tr>
                <td colspan="2">3. Для улаштування ЛУЗОД або АСКОЕ необхідно:</td>
            </tr>
            <tr>
                <td colspan="2" class="par">
                    <p>
                        3.1.	 Розробити та погодити з ПАТ «Прикарпаттяобленерго» технічне завдання і проект на впровадження
                        ЛУЗОД або АСКОЕ підприємства згідно вимог діючої нормативно-технічної документації та державних стандартів України.<br/>
                        3.2.	 Встановити проектною документацією наступні технічні параметри для ЛУЗОД або АСКОЕ:<br/>
                    </p>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="par2">
                    •	тип розрахункового засобу обліку електричної енергії – обрати із списку рекомендованих ПАТ
                    «Прикарпаттяобленерго» для застосування в складі ЛУЗОД або АСКОЕ споживачів (рекомендований тип
                    лічильників – SL7000 фірми Itron, ZMD(ZMG) фірми Landis+Gyr Ltd або LZQJ-ХС фірми ЕМН);<br/>
                    •	перелік даних, що передаються до електропередавальної організації – щодобові показники лічильників на 0:00 год. (сумарні та по тарифам диференційованими за періодами часу в залежності від форми розрахунків за спожиту електроенергію), півгодинний графік споживання виражений в кВт/год окремо по кожні точці обліку;<br/>
                    •	протокол передачі даних – міжнародний стандарт DLMS (МЕК 62056), МЕК 61107, МЕК 1107;<br/>
                    •	формат представлення даних в електропередавальну організацію – формування та відправка файлів-макетів 30917, 30818 на електронну адресу сервера АСКОЕ електропередавальної організації. Структура макетів  стандартна, розроблена НДЦ України за участю ДП НЕК «Укренерго»;<br/>
                    •	забезпечити можливості прямого доступу сервером АСКОЕ ПАТ «Прикарпаттяобленерго» до первинної бази даних (ПБД) розрахункових засобів обліку;<br/>
                    •	включити до складу ЛУЗОД чи АСКОЕ всі існуючі точки обліку електроенергії;<br/>
                    •	за наявності на об’єкті двох або більше точок обліку із сумарною приєднаною потужністю понад   150 кВт необхідно передбачити об’єднання ЛУЗОД в АСКОЕ згідно п. 1.5.11 ПУЕ;<br/>
                    •	місця встановлення засобів обліку визначаються згідно з ПУЕ та проектними рішеннями у відповідності з п. 3.7 ПКЕЕ;<br/>
                    •	для забезпечення захисту від пошкоджень і несанкціонованого доступу до приладу(-ів) обліку встановити його (їх) у герметичній металевій (пластиковій) виносній шафі обліку;<br/>
                    •	місця установлення комунікаційного обладнання повинні забезпечувати робочі умови експлуатації зазначені в настанові з експлуатації або паспорті відповідного пристрою;<br/>
                    •	канали зв'язку, які будуть застосовуватись для обміну даними з ЛУЗОД або АСКОЕ споживача – Internet, GSM- канал, комутований канал зв’язку цифрової АТС з використанням оптоволоконних ліній, CDMA- канал,  Ethernet. Параметри каналів зв’язку визначити на етапі проектування виходячи із особливостей територіального розташування об’єкту автоматизації;<br/>
                    •	апаратний та програмний інтерфейс лічильників – RS232, RS485, оптопорт;<br/>
                    •	механічне перезавантаження комунікаційного обладнання;<br/>
                    •	граничні показники розсинхронізації часу – 0,5 секунди в добу;<br/>
                    •	автоматична синхронізація часу на приладах обліку із серверами точного часу;<br/>
                    •	алгоритм приведення даних вимірювань з лічильників до даних, що будуть використовуватися для проведення комерційних розрахунків – розрахунок технологічних втрат проводити згідно умов Договору на електропостачання підприємства, півгодинний графік споживання за добу формувати з урахуванням фактичного розрахункового коефіцієнта;<br/>
                    •	умови спільного використання ЛУЗОД – регламент прямого доступу сервером АСКОЕ ПАТ «Прикарпаттяобленерго» до ПБД розрахункових засобів обліку в період з 00:30 до 08:00 годин кожної доби. Періодичність надсилання макетів щодобово до 08:00.<br/>

                </td>
            </tr>
            <tr>
                <td colspan="2" class="par">
                    3.3.	 Встановити/замінити розрахункові засоби обліку електроенергії підприємства згідно проекту та відповідних розділів ПУЕ.<br/>
                    3.4.	 Для багатофункціональних електронних засобів обліку електроенергії, перед їх встановленням на розрахункові точки, повинна проводитись процедура первинного програмування (параметризації) згідно вимог пунктів 3.16 – 3.22 ПКЕЕ.<br/>
                    3.5.	 Виконати монтаж та інсталяцію технічних і програмних засоби ЛУЗОД або АСКОЕ згідно проекту.<br/>
                    3.6.	 Всі електричні кола приладу обліку електроенергії, лінії зв'язку ЛУЗОД або АСКОЕ, зборки затискачів у проводці до приладів обліку, вимірювальні трансформатори, що використовуються для розрахункових електролічильників, повинні бути забезпечені пристроями для пломбування і пломбуватися представниками ПАТ «Прикарпаттяобленерго».<br/>
                    3.7.	 Вимірювальні трансформатори  повинні бути повірені органами Держспоживстандарту і відповідати вимогам ПУЕ.<br/>
                    3.8.	 Ввести ЛУЗОД або АСКОЕ в дослідну експлуатацію з оформленням відповідного акту за підписом представника служби приладів обліку ПАТ «Прикарпаттяобленерго».<br/>
                    3.9.	 На етапі проведення дослідної експлуатації забезпечити безперебійну роботу ЛУЗОД або АСКОЕ, оперативно виявляти та усувати недоліки в роботі програмно-технічних засобів якщо такі виникнуть, перевіряти функціональну відповідність технічному завданню та проектним рішенням.<br/>
                    3.10.	 Провести метрологічну повірку ЛУЗОД або АСКОЕ. У випадку побудови АСКОЕ внести систему до реєстру Головних зразків АСКОЕ.<br/>
                    3.11.	 Ввести ЛУЗОД або АСКОЕ в промислову експлуатацію з оформленням відповідного акту за підписом представника служби приладів обліку ПАТ «Прикарпаттяобленерго».<br/>
                    3.12.	 Прийняте в промислову експлуатацію ЛУЗОД або АСКОЕ має використовуватися для проведення комерційних розрахунків за електроенергію.<br/>
                    3.13.	 Заключити договір на сервісне обслуговування ЛУЗОД або АСКОЕ з підрядною організацією, яка має дозвіл на виконання даних робіт.<br/>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    4.	Дані технічні рекомендації можуть бути скориговані в разі введення в дію нових нормативних документів або внесення змін в існуючі нормативні документи, які змінюють вимоги до ЛУЗОД або АСКОЕ (п. 3.10 ПКЕЕ).<br/>
                    5.	При невиконанні даних технічних рекомендацій, по закінченню терміну дії,  вони підлягають продовженню (зміні) на підставі звернення замовника.<br/><br/><br/><br/>
                </td>
            </tr>
            <tr>
                <td>
                    <b>
                        В. Гораль<br/>
                        Заступник технічного директора з<br/>
                        обліку електроенергії
                    </b>
                </td>
            </tr>
        </table>
    </div>

    <%} catch (SQLException e) {
        e.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    }
    %>
</body>
</html>
