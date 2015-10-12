<%@ page import="com.myapp.struts.loginActionForm" %>
<%--
    Document   : admission
    Created on : 10 лют 2010, 9:03:06
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
//HttpSession ses=request.getSession();
//loginActionForm login=(loginActionForm)ses.getAttribute("log");
//String id_rem = login.getUREM_ID();
    String id_rem = ua.ifr.oe.tc.list.MyCoocie.getCoocie("UREM_ID", request);
    String perm = ua.ifr.oe.tc.list.MyCoocie.getCoocie("permisions", request);
%>
<script type="text/javascript" src="detailedview/js/admission.js"></script>
<script type="text/javascript" src="detailedview/js/access.js"></script>
<script type="text/javascript" src="detailedview/js/myscript.js"></script>


<script type="text/javascript">
    $(document).ready(function(){
         permision();
         var num_zv =$("#numb_zver").val();
        if ($.trim(num_zv) !='') {
                $.ajax({
                    url: 'detailedview/appeals.jsp?num_zv='+num_zv,
                    dataType : "json",
                    success: function (data, textStatus) {
                                
                           if(data.requestDate!='') $("#agreement_date").val(data.requestDate);//Дані про об"єкт
                     
                    }
                })
                };
         
        $('#visible_state').click( function(){
            if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="visible_state" value="false" id="visible_state"/>');;
        });
        $('.offer').click( function(){
            $('.no_offer').attr('checked', false);
            $('.no_offer').after('<input type="hidden" name="no_offer_state" value="false" class="no_offer"/>');
            if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="offer_state" value="false" class="offer"/>');
        });
        $('.no_offer').click( function(){
            $('.offer').attr('checked', false);
            $('.offer').after('<input type="hidden" name="offer_state" value="false" class="offer"/>');
            if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="no_offer_state" value="false" class="no_offer"/>');
        });
        if (("2"!="<%=perm%>")){
            $('#visible_state').attr('disabled', 'disabled');
        };
        if (("2"=="<%=perm%>")||("1"=="<%=perm%>")){
            $('#agreement_date').attr('enabled', 'enabled')
        }else if($('#type_join').val()==1){$('#agreement_date').attr('disabled', 'disabled');}
        $(".datepicker").datepicker();
        $(".time").timepicker();
        comput_total_cost();
        $('#ecetpt').change(function(){comput_total_cost();});
        $('#eaelpt').change(function(){comput_total_cost();});
        });
        function comput_total_cost(){
            var  a = parseFloat($('#ecetpt').attr('value'));
            var  b = parseFloat($('#eaelpt').attr('value'));
            if((!isNaN(a))||(!isNaN(b))){
                if(isNaN(a)){a=0}
                if(isNaN(b)){b=0}
                var c =  a + b;
                $('#etpt').attr('value',c+' ');
            }
      
        };
</script>
<html:form action="/frame/detailedview/admission">
    <table border="0">
        <% HttpSession ses = request.getSession();%>
        <tr>
            <td>Дата подання заявки на проектування</td>
            <td><html:text name="DetalViewActionForm" property="date_z_proj" size="10" styleClass="datepicker design rem"/>
                <html:checkbox name="DetalViewActionForm" property="visible_state" styleId="visible_state" styleClass="ch"/>
            </td>
        </tr>
        <tr>
            <td>Вартість демонтованого устаткування та обладнання, яке підлягає подальшому використання, грн.</td>
            <td><html:text name="DetalViewActionForm" property="unmount_devices_price" styleClass="admission date_vud_zam rem"/></td>
        </tr>
        <tr>
            <td>Тип проекту:</td>
            <td><html:select  property="type_project" styleId="2_8" styleClass="dataobjects">
                    <html:option value="0">Виберіть тип проекту:</html:option>
                    <html:option value="1">Типовий проект</html:option>
                    <html:option value="2">Нетиповий проект</html:option>
                    <html:option value="3">Типовий проект з реконструкцією</html:option>
                </html:select>
            </td>
        </tr>
        <tr>
            <td>Проект повторного використання:</td>
            <td><html:select  property="reusable_project" styleId="2_8" styleClass="dataobjects">
                    <html:optionsCollection name="DetalViewActionForm" property="reusable_project_list"
                                            label="name" value="id"/>
                </html:select>
            </td>
        </tr>
        <tr>
            <td>Вартість розробки проекту, грн.</td>
            <td><html:text name="DetalViewActionForm" property="devellopment_price" styleClass="admission date_vud_zam rem"/></td>
        </tr>        
        <tr>
            <td>Вартість реконструкції будівництва ЛЕП, грн.</td>
            <td><html:text name="DetalViewActionForm" property="price_rec_build" styleClass="admission"/></td>
        </tr>        
        <tr>
            <td>Капітальні витрати на будівництво (реконструкцію) підстанції, грн</td>
            <td><html:text name="DetalViewActionForm" property="cap_costs_build" styleClass="admission"/></td>
        </tr>        
        <tr>
            <td>Фактичні витрати на будівництво (реконструкцію) підстанції, грн.</td>
            <td><html:text name="DetalViewActionForm" property="fact_costs_build" styleClass="admission"/></td>
        </tr>        
        <tr>
            <td>Вартість будівництва(реконструкції) підстанції, грн.</td>
            <td><html:text name="DetalViewActionForm" property="price_rec_tp" styleClass="admission"/></td>
        </tr>        
        <tr>
            <td>Дата оплати за проект</td>
            <td><html:text name="DetalViewActionForm" property="pay_date_devellopment" size="10" styleClass="datepicker dateloc admission rem"/></td>
        </tr>

        <%if (!((loginActionForm) ses.getAttribute("log")).getRole().equals("128")) {%>
        <tr>
            <td>Номер проектного ТП після допуску</td>
            <td><html:text name="DetalViewActionForm" property="number_tp_after_admission" styleClass="admission dateloc rem"/></td>
        </tr>
        
        <tr>
            <td>Загальна вартість виконання ТУ згідно з розробленим (погодженим) ПКД</td>
            <td><html:text name="DetalViewActionForm" property="estimated_total_lump_pitch_tu" styleId="etpt" styleClass="admission date_vud_zam rem"/></td>
        </tr>
        
        <%}%>
        <tr>
            <td>Виконавець робіт по виконанню ТУ</td>
            <td><html:select  property="performer_proect_after_point" styleClass="admAndCon">
                    <html:option value="0">Виберіть виконавця</html:option>
                    <html:optionsCollection name="DetalViewActionForm" property="performer_list"
                                            label="name" value="id"/>
                </html:select>
            </td>
        </tr>
        <tr>
            <td>Виконавець проекту</td>
            <td><html:select  property="develloper_company" styleClass="admAndCon design design rem">
                    <html:option value="0">Виберіть виконавця</html:option>
                    <html:optionsCollection name="DetalViewActionForm" property="performer_list"
                                            label="name" value="id"/>
                </html:select>
            </td>
        </tr>
        <tr>
            <td>Дата погодження проекту/заявки або аркушу змін</td>
            <td><html:text name="DetalViewActionForm" property="agreement_date" size="10" styleId="agreement_date" styleClass="datepicker design rem"/>
                <html:checkbox name="DetalViewActionForm" property="offer_state" styleClass="offer"/>Пропозиції РЕМ з реконструкцією погодили
            </td>
        </tr>
        <tr>
            <td>Дата погодження нетипового проекту стандартного приєднання</td>
            <td><html:text name="DetalViewActionForm" property="ntypical_agreement_date" size="10" styleClass="datepicker"/>
            <html:checkbox name="DetalViewActionForm" property="no_offer_state" styleClass="no_offer"/>Пропозиції РЕМ з реконструкцією не погодили
            </td>
        </tr>
        <tr>
            <td><bean:message key="Design.agreement_price" /> грн.</td>
            <td><html:text name="DetalViewActionForm" property="agreement_price" size="10" onkeypress ="isDigit()" styleClass="design rem"/>
            </td>
        </tr>
        <tr>
            <td><bean:message key="Design.pay_date_devellopment" /></td>
            <td><html:text name="DetalViewActionForm" property="pay_date_agreement" size="10" styleClass="datepicker design rem" />
            </td>
        </tr>
        <tr>
            <td>Дата подання проекту на погодження</td>
            <td><html:text name="DetalViewActionForm" property="date_of_submission" size="10" styleClass="datepicker design rem" />
            </td>
        </tr>
    </table>
</html:form>