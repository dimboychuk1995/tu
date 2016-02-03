<%-- 
    Document   : dataobjects
    Created on : 10 лют 2010, 8:45:34
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
//HttpSession ses=request.getSession();
//loginActionForm login=(loginActionForm)ses.getAttribute("log");
//String id_rem = login.getUREM_ID();
            String rem = ua.ifr.oe.tc.list.MyCoocie.getCoocie("rem_id", request);
%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<script type="text/javascript" src="detailedview/js/dataobjects.js"></script>
<script type="text/javascript" src="detailedview/js/multiedit.js"></script>
<script type="text/javascript" src="detailedview/js/myscript.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('#findByAddress').click(function(){
            city = $("select[name='name_locality'] option:selected").text();
            address = $("input[name='object_adress']").val();
            window.location = "blank/addresses.jsp?city="+city+"&address="+address;
        });
        var num_zv =$("#numb_zver").val();
        if ($.trim(num_zv) !='') {
                $.ajax({
                    url: '../AppealsImport',
                    type: 'get',
                    data: {"num_zv":num_zv,"rem_id":'<%=rem%>'},
                    dataType : "json",
                    success: function (data, textStatus) {
                        if(data.ClientKind=="1"){           
                           if(data.phiz_adr_o!='') $("#obj_adr").val((data.phiz_adr_o).replace(/&#034;/gi,'"').replace(/&#039;/gi,"'"));//Дані про об"єкт
                        } else {
                            if(data.obj_name!='')  $("#object_name").val((data.obj_name).replace(/&#034;/gi,'"').replace(/&#039;/gi,"'"));//Дані про об"єкт
                            if(data.phjur_adr!='') $("#obj_adr").val((data.phjur_adr).replace(/&#034;/gi,'"').replace(/&#039;/gi,"'"));//Дані про об"єкт
                        }
                    }
                })
                };
         permision();
        $(".datepicker").datepicker();
        $('.ch_1').click( function(){
            if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="reliabylity_class_1" value="false"/>');;
        });
        $('.ch_2').click( function(){
            if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="reliabylity_class_2" value="false"/>');;
        });
        $('.ch_3').click( function(){
            if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="reliabylity_class_3" value="false"/>');;
        });
        $('.ch_11').click( function(){
            if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="reliabylity_class_1_old" value="false"/>');;
        });
        $('.ch_21').click( function(){
            if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="reliabylity_class_2_old" value="false"/>');;
        });
        $('.ch_31').click( function(){
            if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="reliabylity_class_3_old" value="false"/>');;
        });
        $('.ch_4').click( function(){
            if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="reliabylity_class_1_build" value="false"/>');;
        });
        $('.ch_5').click( function(){
            if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="reliabylity_class_2_build" value="false"/>');;
        });
        $('.ch_6').click( function(){
            if (! $(this).is(':checked')) $(this).after('<input type="hidden" name="reliabylity_class_3_build" value="false"/>');;
        });
    <%--!dataobjectsacces("<%=id_rem%>","<bean:write name="DetalViewActionForm" property="initial_registration_date_rem_tu" />");--%>
            multiedit();
        });
</script>
<style>
#findByAddress { 
  color: blue;
  border: 2px solid transparent;
}
#findByAddress:hover { 
  cursor: pointer;
  border: 2px solid;
}
</style>
<html:form action="/frame/detailedview/dataobjects">
    <table border="0">
        <tr>
            <td><bean:message key="dataobjects.reason_tc"/></td>
            <td><html:select  property="reason_tc" styleId="2_1" styleClass="dataobjects">
                    <html:option value="0">-</html:option>
                    <html:optionsCollection name="DetalViewActionForm" property="reason_tc_list"
                                            label="name" value="id"/>
                </html:select>
            </td>
        </tr>
        <tr>
            <td><bean:message key="dataobjects.object_name" /></td>
            <td><html:text name="DetalViewActionForm" property="object_name" size="50" styleId="object_name" styleClass="dataobjects"/></td>
        </tr>
        <tr>
            <td>Функціональне призначення об'єкта</td>
            <td><html:text name="DetalViewActionForm" property="functional_target" size="50" styleId="2_2" styleClass="dataobjects"/></td>
        </tr>
        <tr>
            <td><bean:message key="dataobjects.name_locality"/></td>
            <td><html:select  property="name_locality" styleId="2_6" styleClass="dataobjects">
                    <html:option value="0">Виберіть населений пункт</html:option>
                    <html:optionsCollection name="DetalViewActionForm" property="locality_list"
                                            label="name" value="id"/>
                </html:select>
            </td>					<!-- substation_id -->
        </tr>
        <tr>
            <td><bean:message key="dataobjects.object_adress" /></td>
            <td><html:text name="DetalViewActionForm" property="object_adress" styleId="obj_adr" styleClass="dataobjects"/></td>
            <td><span id="findByAddress">Сформувати список ТУ виданих по даній адресі</span></td>
        </tr>
        <tr>
            <td>Поштовий індекс</td>
            <td><html:text name="DetalViewActionForm" property="object_zipcode"/></td>
        </tr>
        <tr>
            <td><bean:message key="dataobjects.executor_company" /></td>
            <td><html:select  property="executor_company" styleId="2_8" styleClass="dataobjects">
                    <html:option value="0">РЕМ</html:option>
                    <html:option value="1">ВТП</html:option>8ik
                </html:select>
            </td>
        </tr>
        <tr>
            <td><bean:message key="dataobjects.connection_price" />, грн.</td>
            <td><html:text name="DetalViewActionForm" property="connection_price"  size="8" styleId="2_9" styleClass="dataobjects" /></td>
        </tr>
        <tr>
            <td><bean:message key="dataobjects.tc_pay_date" /></td>
            <td><html:text name="DetalViewActionForm" property="tc_pay_date"  size="10" styleId="2_10" styleClass="dataobjects datepicker"/></td>		<!--  -->
        </tr>
        <tr>
            <td>Дата введення в експлуатацію</td>
            <td><html:text name="DetalViewActionForm" property="date_intro_eksp" size="10"  styleClass="dataobjects datepicker"/></td>		<!--  -->
        </tr>
        <tr>
            <td>Вартість виїзду на об'єкт (без ПДВ), грн</td>
            <td><html:text name="DetalViewActionForm" property="price_visit_obj" size="10"  styleClass="dataobjects"/></td>		<!--  -->
        </tr>
        <tr>
            <td>Географічні координати точки підключення</td>
            <td><html:text name="DetalViewActionForm" property="geo_cord_1"/></td>
        </tr>
        <tr>
            <td>Географічні координати точки забезпечення потужності</td>
            <td><html:text name="DetalViewActionForm" property="geo_cord_2"/></td>
        </tr>
        <tr>
            <td colspan="2"><%--bean:message key="dataobjects.connection_treaty_number" /--%> Точка приєднання<br/>
                <div style="float:left" class="multi_edit">
                    <html:textarea name="DetalViewActionForm" property="connection_treaty_number" cols="100" rows="4" styleId="2_11"  styleClass="dataobjects edit" />
                    <div id="ct" class="multiedit" ><img src="../codebase/imgs/edit3.bmp" alt="..."/></div>
                    <div id="ctf" class="hide_list" style="display:none" >
                        <input type="radio" /><span>на вихідних клемах приладу обліку . </span><br/>
                        <input type="radio" /><span>на вихідних контактах комутуючого пристрою 0,4 кВ в РП-0,4 кВ проектної ТП 10(6)/0,4 кВ. </span><br/>
                        <input type="radio" /><span>на вихідних контактах комутуючого пристрою 0,4 кВ в РП-0,4 кВ ТП-.</span><br/>
                        <input type="radio" /><span>на виходах проводу із натяжного затискача на опорі 0,4 кВ № ПЛ-0,4 кВ Л- від ТП-.</span><br/>
                        <input type="radio" /><span>на виходах проводу із натяжного затискача на опорі 0,23 кВ № ПЛ-0,23 кВ Л- від ТП-.</span><br/>
                        <input type="radio" /><span>у ВРП-0,4 кВ будинку.</span><br/>
                        <input type="radio" /><span>на вихідних контактах лінійного роз’єднувача на опорі  № ПЛ-10 кВ приєднання "". </span><br/>
                        <input type="radio" /><span>на вихідних контактах лінійного роз’єднувача на опорі  № ПЛ-6 кВ приєднання "". </span><br/>
                        <input type="radio" /><span>на вхідних контактах роз’єднувача  кВ на відгалужувальній опорі № ЛЕП- кВ приєднання " ".</span><br/>
                        <input type="radio" /><span>на вихідних контактах комутуючого пристрою  кВ в РП- кВ РП- .</span><br/>
                        <input type="radio" /><span>на виходах проводу із натяжного затискача 10 кВ на опорі № ПЛ-10 кВ приєднання "". </span><br/>
                        <input type="radio" /><span>на виходах проводу із натяжного затискача 6 кВ на опорі № ПЛ-6 кВ приєднання "". </span><br/>
                    </div>
                </div>
            </td>
        </tr>
           <tr>
            <td colspan="2"><%--bean:message key="dataobjects.connection_treaty_number" /--%> Точка забезпечення потужності<br/>
                <div style="float:left" class="multi_edit">
                    <html:textarea name="DetalViewActionForm" property="point_zab_power" cols="100" rows="4" styleId="2_11"  styleClass="dataobjects edit" />
                    <div id="ct" class="multiedit" ><img src="../codebase/imgs/edit3.bmp" alt="..."/></div>
                    <div id="ctf" class="hide_list" style="display:none" >
                        <input type="radio" /><span>на вихідних контактах комутуючого пристрою 0,4 кВ в РП-0,4 кВ проектної ТП 10(6)/0,4 кВ. </span><br/>
                        <input type="radio" /><span>на вихідних контактах комутуючого пристрою 0,4 кВ в РП-0,4 кВ ТП-.</span><br/>
                        <input type="radio" /><span>на виходах проводу із натяжного затискача на опорі 0,4 кВ № ПЛ-0,4 кВ Л- від ТП-.</span><br/>
                        <input type="radio" /><span>на виходах проводу із натяжного затискача на опорі 0,23 кВ № ПЛ-0,23 кВ Л- від ТП-.</span><br/>
                        <input type="radio" /><span>у ВРП-0,4 кВ будинку.</span><br/>
                        <input type="radio" /><span>на вихідних контактах лінійного роз’єднувача на опорі  № ПЛ-10 кВ приєднання "". </span><br/>
                        <input type="radio" /><span>на вихідних контактах лінійного роз’єднувача на опорі  № ПЛ-6 кВ приєднання "". </span><br/>
                        <input type="radio" /><span>на вхідних контактах роз’єднувача  кВ на відгалужувальній опорі № ЛЕП- кВ приєднання " ".</span><br/>
                        <input type="radio" /><span>на вихідних контактах комутуючого пристрою  кВ в РП- кВ РП- .</span><br/>
                        <input type="radio" /><span>на виходах проводу із натяжного затискача 10 кВ на опорі № ПЛ-10 кВ приєднання "". </span><br/>
                        <input type="radio" /><span>на виходах проводу із натяжного затискача 6 кВ на опорі № ПЛ-6 кВ приєднання "". </span><br/>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <table border="0">
        <tr><td colspan="4"><hr></td></tr>
        <tr>
            <td><bean:message key="dataobjects.reliabylity_class"/></td>
            <td>
                <bean:message key="dataobjects.reliabylity_class_1" />
                <html:checkbox name="DetalViewActionForm" property="reliabylity_class_1" styleId="2_12" styleClass="ch_1"/><p>
                <html:text name="DetalViewActionForm" property="reliabylity_class_1_val" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/>
            </td>
            <td>
                <bean:message key="dataobjects.reliabylity_class_2" />
                <html:checkbox name="DetalViewActionForm" property="reliabylity_class_2" styleId="2_13" styleClass="ch_2"/><p>
                    <html:text name="DetalViewActionForm" property="reliabylity_class_2_val" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/>
            </td>
            <td>
                <bean:message key="dataobjects.reliabylity_class_3" />
                <html:checkbox name="DetalViewActionForm" property="reliabylity_class_3" styleId="2_14" styleClass="ch_3"/><p>
                    <html:text name="DetalViewActionForm" property="reliabylity_class_3_val" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/>
            </td>
        </tr>
        <tr><td colspan="4"><hr></td></tr>
        <tr>
            <td><bean:message key="dataobjects.reliabylity_class"/> (існуюча потужність)</td>
            <td>
                <bean:message key="dataobjects.reliabylity_class_1" />
                <html:checkbox name="DetalViewActionForm" property="reliabylity_class_1_old" styleId="2_12" styleClass="ch_11"/><p>
                <html:text name="DetalViewActionForm" property="reliabylity_class_1_val_old" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/>
            </td>
            <td>
                <bean:message key="dataobjects.reliabylity_class_2" />
                <html:checkbox name="DetalViewActionForm" property="reliabylity_class_2_old" styleId="2_13" styleClass="ch_21"/><p>
                    <html:text name="DetalViewActionForm" property="reliabylity_class_2_val_old" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/>
            </td>
            <td>
                <bean:message key="dataobjects.reliabylity_class_3" />
                <html:checkbox name="DetalViewActionForm" property="reliabylity_class_3_old" styleId="2_14" styleClass="ch_31"/><p>
                    <html:text name="DetalViewActionForm" property="reliabylity_class_3_val_old" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/>
            </td>
        </tr>
        <tr><td colspan="4"><hr></td></tr>
        <tr>
            <td>Категорії потужності будівельних струмоприймачів:</td>
            <td>
                <bean:message key="dataobjects.reliabylity_class_1" />
                <html:checkbox name="DetalViewActionForm" property="reliabylity_class_1_build" styleId="2_12" styleClass="ch_4"/><p>
                <html:text name="DetalViewActionForm" property="reliabylity_class_1_val_build" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/>
            </td>
            <td>
                <bean:message key="dataobjects.reliabylity_class_2" />
                <html:checkbox name="DetalViewActionForm" property="reliabylity_class_2_build" styleId="2_13" styleClass="ch_5"/><p>
                    <html:text name="DetalViewActionForm" property="reliabylity_class_2_val_build" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/>
            </td>
            <td>
                <bean:message key="dataobjects.reliabylity_class_3" />
                <html:checkbox name="DetalViewActionForm" property="reliabylity_class_3_build" styleId="2_14" styleClass="ch_6"/><p>
                    <html:text name="DetalViewActionForm" property="reliabylity_class_3_val_build" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/>
            </td>
        </tr>
        <tr><td colspan="4"><hr></td></tr>
        <tr>
            <td colspan="2">Напруга</td>
            <td><html:text name="DetalViewActionForm"  property="voltage" size="8"  onkeypress ="isDigit()" styleId="2_15" styleClass=""/>В</td>
        </tr>
        <tr>
            <td colspan="2"><bean:message key="dataobjects.request_power" /></td>
            <td><html:text name="DetalViewActionForm"  property="request_power" size="8"  onkeypress ="isDigit()" styleId="2_15" styleClass=""/><bean:message key="CIkV"/></td>
        </tr>
        <tr>
            <td colspan="2">Потужність будівельних струмоприймачів:</td>
            <td><html:text name="DetalViewActionForm"  property="build_strum_power" size="8"  onkeypress ="isDigit()" styleId="2_15" styleClass=""/><bean:message key="CIkV"/></td>
        </tr>
        <tr><td colspan="4"><bean:message key="dataobjects.power_for" /></td><td colspan="2"></td></tr>
        <tr>
            <td><bean:message key="dataobjects.power_for_electric_devices"/></td>
            <td><html:text name="DetalViewActionForm" property="power_for_electric_devices" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/></td>
            <td><bean:message key="dataobjects.power_for_environmental_reservation" /></td>
            <td><html:text name="DetalViewActionForm" property="power_for_environmental_reservation" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/></td>
        </tr>
        <tr>
            <td><bean:message key="dataobjects.power_for_emergency_reservation" /></td>
            <td><html:text name="DetalViewActionForm" property="power_for_emergency_reservation" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/></td>
            <td><bean:message key="dataobjects.power_for_technology_reservation" /></td>
            <td><html:text name="DetalViewActionForm" property="power_for_technology_reservation" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/></td>
        </tr>
        <tr>
            <td>електричний підігрів води</td>
            <td><html:text name="DetalViewActionForm" property="power_boil" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/></td>
            <td>стаціонарні електричні плити</td>
            <td><html:text name="DetalViewActionForm" property="power_plit" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/></td>
        </tr>
        <tr>
            <td> існуюча потужність </td>
            <td><html:text name="DetalViewActionForm" property="power_old" size="8" onkeypress ="isDigit()" styleClass=""/><bean:message key="CIkV"/></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Договір про постачання (користування)е/е № та дата</td>
            <td><html:text name="DetalViewActionForm" property="nom_data_dog"/></td>
        </tr>
       
    </table>
</html:form>
