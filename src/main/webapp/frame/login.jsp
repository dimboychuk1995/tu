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
        <link href="files/login000.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="files/rounded0.css" />
        <link rel="stylesheet" type="text/css" href="../button/style.css"></link>
        <STYLE type="text/css">
            .button { /* верхний левый угол, верхняя граница */
                background: url(files/1.png) no-repeat; /* цвет фона при отключенных изображениях */

            }
        </STYLE>
    </head>
    <body>

        <div class="modal-1 reloadDatabase">
            <script type="text/javascript">
                alert("База буде перезавантажена в 12:45");
            </script>
        </div>

        <div id="element-box" class="login">
            <div class="t">
                <div class="t">
                    <div class="t"></div>
                </div>
            </div>
            <div class="m">
                <h1>Вхід в програму технічні умови </h1>
                <div id="section-box">
                    <div class="t">
                        <div class="t">
                            <div class="t"></div>
                        </div>
                    </div>
                    <div class="m">
                        <html:form  action="/frame/login" styleId="form-login" style="clear: both;">
                            <p id="form-login-username">
                                <label for="modlgn_username">РЕМ</label>
                                <select name="rem" id="lang" class="inputbox">
                                    <option value="190">Богородчанський</option>
                                    <option value="200">Верховинський</option>
                                    <option value="210">Галицький</option>
                                    <option value="220">Городенківський</option>
                                    <option value="230">Долинський</option>
                                    <option value="240">Івано-Франківський</option>
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
                            <p id="form-login-password"><label for="modlgn_passwd">Користувач</label>
                                <html:text name="loginActionForm" property="user" styleId="modlgn_passwd" styleClass="inputbox" size="15"/>
                            </p>
                            <p id="form-login-lang" style="clear: both;"><label for="lang">Пароль</label>
                                <html:password name="loginActionForm" property="password" styleId="passwd" styleClass="inputbox" size="15"/>
                            </p>
                            <div class="button_holder">
                                <html:submit property="method" value="login" styleClass="button_login"/>
                            </div>
                        </html:form>
                        <div class="clr"></div>
                    </div>
                    <div class="b">
                        <div class="b">
                            <div class="b"></div>
                        </div>
                    </div>
                </div>
                <p>Виберіть РЕМ та введіть правильно логін та пароль</p>
                <p><img src="../button/img_help.bmp"/><html:link href="hvvid.jsp" target="_blank"> Допомога</html:link></p>
                <div id="lock"></div>

            </div>
            <div class="b">
                <div class="b">
                    <div class="b"></div>
                </div>
            </div>
            <br>

        </div>
    </body>
</html>
