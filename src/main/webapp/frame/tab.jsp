<%@page import="com.myapp.struts.loginActionForm" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String permision = ua.ifr.oe.tc.list.MyCoocie.getCoocie("permisions", request);%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<script type="text/javascript" src="../codebase/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="detailedview/js/multiselect/jquery.multiselect.js"></script>
<script type="text/javascript" src="../codebase/jquery-ui-1.7.2.custom.min.js"></script>
<script type="text/javascript" src="../codebase/jquery.tools.min.js"></script>
<script type="text/javascript" src="../codebase/jquery.cookie.js"></script>
<script type="text/javascript" src="detailedview/js/timePicker-master/jquery.ui.timepicker.js"></script>
<script type="text/javascript" src="detailedview/js/timePicker-master/jquery.proxy.fix.js"></script>
<link rel="stylesheet" type="text/css" href="detailedview/js/timePicker-master/jquery.ui.timepicker.css"/>
<script type="text/javascript" src="detailedview/checkform.js"></script>
<link href="../codebase/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css"/>
<link href="detailedview/js/multiselect/jquery.multiselect.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="../button/style.css"/>
<script type="text/javascript">
    $(document).ready(function () {
        $("#example").tabs();
        $("#example").tabs('option', 'cache', true);
        $("#save_upd").click(function () {
            var str = $("form").serialize();
            progresdlg("<h2>Зачекайте дані зберігаються</h2> <br><img src=\"../codebase/images/ajax-loader.gif\" width=\"100\" height=\"100\" alt=\"ajax-loader\"/>");
            jQuery.ajax({
                type: "POST", url: "tab.do", data: str,
                success: function (msg) {
                    document.location.href = 'grid.jsp';
                },
                error: function (error, textStatus, errorThrown) {
                    progresdlg("Помилка !!! \n Дані не збережено!!!");
                }
            });

        });
        $("#delete").click(function () {
            if (window.confirm('Ви дійсно бажаєте видалити дані ТУ?')) {
                $("#method").val('delete');
                var str = $("form").serialize();
                progresdlg("<h2>Зачекайте дані видаляються</h2> <br><img src=\"../codebase/images/ajax-loader.gif\" width=\"100\" height=\"100\" alt=\"ajax-loader\"/>");
                jQuery.ajax({
                    type: "POST", url: "tab.do", data: str,
                    success: function (msg) {
                        history.go(-1);
                    },
                    error: function (error, textStatus, errorThrown) {
                        progresdlg("Помилка !!! \n Дані не видалено!!!");
                    }
                });
            }
        });
        $(".doc_vud").click(function () {
            $(this).children('.doc_vud_w').dialog("destroy");
            $(this).children('.doc_vud_w').dialog({
                width: 500, modal: true, hide: 'blind', onClose: (function () {
                    $(this).dialog("destroy");
                }),
                buttons: {
                    "OK": function () {
                        $(this).dialog("close");
                    }
                }
            });
        });
    });
    function progresdlg(strmes) {
        $("#mes").html(strmes);
        $("#mes").dialog({
            width: 300, height: 260, modal: true, hide: 'blind',
            position: {
                my: "top",
                at: "top",
                of: $("body"),
                within: $("body")
            },
            buttons: {
                "Закрити": function () {
                    $(this).dialog("destroy");
                    document.location.href = 'login.jsp';
                }
            }
        });
    }
</script>
<html:form action="/frame/tab" onsubmit="return checkForm(this);">
    <%
        HttpSession ses = request.getSession();
        String perm = ua.ifr.oe.tc.list.MyCoocie.getCoocie("permisions", request);
        String role = ((loginActionForm) ses.getAttribute("log")).getRole();
        String remID = ((loginActionForm) ses.getAttribute("log")).getUREM_ID();
        final String tu_id = request.getParameter("tu_id");
         {
    %>
    <div>
        <html:button styleId="save_upd" property="method" value="update" styleClass="button_save"/>
        <%}%>
        <div class="button_close" onclick="window.location.href='grid.jsp';"></div>
        <%
            if ((!tu_id.equals("-1")) && ("2".equals(perm))) {%>
        <html:button styleId="delete" property="method" value="delete" styleClass="button_del"/>
        <%}%>

        <html:hidden property="tu_id"/>
        <input id="method" type="hidden" name="method" value="update"/>

        <div style="clear:both;"></div>
        <div id="example">
            <ul>
                <li><a href="detailedview/customer.do?tu_id=<%=tu_id%>&bdname=<%=request.getParameter("bdname")%>">Замовник</a>
                </li>
                <li><a href="detailedview/dataobjects.do?tu_id=<%=tu_id%>">Дані про обєкт</a></li>
                <%if (!role.equals("128")) {%>
                <li><a href="detailedview/dataobjects2.do?tu_id=<%=tu_id%>">Вимоги ТУ</a></li>
                <%}%>
                <li><a href="detailedview/tund.do?tu_id=<%=tu_id%>">Технічні умови № Договір</a></li>
                <li><a href="detailedview/admission.do?tu_id=<%=tu_id%>">Допуск та Проектування</a></li>
                <li><a href="detailedview/admissionAndConnection.do?tu_id=<%=tu_id%>">Допуск та Підключення</a></li>
                <% if (!role.equals("128")) {%>
                <% if (!tu_id.equals("-1")) {%>
                <li><a href="#supl_tabs">Схема приєднання</a></li>
                <%}%>
                <li><a href="#doc_tabs">Документація</a></li>
                <li><a href="#doc_tabs1">Документація приєднання</a></li>
                <li><a href="#ch_tu_tab">Зміни ТУ</a></li>
                <li><a href="detailedview/join_price.do?tu_id=<%=tu_id%>">Плата за стандартне приєднання</a></li>
                <li><a href="detailedview/join_price_ns.jsp?tu_id=<%=tu_id%>">Плата за нестандартне приєднання</a></li>
                <li><a href="detailedview/vkb_tab.jsp?tu_id=<%=tu_id%>">Дані ВКБ</a></li>
                <li><a href="#file_tab">Прикріплені файли</a></li>
                <li><a href="#DKEE_data">Дані ДКЕЕ</a></li>
                <%}%>
            </ul>
            <%if (!role.equals("128")) {%>
            <div id="ch_tu_tab">
                <iframe src="changestu/changestuxp.jsp?tu_id=<%=tu_id%>" width="820" height="600"></iframe>
            </div>
            <% if (!tu_id.equals("-1")) {%>
            <div id="file_tab">
                <div class="butt"><input type="button" name="back" value="<-назад" onclick="window.history.back(-2);"
                                         class="ui-state-default ui-corner-all"></div>
                <iframe src="FileUpload/fileupload.jsp?tu_id=<%=tu_id%>" width="820" height="450"></iframe>
                Console.log(<%=tu_id%>);
            </div>
            <div id="supl_tabs">
                <iframe src="msupplych/show.jsp?tu_id=<%=tu_id%>&req_paw=<bean:write name="DetalViewActionForm"  property="request_power"/>"
                        width="820" height="600"></iframe>
            </div>
            <%
                }
                if (!role.equals("128")) {
            %>
            <div id="DKEE_data">
                <table border="0">
                    <tr>
                        <td style="vertical-align: baseline; padding-top: 10px;">Договір про користування електричною енергією</td>
                        <td>
                            <div class="doc_vud">
                                <logic:equal value="1" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="0" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/DKEE/agreement_on_the_use_of_electricity.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                </logic:equal>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: baseline; padding-top: 10px;">Договір про користування електричною енергією2</td>
                        <td>
                            <div class="doc_vud">
                                <logic:equal value="1" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="0" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/DKEE/agreement_on_the_use_of_electric2.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                </logic:equal>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="doc_tabs">
                <table border="0">
                    <tr>
                        <td>Договір про надання доступу</td>
                        <td>
                            <div class="doc_vud">
                                <logic:equal value="1" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="0" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/dog/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:equal value="1" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/dog/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                </logic:equal>
                                <logic:equal value="2" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="0" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/dog_bm/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:equal value="1" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/dog_bm/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                </logic:equal>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Технічні умови</td>
                        <td>
                            <div class="doc_vud">
                                <logic:equal value="1" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="0" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/tc/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:equal value="1" name="DetalViewActionForm" property="executor_company">
                                        <%if (remID.equals("0")) {%>
                                        <a href="blank/tc/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                        <%}%>
                                    </logic:equal>
                                </logic:equal>
                                <logic:equal value="2" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="0" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/tc_bm/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:equal value="1" name="DetalViewActionForm" property="executor_company">
                                        <%if (remID.equals("0")) {%>
                                        <a href="blank/tc_bm/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                        <%}%>
                                    </logic:equal>
                                </logic:equal>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Вихідні дані</td>
                        <td>
                            <div class="doc_vud">
                                <logic:equal value="1" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="0" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/vyh/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:equal value="1" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/vyh/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                </logic:equal>
                                <logic:equal value="2" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="0" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/vyh_bm/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:equal value="1" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/vyh_bm/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                </logic:equal>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Заява</td>
                        <td>
                            <div class="doc_vud">
                                <logic:equal value="1" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="0" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/zayava/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:equal value="1" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/zayava/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                </logic:equal>
                                <logic:equal value="2" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="0" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/zayava_bm/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:equal value="1" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/zayava_bm/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                </logic:equal>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Опитувальний лист</td>
                        <td>
                            <div class="doc_vud">
                                <logic:equal value="1" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="0" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/op_lyst/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:equal value="1" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/op_lyst/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                </logic:equal>
                                <logic:equal value="2" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="0" name="DetalViewActionForm" property="executor_company">
                                        <a href="blank/op_lyst_bm/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                </logic:equal>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="doc_tabs1">
                <table border="0">
                    <tr><logic:notEqual value="1" name="DetalViewActionForm" property="type_join">
                        <td>Договір на приєднання</td>
                    </logic:notEqual>
                        <logic:equal value="1" name="DetalViewActionForm" property="type_join">
                            <logic:notEmpty name="DetalViewActionForm" property="agreement_date">
                                <td>Договір на приєднання</td>
                            </logic:notEmpty>
                        </logic:equal>
                        <td>
                            <div class="doc_vud">
                                <logic:equal value="1" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="1" name="DetalViewActionForm" property="customer_soc_status">
                                        <logic:notEmpty name="DetalViewActionForm" property="agreement_date">
                                            <logic:equal value="1" name="DetalViewActionForm" property="type_join">
                                                <a href="blank/dog_join/fiz.jsp?tu_id=<%= tu_id%>" class="button_vudaty"
                                                   onclick="window.open('blank/pamjatka.doc'); window.location('blank/dog_join/fiz.jsp?tu_id=<%= tu_id%>'); return false;">Видати</a>
                                            </logic:equal>
                                        </logic:notEmpty>
                                        <logic:equal value="2" name="DetalViewActionForm" property="type_join">
                                            <a href="blank/dog_join_nonstandart/fiz.jsp?tu_id=<%= tu_id%>"
                                               target="_blank"
                                               class="button_vudaty"
                                               onclick="window.open('blank/pamjatka_ns.doc'); window.location('blank/dog_join_nonstandart/fiz.jsp?tu_id=<%= tu_id%>'); return false;">Видати</a>
                                        </logic:equal>
                                    </logic:equal>
                                    <logic:equal value="6" name="DetalViewActionForm" property="customer_soc_status">
                                        <logic:notEmpty name="DetalViewActionForm" property="agreement_date">
                                            <logic:equal value="1" name="DetalViewActionForm" property="type_join">
                                                <a href="blank/dog_join/fiz.jsp?tu_id=<%= tu_id%>" class="button_vudaty"
                                                   onclick="window.open('blank/pamjatka.doc');window.location('blank/dog_join/fiz.jsp?tu_id=<%= tu_id%>'); return false;">Видати</a>
                                            </logic:equal>
                                        </logic:notEmpty>
                                        <logic:equal value="2" name="DetalViewActionForm" property="type_join">
                                            <a href="blank/dog_join_nonstandart/fiz.jsp?tu_id=<%= tu_id%>"
                                               target="_blank"
                                               class="button_vudaty"
                                               onclick="window.open('blank/pamjatka_ns.doc');window.location('blank/dog_join_nonstandart/fiz.jsp?tu_id=<%= tu_id%>'); return false;">Видати</a>
                                        </logic:equal>
                                    </logic:equal>
                                    <logic:notEqual value="1" name="DetalViewActionForm" property="customer_soc_status">
                                        <logic:notEqual value="6" name="DetalViewActionForm"
                                                        property="customer_soc_status">
                                            <logic:notEmpty name="DetalViewActionForm" property="agreement_date">
                                                <logic:equal value="1" name="DetalViewActionForm" property="type_join">
                                                    <a href="blank/dog_join/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                                       class="button_vudaty"
                                                       onclick="window.open('blank/pamjatka.doc');window.location('blank/dog_join/jur.jsp?tu_id=<%= tu_id%>'); return false;">Видати</a>
                                                </logic:equal>
                                            </logic:notEmpty>
                                            <logic:equal value="2" name="DetalViewActionForm" property="type_join">
                                                <a href="blank/dog_join_nonstandart/jur.jsp?tu_id=<%= tu_id%>"
                                                   target="_blank"
                                                   class="button_vudaty"
                                                   onclick="window.open('blank/pamjatka_ns.doc');window.location('blank/dog_join_nonstandart/jur.jsp?tu_id=<%= tu_id%>'); return false;">Видати</a>
                                            </logic:equal>
                                        </logic:notEqual>
                                    </logic:notEqual>
                                </logic:equal>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <c:if test="${DetalViewActionForm.type_join != 1 && DetalViewActionForm.type_join != 3
                                        || (DetalViewActionForm.type_join == 1 && not empty DetalViewActionForm.agreement_date)}">
                            <td>Технічні умови</td>
                        </c:if>
                        <c:if test="${(DetalViewActionForm.type_join == 3 && not empty DetalViewActionForm.agreement_date)}">
                            <td>Технічні вимоги</td>
                        </c:if>
                        <td>
                            <div class="doc_vud">
                                <c:if test="${DetalViewActionForm.type_contract == 1 }">

                                    <c:choose>
                                        <c:when test="${DetalViewActionForm.customer_soc_status == 1 || DetalViewActionForm.customer_soc_status == 6}">
                                            <c:choose>
                                                    <c:when test="${DetalViewActionForm.type_join==1 && not empty DetalViewActionForm.agreement_date}">
                                                        <a href="blank/tc_join/fiz.jsp?tu_id=<%= tu_id%>"
                                                           target="_blank" class="button_vudaty">Видати</a>
                                                    </c:when>
                                                    <c:when test="${DetalViewActionForm.type_join==3 && not empty DetalViewActionForm.agreement_date}">
                                                        <a href="blank/tr/fiz.jsp?tu_id=<%= tu_id%>"
                                                           target="_blank" class="button_vudaty">Видати</a>
                                                    </c:when>
                                                <c:when test="${DetalViewActionForm.type_join==2}">
                                                    <a href="blank/tc_join_nonstandart/fiz.jsp?tu_id=<%= tu_id%>"
                                                       target="_blank" class="button_vudaty">Видати</a>
                                                </c:when>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                    <c:when test="${DetalViewActionForm.type_join==1 && not empty DetalViewActionForm.agreement_date}">
                                                        <a href="blank/tc_join/jur.jsp?tu_id=<%= tu_id%>"
                                                           target="_blank" class="button_vudaty">Видати</a>
                                                    </c:when>

                                                    <c:when test="${DetalViewActionForm.type_join==3 && not empty DetalViewActionForm.agreement_date}">
                                                        <a href="blank/tr/jur.jsp?tu_id=<%= tu_id%>"
                                                           target="_blank" class="button_vudaty">Видати</a>
                                                    </c:when>
                                                <c:when test="${DetalViewActionForm.type_join==2}">
                                                    <a href="blank/tc_join_nonstandart/jur.jsp?tu_id=<%= tu_id%>"
                                                       target="_blank" class="button_vudaty">Видати</a>
                                                </c:when>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Заявка на проектування</td>
                        <td>
                            <div class="doc_vud">
                                <c:if test="${DetalViewActionForm.type_contract == 1 }">
                                    <c:choose>
                                        <c:when test="${DetalViewActionForm.customer_soc_status == 1 || DetalViewActionForm.customer_soc_status == 6}">
                                            <c:choose>
                                                <c:when test="${DetalViewActionForm.type_join==1}">
                                                    <a href="blank/zayavka_join/fiz.jsp?tu_id=<%= tu_id%>"
                                                       target="_blank"
                                                       class="button_vudaty">Видати</a>
                                                </c:when>
                                                <c:when test="${DetalViewActionForm.type_join==2}">
                                                    <a href="blank/zayavka_join_ns/fiz.jsp?tu_id=<%= tu_id%>"
                                                       target="_blank"
                                                       class="button_vudaty">Видати</a>
                                                </c:when>
                                                <%--<c:when test="${DetalViewActionForm.type_join==3}">/</c:when>--%>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${DetalViewActionForm.type_join==1}">
                                                    <a href="blank/zayavka_join/jur.jsp?tu_id=<%= tu_id%>"
                                                       target="_blank"
                                                       class="button_vudaty">Видати</a>
                                                </c:when>
                                                <c:when test="${DetalViewActionForm.type_join==2}">
                                                    <a href="blank/zayavka_join_ns/jur.jsp?tu_id=<%= tu_id%>"
                                                       target="_blank" class="button_vudaty">Видати</a>
                                                </c:when>
                                                <%--<c:when test="${DetalViewActionForm.type_join==3}"></c:when>--%>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Вихідні дані</td>
                        <td>
                            <div class="doc_vud">
                                <logic:equal value="1" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="1" name="DetalViewActionForm" property="customer_soc_status">
                                        <a href="blank/vuh_join/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:equal value="6" name="DetalViewActionForm" property="customer_soc_status">
                                        <a href="blank/vuh_join/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:notEqual value="1" name="DetalViewActionForm" property="customer_soc_status">
                                        <logic:notEqual value="6" name="DetalViewActionForm"
                                                        property="customer_soc_status">
                                            <a href="blank/vuh_join/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                               class="button_vudaty">Видати</a>
                                        </logic:notEqual>
                                    </logic:notEqual>
                                </logic:equal>

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Заява на приєднання електоустановки</td>
                        <td>
                            <div class="doc_vud">
                                <logic:equal value="1" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="1" name="DetalViewActionForm" property="customer_soc_status">
                                        <logic:equal value="1" name="DetalViewActionForm" property="type_join">
                                            <a href="blank/zayava_join/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                               class="button_vudaty">Видати</a>
                                        </logic:equal>
                                        <logic:equal value="2" name="DetalViewActionForm" property="type_join">
                                            <a href="blank/zayava_join_ns/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                               class="button_vudaty">Видати</a>
                                        </logic:equal>
                                    </logic:equal>
                                    <logic:equal value="6" name="DetalViewActionForm" property="customer_soc_status">
                                        <logic:equal value="1" name="DetalViewActionForm" property="type_join">
                                            <a href="blank/zayava_join/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                               class="button_vudaty">Видати</a>
                                        </logic:equal>
                                        <logic:equal value="2" name="DetalViewActionForm" property="type_join">
                                            <a href="blank/zayava_join_ns/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                               class="button_vudaty">Видати</a>
                                        </logic:equal>
                                    </logic:equal>
                                    <logic:notEqual value="1" name="DetalViewActionForm" property="customer_soc_status">
                                        <logic:notEqual value="6" name="DetalViewActionForm"
                                                        property="customer_soc_status">
                                            <logic:equal value="1" name="DetalViewActionForm" property="type_join">
                                                <a href="blank/zayava_join/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                                   class="button_vudaty">Видати</a>
                                            </logic:equal>
                                            <logic:equal value="2" name="DetalViewActionForm" property="type_join">
                                                <a href="blank/zayava_join_ns/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                                   class="button_vudaty">Видати</a>
                                            </logic:equal>
                                        </logic:notEqual>
                                    </logic:notEqual>
                                </logic:equal>

                            </div>
                        </td>
                    </tr>
                    <logic:notEmpty name="DetalViewActionForm" property="reusable_project">
                        <tr>
                            <td>Типовий проект</td>
                            <td>
                                <div class="doc_vud">
                                    <a href="blank/reusable_proj.jsp?tu_id=<%= tu_id%>" target="_blank"
                                       class="button_vudaty">Видати</a>
                                </div>
                            </td>
                        </tr>
                    </logic:notEmpty>
                    <tr>
                        <td>Акт розмежування балансової належності електромереж</td>
                        <td>
                            <div class="doc_vud">
                                <logic:equal value="1" name="DetalViewActionForm" property="type_contract">
                                    <logic:equal value="1" name="DetalViewActionForm" property="customer_soc_status">
                                        <a href="blank/akt/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:equal value="6" name="DetalViewActionForm" property="customer_soc_status">
                                        <a href="blank/akt/fiz.jsp?tu_id=<%= tu_id%>" target="_blank"
                                           class="button_vudaty">Видати</a>
                                    </logic:equal>
                                    <logic:notEqual value="1" name="DetalViewActionForm" property="customer_soc_status">
                                        <logic:notEqual value="6" name="DetalViewActionForm"
                                                        property="customer_soc_status">
                                            <a href="blank/akt/jur.jsp?tu_id=<%= tu_id%>" target="_blank"
                                               class="button_vudaty">Видати</a>
                                        </logic:notEqual>
                                    </logic:notEqual>
                                </logic:equal>

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Акт ОЗ</td>
                        <td>
                            <div class="doc_vud">
                                <a href="blank/akt_oz.jsp?tu_id=<%= tu_id%>" target="_blank" class="button_vudaty">Видати</a>
                            </div>
                        </td>
                    </tr>
                    <logic:equal value="2" name="DetalViewActionForm" property="type_join">
                        <tr>
                            <td>Розрахунок нестандартного приєднання</td>
                            <td>
                                <div class="doc_vud">
                                    <logic:equal value="true" name="DetalViewActionForm" property="ch_rez2">
                                        <logic:notEqual value="true" name="DetalViewActionForm" property="ch_rez1">
                                            <a href="blank/calc_ns_join_1.jsp?tu_id=<%= tu_id%>" target="_blank"
                                               class="button_vudaty">Видати</a>
                                        </logic:notEqual>
                                    </logic:equal>
                                    <logic:equal value="true" name="DetalViewActionForm" property="ch_rez1">
                                        <logic:notEqual value="true" name="DetalViewActionForm" property="ch_rez2">
                                            <a href="blank/calc_ns_join_2.jsp?tu_id=<%= tu_id%>" target="_blank"
                                               class="button_vudaty">Видати</a>
                                        </logic:notEqual>
                                    </logic:equal>
                                </div>
                            </td>
                        </tr>
                    </logic:equal>
                </table>
            </div>
            <%}%>
            <%}%>
        </div>
    </div>
</html:form>
<div id="mes" style="display:none;z-index: 432423;"/>