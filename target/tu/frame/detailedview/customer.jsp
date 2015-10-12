<%-- 
    Document   : customer
    Created on : 10 лют 2010, 8:38:45
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1

    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
//HttpSession ses=request.getSession();
//loginActionForm login=(loginActionForm)ses.getAttribute("log");
//String id_rem = login.getUREM_ID();
    //String id_rem = ua.ifr.oe.tc.list.MyCoocie.getCoocie("UREM_ID", request);
    String rem = ua.ifr.oe.tc.list.MyCoocie.getCoocie("rem_id", request);
%>
<script type="text/javascript" src="detailedview/js/customer_01.js"></script>
<script type="text/javascript" src="detailedview/js/myscript.js"></script>
<script type="text/javascript" src="detailedview/js/multiedit.js"></script>
<script type="text/javascript">
    function my(){
        if ($("#type_join").val()=='1'){
            $("#stage_join [value='3'],#stage_join [value='4'],#stage_join [value='5'],#stage_join [value='7']").attr("disabled","disabled");
            $("#stage_join [value='0'],#stage_join [value='1'], #stage_join [value='2']").removeAttr("disabled");
        }  else
            if ($("#type_join").val()=='2'){
                $("#stage_join [value='1']").attr("disabled","disabled");
                $("#stage_join [value='0'],#stage_join [value='2'],#stage_join [value='3'],#stage_join [value='4'],#stage_join [value='5'],#stage_join [value='7']").removeAttr("disabled");
            }
        else {
            $("#stage_join [value='1'],#stage_join [value='2'],#stage_join [value='3'],#stage_join [value='4'],#stage_join [value='7']").attr("disabled","disabled");
            $("#stage_join [value='0'],#stage_join [value='5']").removeAttr("disabled");    
        }
    };
    $(document).ready(function(){
        $("#1_1").change(function(){ cust_soc_stat_ch();    });
        $("#type_contract_sel").change(function(){ main_cont();});
        $(".datepicker").datepicker();
        cust_soc_stat_ch();
        main_cont();
        multiedit();
        my();
        permision();
        
        
        $("#b_numb_zver").click(function (){
            var num_zv =$("#numb_zver").val();
            if ($.trim(num_zv) !='') {
                $.ajax({
                    url: '../AppealsImport',
                    type: 'get',
                    data: {"num_zv":num_zv,"rem_id":'<%=rem%>'},
                    dataType : "json",
                    success: function (data, textStatus) {
                        if(data.ClientKind=="1"){           
                            $("#f_name").val(data.l_nm);
                            $("#s_name").val(data.f_nm);
                            $("#l_name").val(data.s_nm);
                            $("#cds").val("паспорт серія "+data.pas_ser+" №"+data.pas_no+" виданий "+data.pas_vud);
                            $("#ident_no").val(data.ident_no);
                            $("#telephone").val(data.tel+" "+data.mob_tel);
                            $("#acc_no").val(data.acc_no);
                            $("#cust_adr").val((data.phiz_adr).replace(/&#034;/gi,'"').replace(/&#039;/gi,"'"));
                        } else {
                            $("#juridical_txt").val((data.jur_nm).replace(/&#034;/gi,'"').replace(/&#039;/gi,"'"));
                            $("#f_name").val(data.jur_pip_f);
                            $("#s_name").val(data.jur_pip_s);
                            $("#l_name").val(data.jur_pip_l);
                            $("#mfo").val((data.mfo).replace(/&#034;/gi,'"').replace(/&#039;/gi,"'"));
                            $("#cust_adr").val((data.jur_adr).replace(/&#034;/gi,'"').replace(/&#039;/gi,"'"));
                            $("#telephone").val(data.phone_j);
                            $("#acc_no").val(data.roz_rah);
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert('Помилка: споживача не існує!');
                    }
                })
                }
            else{
                alert('Введіть номер!');
            }
        }
    )
    });
</script>


<html:form action="/frame/detailedview/customer">
    <input type="hidden" name="bdname" value="<%=request.getParameter("bdname")%>">
    <table border="0">
        <tr>
            <td>Ввести номер з програми "Звернення":</td>
            <td><input type="text" id="numb_zver"/> <input type="button" value="Імпортувати" id="b_numb_zver" class="ui-state-default ui-corner-all"/></td>
        </tr>
        <tr>
            <td>Соціальний статус</td>
            <td><html:select  styleId="1_1" styleClass="customer" property="customer_soc_status" >
                    <html:optionsCollection name="DetalViewActionForm" property="customer_soc_status_list" label="name" value="id"/>
                </html:select>
            </td>
        </tr>
        <tr>
            <td>Споживач:</td>
            <td><h3 id="customer_type_div"></h3><html:hidden name="DetalViewActionForm" property="customer_type" styleId="customer_type_hid"/></td>
        </tr>
        <tr>
            <td><bean:message key="customer.type_contract" /></td>
            <td><html:select styleId="type_contract_sel" styleClass="customer" property="type_contract" >
                    <html:optionsCollection name="DetalViewActionForm" property="type_contract_list"
                                            label="name" value="id"/>
                </html:select>
            </td>
        </tr>
        <tr>
            <td>Тип приєднання:</td>
            <td><html:select  property="type_join" styleId="type_join" styleClass="dataobjects" onchange="my();">
                    <html:optionsCollection name="DetalViewActionForm" property="typeJoinList"
                                            label="name" value="id"/>
                </html:select>
            </td>
        </tr>
        <tr>
            <td>Ступінь приєднання:</td>
            <td><html:select  property="stage_join" styleId="stage_join" styleClass="stage_join">
                    <html:optionsCollection name="DetalViewActionForm" property="stageJoinList"
                                            label="name" value="id"/>
                </html:select>
            </td>
        </tr>
        <tr id="main_contract_div">
            <td><bean:message key="customer.main_contract" /></td>
            <td><html:select property="main_contract" styleClass="customer" >
                    <html:option value="0">Виберіть ТУ</html:option>
                    <html:optionsCollection name="DetalViewActionForm" property="main_contract_list"  label="name" value="id"/>
                </html:select>
            </td>
        </tr>
        <tr>
            <td><bean:message key="customer.registration_date" /></td>
            <td><html:text name="DetalViewActionForm" property="egistration_date" styleClass="datepicker customer" size="10"/> </td>
        </tr>
        <tr>
            <td><bean:message key="customer.no_zvern" /></td>
            <td><html:text name="DetalViewActionForm" property="no_zvern" styleClass="customer"/> </td>
        </tr>
        <tr id="juridical_div">
            <td><bean:message key="customer.juridical" /></td>
            <td><html:text styleId="juridical_txt" styleClass="customer" name="DetalViewActionForm"  property="juridical" size="70"/></td>
        </tr>
        <tr>
            <td><bean:message key="customer.customer_name" /></td>
            <td>
                <html:text name="DetalViewActionForm" property="f_name" size="20" styleClass="customer" styleId="f_name"/>
                <html:text name="DetalViewActionForm" property="s_name" size="10" styleClass="customer" styleId="s_name"/>
                <html:text name="DetalViewActionForm" property="t_name" size="10" styleClass="customer" styleId="l_name"/>
            </td>
        </tr>
        <tr>
            <td>Посада керівника</td>
            <td><html:text name="DetalViewActionForm" property="customer_post" styleClass="customer"/></td>
        </tr>
        <tr>
            <td colspan="2"><bean:message key="customer.constitutive_documents" /><br/>
                <div style="float:left" class="multi_edit">
                    <html:textarea name="DetalViewActionForm" property="constitutive_documents" cols="100" styleId="cds" styleClass="customer edit" />
                    <div class="multiedit" ><img src="../codebase/imgs/edit3.bmp" alt="..."/></div>
                    <div class="hide_list" style="display:none">
                        <input type="radio" /><span>Довіреності № від року</span><br/>
                        <input type="radio" /><span>Свідоцтва про державну реєстрацію фізичної особи-підприємця серія  № виданого, дата проведення державної реєстрації року,№ </span><br/>
                        <input type="radio" /><span>Закону України "Про місцеве самоврядування"</span><br/>
                        <input type="radio" /><span>Статуту № зареєстрованого  від року</span><br/>
                        <input type="radio" /><span>паспорт серія №  виданий року</span><br/>
                        <input type="radio" /><span>Виписка з єдиного державного реєстру фізичної особи-підприємця серія  № видана, дата року </span><br/>
                    </div>
                </div>
            </td>
        </tr>
        <tr><td colspan="2"><hr></td></tr>
        <tr>
            <td><bean:message key="customer.bank_account"/></td>
            <td><html:text name="DetalViewActionForm" property="bank_account" styleClass="customer" styleId="acc_no"/></td>
        </tr>
        <tr>
            <td><bean:message key="customer.bank_mfo"/></td>
            <td><html:text name="DetalViewActionForm" property="bank_mfo" size="70" styleClass="customer" styleId="mfo"/></td>
        </tr>
        <tr>
            <td><bean:message key="customer.bank_identification_number"/></td>
            <td><html:text name="DetalViewActionForm" property="bank_identification_number" styleClass="customer" styleId="ident_no"/></td>
        </tr>
        <tr>
            <td>Свідоцтво платника податків</td>
            <td><html:text name="DetalViewActionForm" property="taxpayer" styleClass="customer" styleId="taxpayer"/></td>
        </tr>
        <tr><td colspan="2"><hr></td></tr>
        <tr>
            <td> <bean:message key="customer.customer_adress" /></td>
            <td> <html:select  property="customer_locality" styleClass="customer">
                    <html:option value="0">Виберіть населений пункт</html:option>
                    <html:optionsCollection name="DetalViewActionForm" property="locality_list1"
                                            label="name" value="id"/>
                </html:select>
            </td>
        </tr>
        <tr>
            <td><bean:message key="customer.customer_adress_str" /></td>
            <td><html:text name="DetalViewActionForm" property="customer_adress" size="70" styleClass="customer" styleId="cust_adr"/></td>
        </tr>
        <tr>
            <td>Телефон</td>
            <td><html:text name="DetalViewActionForm" property="customer_telephone" size="70" styleClass="customer" styleId="telephone"/></td>
        </tr>
        <tr>
            <td>Поштовий індекс</td>
            <td><html:text name="DetalViewActionForm" property="customer_zipcode" size="70" styleClass="customer"/></td>
        </tr>
    </table>
</html:form>