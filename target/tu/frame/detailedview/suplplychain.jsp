<%--
    Document   : suplplychain
    Created on : 22 черв 2010, 9:32:17
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
    //HttpSession ses=request.getSession();
    //loginActionForm login=(loginActionForm)ses.getAttribute("log");
    //String id_rem = login.getUREM_ID();
    String id_rem = ua.ifr.oe.tc.list.MyCoocie.getCoocie("UREM_ID", request);
%>
<script type="text/javascript" src="detailedview/js/suplychain.js"></script>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            $(document).ready(function(){
            <%--! suplychainacces("<%=id_rem%>","<bean:write name="DetalViewActionForm" property="initial_registration_date_rem_tu" />");--%>
                    $(function() {
                        $(".datepicker").datepicker();
                    });
                    $(function() {
                        $("#tabs").tabs();
                    });
                    $(function() {
                        $("#tabs2").tabs();
                    });

                });
        </script>
        <%--      <script>
                  function makeRequest(url,f) {
              var httpRequest;

        if (window.XMLHttpRequest) { // Mozilla, Safari, ...
                httpRequest = new XMLHttpRequest();
                if (httpRequest.overrideMimeType) {
                        httpRequest.overrideMimeType('text/xml');
                        // See note below about this line
                }
        }
        else if (window.ActiveXObject) { // IE
                try {
                        httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                        try {
                                httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        catch (e) {}
                }
        }

        if (!httpRequest) {
                alert('Giving up :( Cannot create an XMLHTTP instance');
                return false;
        }
        urlf=url+"?tp_id="+f.ps_10_disp_name.options[f.ps_10_disp_name.selectedIndex].value;
        httpRequest.onreadystatechange = function() { alertContents(httpRequest,f); };
        httpRequest.open('GET', urlf, true);
        httpRequest.send('');

}

function alertContents(httpRequest,f) {
        if (httpRequest.readyState == 4) {
                if (httpRequest.status == 200) {
                        var xmldoc = httpRequest.responseXML;

                        setSelectValue(xmldoc.getElementsByTagName('cell1').item(0).firstChild.data,f.fid_10_disp_name)
                        setSelectValue(xmldoc.getElementsByTagName('cell2').item(0).firstChild.data,f.ps_35_disp_name)
                        
                } else {
                        alert('There was a problem with the request.');
                }
        }
}

function setSelectValue(str,f){
    for (var i = 0; i < f.options.length; i++) {
            if (f.options[i].value == str) {
              f.options[i].selected = true;
              f.disabled=true;
              break;
           }
        }

}
        </script>
        <script type="text/javascript">
    function dataSelectFID04(f) {
      n = f.fid_04_br.selectedIndex
      switch(n){
          case 1: {
                  f.fid_04_leng.disabled=false;
                  f.fid_04_cost_o.disabled=false;
                  f.fid_04_cost_r.disabled=false;
                  f.performer_fid_04.disabled=false;
                  f.fid_04_disp_name.disabled=true;
                  break;};
          case 2: {
                  f.fid_04_leng.disabled=false;
                  f.fid_04_cost_o.disabled=false;
                  f.fid_04_cost_r.disabled=false;
                  f.performer_fid_04.disabled=false;
                  f.fid_04_disp_name.disabled=false;
                  break;};
          default : {
                  f.fid_04_leng.disabled=true;
                  f.fid_04_cost_o.disabled=true;
                  f.fid_04_cost_r.disabled=true;
                  f.performer_fid_04.disabled=true;
                  f.fid_04_disp_name.disabled=false;
                  break;}
      }
    }
</script>
<script type="text/javascript">
    function dataSelectFID35(f) {
      n = f.fid_35_br.selectedIndex
      switch(n){
          case 1: {
                  f.fid_35_leng.disabled=false;
                  f.fid_35_cost_o.disabled=false;
                  f.fid_35_cost_r.disabled=false;
                  f.performer_fid_35.disabled=false;
                  break;};
          case 2: {
                  f.fid_35_leng.disabled=false;
                  f.fid_35_cost_o.disabled=false;
                  f.fid_35_cost_r.disabled=false;
                  f.performer_fid_35.disabled=false;
                  break;};
          default : {
                  f.fid_35_leng.disabled=true;
                  f.fid_35_cost_o.disabled=true;
                  f.fid_35_cost_r.disabled=true;
                  f.performer_fid_35.disabled=true;
                  break;}
      }
    }
</script>--%>
        <script type="text/javascript">
            function dataSelectjoin_point(f) {
                n = f.join_point.selectedIndex
                switch(n){
                    case 1: { f.voltage_class.value="0,4"; break;};
                    case 2: { f.voltage_class.value="0,4"; break;};
                    case 3: { f.voltage_class.value="10"; break;};
                    case 4: { f.voltage_class.value="10"; break;};
                    case 5: { f.voltage_class.value="35"; break;};
                    case 6: { f.voltage_class.value="35"; break;};
                    case 7: { f.voltage_class.value="110"; break;};
                    default : {
                            f.performer_fid_04.disabled=true;
                            break;}
                }
            }
        </script>
        <title>JSP Page</title>
    </head>
    <body>
        <html:form action="/frame/detailedview/suplplychain">
            <logic:equal name="DetalViewActionForm" property="reliabylity_class_1" value="true">I - категорія надійності </logic:equal>
            <logic:equal name="DetalViewActionForm" property="reliabylity_class_2" value="true">IІ - категорія надійності </logic:equal>
            <logic:equal name="DetalViewActionForm" property="reliabylity_class_3" value="true">IІІ - категорія надійності </logic:equal>
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-0">Загальні дані</a></li>
                        <li><a href="#tabs-1">ЛЕП 0,4 кВ</a></li>
                        <li><a href="#tabs-2">Підстанція ТП 10/0,4</a></li>
                        <li><a href="#tabs-3">ЛЕП 10 кВ</a></li>
                        <li><a href="#tabs-4">Підстанція ПС 35/10</a></li>
                        <li><a href="#tabs-5">ЛЕП, 35кВ</a></li>
                        <li><a href="#tabs-6">Підстанція 110/35/10</a></li>
                        <li><a href="#tabs-7">ЛЕП, 110кВ</a></li>
                    </ul>
                    <div id="tabs-0">
                        <table border="0">
                            <tr>
                                <td><bean:message key="Supplychain.Join_point" />
                                <html:select  property="join_point" onchange="dataSelectjoin_point(this.form)" styleClass="suplychain" >
                                    <html:option value="0">--</html:option>
                                    <html:optionsCollection name="DetalViewActionForm" property="join_point_list"
                                                            label="name" value="id"/>
                                </html:select>
                            </td>
                            <td>Напруга кВ</td>
                            <%--<bean:message key="Supplychain.Voltage_class" />--%>
                            <td><html:text name="DetalViewActionForm" property="voltage_class" size="6" styleClass="suplychain"/>
                            </td>
                        </tr>
                        <%--<tr>
                            <td><bean:message key="Supplychain.Status" />
                                <html:select  property="status" styleClass="suplychain">
                                    <html:option value="0">Існуюча</html:option>
                                    <html:option value="1">проектна</html:option>
                                </html:select>
                            </td>
                            <td>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>Точка підключення</td>
                            <td><td><html:text property="selecting_point" styleClass="suplychain" /></td>
                        </tr>
                        <%--<tr>
                            <td>Автономне джерело</td>
                            <td><td><html:checkbox property="independent_source" styleClass="suplychain" /></td>
                        </tr>--%>
                    </table>
                </div>
                <div id="tabs-1">
                    <table border="0">
                        <tr>
                            <td><h2>ЛЕП, 0,4 кВ </h2></td>
                            <td><%--<html:select property="fid_04_br" onchange="dataSelectFID04(this.form)" styleClass="suplychain">
                                    <html:option value="0">ні</html:option>
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="brList"
                                                            label="name" value="id"/>
                                </html:select>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>Опора номер</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                            <td><html:select property="fid_04_disp_name" styleClass="suplychain">
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
                            <td><bean:message key="Supplychain.Fid_leng" /></td>
                            <td><html:text name="DetalViewActionForm" property="fid_04_leng" size="8" onkeypress ="isDigit()" styleClass="suplychain"/>
                                <bean:message key="CIkm" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="tabs-2">
                    <table border="0">
                        <tr>
                            <td><h2>Підстанція ТП 10(6)/0,4 кВ</h2></td>
                            <td><%--<html:select property="ps_10_br"onchange="dataSelectPS10(this.form)" styleClass="suplychain">
                                    <html:option value="0">ні</html:option>
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="brList"
                                                            label="name" value="id"/>
                                </html:select>--%>
                            </td>
                            <td>Тип джерела</td>
                            <td>
                                <html:select property="type_source" styleClass="suplychain">
                                    <html:option value="ТП">ТП</html:option>
                                    <html:option value="КТП">КТП</html:option>
                                    <html:option value="ЗТП">ЗТП</html:option>
                                    <html:option value="РП">РП</html:option>
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td>Завантаженість трансформатора</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_u_measurements" /></td>
                            <td><html:text property="ps_10_u" styleClass="suplychain" /><bean:message key="CImV"/></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_u_reserve" /></td>
                            <td><html:text property="ps_10_u_rez" readonly="true" /><bean:message key="CImV"/></td>
                        </tr>
                        <tr>
                            <td><%--<bean:message key="Supplychain.Ps_u_transformer" />--%>Номінальна потужність трансформаторів, кВА</td>
                            <td><html:text property="ps_10_nom" readonly="true" /><bean:message key="CImV"/></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_disp_name" /></td>
                            <td><html:select property="ps_10_disp_name"onchange="makeRequest('detailedview/ajax.jsp',this.form)" styleClass="suplychain">
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="ps_10_disp_name_list"
                                                            label="name" value="id"/>
                                </html:select>
                                <html:text property="ps_10_disp_name_tmp"/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="tabs-3">
                    <table border="0">
                        <tr>
                            <td><h2>ЛЕП, 10(6) кВ </h2></td>
                            <td><%--<html:select property="fid_10_br" onchange="dataSelectFID10(this.form)" styleClass="suplychain">
                                    <html:option value="0">ні</html:option>
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="brList"
                                                            label="name" value="id"/>
                                </html:select>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>Опора номер</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                            <td><html:select property="fid_10_disp_name">
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="fid_10_disp_name_list"
                                                            label="name" value="id" styleClass="suplychain"/>
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_leng"  /></td>
                            <td><html:text  property="fid_10_leng" size="8" styleClass="suplychain"/><%--onKeyPress ="isDigit()"--%>
                                <bean:message key="CIkm" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="tabs-4">
                    <table border="0">
                        <tr>
                            <td><h2>Підстанція ПС 35/10(6) кВ</h2></td>
                            <td><%--<html:select property="ps_35_br" onchange="dataSelectPS35(this.form)" styleClass="suplychain">
                                    <html:option value="0">ні</html:option>
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="brList"
                                                            label="name" value="id"/>
                                </html:select>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>Завантаженість трансформатора</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_u_measurements" /></td>
                            <td><html:text  property="ps_35_u" styleClass="suplychain" /><bean:message key="CImV"/></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_u_reserve" /></td>
                            <td><input type="text" name="ps_35_u" /><bean:message key="CImV"/></td>
                        </tr>
                        <tr>
                            <td><%--<bean:message key="Supplychain.Ps_u_transformer" />--%>Номінальна потужність трансформаторів, кВА</td>
                            <td><input type="text" name="ps_35_u" /><bean:message key="CImV"/></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_disp_name" /></td>
                            <td><html:select property="ps_35_disp_name">
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="ps_35_disp_name_list"
                                                            label="name" value="id"/>
                                </html:select>
                            </td>
                    </table>
                </div>
                <div id="tabs-5">
                    <table border="0">
                        <tr>
                            <td><h2>ЛЕП, 35 кВ </h2></td>
                            <td><%--<html:select property="fid_35_br" onchange="dataSelectFID35(this.form)">
                                    <html:option value="0">ні</html:option>
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="brList"
                                                            label="name" value="id"/>
                                </html:select>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>Опора номер</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                            <td><html:select property="fid_35_disp_name">
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="fid_35_disp_name_list"
                                                            label="name" value="id"/>
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
                            <td><h2>Підстанція 110/35/10(6) кВ</h2></td>
                            <td><%--<html:select property="ps_110_br" onchange="dataSelectPS110(this.form)">
                                    <html:option value="0">ні</html:option>
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="brList"
                                                            label="name" value="id"/>
                                </html:select>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>Завантаженість трансформатора</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_disp_name" /></td>
                            <td><html:select property="ps_110_disp_name">
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="ps_110_disp_name_list"
                                                            label="name" value="id"/>
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_u_measurements" /></td>
                            <td><html:text  property="ps_110_u" /><bean:message key="CImV"/></td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Ps_u_reserve" /></td>
                            <td><input type="text" name="ps_110_u" /><bean:message key="CImV"/></td>
                        </tr>
                        <tr>
                            <td><%--<bean:message key="Supplychain.Ps_u_transformer" />--%>Номінальна потужність трансформаторів, кВА</td>
                            <td><input type="text" name="ps_110_u" /><bean:message key="CImV"/></td>
                        </tr>
                    </table>
                </div>
                <div id="tabs-7">
                    <table border="0">
                        <tr>
                            <td><h2>ЛЕП, 110 кВ </h2></td>
                            <td><%--<html:select property="fid_110_br" onchange="dataSelectFID110(this.form)">
                                    <html:option value="0">ні</html:option>
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="brList"
                                                            label="name" value="id"/>
                                </html:select>--%>
                            </td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                            <td><html:select property="fid_110_disp_name">
                                    <html:optionsCollection name="DetalViewActionForm"
                                                            property="fid_110_disp_name_list"
                                                            label="name" value="id"/>
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td><bean:message key="Supplychain.Fid_leng" /></td>
                            <td><html:text  property="fid_110_leng" size="8" /><%--onKeyPress ="isDigit()"--%>
                                <bean:message key="CIkm" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <logic:equal name="DetalViewActionForm" property="reliabylity_class_1" value="true">
                <div id="tabs2">
                    <ul>
                        <li><a href="#tabs2-0">Загальні дані</a></li>
                        <li><a href="#tabs2-1">ЛЕП 0,4 кВ</a></li>
                        <li><a href="#tabs2-2">Підстанція ТП 10/0,4</a></li>
                        <li><a href="#tabs2-3">ЛЕП 10 кВ</a></li>
                        <li><a href="#tabs2-4">Підстанція ПС 35/10</a></li>
                        <li><a href="#tabs2-5">ЛЕП, 35кВ</a></li>
                        <li><a href="#tabs2-6">Підстанція 110/35/10</a></li>
                        <li><a href="#tabs2-7">ЛЕП, 110кВ</a></li>
                    </ul>
                    <div id="tabs2-0">
                        <table border="0">
                            <tr>
                                <td><bean:message key="Supplychain.Join_point" />
                                    <html:select  property="join_point_2" onchange="dataSelectjoin_point(this.form)">
                                        <html:option value="0">--</html:option>
                                        <html:optionsCollection name="DetalViewActionForm" property="join_point_list"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                                <td>
                                    <bean:message key="Supplychain.Voltage_class" />
                                    <html:text name="DetalViewActionForm" property="voltage_class_2" size="6"  />
                                </td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Status" />
                                    <html:select  property="status_2">
                                        <html:option value="0">Існуюча</html:option>
                                        <html:option value="1">проектна</html:option>
                                    </html:select>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs2-1">
                        <table border="0">
                            <tr>
                                <td><h2>ЛЕП, 0,4 кВ </h2></td>
                                <td><html:select property="fid_04_br_2" onchange="dataSelectFID04(this.form)">
                                        <html:option value="0">ні</html:option>
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="brList"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                                <td><html:select property="fid_04_disp_name_2" styleClass="suplychain">
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
                                <td><bean:message key="Supplychain.Fid_leng" /></td>
                                <td><html:text name="DetalViewActionForm" property="fid_04_leng_2" size="8" onkeypress ="isDigit()"/>
                                    <bean:message key="CIkm" />
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div id="tabs2-2">
                        <table border="0">
                            <tr>
                                <td><h2>Підстанція ТП 10/0,4</h2></td>
                                <td><html:select property="ps_10_br_2"onchange="dataSelectPS10(this.form)">
                                        <html:option value="0">ні</html:option>
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="brList"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Ps_u_measurements" /></td>
                                <td><html:text property="ps_10_u_2" /><bean:message key="CImV"/></td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Ps_u_reserve" /></td>
                                <td><input type="text" name="ps_10_u_2" /><bean:message key="CImV"/></td>
                            </tr>
                            <tr>
                                <td><%--<bean:message key="Supplychain.Ps_u_transformer" />--%>Номінальна потужність трансформаторів, кВА</td>
                                <td><input type="text" name="ps_10_u_2" /><bean:message key="CImV"/></td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Ps_disp_name" /></td>
                                <td><html:select property="ps_10_disp_name_2"onchange="makeRequest('detailedview/ajax.jsp',this.form)">
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="ps_10_disp_name_list"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                            </tr>
                        </table>
                    </div>




                    <div id="tabs2-3">
                        <table border="0">
                            <tr>
                                <td><h2>ЛЕП, 10кВ </h2></td>
                                <td><html:select property="fid_10_br_2" onchange="dataSelectFID10(this.form)">
                                        <html:option value="0">ні</html:option>
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="brList"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                                <td><html:select property="fid_10_disp_name_2">
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="fid_10_disp_name_list"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Fid_leng" /></td>
                                <td><html:text property="fid_10_leng_2" size="8" /><%--onKeyPress ="isDigit()"--%>
                                    <bean:message key="CIkm" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs2-4">
                        <table border="0">
                            <tr>
                                <td><h2>Підстанція ПС 35/10</h2></td>
                                <td><html:select property="ps_35_br_2" onchange="dataSelectPS35(this.form)">
                                        <html:option value="0">ні</html:option>
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="brList"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Ps_u_measurements" /></td>
                                <td><html:text property="ps_35_u_2" /><bean:message key="CImV"/></td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Ps_u_reserve" /></td>
                                <td><input type="text" name="ps_35_u_2" /><bean:message key="CImV"/></td>
                            </tr>
                            <tr>
                                <td><%--<bean:message key="Supplychain.Ps_u_transformer" />--%>Номінальна потужність трансформаторів, кВА</td>
                                <td><input type="text" name="ps_35_u_2" /><bean:message key="CImV"/></td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Ps_disp_name" /></td>
                                <td><html:select property="ps_35_disp_name_2">
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="ps_35_disp_name_list"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                        </table>
                    </div>
                    <div id="tabs2-5">
                        <table border="0">
                            <tr>
                                <td><h2>ЛЕП, 35кВ </h2></td>
                                <td><html:select property="fid_35_br_2" onchange="dataSelectFID35(this.form)">
                                        <html:option value="0">ні</html:option>
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="brList"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                                <td><html:select property="fid_35_disp_name_2">
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="fid_35_disp_name_list"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Fid_leng" /></td>
                                <td><input type="text" name="fid_35_leng_2" />
                                    <bean:message key="CIkm" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs2-6">
                        <table border="0">
                            <tr>
                                <td><h2>Підстанція 110/35/10</h2></td>
                                <td><html:select property="ps_110_br_2" onchange="dataSelectPS110(this.form)">
                                        <html:option value="0">ні</html:option>
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="brList"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Ps_disp_name" /></td>
                                <td><html:select property="ps_110_disp_name_2">
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="ps_110_disp_name_list"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Ps_u_measurements" /></td>
                                <td><html:text property="ps_110_u_2" /><bean:message key="CImV"/></td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Ps_u_reserve" /></td>
                                <td><input type="text" name="ps_110_u_2" /><bean:message key="CImV"/></td>
                            </tr>
                            <tr>
                                <td><%--<bean:message key="Supplychain.Ps_u_transformer" />--%>Номінальна потужність трансформаторів, кВА</td>
                                <td><input type="text" name="ps_110_u_2" /><bean:message key="CImV"/></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs2-7">
                        <table border="0">
                            <tr>
                                <td><h2>ЛЕП, 110кВ </h2></td>
                                <td><html:select property="fid_110_br_2" onchange="dataSelectFID110(this.form)">
                                        <html:option value="0">ні</html:option>
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="brList"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                                <td><html:select property="fid_110_disp_name_2">
                                        <html:optionsCollection name="DetalViewActionForm"
                                                                property="fid_110_disp_name_list"
                                                                label="name" value="id"/>
                                    </html:select>
                                </td>
                            </tr>
                            <tr>
                                <td><bean:message key="Supplychain.Fid_leng" /></td>
                                <td><html:text property="fid_110_leng_2" size="8" /><%--onKeyPress ="isDigit()"--%>
                                    <bean:message key="CIkm" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </logic:equal>
            <logic:notEqual name="DetalViewActionForm" property="reliabylity_class_1" value="true">
                <logic:equal name="DetalViewActionForm" property="reliabylity_class_2" value="true">
                    <div id="tabs2">
                        <ul>
                            <li><a href="#tabs2-0">Загальні дані</a></li>
                            <li><a href="#tabs2-1">ЛЕП 0,4 кВ</a></li>
                            <li><a href="#tabs2-2">Підстанція ТП 10/0,4</a></li>
                            <li><a href="#tabs2-3">ЛЕП 10 кВ</a></li>
                            <li><a href="#tabs2-4">Підстанція ПС 35/10</a></li>
                            <li><a href="#tabs2-5">ЛЕП, 35кВ</a></li>
                            <li><a href="#tabs2-6">Підстанція 110/35/10</a></li>
                            <li><a href="#tabs2-7">ЛЕП, 110кВ</a></li>
                        </ul>
                        <div id="tabs2-0">
                            <table border="0">
                                <tr>
                                    <td><bean:message key="Supplychain.Join_point" />
                                        <html:select  property="join_point_2" onchange="dataSelectjoin_point(this.form)">
                                            <html:option value="0">--</html:option>
                                            <html:optionsCollection name="DetalViewActionForm" property="join_point_list"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                    <td>
                                        <bean:message key="Supplychain.Voltage_class" />
                                        <html:text name="DetalViewActionForm" property="voltage_class_2" size="6" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Status" />
                                        <html:select  property="status_2">
                                            <html:option value="0">Існуюча</html:option>
                                            <html:option value="1">проектна</html:option>
                                        </html:select>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="tabs2-1">
                            <table border="0">
                                <tr>
                                    <td><h2>ЛЕП, 0,4 кВ </h2></td>
                                    <td><html:select property="fid_04_br_2" onchange="dataSelectFID04(this.form)">
                                            <html:option value="0">ні</html:option>
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="brList"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                                    <td><html:text name="DetalViewActionForm" property="fid_04_disp_name_2" /></td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Fid_leng" /></td>
                                    <td><html:text name="DetalViewActionForm" property="fid_04_leng_2" size="8" onkeypress ="isDigit()"/>
                                        <bean:message key="CIkm" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div id="tabs2-2">
                            <table border="0">
                                <tr>
                                    <td><h2>Підстанція ТП 10/0,4</h2></td>
                                    <td><html:select property="ps_10_br_2"onchange="dataSelectPS10(this.form)">
                                            <html:option value="0">ні</html:option>
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="brList"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Ps_u_measurements" /></td>
                                    <td><html:text property="ps_10_u_2" /><bean:message key="CImV"/></td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Ps_u_reserve" /></td>
                                    <td><input type="text" name="ps_10_u_2" /><bean:message key="CImV"/></td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Ps_u_transformer" /></td>
                                    <td><input type="text" name="ps_10_u_2" /><bean:message key="CImV"/></td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Ps_disp_name" /></td>
                                    <td><html:select property="ps_10_disp_name_2"onchange="makeRequest('ajax.jsp',this.form)">
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="ps_10_disp_name_list"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                </tr>
                            </table>
                        </div>




                        <div id="tabs2-3">
                            <table border="0">
                                <tr>
                                    <td><h2>ЛЕП, 10кВ </h2></td>
                                    <td><html:select property="fid_10_br_2" onchange="dataSelectFID10(this.form)">
                                            <html:option value="0">ні</html:option>
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="brList"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                                    <td><html:select property="fid_10_disp_name_2">
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="fid_10_disp_name_list"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Fid_leng" /></td>
                                    <td><html:text property="fid_10_leng_2" size="8" /><%--onKeyPress ="isDigit()"--%>
                                        <bean:message key="CIkm" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="tabs2-4">
                            <table border="0">
                                <tr>
                                    <td><h2>Підстанція ПС 35/10</h2></td>
                                    <td><html:select property="ps_35_br_2" onchange="dataSelectPS35(this.form)">
                                            <html:option value="0">ні</html:option>
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="brList"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Ps_u_measurements" /></td>
                                    <td><html:text property="ps_35_u_2" /><bean:message key="CImV"/></td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Ps_u_reserve" /></td>
                                    <td><input type="text" name="ps_35_u_2" /><bean:message key="CImV"/></td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Ps_u_transformer" /></td>
                                    <td><input type="text" name="ps_35_u_2" /><bean:message key="CImV"/></td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Ps_disp_name" /></td>
                                    <td><html:select property="ps_35_disp_name_2">
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="ps_35_disp_name_list"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                            </table>
                        </div>
                        <div id="tabs2-5">
                            <table border="0">
                                <tr>
                                    <td><h2>ЛЕП, 35кВ </h2></td>
                                    <td><html:select property="fid_35_br_2" onchange="dataSelectFID35(this.form)">
                                            <html:option value="0">ні</html:option>
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="brList"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                                    <td><html:select property="fid_35_disp_name_2">
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="fid_35_disp_name_list"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Fid_leng" /></td>
                                    <td><input type="text" name="fid_35_leng_2" />
                                        <bean:message key="CIkm" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="tabs2-6">
                            <table border="0">
                                <tr>
                                    <td><h2>Підстанція 110/35/10</h2></td>
                                    <td><html:select property="ps_110_br_2" onchange="dataSelectPS110(this.form)">
                                            <html:option value="0">ні</html:option>
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="brList"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Ps_disp_name" /></td>
                                    <td><html:select property="ps_110_disp_name_2">
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="ps_110_disp_name_list"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Ps_u_measurements" /></td>
                                    <td><html:text property="ps_110_u_2" /><bean:message key="CImV"/></td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Ps_u_reserve" /></td>
                                    <td><input type="text" name="ps_110_u_2" /><bean:message key="CImV"/></td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Ps_u_transformer" /></td>
                                    <td><input type="text" name="ps_110_u_2" /><bean:message key="CImV"/></td>
                                </tr>
                            </table>
                        </div>
                        <div id="tabs2-7">
                            <table border="0">
                                <tr>
                                    <td><h2>ЛЕП, 110кВ </h2></td>
                                    <td><html:select property="fid_110_br_2" onchange="dataSelectFID110(this.form)">
                                            <html:option value="0">ні</html:option>
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="brList"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Fid_disp_name" /></td>
                                    <td><html:select property="fid_110_disp_name_2">
                                            <html:optionsCollection name="DetalViewActionForm"
                                                                    property="fid_110_disp_name_list"
                                                                    label="name" value="id"/>
                                        </html:select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><bean:message key="Supplychain.Fid_leng" /></td>
                                    <td><html:text property="fid_110_leng_2" size="8" /><%--onKeyPress ="isDigit()"--%>
                                        <bean:message key="CIkm" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </logic:equal>
            </logic:notEqual>
        </html:form>
    </body>
</html>
