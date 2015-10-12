<%-- 
    Document   : search_detal
    Created on : 3 серп 2010, 10:50:27
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.myapp.struts.loginActionForm"%>
<link rel="STYLESHEET" type="text/css" href="../codebase/dhtmlxgrid.css">
<link rel="stylesheet" type="text/css" href="../codebase/skins/dhtmlxgrid_dhx_skyblue.css">
<script type="text/javascript"   src="../codebase/dhtmlxgrid.js"></script>
<script type="text/javascript"   src="../codebase/dhtmlxgridcell.js"></script>
<script type="text/javascript"   src="../codebase/ext/dhtmlxgrid_start.js"></script>
<script>
    dhtmlx.skin = "light";
</script>


<script>
    $(document).ready(function(){
        $("#resalt").toggle("slide",{},50);
        $(function() {
            $(".datepicker").datepicker();
        });
        $(function() {
            $("#button_s").click(function() {
                $("#resalt").toggle("slide",{},50);
                $("#search").toggle("slide",{},50);
                var str = $("form").serialize();
                $("#rez_serch > iframe").attr("src","main_grid.jsp?"+str);
                return false;
            });
            $("#button_r").click(function() {
                $("#search").toggle("slide",{},50);
                $("#resalt").toggle("slide",{},50);
                return false;
            });
            $('.exp_xls').click(function(){
                var str = $("form").serialize();
                window.open("xls.jsp?"+str);
            });
        });

    });
</script>
</head>
<body>
    <div id="search" class="ui-widget-content ui-corner-all">
        <h3 class="ui-widget-header ui-corner-all">Пошук</h3>
        <p>
            <html:form action="/frame/search_detal">
            <table border="0">
                <tr>
                    <td><bean:message key="VTS.number" /></td>
                    <td><input type="text" name="number"/></td>
                </tr>
                <tr>
                    <td><bean:message key="customer.juridical" /></td>
                    <td><input type="text" name="juridical" size="70"/></td>
                </tr>
                <tr>
                    <td><bean:message key="customer.customer_name" /></td>
                    <td><input type="text" name="f_name"size="20" /></td>
                </tr>
                <tr>
                    <td><bean:message key="dataobjects.object_name" /></td>
                    <td><input type="text" name="object_name" size="50"/></td>
                </tr>
                <tr>
                    <td><bean:message key="dataobjects.object_adress" /></td>
                    <td><html:select  property="name_locality">
                            <html:option value="0"> </html:option>
                            <html:optionsCollection name="DetalViewActionForm" property="locality_list"
                                                    label="name" value="id"/>
                        </html:select>
                        <input type="text" name="object_adress"/>
                    </td>
                </tr>
                <tr>
                    <td><bean:message key="dataobjects.request_power" /></td>
                    <td>
                        З:<input type="text" name="request_power_from"size="8" onkeypress ="isDigit()"/>
                        по:<input type="text" name="request_power_till"size="8" onkeypress ="isDigit()"/><bean:message key="CIkV"/>
                    </td>
                </tr>
                <tr><td colspan="2"><hr></td></tr>
                <tr>
                    <td><bean:message key="Design.develloper_company" /> ПКД</td>
                    <td><html:select  property="develloper_company">
                            <html:option value="0"> </html:option>
                            <html:optionsCollection name="DetalViewActionForm" property="performer_list"
                                                    label="name" value="id"/>
                        </html:select>
                    </td>
                </tr>
                <tr>
                    <td><bean:message key="Admission.Performer_proect_to_point" /></td>
                    <td><html:select  property="performer_proect_to_point">
                            <html:option value="0"> </html:option>
                            <html:optionsCollection name="DetalViewActionForm" property="performer_list"
                                                    label="name" value="id"/>
                        </html:select>
                    </td>
                </tr>
                <tr>
                    <td><bean:message key="Admission.Performer_proect_after_point" /></td>
                    <td><html:select  property="performer_proect_after_point">
                            <html:option value="0"> </html:option>
                            <html:optionsCollection name="DetalViewActionForm" property="performer_list"
                                                    label="name" value="id"/>
                        </html:select>
                    </td>
                </tr>
                <tr>
                    <td><bean:message key="customer.type_contract" /></td>
                    <td><html:select  property="customer_type" onchange="dataSelectJUR(this.form)">
                            <html:option value="2">Всі</html:option>
                            <html:option value="0">Побутовий</html:option>
                            <html:option value="1">Юридичний</html:option>
                        </html:select>
                    </td>
                </tr>
                <tr>
                    <td>Споживач</td>
                    <td>
                        <html:select property="customer_soc_status" >
                            <html:option value="100">Всі</html:option>
                            <html:optionsCollection name="DetalViewActionForm" property="customer_soc_status_list" label="name" value="id"/>
                        </html:select>
                    </td>
                </tr>
                <tr>
                    <td>Вихідна дата реєстрації ТУ в РЕМ</td>
                    <td>
                        З:<input type="text" name="initial_registration_date_rem_tu_from" size="10" class="datepicker"/>
                        по:<input type="text" name="initial_registration_date_rem_tu_till" size="10" class="datepicker"/>
                    </td>
                </tr>
                <tr>
                    <td><bean:message key="Admission.Date_admission_consumer" /></td>
                    <td>
                        З:<input type="text" name="date_admission_consumer_from" size="10" class="datepicker"/>
                        по:<input type="text" name="date_admission_consumer_till" size="10" class="datepicker"/>
                    </td>
                </tr>
                <tr>
                    <td><bean:message key="tund.date_contract" /></td>
                    <td>
                        З:<input type="text" name="date_contract_from" size="10" class="datepicker"/>
                        по:<input type="text" name="date_contract_till" size="10" class="datepicker"/>
                    </td>
                </tr>
                <tr>
                    <td>Номер ТП</td>
                    <td><html:select property="ps_10_disp_name" onchange="makeRequest('detailedview/ajax.jsp',this.form)" styleClass="suplychain">
                            <html:optionsCollection name="DetalViewActionForm"
                                                    property="ps_10_disp_name_list"
                                                    label="name" value="id"/>
                        </html:select>
                    </td>
                </tr>
                <tr>
                    <td>Назва підстанції</td>
                    <td><html:select property="ps_35_disp_name">
                            <html:option value="0">Всі</html:option>
                            <html:optionsCollection name="DetalViewActionForm"
                                                    property="ps_35_disp_name_list"
                                                    label="name" value="id"/>
                        </html:select>
                    </td>
                <tr>
                    <td>Назва приєднання, 10 кВ</td>
                    <td><html:select property="fid_10_disp_name">
                            <html:option value="0">Всі</html:option>
                            <html:optionsCollection name="DetalViewActionForm"
                                                    property="fid_10_disp_name_list"
                                                    label="name" value="id" styleClass="suplychain"/>
                        </html:select>
                    </td
                </tr>
                <tr><td colspan="2"><hr></td></tr>
                <tr>
                    <td>У електромережах до прогнозованої межі балансової належності:</td>
                    <td><input type="textarea" name="do1" cols="50" class="dataobjects"/></td>
                </tr>
                <tr>
                    <td>Від межі балансової належності до електроустановок Замовника:</td>
                    <td><input type="textarea" name="do2" cols="50" class="dataobjects"/></td>
                </tr>
                <tr>
                    <td>Розрахунковий облік електричної енергії:</td>
                    <td><input type="text" name="do3" class="dataobjects"/></td>
                </tr>
                <tr>
                    <td>Точка забезпечення потужності:</td>
                    <td><input type="textarea" name="point_zab_power" cols="50" size="70" class="dataobjects"/></td>
                </tr>
                <tr>
                    <td><bean:message key="tund.state_contract" /></td>
                    <td><html:select  property="state_contract" styleClass="tund">
                            <html:option value="0">--</html:option>
                            <html:optionsCollection name="DetalViewActionForm" property="state_contract_list"
                                                    label="name" value="id"/>
                        </html:select>
                    </td>
                </tr>
                <tr><td colspan="2"><hr></td></tr>

            </table>
        </html:form>

        <button id="button_s" class="ui-state-default ui-corner-all">Знайти</button>
        <%
            HttpSession ses = request.getSession();
            if (!((loginActionForm) ses.getAttribute("log")).getRole().equals("128")) {
        %>
        <button  class="exp_xls ui-state-default ui-corner-all">Експорт В EXEL</button>
        <%}%>
    </div>
    <div id="resalt" class="ui-widget-content ui-corner-all">
        <h3 class="ui-widget-header ui-corner-all">Результат пошуку</h3>
        <div id="rez_serch">
            <iframe  width="99%" height="550px"></iframe>
        </div>
        <button id="button_r" class="ui-state-default ui-corner-all">Новий пошук</button>
        <%
          
           if (!((loginActionForm) ses.getAttribute("log")).getRole().equals("128")) {
        %>
        <button class="exp_xls ui-state-default ui-corner-all">Експорт В EXEL</button>
        <%}%>
    </div>
</body>
</html>

