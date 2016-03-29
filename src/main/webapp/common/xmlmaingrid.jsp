<%@ page contentType="text/xml;charset=UTF-8" language="java"%><?xml version="1.0" encoding="UTF-8"?>
<%-- 
    Document   : xmlmaingrid
    Created on : 8 груд 2009, 9:41:24
    Author     : AsuSV
--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.Connection"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.Statement" %>
<%  
    //HttpSession ses=request.getSession();
    //String db=(String)ses.getAttribute("db_name");
      String  db="TUWeb";
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/"+db);
    Connection c = ds.getConnection();
    Statement stmt = c.createStatement();
    ResultSet rs = stmt.executeQuery("{call dbo.TC}");
    ResultSetMetaData rsmd = rs.getMetaData();
    int numCols = rsmd.getColumnCount();
%>
<rows>
    <head>
    <column width="150" type="link" align="right" sort="str">Редагувати</column>
    <column width="50" type="ed" align="right" color="white" sort="str">Загальна інформація</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="50" type="ed" align="right" color="white" sort="str">Замовник</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">Дані про Обєкт</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ch" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ch" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ch" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">Орієнтовна вартість</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">ВТС</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">Технічні умови № Договір</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">Допуск</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">Зміни в ТУ</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">Проектування</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <column width="60" type="ro" align="right" color="white" sort="str">#cspan</column>
    <beforeInit>

    </beforeInit>
    <afterInit>
        <call command="attachHeader"><param>
            Ред,
            Рік вид,Дата подання заяв,
            Тип договору,Згідно основного договору,Дата/№ зввернення,Соц статус,Юридична назва Замовника,Прізвище І.П.,Установчий документ,Розрахунковий рахунок,МФО,Банк,Ідентифікаційний номерб,Адреса,
            Підстава видачі ТУ,Назва,Функціональне призначення,Прогнозований рік уведення обєкта в експлуатацію,Тип населеного пункту,Назва населеного пункту,Адреса,Розробник ТУ,Сума за ТУ,Дата оплати,№ТУ Договору,І-ша кат.,ІІ-ша кат.,ІІІ-ша кат.,Заявлена потужністькВт,В тому числі:для електронагрівних пристроїв,екологічної броні,аварійної броні,технологічної броні,
            Вартість обладнання грн.,Вартість робіт.грн,Всього,
            Номер ТУ,Вх. номер заявиканцелярії,Дата реєстрації,Дата передачі у філію,Дата повернення підписаного примірника з філії,
            Дата видачі Замовнику ТУ та договору,ОТЗ №,Реєстраційний номер договору,Термін дії Договору та ТУ,дата укладення договору,Термін підключення,Дата (план),Дата (факт),Стан договору,Виконання даних ТУ спільно з ТУ №,
            Дата допуску споживача,Дата підключення споживача,Виконавець робіт,Виконавець робіт,Виконавець робіт,Виконавець робіт,Виконавець робіт,Виконавець робіт,Виконавець робіт,Виконавець проекту до точки приєднання,
            № додаткового правочину (листа),Дата,ТУ продовжено до,Короткий опис,
            Виконавець,Дата початку,Дата завершення,Вартість виготовлення проекту грн.,Дата оплати,Вартість погодження ПКД грн.,Дата погодження</param></call>
        <call command="setSkin"><param>dhx_skyblue</param></call>
    </afterInit>
</head>
<%
     int  j=1;
     while (rs.next()){
%>
<row id="<%= Integer.toString(j++)%>">
    <cell><![CDATA[<link href="google.com">1</link>]]></cell>
        <%
    for(int i=1;i<=numCols;i++){
        %><cell><%= rs.getString(i)%></cell>
    <%}
    %></row><%
}
rs.close();
    %>
</rows>
