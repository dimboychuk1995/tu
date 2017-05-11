<%-- 
    Document   : fiz
    Created on : 16 лют 2011, 16:18:59
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="java.sql.*,java.text.NumberFormat"%>
<% NumberFormat nf = NumberFormat.getInstance();
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    HttpSession ses = request.getSession();
    String db = new String();
    if (!ses.getAttribute("db_name").equals(null)) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try {
        c = ds.getConnection();
        String qry = "SELECT ISNULL(soc_status.full_name, '') AS customer_soc_status, \n"
                + "       CASE  \n"
                + "            WHEN TC_V2.customer_type = 1 THEN ISNULL(TC_V2.juridical, '') \n"
                + "            WHEN TC_V2.customer_type = 0 THEN ISNULL(TC_V2.[f_name], '') + ' ' +  \n"
                + "                 ISNULL(TC_V2.[s_name], '') + ' ' + ISNULL(TC_V2.[t_name], '') \n"
                + "            ELSE '' \n"
                + "       END AS [name], \n"
                + "       ISNULL(TC_V2.customer_post, '') AS customer_post, \n"
                + "       ISNULL(TC_V2.[f_name], '') + ' ' + ISNULL(TC_V2.[s_name], '') + ' ' +  \n"
                + "       ISNULL(TC_V2.[t_name], '') AS PIP, \n"
                + "       ISNULL(TC_V2.[object_name], '') AS [object_name], \n"
                + "       CASE  \n"
                + "            WHEN objadr.type = 1 THEN 'м.' \n"
                + "            WHEN objadr.type = 2 THEN 'с.' \n"
                + "            WHEN objadr.type = 3 THEN 'смт.' \n"
                + "       END AS type_o, \n"
                + "       CASE  \n"
                + "            WHEN NULLIF(TC_V2.[object_adress], '') IS NOT NULL THEN ISNULL(objadr.name, '') \n"
                + "                 + ', вул. ' + ISNULL(TC_V2.[object_adress], '') \n"
                + "            ELSE ISNULL(objadr.name, '') \n"
                + "       END AS object_adress, \n"
                + "       CASE  \n"
                + "            WHEN cusadr.type = 1 THEN 'м.' \n"
                + "            WHEN cusadr.type = 2 THEN 'с.' \n"
                + "            WHEN cusadr.type = 3 THEN 'смт.' \n"
                + "       END AS type_c, \n"
                + "       ISNULL(cusadr.name, '') + ', вул. ' + ISNULL(TC_V2.[customer_adress], '') AS  \n"
                + "       customer_adress, \n"
                + "CASE TC_V2.[reliabylity_class_1] \n"
                + "       WHEN 'TRUE' THEN 'першій'  \n"
                + "       ELSE '' END AS rc_1, \n"
                + "       CASE TC_V2.[reliabylity_class_2] \n"
                + "       WHEN 'TRUE' THEN 'другій'  \n"
                + "       ELSE '' END AS rc_2, \n"
                + "       CASE TC_V2.[reliabylity_class_3] \n"
                + "       WHEN 'TRUE' THEN 'третій'  \n"
                + "       ELSE '' END AS rc_3,"
                + "       [rem_name], \n"
                + "       [Director], \n"
                + "       [director_rod], \n"
                + "       [golovnyi_ingener], \n"
                + "       ISNULL(SUPPLYCH.selecting_point, '') AS selecting_point \n"
                + "FROM   TC_V2 \n"
                + "       LEFT JOIN [TC_LIST_locality] objadr \n"
                + "            ON  objadr.id = TC_V2.name_locality \n"
                + "       LEFT JOIN [TC_LIST_locality] cusadr \n"
                + "            ON  cusadr.id = TC_V2.customer_locality \n"
                + "       LEFT JOIN [TUweb].[dbo].[TC_LIST_customer_soc_status] soc_status \n"
                + "            ON  soc_status.id = TC_V2.customer_soc_status \n"
                + "       LEFT JOIN [TUweb].[dbo].[rem] rem \n"
                + "            ON  TC_V2.department_id = rem.rem_id \n"
                + "       LEFT JOIN SUPPLYCH \n"
                + "            ON  SUPPLYCH.tc_id = TC_V2.id "
                + " where TC_V2.id=" + request.getParameter("tu_id");
        pstmt = c.prepareStatement(qry);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCdls = rsmd.getColumnCount();
        String tmp = "";
        int i = 1;
        rs.next();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="../word_page_format_12pt.jsp"/>
        <style type="text/css">
            <!--
            body,td,th {
                font-size: 9pt;
            }
            .style1 {
                font-size: 9pt;
                font-weight: bold;

            }
            .style2 {
                font-size: 9pt;
                font-weight: bold;
                margin-top: 0; /* Отступ сверху */
                margin-bottom: 0; /* Отступ снизу */  
            }
            li {
                margin-top: 0; /* Отступ сверху */
                margin-bottom: 0; /* Отступ снизу */    
            }
            -->
        </style>
    </head>
    <body>
        <p align="center"><strong>Акт</strong><br />
            <strong>розмежування балансової належності електромереж та експлуатаційної  відповідальності сторін </strong><br />
            Споживач  електроенергії: <strong><%= rs.getString("PIP")%>, <%= rs.getString("type_o")%><%= rs.getString("customer_adress")%></strong><br />
            та <strong>філія АТ «Прикарпаттяобленерго» «<%= rs.getString("rem_name")%> РЕМ»</strong><br />
            в особі  <strong>директора <%= rs.getString("director_rod")%></strong><br /></p> 
        цим актом установили:
        <div align="justify" style="text-align:justify">
            <dl>
                <dt>1. Балансова належність електромереж та  установок:</dt>
                <dt> Постачальника: <strong>до вихідних клем приладу обліку, що за живлений від <%= rs.getString("selecting_point")%></strong>.<dt />
                <dt>Власника: ___________________; <dt />
                <dt>Споживача: <strong> від вихідних клем приладу  обліку.</strong> <dt />
                <dt>2. Межа балансової належності між  Постачальником та Споживачем установлюється на вихідних клемах  приладу обліку;<dt />
                Межа балансової належності між Власником мереж та Споживачем установлюється на ____.<dt />
                <dt>3. Межа експлуатаційної відповідальності за стан  обслуговування електромереж і установок між Постачальником та Споживачем  установлюється на вихідних клемах приладу  обліку;<dt />
                <dt>Межа експлуатаційної відповідальності за стан обслуговування електромереж і установок між Власником мереж та  Споживачем установлюється на ____.<dt />
                <dt>4. Експлуатаційна  відповідальність  за стан обслуговування  електромереж і установок: <dt />
                <dt>Постачальника:  <strong>до  вихідних клем приладу обліку, що за живлений від <%= rs.getString("selecting_point")%></strong>.<dt />
                <dt>Власника: ___________________;<dt />
                <dt>Споживача: <strong>від вихідних клем приладу обліку.</strong><dt />
                <dt>5. Схема електромереж Постачальника, якими здійснюється постачання  електричної енергії на даний об&rsquo;єкт Споживача відповідає <strong><%= rs.getString("rc_1")%></strong> <strong><%= rs.getString("rc_2")%></strong> <strong><%= rs.getString("rc_3")%></strong> категорії надійності електропостачання. <dt />
                <dt> У власності споживача наявне джерело резервного живлення - ___,
                    за  технічний стан якого і готовність до своєчасного пуску Споживач несе повну відповідальність. Збитки та негативні наслідки від  несвоєчасного або несанкціонованого пуску резервних джерел живлення  відшкодовуються за рахунок Споживача.<dt />
                <dt>6. Споживач електроенергії та  Постачальник зобов'язуються утримувати установки, які зазначені в цьому акті, у  справному стані та експлуатувати їх відповідно до Правил користування  електричною енергією, ПТЕ, ПТБ.<dt />
                <dt>7. Споживач зобов'язується забезпечити  на своїй території охорону електроустановок, в тому числі електричних мереж,  які належать Постачальнику, доступ до цих електроустановок працівників  Постачальника для проведення необхідних робіт.<dt />
                <dt>8. Постачальник зобов'язується  забезпечити на своїй території охорону електроустановок, в тому числі  електричних мереж, які належать Споживачу, та допуск працівників Споживача  до  цих електроустановок для ремонту  обладнання. <dt/>
            </dl>
        </div>
        <em>Примітка. </em><br />
        <em>Акт розмежування  балансової належності і експлуатаційної відповідальності складається по кожній  точці приєднання електроустановок споживача до електромереж</em>.

        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="391" valign="top"><p class="style2"><strong>Постачальник</strong></p></td>
                <td width="240" valign="top"><p class="style2">Замовник</p></td>
            </tr>
            <tr>
                <td width="328" valign="top"><p>філія “ <%=rs.getString("rem_name")%> РЕМ”<br>
                        Директор <br>
                        <%=rs.getString("Director")%></p>
                    М.П.
                </td>
                <td width="329" valign="top"><p><br>
                        Громадянин (ка)<br>
                        <%=rs.getString("PIP")%></p>
                    М.П.
                </td>
            </tr>
            <tr>
                <td>________________ <br>
                            (підпис)                              <br></td>
                <td>_______________       

                    <br>
                               (підпис)   
                </td>
            </tr>
        </table>
    </body>
    <%} catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(c);
            ic.close();
        }
    %>
</html>
