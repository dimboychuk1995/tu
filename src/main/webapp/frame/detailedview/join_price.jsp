<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
//HttpSession ses=request.getSession();
//loginActionForm login=(loginActionForm)ses.getAttribute("log");
//String id_rem = login.getUREM_ID();
    String id_rem = ua.ifr.oe.tc.list.MyCoocie.getCoocie("UREM_ID", request);
%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<script type="text/javascript">
    $(document).ready(function () {
        permision();
        $(".datepicker").datepicker();
        calc_price();
        $("#rate_choice").change(function () {
            calc_price();

        });
    });
    function convert(data) {
        return data.substr(6, 4) + data.substr(3, 2) + data.substr(0, 2);
    }
    function calc_price() {
        var rt_choice = $("#rate_choice option:selected").val();
        var req_pow = $("#request_power").val();
        var isn_pow = $("#power_old").val();
        var registration_date = $("#registration_date").val();
        if (convert(registration_date) < convert('01.04.2013')) {
            var kof = 1.19 * 1.2
        }
        else {
            kof = 1.2
        }
        if (isn_pow == '' || isNaN(isn_pow)) {
            isn_pow = 0
        }

        if (rt_choice != 0){
            $.ajax({
                url: 'ajax/join_price_calc.jsp?rt_choice=' + rt_choice + '&registration_date=' + registration_date,
                dataType: "json",
                success: function (data, textStatus) {
                    var rate = data.rate;
                    $("#stavka").val(rate);
                    var t_pow;
                    if (req_pow == '' || isNaN(req_pow)) {
                        t_pow = 0
                    }
                    else {
                        t_pow = parseFloat(req_pow) - parseFloat(isn_pow)
                    }
                    $("#temp_pow").val(parseFloat(t_pow.toFixed(2)));
                    $("#price_join").val((t_pow * rate * kof * 1000).toFixed(2));
                }
            });
        } else {
            $('.clearInput').val('');
        }
    }
</script>
<style>
    #request_power {
        display: none;
    }

    #power_old {
        display: none;
    }

    #registration_date {
        display: none;
    }
</style>
<html:form action="/frame/detailedview/join_price">
    <table border="0">
        <tr>
            <td><html:text name="DetalViewActionForm" property="power_old" size="8" onkeypress="isDigit()"
                           styleId="power_old"/></td>
        </tr>
        <tr>
            <td><html:text name="DetalViewActionForm" property="egistration_date" size="8" onkeypress="isDigit()"
                           styleId="registration_date" styleClass=""/></td>
            <td><html:text name="DetalViewActionForm" property="request_power" size="8" onkeypress="isDigit()"
                           styleId="request_power"/></td>
        </tr>
        <tr>
            <td>Потужність:</td>
            <td><input id="temp_pow" type="text" readonly="true" class="clearInput"/></td>
        </tr>
        <tr>
            <td>Вибір ставки плати за приєднання:</td>
            <td><html:select property="rate_choice" styleId="rate_choice" styleClass="admission">
                <html:option value="0">Виберіть тип приєднання:</html:option>
                <html:optionsCollection name="DetalViewActionForm" property="rate_join_list" label="name" value="id"/>
            </html:select>
            </td>
        </tr>
        <tr>
            <td>Ставка за приєднання</td>
            <td><input type="text" id="stavka" readonly="true" class="clearInput"/></td>
        </tr>
        <tr>
            <td>Вартість приєдання, грн</td>
            <td><html:text name="DetalViewActionForm" property="price_join" readonly="true" styleId="price_join"
                           styleClass="admission clearInput"/></td>
        </tr>
        <tr>
            <td>Вартість плати за нестандартне приєднання, тис. грн.</td>
            <td><html:text name="DetalViewActionForm" property="price_join_ns" size="8" styleId="2_9"
                           styleClass="dataobjects"/></td>
        </tr>
        <tr>
            <td>Дата оплати плати за приєднання</td>
            <td><html:text name="DetalViewActionForm" property="date_pay_join" size="10"
                           styleClass="datepicker design rem"/>
            </td>
        </tr>
        <tr>
            <td>Сума оплати у випадку відмінності від вартості плати за приєднання, тис. грн.</td>
            <td><html:text name="DetalViewActionForm" property="sum_other_price" size="8" styleId="2_9"
                           styleClass="dataobjects"/></td>
        </tr>
    </table>
</html:form>

