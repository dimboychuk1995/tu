<%-- 
    Document   : documentation
    Created on : 10 лют 2010, 8:13:42
    Author     : AsuSV
--%>
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.Connection,java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<script type="text/javascript">
    $(document).ready(function(){
        $(".doc_vud").click(function(){
            $(this).children('.doc_vud_w').dialog("destroy");
            $(this).children('.doc_vud_w').dialog({
                width:500,
                modal:true,
                hide: 'blind',
                onClose: (function() {$(this).dialog("destroy"); }),
                buttons: {"OK": function() {$(this).dialog("close");}}
            });
        });
    });
</script>
<table border="0">
    <tr>
        <td>Рахунок вартості видачі ТУ</td>
        <td><a href="../word/main.jsp?type=r_vart_vud_tu&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
        </td>
    </tr>
    <tr>
        <td>Договір про надання доступу</td>
        <td>
            <div class="doc_vud" ><img src="../button/button_vudaty.bmp" alt="Видати "/>
                <div class="doc_vud_w"  style="display:none">
                    Додаток  <a href="../word/main.jsp?type=tcf&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
                    Додаток М<a href="../word/main.jsp?type=tcm&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
                    Додаток Н<a href="../word/main.jsp?type=tch&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
                    Додаток П<a href="../word/main.jsp?type=tcd&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
                    Додаток Р<a href="../word/main.jsp?type=tcp&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
                    Додаток С<a href="../word/main.jsp?type=tcc&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td>Технічні умови</td>
        <td>
            <div class="doc_vud" ><img src="../button/button_vudaty.bmp" alt="Видати"/>
                <div class="doc_vud_w"  style="display:none">
                    Для ВТС<a href="../word/main.jsp?type=tc1&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
                    Для РЕМ<a href="../word/main.jsp?type=tc2&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td>Рахунок на оплату вартості погодження проекту</td>
        <td><a href="../word/main.jsp?type=r_pogod_proectu&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
        </td>
    </tr>
    <tr>
        <td>Рахунок на оплату вартості підключення</td>
        <td><a href="../word/main.jsp?type=r_pidklu&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
        </td>
    </tr>
    <tr>
        <td>Листи протермінування 20-ти денного терміну укладення Договору/ТУ;<br>Закінчення терміну дії Договору/ТУ.</td>
        <td>
            <div class="doc_vud" ><img src="../button/button_vudaty.bmp" alt="Видати"/>
                <div class="doc_vud_w"  style="display:none">
                    Фізичні особи<a href="../word/main.jsp?type=letterf&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
                    Юридичні особи<a href="../word/main.jsp?type=lettery&id=<%= request.getParameter("tu_id")%>" target="_blank" class="button_vudaty">Видати</a>
                </div>
            </div>
        </td>
    </tr>
</table>
<%
    HttpSession ses = request.getSession();
    String db = new String();
    if (!ses.getAttribute("db_name").equals(null)) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    Connection c = ds.getConnection();

    PreparedStatement pstmt = c.prepareStatement("select * from tu_file where tu_id = ?");
    pstmt.setString(1, request.getParameter("tu_id"));
    ResultSet rs = pstmt.executeQuery();
    ResultSetMetaData rsmd = rs.getMetaData();
    int numCols = rsmd.getColumnCount();
    int flag = 0;
    while (rs.next()) {
        if (0 == flag++) {
%>
<h2>Переліу документів виданих на дані технічні умови:</h2>
<table >
    <%}%>
    <tr style="background-color:aqua">
        <td><a href="#"onClick="window.open('../word/arhiv/<%= rs.getString(3)%>', '_blank', 'Toolbar=0');" ><%= rs.getString(3)%></td>
    </tr>
    <%
        }
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    %>