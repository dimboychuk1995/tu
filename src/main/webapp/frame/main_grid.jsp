<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<link   href="../codebase/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css"/>
<script  type="text/javascript" src="../codebase/jquery-1.3.2.min.js"></script>
<script  type="text/javascript" src="../codebase/jquery-ui-1.7.2.custom.min.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../css/ui.jqgrid.css" />
<script src="../js/i18n/grid.locale-ua.js" type="text/javascript"></script>
<script src="../js/jquery.jqgrid.min.js" type="text/javascript"></script>
<script src="detailedview/js/tu_jqgrid_1.js" type="text/javascript" ></script>
<script  type="text/javascript" src="detailedview/js/jquery.omniwindow.js"></script>
<style>
    .ui-jqgrid .ui-jqgrid-htable th {font-size:10px;height:80px;}
    .ui-jqgrid tr.jqgrow td {font-size:10px}
</style>
<%
    String req = "../getMainGrid";
    if (request.getQueryString() != null) {
        req += "?" + request.getQueryString();
    }
%>
<script type="text/javascript">
    $(function(){jqgrid_constructor('<%=req%>'); });
</script>
<div>
    <div id="le_tablePager"></div>
    <table id="le_table"></table>
</div>

<div id="mes" style="display:none"></div>


