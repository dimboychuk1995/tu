<%-- 
    Document   : mainlayout
    Created on : 1 квіт 2010, 11:04:27
    Author     : AsuSV
--%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/json.tld" prefix="json" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link   href="../codebase/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css"/>
        <script  type="text/javascript" src="../codebase/jquery-1.3.2.min.js"></script>
        <script  type="text/javascript" src="../codebase/jquery-ui-1.7.2.custom.min.js"></script>
        <script  type="text/javascript" src="../codebase/jquery.tools.min.js"></script>
        <script  type="text/javascript" src="detailedview/js/jquery.omniwindow.js"></script>
        <link rel="stylesheet" type="text/css" href="../button/style.css"/>
        <link rel="stylesheet" type="text/css" href="../codebase/skins/dhtmlxmenu_dhx_skyblue.css"/>
        <link rel="stylesheet" type="text/css" href="../codebase/skins/dhtmlxtoolbar_dhx_skyblue.css"/>
        <script type="text/javascript" src="../codebase/dhtmlxcommon.js"></script>
        <script type="text/javascript" src="../codebase/dhtmlxmenu.js"></script>
        <script type="text/javascript" src="../codebase/ext/dhtmlxmenu_ext.js"></script>
        <script type="text/javascript" src="../codebase/dhtmlxtoolbar.js"></script>
        <script type="text/javascript" src="menuClick126.js"></script>
        <script type="text/javascript" src="ajax/exportExcell.js"></script>
    </head>
    <script type="text/javascript">
        $(document).ready(function(){
            
            $('#dialog').dialog({
                autoOpen:false,
                width:585,
                modal:true,
                resizable: false
            });
            $('#dialog_nastya').dialog({
                autoOpen:false,
                width:585,
                modal:true,
                resizable: false
            });
            $('#dialog_list_deals').dialog({
                autoOpen:false,
                width:585,
                modal:true,
                resizable: false
            });
            $(function() {
                $(".datepicker").datepicker();
                $(".create").click(function(){
                    var rep = $(this).parent().attr('rep');
                    var FromDate = $(this).parent().children(".FromDate").attr("value");
                    var TillDate = $(this).parent().children(".TillDate").attr("value");
                    var st ="report/AJAX/db_"+rep+".jsp?FromDate="+FromDate+"&TillDate="+TillDate;
                    alert(st);
                    window.open(st, '_blank', 'Toolbar=0, Scrollbars=1,');
                });
            });
            
        });
        var menu,toolbar;
        function initMenu() {
            var menuData = {parent: "menuObj",icon_path: "../common/imgs/",xml: "../common/menu.jsp?rol=<bean:write name="loginActionForm" property="role"/>"};
            menu = new dhtmlXMenuObject(menuData);
            menu.setSkin("dhx_skyblue");
            menu.setTopText("Технічні умови <bean:write name="loginActionForm" property="rem_name"/> РЕМ <bean:write name="loginActionForm" property="PIP"/> ");
            menu.attachEvent("onClick", menuClick);
            toolbar = new dhtmlXToolbarObject("toolbarObj");
            toolbar.setIconsPath("../common/imgs/");
            toolbar.loadXML("../common/toolbar.jsp?rol=<bean:write name="loginActionForm" property="role"/>");
            toolbar.attachEvent("onClick", menuClick);
        }
    </script>
    <style>
        #ui-datepicker-div 
        {
            z-index: 1010; /* must be > than popup editor (950) */
        }
    </style>
    <body onload="initMenu();">
        <div style="text-align:center">
            <div style="width:1001px; margin:0 auto" >
                <div id="menuObj"></div>
                <div id="toolbarObj"></div>
                <div style="background:white">
                    <tiles:insert attribute="content"/>
                </div>
                <div id="mes" style="display:none"></div>
            </div>
        </div>
        <form action="xls_all.jsp">
            <div id="dialog" title="Експорт в Excel всіх РЕМ">
                <center><h2>Виберіть необхідні вкладки для експорту:</h2></center>
                <table>
                    <tr>
                        <td><input type="checkbox" id="CHcustomer" checked disabled>Замовник</td> 
                        <td><input type="checkbox" id="CHdataobjects">Дані про об'єкт</td>
                    </tr>
                    <tr> 
                        <td><input type="checkbox" id="CHdataobjects2">Вимоги ТУ</td>  
                        <td><input type="checkbox" id="CHtund">Технічні умови № Договіру</td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" id="CHadmision">Допуск та проектування</td> 
                        <td><input type="checkbox" id="CHsupplychain">Схема приєднання</td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" id="CHpricejoin">Плата за приєднання</td> 
                        <td><input type="checkbox" id="CHvkb">Дані ВКБ</td> 
                    </tr>
                    <tr>
                        <td><input type="checkbox" id="CHchange">Журнал змін</td>
                        <td><input type="checkbox" id="CHadmision2">Допуск та підключення</td>
                    </tr> 
                    <tr>
                        <td><input type="checkbox" id="CHpricejoin_ns">Плата за нестандартне приєднання</td>
                    </tr> 
                </table>
                <span style="font-size: 16px;">Виберіть рік:</span>
                <select style="font-size: 16px;" id="selectYear">
                    <option value="0">&nbsp;</option>
                    <option>2005</option>
                    <option>2006</option>
                    <option>2007</option>
                    <option>2008</option>
                    <option>2009</option>
                    <option>2010</option>
                    <option>2011</option>
                    <option>2012</option>
                    <option>2013</option>
                    <option>2014</option>
                    <option>2015</option>
                    <option>2016</option>
                    <option>2017</option>
                </select><br/>
                <input type="button" id="excelExport" value="Експортувати" style="margin-left: 40%;">
            </div>
        </form>  
        <form action="xls_nastya.jsp">
            <div id="dialog_nastya" title="Експорт в Excel всіх РЕМ">
                <center><h2>Виберіть рік, який вас цікавить для експорту:</h2></center>
                <span style="font-size: 16px;">Виберіть рік:</span>
                <select style="font-size: 16px;" id="selectYear2">
                    <option value="0">&nbsp;</option>
                    <option>2005</option>
                    <option>2006</option>
                    <option>2007</option>
                    <option>2008</option>
                    <option>2009</option>
                    <option>2010</option>
                    <option>2011</option>
                    <option>2012</option>
                    <option>2013</option>
                    <option>2014</option>
                    <option>2015</option>
                    <option>2016</option>
                    <option>2017</option>
                </select><br/>
                <input type="button" id="excelExport2" value="Експортувати" style="margin-left: 40%;">
            </div>
        </form>
        <div id="dialog_list_deals" title="Експорт в Excel всіх РЕМ">
            <center><h2>Виберіть період:</h2></center>
            <span style="font-size: 16px;">Виберіть період, за який хочете сформувати звіт:</span>
            <div>
                з <input type="text" name ="FromDate" class="datepicker">
                по <input type="text" name ="TillDate" class="datepicker">
            </div>
            <input type="button" id="list_deals" value="Експортувати" style="margin-left: 40%;">
        </div>
    </body>
</html>

