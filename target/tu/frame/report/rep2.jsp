<%-- 
    Document   : rep2
    Created on : 13 трав 2010, 15:36:17
    Author     : AsuSV
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%
Date from = new Date();
Date till = new Date();
from.setMonth(till.getMonth()-1);
from.setDate(1);
till.setDate(1);
till.setMonth(from.getMonth()+1);
till.setDate(till.getDate()-1);
DateFormat df = new SimpleDateFormat("dd.MM.yyyy");
%>
<link href="report/style.css" type="text/css" rel="stylesheet" />

<div id="my" class="text" rep="1">
    <h3>Облік укладених договорів про надання доступу до електричних мереж та технічних умов за</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 1</button>
</div>
<div id="my" class="text" rep="2">
    <h3>Щоквартальний звіт по виданих технічних умовах</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 2</button>
</div>
<div id="my" class="text" rep="3">
    <h3>Інформація щодо кількості та вартості виданих технічних умов на приєднання по АТ"Прикарпаттяобленерго" всі РЕМ</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 3</button>
</div>
<div id="my" class="text" rep="31">
    <h3>Інформація щодо кількості та вартості виданих технічних умов на приєднання по АТ"Прикарпаттяобленерго" </h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 3.1</button>
</div>
<div id="my" class="text" rep="4">
    <h3>Інформація про кількість виданих технічних умов за період та з початку року наростаючим підсумком</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 4</button>
</div>
<div id="my" class="text" rep="5">
    <h3>Кількість виданих ТУ по філіях з початку ______ року та за ____________ місяць</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 5</button>
</div>
<div id="my" class="text" rep="6">
    <h3>Аналіз рознесення "Бази даних ТУ" за _______________ період</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 6</button>
</div>
<div id="my" class="text" rep="7">
    <h3>Загальна інформація про стан ТУ</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 7</button>
</div>
<div id="my" class="text" rep="8">
    <h3>Моніторинг якості надання послуг</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 8</button>
</div>
<div id="my" class="text" rep="9">
    <h3>Інформація щодо фактичних витрат з приєднання електроустановок</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 9</button>
</div>    
<div id="my" class="text" rep="10">
    <h3>Отримані кошти за стандартне приєднання</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 10</button>
</div>    
<div id="my" class="text" rep="101">
    <h3>Отримані кошти за нестандартне приєднання</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 10.1</button>
</div>    
<div id="my" class="text" rep="11">
    <h3>Інформація про витрати згідно акту БМР</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 11</button>
</div>    
<div id="my" class="text" rep="111">
    <h3>Інформація про витрати згідно акту БМР(нестандартне)</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 11.1</button>
</div>       
<div id="my" class="text" rep="12">
    <h3>Перелік споживачів, з якими укладено договори про користування електричною енергією чи постачання електричної енергії(стандартне)</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 12</button>
</div>    
<div id="my" class="text" rep="13">
    <h3>Перелік споживачів, з якими укладено договори про користування електричною енергією чи постачання електричної енергії(нестандартне)</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 13</button>
</div>    
<div id="my" class="text" rep="14">
    <h3>Щомісячного звіт про оформлені допуски на підключення електроустановок споживачів(звіт для ДЕН)</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати звіт для ДЕН</button>
</div> 
<div id="my" class="text" rep="41">
    <h3>Інформація про кількість фактично наданих послуг  за період та з початку року наростаючим підсумком</h3>
    <strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="<%=df.format(from)%>">
    по <input type="text" name="do" class="datepicker TillDate"  value="<%=df.format(till)%>">
    <button type="button" class="create">Сформувати додаток 14</button>
</div>
<%--
<div id="my" class="text" rep="5">
    <h1></h1>
    <br><strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="01.07.2010">
    по <input type="text" name="do" class="datepicker TillDate"  value="30.07.2010">
    <button type="button" class="create">Сформувати додаток 5</button>
</div>
<div id="my" class="text" rep="6">
    <h3>Виконавці по ТУ за ________ місяць 20__ року (Діаграми)</h3>
    <br><strong>Період</strong>&nbsp;&nbsp;&nbsp;
    з  <input type="text" name="vid" class="datepicker FromDate"  value="01.07.2010">
    по <input type="text" name="do" class="datepicker TillDate"  value="30.07.2010">
    <button type="button" class="create">Сформувати додаток 6</button>
</div>--%>
