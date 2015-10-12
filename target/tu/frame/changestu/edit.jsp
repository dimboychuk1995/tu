<%-- 
    Document   : edit
    Created on : 29 груд 2009, 16:10:12
    Author     : AsuSV
--%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<script type="text/javascript" src="../detailedview/checkform.js"></script>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="../../button/style.css"/>
        <link href="../../codebase/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="../../codebase/jquery-1.3.2.min.js"></script>
        <script type="text/javascript" src="../../codebase/jquery-ui-1.7.2.custom.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){

                $(".datepicker").datepicker();
                
                $(".multi_edit_new .multiedit_mul").click(function(){
                    $(this).next('.hide_list').toggle("blind");
                });

                $("h1").click(function(){
                    $(this).next('.block_l1').toggle("blind");
                }).hover(function(){
                    $(this).addClass("div_hover");
                },function(){
                    $(this).removeClass("div_hover");
                });
                $('.items').hover(function(){
                    $(this).addClass("div_hover");
                },function(){
                    $(this).removeClass("div_hover");
                });
                $('.items').click(function(){
                    var the_value = $(this).html();
                    var the_value_pre = $(this).parent().parent().parent().parent().children('.edit').attr("value");
                    $(this).parent().parent().parent().parent().children('.edit').attr("value",the_value_pre+the_value);
                    $(this).parent().parent().parent().parent().children('.hide_list').toggle("blind");
                });
            });
        </script>
        <style type="text/css" >
            .div_hover{
                background: #DD0000;
                border: #000;
            }
            .hide_list span{
                border: #0000FF;
            }
            .block{
                border-width: 4px;
                border-style: solid;
                border-color: #00FF00;
            }
            .items{
                padding: 0px;
                margin: 0px;
                border-width: 2px;
                border-style: solid;
                border-color: #0000FF;
                font-size: 12px;
            }
            h1{
                border-width: 2px;
                border-style: solid;
                border-color: #990000
            }
        </style>
    </head>
    <body>
        <a href="changestuxp.jsp?tu_id=-1"><h1>Вернутись до змін</h1></a>
        <html:form action="/frame/changestu/changestuxp" onsubmit="return checkFormChTC(this);" >
            <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
            <table border="0">
                <tr>
                    <td>Номер ТУ</td>
                    <td><html:select property="tu_id">
                            <html:option value="0"><strong>Виберіть ТУ</strong></html:option>
                            <html:optionsCollection name="ChangestuForm"
                                                    property="TCno_list"
                                                    label="name" value="id"/>
                        </html:select></td>
                </tr>
                <tr><td colspan="2"><hr></td></tr>
                <tr>
                    <td><bean:message key="Changestu.No_letter" /></td>
                    <td><html:text name="ChangestuForm" property="no_letter"/></td>
                </tr>
                <tr>
                    <td>Тип листа (правочина)</td>
                    <td><html:select property="type_letter">
                            <html:option value="0">Виберіть причину зміни</html:option>
                            <html:option value="1">Неукладений</html:option>
                            <html:option value="11">Неукладений(приєднання)</html:option>
                            <html:option value="2">Правочин з додатками</html:option>
                            <html:option value="3">Продовжений листом</html:option>
                            <html:option value="4">Продовжений по правочину</html:option>
                            <html:option value="5">Розірваний листом</html:option>
                            <html:option value="6">Розірваний по правочину</html:option>
                            <html:option value="12">Розірваний по правочину(приєднання)</html:option>
                            <html:option value="7">Змінений листом</html:option>
                            <html:option value="8">Змінений по правочину</html:option>
                            <html:option value="9">Лист відмова</html:option>
                            <html:option value="10">Лист попередження</html:option>
                            <html:option value="13">Лист про продовження строку приєднання</html:option>
                            <html:option value="14">Лист-звернення до власника земельної ділянки</html:option>
                            <html:option value="15">Додаткова угода про оплату нестандартного приєднання</html:option>
                            <html:option value="16">Лист-відмова у стандартному приєднанні</html:option>
                        </html:select> </td>
                </tr>
                <tr>
                    <td>Вхідний номер</td>
                    <td><html:text name="ChangestuForm" property="in_namber"/></td>
                </tr>
                <tr>
                    <td>Дата заяви</td>
                    <td><html:text name="ChangestuForm" property="send_date_lenner" styleClass="datepicker"/></td>
                </tr>
                <tr>
                    <td>Вихідний номер</td>
                    <td><html:text name="ChangestuForm" property="out_namber"/></td>
                </tr>
                <tr>
                    <td>Дата Відповіді</td>
                    <td><html:text name="ChangestuForm" property="change_date_tc" styleClass="datepicker"/></td>

                </tr>
                <tr><td colspan="2"><hr></td></tr>
                <tr>
                    <td><bean:message key="Changestu.Tc_continue_to" /></td>
                    <td><html:text name="ChangestuForm" property="tc_continue_to" styleClass="datepicker"/></td>
                </tr>
                <tr>
                    <td>Гранична дата оплати</td>
                    <td><html:text name="ChangestuForm" property="limit_date" styleClass="datepicker"/></td>
                </tr>
                <tr>
                    <td colspan="2"><bean:message key="Changestu.Description_change" />
                        <div class="multi_edit_new">
                            <html:textarea name="ChangestuForm" property="description_change"  cols="60" styleClass="edit dataobjects"/>
                            <img src="../../codebase/imgs/edit3.bmp" class="multiedit_mul"/>
                            <div  class="hide_list" style="background-color: #ffffff;display:none" >
                                <div class="block">
                                    <div class="block_l1">
                                        <div class="items" >Встановити прилади обліку електроенергії з функцією обмеження максимуму споживання потужності.</div>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </td>
                </tr>
            </table>
            <html:submit property="method" value="update" styleClass="button_save"/>
        </html:form>
    </body>
</html>
