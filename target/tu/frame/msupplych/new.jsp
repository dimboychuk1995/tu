<%--
    Document   : new
    Created on : 14 лют 2011, 10:38:05
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="../../js/jquery-1.4.min.js"></script>
        <script type="text/javascript" src="../../js/jquery-ui-1.7.2.custom.min.js"></script>
        <!--<link type="text/css" rel="stylesheet" href="../../css/flick/jquery-ui-1.7.2.custom.css"/>-->
        <link rel="stylesheet" type="text/css" href="../../codebase/jquery-ui-1.7.2.custom.css" />
        <link type="text/css" rel="stylesheet" href="../../button/style.css"/>
        <script  type="text/javascript" src="../../codebase/jquery.cookie.js"></script>
        <script  type="text/javascript" >
            $(document).ready(function(){
                $('.red').hide();
                $("#tabs").tabs();
                var rem_id =$.cookie("rem_id");
                console.log(checkDodDeal());
                
                //запит для чевоних(RTR) ПС
                $.ajax({
                    url: '/tu/getRTR?rem_id='+rem_id,
                    dataType : "json",
                    success: function (data) {
                        var temp= (data.ps).toString();
                        var arr = temp.split(',');
                        for(i=0;i<=arr.length;i++){
                            $("#ps_10_disp_name [value='"+arr[i]+"']").css({color:"red"});
                        }
                        showRed();
                    }
            });
                
            calc('10');
            calc('35');
            calc('110');
                
            $('#spisok_tp').click(function(){
                var ps_name;
                ps_name=$("#ps_10_disp_name").attr("value");
                window.open('../xls_zavant.jsp?ps_10_disp_name='+ps_name);
            });
                
            $("#ps_10_disp_name").change(function(){
                calc('10');
                showRed();
            });
            $("#ps_35_disp_name").change(function(){
                calc('35');
            });
            $("#ps_110_disp_name").change(function(){
                calc('110');
            });
        });
        function showRed() {
            var index = $("#ps_10_disp_name").val();
            if(document.querySelectorAll("#ps_10_disp_name [value='"+index+"']")[0].style.color == 'red')
                $('.red').show();
            else $('.red').hide();
        }
        function checkDodDeal() {
             var tuid = "<%=request.getParameter("tu_id")%>";
             var check = false;
                $.ajax({
                    url: '../ajax/checkDodDeal.jsp?tu_id='+tuid,
                    async: false,
                    //dataType : "json",
                    success: function (data) {
                       if (data=='true') check=true;     
                    }
            });
            return check;
        }
        function isNumeric(n) {
            return !isNaN(parseFloat(n)) && isFinite(n);
        }
        function calc(type){
            var id = $("#ps_"+type+"_disp_name").attr("value");
            var ps =$("#ps_"+type+"_disp_name :selected").text();
            var ps_red =$("#ps_10_disp_name :selected");
            var ps_selected =$("#ps_"+type+"_disp_name :selected"); 
                
            var tuid = "<%=request.getParameter("tu_id")%>";
            $("#ps_"+type+"_reserv").attr("value","");
            //alert('ajax.jsp?ps_id='+id+"&tu_id="+tuid);
            $.ajax({
                url: 'ajax'+type+'.jsp?ps_id='+id+"&tu_id="+tuid+"&ps="+ps,
                dataType : "json",
                success: function (data, textStatus) {
                    $("#ps_"+type+"_u").attr("value",data.ps_u);
                    $("#ps_"+type+"_nom").attr("value",data.ps_nom);
                    var ps_zav_tr =data.ps_zav;
                    var d_p=(data.p_max*1/(data.koef)-data.sum_pow-data.ps_rez+parseFloat(data.pow));
                    var p_max_new=$("#ps_"+type+"_pow_after_rec").attr("value");
                    var ps_inc_rez=(p_max_new-(data.p_max))/data.koef;
                    if(ps_zav_tr > 70){ alert('Увага завантаженість перевищує 70 %'); }
                    $("#ps_"+type+"_zav_tr").attr("value",ps_zav_tr);
                    $("#ps_"+type+"_u_rez").attr("value",data.ps_rez);
                    if(!checkDodDeal()){
                            console.log('виконано');
                        }else{
                            console.log('невиконано'); 
                        }
                    if(isNumeric(d_p)){
                        $("#ps_"+type+"_reserv").attr("value",(d_p.toFixed(3)))};
                    if(isNumeric(ps_inc_rez)&&p_max_new!=0.0){
                        if(!checkDodDeal()){
                            $("#ps_"+type+"_inc_rez").attr("value",ps_inc_rez.toFixed(3));
                            console.log('виконано');
                        }else{
                            console.log('невиконано'); 
                        }
                        
                    };
                    $("#ps_"+type+"_sum_pow").attr("value",data.sum_pow);
                    $("#ps_"+type+"_k_vuk").attr("value",data.koef);
                }
            });
        }
        </script>
        <title>JSP Page</title>
    </head>
    <body>
        <html:form action="/frame/msupplych/new">
            <a href="show.jsp?tu_id=<%=request.getParameter("tu_id")%>"><h1>Вернутись до списку приєднань</h1></a>
            <input type="hidden" name="tu_id" value="<%=request.getParameter("tu_id")%>"/>
            <html:hidden property="id" />
            <div id="tabs">
                <ul>
                    <li><a href="#tabs-0">Загальні дані</a></li>
                    <li><a href="#tabs-1">ЛЕП 0,4 кВ</a></li>
                    <li><a href="#tabs-2">ТП 10(6)/0,4 кВ</a></li>
                    <li><a href="#tabs-3">ЛЕП, 10(6) кВ</a></li>
                    <li><a href="#tabs-4">ПС 35/10</a></li>
                    <li><a href="#tabs-5">ЛЕП, 35кВ</a></li>
                    <li><a href="#tabs-6">ПС 110/35/10</a></li>
                    <li><a href="#tabs-7">ЛЕП, 110кВ</a></li>
                </ul>
                <div id="tabs-0">
                    <table border="0">
                        <tr>
                            <td><bean:message key="Supplychain.Join_point" /></td>
                            <td>
                                <html:select  property="join_point" onchange="dataSelectjoin_point(this.form)" styleClass="suplychain" >
                                    <html:option value="0">--</html:option>
                                    <html:option value="1">C4.1 Напруга 0.4 кВ 2</html:option>
                                    <html:option value="11">C4.1 Напруга 0.23 кВ 2</html:option>
                                    <html:option value="2">C4.0 Напруга 0.4 кВ 2</html:option>
                                    <html:option value="21">C4.0 Напруга 0.23 кВ 2</html:option>
                                    <html:option value="3">C3.1 Напруга 10 кВ 2</html:option>
                                    <html:option value="4">C3.0 Напруга 10 кВ 2</html:option>
                                    <html:option value="5">C2.1 Напруга 35 кВ 1</html:option>
                                    <html:option value="6">C2.0 Напруга 35 кВ 1</html:option>
                                    <html:option value="7">C1.1 Напруга 110 кВ 1</html:option>
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td>Точка підключення</td><td><html:text property="selecting_point" styleClass="suplychain" /></td>
                        </tr>
                    </table>
                </div>
                <div id="tabs-1">
                    <table border="0">
                        <tr><td><h2>ЛЕП, 0,4 кВ </h2></td><td></td></tr>
                        <tr>
                            <td>Опора номер</td>
                            <td><html:text property="opor_nom_04"/></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                            <td><html:select property="fid_04_disp_name" styleClass="suplychain">
                                    <html:option value="Л-проектне">Л-проектне</html:option>
                                    <html:option value="Л-1">Л-1</html:option>
                                    <html:option value="Л-2">Л-2</html:option>
                                    <html:option value="Л-3">Л-3</html:option>
                                    <html:option value="Л-4">Л-4</html:option>
                                    <html:option value="Л-5">Л-5</html:option>
                                    <html:option value="Л-6">Л-6</html:option>
                                    <html:option value="Л-7">Л-7</html:option>
                                    <html:option value="Л-8">Л-8</html:option>
                                    <html:option value="Л-9">Л-9</html:option>
                                    <html:option value="Л-10">Л-10</html:option>
                                    <html:option value="Л-11">Л-11</html:option>
                                    <html:option value="Л-12">Л-12</html:option>
                                    <html:option value="Л-13">Л-13</html:option>
                                    <html:option value="Л-14">Л-14</html:option>
                                    <html:option value="Л-15">Л-15</html:option>
                                    <html:option value="Л-16">Л-16</html:option>
                                    <html:option value="Л-17">Л-17</html:option>
                                    <html:option value="Л-18">Л-18</html:option>
                                    <html:option value="Л-19">Л-19</html:option>
                                    <html:option value="Л-20">Л-20</html:option>
                                    <html:option value="Л-21">Л-21</html:option>
                                    <html:option value="Л-22">Л-22</html:option>
                                    <html:option value="Л-23">Л-23</html:option>
                                    <html:option value="Л-24">Л-24</html:option>
                                    <html:option value="Л-25">Л-25</html:option>
                                    <html:option value="Л-26">Л-26</html:option>
                                    <html:option value="Л-27">Л-27</html:option>
                                    <html:option value="Л-28">Л-28</html:option>
                                    <html:option value="Л-29">Л-29</html:option>
                                    <html:option value="Л-30">Л-30</html:option>
                                    <html:option value="Л-31">Л-31</html:option>
                                    <html:option value="Л-32">Л-32</html:option>
                                    <html:option value="Л-33">Л-33</html:option>
                                    <html:option value="Л-34">Л-34</html:option>
                                    <html:option value="Л-35">Л-35</html:option>
                                    <html:option value="Л-36">Л-36</html:option>
                                    <html:option value="Л-37">Л-37</html:option>
                                    <html:option value="Л-38">Л-38</html:option>
                                    <html:option value="Л-39">Л-39</html:option>
                                    <html:option value="Л-40">Л-40</html:option>
                                    <html:option value="Л-41">Л-41</html:option>
                                    <html:option value="Л-42">Л-42</html:option>
                                    <html:option value="Л-43">Л-43</html:option>
                                    <html:option value="Л-44">Л-44</html:option>
                                    <html:option value="Л-45">Л-45</html:option>
                                    <html:option value="Л-46">Л-46</html:option>
                                    <html:option value="Л-47">Л-47</html:option>
                                    <html:option value="Л-48">Л-48</html:option>
                                    <html:option value="Л-49">Л-49</html:option>
                                    <html:option value="Л-50">Л-50</html:option>

                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td>Інвертарний номер ПЛ(КЛ)-0,4 кВ</td>
                            <td><html:text property="inv_num_04"/></td>
                        </tr>
                        <tr>
                            <td>Тип ЛЕП</td>
                            <td><html:select property="fid_04_type_lep" styleClass="suplychain" >
                                    <html:option value="-">-</html:option>
                                    <html:option value="ПЛ">ПЛ</html:option>
                                    <html:option value="КЛ">КЛ</html:option>
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_leng" /></td>
                            <td><html:text property="fid_04_leng" size="8" onkeypress ="isDigit()" styleClass="suplychain"/>
                                <bean:message key="CIkm" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="tabs-2">
                    <table border="0">
                        <tr>
                            <td><h2>Підстанція ТП 10(6)/0,4 кВ</h2></td><td></td>
                            <td>Тип джерела</td>
                            <td>
                                <html:select property="type_source" styleClass="suplychain">
                                    <html:option value="ТП">ТП</html:option>
                                    <html:option value="КТП">КТП</html:option>
                                    <html:option value="ЗТП">ЗТП</html:option>
                                    <html:option value="РП">РП</html:option>
                                    <html:option value="МТП">МТП</html:option>
                                    <html:option value="ГКТП">ГКТП</html:option>
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_disp_name" /></td>
                            <td><html:select property="ps_10_disp_name"  styleClass="suplychain" styleId="ps_10_disp_name">
                                    <html:optionsCollection name="MSupplyChForm" property="ps_10_disp_name_list" label="name" value="id" />
                                </html:select>
                                <html:text property="ps_10_disp_name_tmp"/>
                                
                            </td>
                            <td></td>
                            <td><span class="red" style="color:red; font-size: 12px; border:1px red solid;">На ТП - маршрутизатор!</span></td>
                        </tr>
                        <tr>
                            <td>Інвертарний номер рекунструйованої ТП</td>
                            <td><html:text property="inv_num_tp"/></td>
                        </tr>
                        <tr>
                            <td>Потужність</td>
                            <td><html:text property="power" size="8" onkeypress ="isDigit()" styleClass="suplychain"/></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_u_measurements" /></td>
                            <td><input type="text" id="ps_10_u" readonly="true"/><bean:message key="CIkV"/></td>
                        </tr>
                        <tr>
                            <td>Резерв по ТУ</td>
                            <td><input type="text" id="ps_10_u_rez" readonly="true" name="ps_10_u_rez" /><bean:message key="CIkV"/></td>
                        </tr>
                        <tr>
                            <td>Номінальна потужність трансформаторів</td>
                            <td><input type="text" id="ps_10_nom" readonly="true" />кВА.</td>
                        </tr>

                        <tr>
                            <td>Завантаженість трансформатора</td>
                            <td><input type="text" id="ps_10_zav_tr" readonly="true" />%</td>
                        </tr>
                        <tr>
                            <td><a id="spisok_tp" href="#">Сформувати список ТУ(Резерв потужності)</a></td>
                        </tr>
                        <tr>
                            <td>Резерв приєднаної потужності</td>
                            <td><html:text property="ps_10_reserv" onkeypress ="isDigit()" styleId="ps_10_reserv" styleClass="suplychain"/></td>
                        </tr>
                        <tr>
                            <td>Вартість резерву приєднаної потужності</td>
                            <td><html:text property="ps_10_price_reserv" onkeypress ="isDigit()" styleClass="suplychain"/></td>
                        </tr>
                        <tr>
                            <td>Номінальна потужність підстанції після реконструкції</td>
                            <td><html:text property="ps_10_pow_after_rec" onchange="calc(10)" styleId="ps_10_pow_after_rec" styleClass="suplychain"/></td>
                        </tr>
                        <tr>
                            <td>Сумарна абонована потужність, кВт</td>
                            <td><input type="text" id="ps_10_sum_pow" readonly="true" /></td>
                        </tr>
                        <tr>
                            <td>Коефіцієнт використання потужності</td>
                            <td><input type="text" id="ps_10_k_vuk" readonly="true"/></td>

                        </tr>
                        <tr>
                            <td>Збільшення резерву приєднаної потужності, кВт</td>
                            <td><html:text property="ps_10_inc_rez" styleId="ps_10_inc_rez" styleClass="suplychain"/></td>
                        </tr>
                    </table>
                </div>
                <div id="tabs-3">
                    <table border="0">
                        <tr>
                            <td><h2>ЛЕП, 10(6) кВ </h2></td><td></td>
                        </tr>
                        <tr>
                            <td>Опора номер</td>
                            <td><html:text property="opor_nom_10"/></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                            <td><html:select property="fid_10_disp_name">
                                    <html:optionsCollection name="MSupplyChForm" property="fid_10_disp_name_list" label="name" value="id" styleClass="suplychain"/>
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td>Інвертарний номер рекунструйованої ПЛ 10 кВ</td>
                            <td><html:text property="inv_num_rec_10"/></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_leng"  /></td>
                            <td><html:text  property="fid_10_leng" size="8" styleClass="suplychain"/><bean:message key="CIkm" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="tabs-4">
                    <table border="0">
                        <tr>
                            <td><h2>Підстанція ПС 35/10(6) кВ</h2></td><td></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_disp_name" /></td>
                            <td><html:select property="ps_35_disp_name" styleId="ps_35_disp_name">
                                    <html:optionsCollection name="MSupplyChForm" property="ps_35_disp_name_list" label="name" value="id"/>
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_u_measurements" /></td>
                            <td><input type="text" id="ps_35_u" readonly="true"/>МВт.</td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_u_reserve" /></td>
                            <td><input type="text"  id="ps_35_u_rez" readonly="true" name="ps_35_u_rez" />МВт.</td>
                        </tr>
                        <tr>
                            <td>Номінальна потужність трансформаторів</td>
                            <td><input type="text" id="ps_35_nom" readonly="true" /><bean:message key="CImV"/></td>
                        </tr>

                        <tr>
                            <td>Завантаженість трансформатора</td>
                            <td><input type="text" id="ps_35_zav_tr" readonly="true" />%</td>
                        </tr>
                        <tr>
                            <td>Резерв приєднаної потужності</td>
                            <td><html:text property="ps_35_reserv" onkeypress ="isDigit()" styleId="ps_35_reserv" styleClass="suplychain"/></td>
                        </tr>
                        <tr>
                            <td>Вартість резерву приєднаної потужності</td>
                            <td><html:text property="ps_35_price_reserv" onkeypress ="isDigit()" styleClass="suplychain"/></td>
                        </tr>
                        <tr>
                            <td>Номінальна потужність підстанції після реконструкції</td>
                            <td><html:text property="ps_35_pow_after_rec" onchange="calc(35)" styleId="ps_35_pow_after_rec" styleClass="suplychain"/></td>
                        </tr>
                        <tr>
                            <td>Сумарна абонована потужність, кВт</td>
                            <td><input type="text" id="ps_35_sum_pow" readonly="true" /></td>
                        </tr>
                        <tr>
                            <td>Коефіцієнт використання потужності</td>
                            <td><input type="text" id="ps_35_k_vuk" readonly="true"/></td>

                        </tr>
                        <tr>
                            <td>Збільшення резерву приєднаної потужності, кВт</td>
                            <td><input type="text" id="ps_35_inc_rez" /></td></td>
                        </tr>

                    </table>
                </div>
                <div id="tabs-5">
                    <table border="0">
                        <tr>
                            <td><h2>ЛЕП, 35 кВ </h2></td><td></td>
                        </tr>
                        <tr>
                            <td>Опора номер</td>
                            <td><html:text property="opor_nom_35"/></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                            <td><html:select property="fid_35_disp_name">
                                    <html:optionsCollection name="MSupplyChForm" property="fid_35_disp_name_list" label="name" value="id"/>
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_leng" /></td>
                            <td><input type="text" name="fid_35_leng" />
                                <bean:message key="CIkm" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="tabs-6">
                    <table border="0">
                        <tr>
                            <td><h2>Підстанція 110/35/10(6) кВ</h2></td><td></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_disp_name" /></td>
                            <td><html:select property="ps_110_disp_name" styleId="ps_110_disp_name">
                                    <html:optionsCollection name="MSupplyChForm" property="ps_110_disp_name_list" label="name" value="id"/>
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_u_measurements" /></td>
                            <td><input type="text" id="ps_110_u" />МВт.</td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_u_reserve" /></td>
                            <td><input type="text"  id="ps_110_u_rez" readonly="true" name="ps_110_u_rez" />МВт.</td>
                        </tr>
                        <tr>
                            <td>Номінальна потужність трансформаторів</td>
                            <td><input type="text" id="ps_110_nom" /><bean:message key="CImV"/></td>
                        </tr>
                        <tr>
                            <td>Завантаженість трансформатора</td>
                            <td><input type="text" id="ps_110_zav_tr" readonly="true" />%</td>
                        </tr>
                        <tr>
                            <td>Резерв приєднаної потужності</td>
                            <td><html:text property="ps_110_reserv" onkeypress ="isDigit()" styleId="ps_110_reserv" styleClass="suplychain"/></td>
                        </tr>
                        <tr>
                            <td>Вартість резерву приєднаної потужності</td>
                            <td><html:text property="ps_110_price_reserv"  onkeypress ="isDigit()" styleClass="suplychain"/></td>
                        </tr>
                        <tr>
                            <td>Номінальна потужність підстанції після реконструкції</td>
                            <td><html:text property="ps_110_pow_after_rec" onchange="calc(110)" styleId="ps_110_pow_after_rec" styleClass="suplychain"/></td>
                        </tr>
                        <tr>
                            <td>Сумарна абонована потужність, кВт</td>
                            <td><input type="text" id="ps_110_sum_pow" readonly="true" /></td>
                        </tr>
                        <tr>
                            <td>Коефіцієнт використання потужності</td>
                            <td><input type="text" id="ps_110_k_vuk" readonly="true"/></td>

                        </tr>
                        <tr>
                            <td>Збільшення резерву приєднаної потужності, кВт</td>
                            <td><input type="text" id="ps_110_inc_rez" readonly="true"/></td></td>
                        </tr>
                    </table>
                </div>
                <div id="tabs-7">
                    <table border="0">
                        <tr>
                            <td><h2>ЛЕП, 110 кВ </h2></td><td></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                            <td><html:select property="fid_110_disp_name">
                                    <html:optionsCollection name="MSupplyChForm"  property="fid_110_disp_name_list" label="name" value="id"/>
                                </html:select>

                            </td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_leng" /></td>
                            <td><html:text  property="fid_110_leng" size="8" /><bean:message key="CIkm" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <html:submit property="method" value="update" styleClass="button_save"/>
        </html:form>
    </body>
</html>
