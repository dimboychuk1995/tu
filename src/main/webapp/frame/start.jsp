<%-- 
    Document   : start
    Created on : 12 квіт 2010, 9:41:19
    Author     : AsuSV
--%>
<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@page import="com.myapp.struts.loginActionForm"%>
<style type="text/css">
<!--
.style1 {
     font-family: Arial, Helvetica, sans-serif;
     color: #0099CC;
}
-->
</style>
 <%
        HttpSession ses = request.getSession();
        String perm = ua.ifr.oe.tc.list.MyCoocie.getCoocie("permisions", request);
        if (!((loginActionForm) ses.getAttribute("log")).getRole().equals("128")) {
    %>
<script type="text/javascript">
  $(document).ready(function(){
      
        jQuery.ajax({
               type: "POST",
               url: "remindernew.jsp",
               //data: str,
               success: function(msg){
                    $("#mes").html(msg);
                    $("#mes").dialog({
                        width:800,
                        height:700,
                        modal:true,
                        hide: 'clip',
                        //show: 'clip',
                        buttons: {"Закрити": function() {$(this).dialog("destroy"); }
                        }
                    });
               },
              error: function(error) {
                alert("Помилка !!! \n Список протермінованих невідомий!!!");
              }
        });
  });
</script>
<%}%>

<table width="100%" height="100%" border="0" bgcolor="#ECE9D8">
  <tr>
    <td height="800" align="center" valign="middle" >
     <h1 class="style1">Технічні Умови</h1>
     <h1 class="style1"><bean:write name="log" property="rem_name"/> РЕМ</h1>
     </td>
  </tr>

</table>

