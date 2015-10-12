<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/codebase/jquery.cookie.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery/jquery-ui-1.10.3.custom.min.css" />
<script src="${pageContext.request.contextPath}/js/jquery/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frame/FileUpload/fileUpload.js"></script>

<%  String perm = ua.ifr.oe.tc.list.MyCoocie.getCoocie("permisions", request);
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
    HttpSession ses = request.getSession();
    String db = (String) ses.getAttribute("db_name");
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    Connection c = ds.getConnection();
    PreparedStatement pstmt = c.prepareStatement("select "
            + "tu_id"
            + ",isnull([file_name],'') as file_name "
            + ",isnull([full_name],'') as full_name "
            + ",isnull([comment],'') as comment "
            + "from [Files]"
            + " where tu_id=" + request.getParameter("tu_id"));
    ResultSet rs = pstmt.executeQuery();

    ResultSetMetaData rsmd = rs.getMetaData();
    int numCols = rsmd.getColumnCount();

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">
            #edit 
            {
                background-image:url(pdf.png);
                background-repeat: no-repeat;
                display:block;
                height:100px;
                width:460px;
                /*background-size:80px 60px;*/
            }
            .ui-widget {
                font-family: Trebuchet MS,Tahoma,Verdana,Arial,sans-serif;
                font-size: 13px;
            }
        </style>
    </head>
    <body>
        <html:messages id="err_name" property="common.file.err">
            <div style="color:red">
                <bean:write name="err_name" />
            </div>
        </html:messages>
        <html:messages id="err_name" property="common.file.err.ext">
            <div style="color:red">
                <bean:write name="err_name" />
            </div>
        </html:messages>
        <html:messages id="err_name" property="common.file.err.size">
            <div style="color:red">
                <bean:write name="err_name" />
            </div>
        </html:messages>
        <html:messages id="err_name" property="common.file.exists">
            <div style="color:red">
                <bean:write name="err_name" />
            </div>
        </html:messages>
        
        <table border="1" cellspacing="0" cellpadding="0" style="width: border-box;">
            <tr>
                <td align="center">Дії</td>
                <td align="center">Назва файлу</td>
                <td align="center">Опис файлу</td>
                <td align="center" class="hide">Видалити</td>
            </tr>
            <% while (rs.next()) {%>
            <tr>
                <td align="center">
                    <% if (rs.getString("file_name").toLowerCase().endsWith(".pdf")) {%>
                    <a href="<%= rs.getString("full_name")%>"><img src="<%=request.getContextPath()%>/frame/FileUpload/pdf.png" width="40" height="40"/></a>
                        <%} else if(rs.getString("file_name").toLowerCase().endsWith(".doc")){%>
                    <a href="<%= rs.getString("full_name")%>"><img src="<%=request.getContextPath()%>/frame/FileUpload/doc.png" width="40" height="40"/></a>
                        <%} else {%>
                    <a href="<%= rs.getString("full_name")%>"><img src="<%=request.getContextPath()%>/frame/FileUpload/image.png" width="40" height="40"/></a>
                        <%}%>
                </td>
                <td align="center"><%= rs.getString("file_name")%></td>
                <td align="center"><%= rs.getString("comment")%></td>
                <td class="hide" align="center"><a href="<%=request.getContextPath()%>/frame/FileUpload/delete.jsp?file=<%= rs.getString("file_name")%>&tu_id=<%=request.getParameter("tu_id")%>" onclick="if (!window.confirm('Ви дійсно бажаєте видалити даний файл?')){return false;}"><img src="<%=request.getContextPath()%>/frame/FileUpload/delete.png" width="40" height="40"/></a></td>
            </tr>
            <%}%>
        </table>
       
        <html:form action="/Upload" method="post" enctype="multipart/form-data">
            <input type="hidden" name="tu_id" value="<%=request.getParameter("tu_id")%>"/>
            <div id="dialog" title="Виберіть прізвище">
                <p>Виберіть прізвище інженера, якого ви хочете повідомити:</p>
                <select name="engineer">
                    <option value="1">Куца Л.Є.</option>
                    <option value="2">Кушина О.М.</option>
                    <option value="3">Якцовий В.М.</option>
                    <option value="4">Тимченко М.М.</option>
                    <option value="5">Солонична О.В.</option>
                </select>
            </div>
            <br />
            Виберіть файл для завантаження :<br> 
            <html:file property="file" size="40" accept="application/pdf,application/msword,image/*"/>
            <br />
            Короткий опис файлу: <input type="text" name="f_desc" size="40"/>
            <br />
            
            <input type="button" onclick="if($.cookie('permisions')=='0'){$('#confirm').dialog('open');} else{$('form').submit();}" value="Завантажити" class="ui-state-default ui-corner-all">
            <html:submit style="display:none;" styleClass="ui-state-default ui-corner-all">Завантажити</html:submit>
            
        </html:form>
        <div id="confirm" title="Підтвердження">
            <p>Чи бажаєте ви повідомити про дані зміни інженера ВТП?</p>
        </div>
    </body>
    <%
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    %> 
</html>