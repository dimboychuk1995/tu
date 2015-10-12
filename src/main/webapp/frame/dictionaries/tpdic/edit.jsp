<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
            String id_rem = ua.ifr.oe.tc.list.MyCoocie.getCoocie("rem_id", request);
            String perm = ua.ifr.oe.tc.list.MyCoocie.getCoocie("permisions", request);
        %>
        <script  type="text/javascript" >
            $(document).ready(function(){
                calc();
                $("#ps").change(function(){
                    calc();
                });
                $("#add").click(function () {
                    if($("#toogle").css('display')=='none'){
                        $("#add").attr('value','Сховати');
                        $("#toogle").show(2000);
                    }else{
                        $("#add").attr('value','Додати нове ТП');
                        $("#toogle").hide(2000);
                        
                    }
                });
            
            });
           
            function calc(){
                var ps_id=$("#ps").attr("value");
                //alert(ps_id);
                $.ajax({
                    url: 'dictionaries/tpdic/ajax_show.jsp?ps_id='+ps_id,
                    dataType : "json",
                    success: function (data, textStatus) {
                        $("#ps_t1").attr("value",data.ps_t1);
                        $("#ps_t2").attr("value",data.ps_t2);
                        $("#ps_nav").attr("value",data.ps_nav);
                        $("#edit_date").attr("value",data.edit_date);
                    }
                });
            }
        </script>
    <body>
        <sql:setDataSource
            var="DB"
            driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
            url="jdbc:sqlserver://obl-devel:1433;databaseName=TUWeb;charSet=UTF8;"
            user="sa" password="Gjdybq<h'l?55" />
        <sql:query var="list"   dataSource="${DB}">
            SELECT [ps_id]
            ,[ps_name]
            FROM [TUWeb].[dbo].[ps_tu_web] ptw
            LEFT JOIN [TUWeb].dbo.ps_feed_rem_tu_web pfrtw ON pfrtw.ps_tu_web_id = ptw.ps_id
            WHERE pfrtw.rem_id=<%=id_rem%>
            order by ps_name
        </sql:query>
        <form action="dictionaries/tpdic/update.jsp" method="get">
            <fieldset style="">
                <legend style="font-size: 14px;">Редагування ТП:</legend>
                <table style="font-size: 14px; background-color: #F5F5F5; width: 100%;">
                    <tr >
                        <td style="width: 40%">Диспетчерська назва ТП:</td>
                        <td>
                            <select name="tplist" id="ps">
                                <c:forEach var="pslist" items="${list.rows}">
                                    <option value="${pslist.ps_id}">${pslist.ps_name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 40%">Потужність трансформатора Т1, кВА:</td>
                        <td><input type="text" id="ps_t1" name="ps_t1"></td>
                    </tr>
                    <tr>
                        <td style="width: 40%">Потужність трансформатора Т2, кВА:</td>
                        <td><input type="text" id="ps_t2" name="ps_t2"></td>
                    </tr>
                    <tr>
                        <td style="width: 40%">Максимальне навантаження, кВт</td>
                        <td><input type="text" id="ps_nav" name="ps_nav"></td>
                    </tr>
                    <tr>
                        <td style="width: 40%">Дата останнього редагування</td>
                        <td><input type="text" id="edit_date" name="edit_date" readonly="true"></td>
                    </tr>
                    <tr>
                        <td><%if (("2".equals(perm))||("1".equals(perm))){%><input type="submit" value="Зберегти"><input type="button" value="Додати нове ТП" id="add"><%}%></td>
                        <td></td>
                    </tr>
                </table>
            </fieldset>
        </form>
        <div id="toogle" style="display:none">
            <form action="dictionaries/tpdic/add.jsp" method="get">
                <input type="hidden" value="<%=id_rem%>" name="rem">
                <fieldset style="">
                    <legend style="font-size: 14px;">Додати ТП:</legend>
                    <table style="font-size: 14px; background-color: #F5F5F5; width: 100%;">
                        <tr >
                            <td style="width: 40%">Диспетчерська назва ТП:</td>
                            <td><input type="text" id="ps_name" name="ps_name_add"></td>
                        </tr>
                        <tr >
                            <td style="width: 40%">Номінал</td>
                            <td><select name="ps_nominal">
                                    <option value="3">ТП 10</option>    
                                    <option value="2">ПС 35/10</option>    
                                    <option value="1">ПС 110/35/10</option>    
                                </select></td>
                        </tr>
                        <tr>
                            <td style="width: 40%">Потужність трансформатора Т1, кВА:</td>
                            <td><input type="text" id="ps_t1_add" name="ps_t1_add"></td>
                        </tr>
                        <tr>
                            <td style="width: 40%">Потужність трансформатора Т2, кВА:</td>
                            <td><input type="text" id="ps_t2_add" name="ps_t2_add"></td>
                        </tr>
                        <tr>
                            <td style="width: 40%">Максимальне навантаження, кВт</td>
                            <td><input type="text" id="ps_nav_add" name="ps_nav_add"></td>
                        </tr>
                    </table>
                </fieldset>
                <input type="submit" value="Додати">
            </form>
        </div>
    </body>
</html>
