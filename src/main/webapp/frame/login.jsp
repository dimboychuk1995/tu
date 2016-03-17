<%-- 
    Document   : login
    Created on : 25 січ 2010, 12:22:25
    Author     : AsuSV
--%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <!--[IF IE]>
            <script type="text/javascript">
                alert('Рекомендовано використовувати інший браузер (наприклад Chrome, Firefox)!');
            </script>
        <![endif]-->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="../css/login.css" rel="stylesheet" type="text/css">
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="../js/bootstrap.min.js"></script>
    </head>

    <body>
    <%--<script type="text/javascript">--%>
        <%--$(document).ready(function(){--%>
            <%--$('#lang').on('change', function(){--%>
                <%--$('.button_holder').children().eq(0).removeAttr('disabled');--%>
            <%--});--%>
        <%--});--%>
    <%--</script>--%>
    <div id="element-box" class="login">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h1>Вхід в програму технічні умови </h1>
                </div>
                <div class="col-md-4">
                    <p class="message">
                        До уваги користувачів!!!<br/> ПЗ "Технічні умови", для запобігання зависання, буде
                        перезавантажено кожного дня о 12:45, прохання не працювати в базі напротязі 5 хвилин!!!
                    </p>
                </div>
                <div id="section-box">
                    <div class="col-md-8">
                        <html:form  action="/frame/login" styleId="form-login" style="clear: both;">
                            <p id="form-login-username">
                                <select name="rem" id="lang" class="inputbox form-control">
                                    <option value="999">Виберіть РЕМ</option>
                                    <option value="190">Богородчанський</option>
                                    <option value="200">Верховинський</option>
                                    <option value="210">Галицький</option>
                                    <option value="220">Городенківський</option>
                                    <option value="230">Долинський</option>
                                    <%--<option value="240">Івано-Франківський</option>--%>
                                    <option value="250">Калуський</option>
                                    <option value="260">Коломийський М</option>
                                    <option value="270">Коломийський Р</option>
                                    <option value="280">Косівський</option>
                                    <option value="290">Лисецький</option>
                                    <option value="300">Надвірнянський</option>
                                    <option value="310">Рогатинський</option>
                                    <option value="320">Рожнятівський</option>
                                    <option value="330">Снятинський</option>
                                    <option value="340">Тлумацький</option>
                                    <option value="350">Яремчанський</option>
                                    <option value="360">OE</option>
                                </select>
                            </p>
                            <p id="form-login-password"><label class="info_text" for="modlgn_passwd">Користувач</label>
                                <html:text name="loginActionForm" property="user" styleId="modlgn_passwd"
                                           styleClass="form-control" size="15"/>
                            </p>
                            <p id="form-login-lang"><label class="info_text" for="lang">Пароль</label>
                                <html:password name="loginActionForm" property="password" styleId="passwd"
                                               styleClass="form-control" size="15"/>
                            </p>
                            <div class="button_holder">
                                <html:submit property="method" value="login" styleClass="btn btn-warning"/>
                            </div>
                        </html:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>
