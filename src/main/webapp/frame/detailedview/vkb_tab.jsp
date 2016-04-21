<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
    String id_rem = ua.ifr.oe.tc.list.MyCoocie.getCoocie("UREM_ID", request);
%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<html>
<head>
    <script type="text/javascript" src="detailedview/js/myscript.js"></script>
    <script type="text/javascript" src="/tu/resources/plugins/multiselect/jquery.multiple.select.js"></script>
    <link rel="stylesheet" type="text/css" href="/tu/resources/plugins/multiselect/multiple-select.css"/>

    <script type="text/javascript">
        $(document).ready(function(){
            $('.select').multipleSelect({width:128});
            permision();
            $('.ch_1033').click( function(){
                if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="ch_1033" value="false"/>');
            });
            $('.ch_1044').click( function(){
                if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="ch_1044" value="false"/>');
            });
            $(".datepicker").datepicker();

            var perm = $.cookie("permisions");
            if (perm!="-2" && perm!="2") {
                $(":input:not(input[type=checkbox],input[type=button],input[type=hidden],.free),select:not(.free)")
                        .attr('disabled','disabled');
            }
        });
    </script>
</head>
<body>
<html:form action="/frame/detailedview/vkb">
    <table>
        <tr>
            <td>Вид робіт:</td>
            <td><html:select property="type_jobs_vkb">
                    <html:option value="0">-</html:option>
                    <html:option value="1">будівництво</html:option>
                    <html:option value="2">реконструкція</html:option>
                    <html:option value="3">технічне переоснащення</html:option>
                </html:select>
            </td>
            <td>
                Вид ОЗ:
            </td>
            <td>
                <html:select property="type_OZ">
                    <html:option value="0">-</html:option>
                    <html:option value="1">ОЗ 1</html:option>
                    <html:option value="2">ОЗ 2</html:option>
                </html:select>
            </td>
        </tr>
        <tr>
            <td>Виконавець проекту:</td>
            <td width="13%"><html:select property="executor_vkb" styleId="test">
                <html:optionsCollection name="DetalViewActionForm" property="executor_vkb_list" label="name" value="id"/>
            </html:select>
            </td>
        </tr>
        <tr>
            <td>Група ОЗ</td>
            <td>1033<html:checkbox name="DetalViewActionForm" property="ch_1033" styleId="ch_1033" styleClass="ch_1033"/></td>
            <td>1044<html:checkbox name="DetalViewActionForm" property="ch_1044" styleId="ch_1044" styleClass="ch_1044"/></td>
            <td>Заводський номер лічильника №:</td>
            <td><html:text name="DetalViewActionForm" property="counter_number" size="14" styleClass="free"/></td>
        </tr>
        <tr>
            <td>Поле класифікації:</td>
            <td><html:select  property="selectedValues" multiple="true"  styleClass="select free">
                <html:optionsCollection name="DetalViewActionForm" property="selectedValuesList" label="name" value="id"/>
            </html:select>
            </td>
            <td>&nbsp;</td>
            <td>Тип лічильника</td>
            <td><html:text name="DetalViewActionForm" property="counter_type" size="14" styleClass="free"/></td>
        </tr>
        <tr>
            <td>Дата приймання проектних робіт</td>
            <td><html:text name="DetalViewActionForm" property="date_of_reception" size="14" styleClass="datepicker"/></td>
            <td width="8%">&nbsp;</td>
            <td width="8%">Вартість розробки проекту, грн</td>
            <td width="33%" colspan="4"><html:text name="DetalViewActionForm" property="develop_price_proj" size="14"/></td>
        </tr>
        <tr>
            <td>Дата приймання інших витрат</td>
            <td><html:text name="DetalViewActionForm" property="other_date_of_reception" size="14" styleClass="datepicker"/></td>
            <td width="8%">&nbsp;</td>
            <td width="8%">Інші витрати, грн.</td>
            <td width="33%" colspan="4"><html:text name="DetalViewActionForm" property="other_develop_price_proj" size="14"/></td>
        </tr>
        <tr>
            <td>Затверджена кошторисна вартість виконання проекту по відповідному об'єкту, грн.</td>
            <td><html:text name="DetalViewActionForm" property="approved_price" size="14"/></td>
        </tr>
        <tr>
            <td>Виберіть тип ЛЕП:</td>
            <td><html:select property="type_lep_vkb">
                <html:option value="0">-</html:option>
                <html:option value="1">ПЛ</html:option>
                <html:option value="2">КЛ</html:option>
            </html:select>
            </td>
        </tr>
        <tr>
            <td>Необхідність будівництва (реконструкції, переоснащення, модернізації) ПС (ТП) напругою в кВ</td>
            <td><html:text name="DetalViewActionForm" property="need_to_build" size="14"/></td>
        </tr>
        <tr>
            <td>Довжина будівництва/реконструкції ЛЕП  0,4 кВ, км</td>
            <td><html:text name="DetalViewActionForm" property="l_build_04" size="14"/></td>
        </tr>
        <tr>
            <td>Довжина будівництва/реконструкції ЛЕП 10(6) кВ, км</td>
            <td><html:text name="DetalViewActionForm" property="l_build_10" size="14" /></td>
        </tr>
        <tr>
            <td>Довжина будівництва/ реконструкції ЛЕП  35 кВ, км</td>
            <td><html:text name="DetalViewActionForm" property="l_build_35" size="14"/></td>
        </tr>
        <tr>
            <td>Довжина будівництва/ реконструкції ЛЕП 110 кВ, км</td>
            <td><html:text name="DetalViewActionForm" property="l_build_110" size="14"/></td>
        </tr>
        <tr>
            <td>Виконавець будівельно-монтажних робіт:</td>
            <td><html:select property="exec_jobs_vkb">
                <html:optionsCollection name="DetalViewActionForm" property="executor_build_vkb_list" label="name" value="id"/>
            </html:select>
            </td>
        </tr>
        <tr>
            <td>Дата приймання БМР</td>
            <td><html:text name="DetalViewActionForm" property="date_of_reception_bmr" size="14" styleClass="datepicker"/></td>
            <td>&nbsp;</td>
            <td>Вартість будівництва згідно акту, грн</td>
            <td><html:text name="DetalViewActionForm" property="develop_price_akt" size="14"/></td>
        </tr>
        <tr>
            <td>Вартість лічильника, грн</td>
            <td><html:text name="DetalViewActionForm" property="counter_price" size="14"/></td>
        </tr>
        <tr>
            <td>Дата введення в експлуатацію</td>
            <td><html:text name="DetalViewActionForm" property="commissioning_date" size="14" styleClass="datepicker"/></td>
            <td>&nbsp;</td>

            <td>Сума введення, грн</td>
            <td><html:text name="DetalViewActionForm" property="commissioning_price" size="14"/></td>
        </tr>
        <tr>
            <td>Довжина збудованої ПЛ-0,4кВ,км</td>
            <td><html:text name="DetalViewActionForm" property="l_built_pl_04" size="14"/></td>
        </tr>
        <tr>
            <td>Довжина збудованої КЛ-0,4кВ,км</td>
            <td><html:text name="DetalViewActionForm" property="l_built_kl_04" size="14"/></td>
            <td>&nbsp;</td>

            <td>Потужність збудованих ТП:</td>
            <td><html:text name="DetalViewActionForm" property="tp_built_power" size="14"/></td>
        </tr>
        <tr>
            <td>Довжина збудованої ПЛ-10 кВ,км</td>
            <td><html:text name="DetalViewActionForm" property="l_built_pl_10" size="14"/></td>
            <td>&nbsp;</td>

            <td>Кількість збудованих ТП, кВА</td>
            <td><html:text name="DetalViewActionForm" property="tp_built_count" size="14"/></td>
        </tr>
        <tr>
            <td>Довжина збудованої КЛ-10 кВ,км</td>
            <td><html:text name="DetalViewActionForm" property="l_build_kl_10" size="14"/></td>
        </tr>
        <tr>
            <td>Cумісна підвіска проводу</td>
            <td><html:text name="DetalViewActionForm" property="compatible_wire" size="14"/></td>
        </tr>
        <tr>
            <td>Додатковий провід</td>
            <td><html:text name="DetalViewActionForm" property="additional_wire" size="14"/></td>
        </tr>
        <tr>
            <td>Заміна проводу</td>
            <td><html:text name="DetalViewActionForm" property="replace_wire" size="14"/></td>
        </tr>
        <tr>
            <td>Заміна опор, шт.</td>
            <td><html:text name="DetalViewActionForm" property="replace_opora" size="14"/></td>
        </tr>
    </table>
</html:form>
</body>
</html>
