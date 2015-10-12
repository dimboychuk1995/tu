<%-- 
    Document   : changestuxp
    Created on : 4 бер 2010, 11:20:56
    Author     : AsuSV
--%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" type="text/css" href="../../button/style.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="../../css/flick/jquery-ui-1.7.2.custom.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="../../css/ui.jqgrid.css"/>
    <script type="text/javascript" src="../../js/jquery-1.4.min.js"></script>
    <script src="../../js/i18n/grid.locale-ua.js" type="text/javascript"></script>
    <script src="../../js/jquery.jqgrid.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#le_table').jqGrid({
                url: 'changes_tu_json.jsp?tu_id=<%=request.getParameter("tu_id")%>',
                          datatype: 'json',
                          mtype: 'GET',
                          toolbar: [true,'top'],
                          colNames:['№','Номер ТУ','П.І.Б.','№ додаткового правочина (листа)','Тип листа','Вхідний номер','Вихідний номер','Дата заяви','Гранична дата оплати','ТУ продовжено до','Дата віповіді','Короткий опис',''],
                          colModel :[
                            {name:'id', index:'id', width:80, searchoptions:{sopt:['eq','ne','bw','cn']}},
                            {name:'id_tc', index:'id_tc', width:40, searchoptions:{sopt:['eq','ne','bw','cn']}},
                            {name:'pip', index:'pip', width:40, searchoptions:{sopt:['eq','ne','bw','cn']}},
                            {name:'No_letter', index:'No_letter', width:80, searchoptions:{sopt:['eq','ne','bw','cn']}},
                            {name:'type_letter', index:'type_letter', width:80, searchoptions:{sopt:['eq','ne','bw','cn']}},
                            {name:'in_namber', index:'in_namber', width:80, searchoptions:{sopt:['eq','ne','bw','cn']}},
                            {name:'out_namber', index:'out_namber', width:80, searchoptions:{sopt:['eq','ne','bw','cn']}},
                            {name:'send_date_lenner', index:'Change_date_tc', width:90, searchoptions:{sopt:['eq','ne']}},
                            {name:'limit_date', index:'limit_date', width:90, searchoptions:{sopt:['eq','ne']}},
                            {name:'Tc_continue_to', index:'Tc_continue_to', width:60, searchoptions:{sopt:['eq','ne']}},
                            {name:'Change_date_tc', index:'send_date_lenner', width:30, searchoptions:{sopt:['eq','ne']}},
                            {name:'Description_change', index:'Description_change', width:120, searchoptions:{sopt:['eq','ne','bw','cn']}},
                            {name:'id', index:'id', width:10}],
                          pager: $('#le_tablePager'),
                          rowNum:20,
                          rowList:[20,50,100],
                          sortname: 'id',
                          sortorder: 'desc',
                          height: 390,
                          width: 870
                        });
                        $("#le_table").jqGrid('navGrid','#le_tablePager',{view:false, del:false, add:false, edit:false},
                                            {}, // default settings for edit
                                            {}, // default settings for add
                                            {}, // delete instead that del:false we need this
                                            {closeOnEscape:true, multipleSearch:true, closeAfterSearch:true}, // search options
                                            {} );
                        $("#t_le_table").height(40); //Set height of toolbar
                        $("#t_le_table").append('<table><tr><td><input id="add" type="button" value="" class="button_add"></td><td><input id="ser" type="button" value="Знайти" ></td></tr></table>');
                        $("#add").click(function(){
                            location.replace('changestuxp.do?method=empty&id=-1');
                        });
                        $("#ser").click(function(){
                            location.replace('search_tu.jsp');
                        });
            });
            
        </script>
    </head>
    <body>
        <div style="width:300px; overflow:visible ">
            <table id="le_table"></table>
            <div id="le_tablePager"></div>
        </div>
    </body>
</html>
