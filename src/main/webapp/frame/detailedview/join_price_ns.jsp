
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            $(document).ready(function(){
                $("#tabs").tabs();
                $("#tabs").tabs('option', 'cache', true);
                $("#date_pay_ns").datepicker();
                 permision();
                 if ($('#ch_rez1').is(':checked')){
                     $('#tb1').remove();
                     $('#tabs-1').remove();
                 }
                 else if ($('#ch_rez2').is(':checked')){
                      $('#tb0').remove();
                      $('#tabs-0').remove();
                 }

                 else alert("Невибрано резерв!");
                $('#ch_rez1').click( function(){
                    $('#ch_rez2').attr('checked', false);
                    $('#ch_rez2').after('<input type="hidden" name="ch_rez2" value="false" id="ch_rez2"/>');
                    if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="ch_rez1" value="false" id="ch_hidden1"/>');
                });
                $('#ch_rez2').click( function(){
                    $('#ch_rez1').attr('checked', false);
                    $('#ch_rez1').after('<input type="hidden" name="ch_rez1" value="false" id="ch_rez1"/>');
                    if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="ch_rez2" value="false" id="ch_hidden2"/>');
                });
                calc_price_ns();

            });
            function calc_price_ns() {
                var tuid = "<%=request.getParameter("tu_id")%>";
                if(tuid!=-1)
                $.ajax({
                    url: 'ajax/join_price_calc_ns_b.jsp?tu_id='+tuid,
                    dataType : "json",
                    success: function (data, textStatus) {
                        $("#ch_rez1").attr("value",parseFloat(data.ch_rez1));
                        $("#ch_rez2").attr("value",parseFloat(data.ch_rez2));
                        $("#price_el_dev").attr("value",parseFloat(data.price_el_dev));
                        $("#price_el_dev_1").val(parseFloat(data.price_el_dev_1));
                        $("#p_price_join").attr("value",parseFloat(data.p_price_join));
                        $("#customer_participate").attr("value",parseFloat(data.customer_participate));
                        $("#pdv").attr("value",parseFloat(data.price_el_dev*.2).toFixed(2));
                        $("#pdv1").attr("value",parseFloat(data.price_el_dev_1*.2).toFixed(2));
                        $("#price_join_nsj").attr("value",(parseFloat(data.price_el_dev*1.2).toFixed(2)));
                        $("#price_join_nsj1").attr("value",(parseFloat(data.price_el_dev_1*1.2).toFixed(2)));
                    }
                })};
        </script>
    </head>
    <body>
        <table border="0">
            <tr>
                <td>Резерв приєднаної потужності на дату укдадання договору</td>
                <td><html:text name="DetalViewActionForm" property="rez_pow_for_date" styleId="rez_pow_for_date"/></td>
            </tr>
            <tr>
                <td>Дата оплати</td>
                <td><html:text name="DetalViewActionForm" property="date_pay_ns" styleId="date_pay_ns"/></td>
            </tr>
            <tr>
                <td>Сума оплати у випадку відмінності від вартості плати за приєднання, тис. грн.</td>
                <td><html:text name="DetalViewActionForm" property="sum_other_price_ns"/></td>
            </tr>
            <tr>
                <td>Потужність(нестандартне(Поле тільки для читання))</td>
                <td><input type="text" id="power_join_nonstandart" readonly="true"/></td>
            </tr>
        </table>


        <h2><center>Порівняйте резерв потужності та замовлену потужність</center></h2>
        <div align="center" style="font-size: 16px;">Резерв більший Рзам
            <html:checkbox name="DetalViewActionForm" property="ch_rez1" styleId="ch_rez1" styleClass="ch_rez1"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Резерв менший Рзам
            <html:checkbox name="DetalViewActionForm" property="ch_rez2" styleId="ch_rez2" styleClass="ch_rez2"/>
        </div>
        <div id="tabs">
            <ul>
                <li id="tb0"><a href="#tabs0">Резерв більший Pзам</a></li>
                <li id="tb1"><a href="#tabs1">Резерв менший Pзам</a></li>
            </ul>

        <div id="tabs0">
            <table border="0" >
                <tr>
                    <td>Плата за приєднання електроустановки Замовника, грн.</td>
                    <td><input type="text" id="price_el_dev" readonly="true"/></td>
                </tr>
                <tr>
                    <td>ПДВ, грн</td>
                    <td><input type="text" id="pdv" readonly="true"/></td>
                </tr>
                <tr>
                    <td>Сума оплати, грн</td>
                    <td><input type="text" id="price_join_nsj" readonly="true"/></td>
                </tr>
            </table>
        </div>
        <div id="tabs1">
            <table border="0" >
                <tr>
                    <td>Питома вартість резерву приєднаної потужності, грн.</td>
                    <td><input type="text" id="p_price_join" readonly="true" /></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>Участь Замовника у фінансуванні капітального будівництва, грн</td>
                    <td><input type="text" id="customer_participate" readonly="true"/></td>
                </tr>
                <tr>
                    <td>Сумарна заявлена до приєднання потужність, кВт.</td>
                    <td><html:text name="DetalViewActionForm" property="sum_join_pow" onchange="calc_price_ns()" styleId="sum_join_pow"/></td>
                </tr>
                <tr>
                    <td>Плата за приєднання електроустановки Замовника, грн.</td>
                    <td><input type="text" id="price_el_dev_1" readonly="true"/></td>
                </tr>
                <tr>
                    <td>ПДВ, грн</td>
                    <td><input type="text" id="pdv1" readonly="true"/></td>
                </tr>
                <tr>
                    <td>Сума оплати, грн</td>
                    <td><input type="text" id="price_join_nsj1" readonly="true"/></td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
