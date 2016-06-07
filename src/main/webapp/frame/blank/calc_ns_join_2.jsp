<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<% response.setHeader("Content-Disposition", "inline;filename=calc_ns_join_2.doc");
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
        String sql = "DECLARE @connection_price numeric(10,2),"
                           + "@connection_price_temp numeric(10,2), "
                           + "@price_conn numeric(10,2)= 542.93  "
                + "               SET @connection_price_temp =(SELECT (isnull(tv.request_power,0)) FROM TC_V2 tv where tv.id=" + request.getParameter("tu_id") + " ) \n"
                + "               SET @connection_price =(SELECT CASE     WHEN @connection_price_temp<=15 THEN 1287.97  \n"
                + "                					  WHEN @connection_price_temp>15 AND @connection_price_temp<=150 THEN 1321.99  \n"
                + "                					  WHEN @connection_price_temp>150 AND @connection_price_temp<=500 THEN 2284.26  \n"
                + "                					  WHEN @connection_price_temp>500 AND @connection_price_temp<=10000 THEN 2462.39  \n"
                + "                					  ELSE 0 END) "
                + "SELECT   \n"
                + " CASE tv.customer_type \n"
                + "				WHEN 0 THEN ISNULL(tv.f_name,'') + ' ' + ISNULL(tv.s_name,'') + ' ' + ISNULL(tv.t_name,'') \n"
                + "				ELSE isnull(tv.juridical,'')  \n"
                + "        END AS [name] \n"
                + "        ,tv.number AS number \n"
                + "                ,(ISNULL(tv.request_power,0)-ISNULL(tv.power_old,0)) AS request_power \n"
                + "                ,@connection_price AS connection_price \n"
                + "                ,(ISNULL(tv.request_power,0)-ISNULL(tv.power_old,0))*250 as reserve "
                + "                ,250 AS Hpj  \n"
                + "                ,ISNULL(tv.price_rec_build,0) AS price_rec_build  \n"
                + "                ,@price_conn  AS price_conn  \n"
                + "                ,ISNULL(tv.devellopment_price,0) AS devellopment_price  \n"
                + "                ,CAST(((ISNULL(tv.request_power,0)-ISNULL(tv.power_old,0))*250+ISNULL(tv.price_rec_build,0)+ISNULL(cast(@connection_price AS NUMERIC(10,2)),0)+@price_conn-ISNULL(tv.devellopment_price,0)) AS NUMERIC(10,2)) AS rez  \n"
                + "                ,CAST(((ISNULL(tv.request_power,0)-ISNULL(tv.power_old,0))*250+ISNULL(tv.price_rec_build,0)+ISNULL(cast(@connection_price AS NUMERIC(10,2)),0)+@price_conn-ISNULL(tv.devellopment_price,0))*.2 AS NUMERIC(10,2)) AS pdv  \n"
                + "                ,CAST(((ISNULL(tv.request_power,0)-ISNULL(tv.power_old,0))*250+ISNULL(tv.price_rec_build,0)+ISNULL(cast(@connection_price AS NUMERIC(10,2)),0)+@price_conn-ISNULL(tv.devellopment_price,0))*1.2 AS NUMERIC(10,2)) AS price  \n"
                + "                FROM TC_V2 tv"
                + " where tv.id=" + request.getParameter("tu_id");
        pstmt = c.prepareStatement(sql);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();
        rs.next();

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>JSP Page</title>
        <jsp:include page="word_page_format.jsp"/>
    </head>
    <body>
        <h2 align="center"><strong>Розрахунок  нестандартного приєднання</strong></h2>
        <h4 align="center">(<%=rs.getString("name")%> №<%=rs.getString("number")%>)</h4>
        <p><strong><h3>Вхідні дані:</h3></strong>
            Заявлена потужність  <em>P<sub>заявл</sub></em>= <%=rs.getString("request_power")%> кВт <br />
            Витрати з видачі технічних умов <em>B<sub>ТУ</sub></em> = <%=rs.getString("connection_price")%> грн.<br />
            Вартість будівництва та/або реконструкції електричних мереж до точки  приєднання електроустановки <em>B<sub>пр</sub><sup>лін</sup></em>= <%=rs.getString("price_rec_build")%> грн.<br />
            Вартість розробки ПКД <em>B<sub>ПКД</sub></em>= <%=rs.getString("devellopment_price")%> грн. <br />
            Вартість резерву абонованої  приєднаної потужності  <em>H<sub>p</sub><sup>j</sup></em>=<%=rs.getString("Hpj")%> грн.<br />
            За резерв потужності <%=rs.getString("request_power")%> * <%=rs.getString("Hpj")%> = <%=rs.getString("reserve")%> грн.<br />
            Вартість підключення споживача в електромережу <em> B<sub>підк</sub></em>=<%=rs.getString("price_conn")%> грн.<br />
            <strong><h3>Розрахунок:</h3> </strong>
            Плата за приєднання електроустановки без ПДВ  становить:</p>
        <p><em>П<sub>i</sub><sup>j</sup></em>=<em>P<sub>заявл</sub></em><em>* H<sub>p</sub><sup>j</sup></em> +<em> B<sub>пр</sub><sup>лін </sup></em>+ <em>B<sub>ТУ</sub></em>  + <em>B<sub>підк</sub></em> - <em>B<sub>ПКД</sub></em><br />
            <br />
            П=<%=rs.getString("request_power")%> * <%=rs.getString("Hpj")%> + <%=rs.getString("price_rec_build")%> + <%=rs.getString("connection_price")%> + 
            <%=rs.getString("price_conn")%> - <%=rs.getString("devellopment_price")%> = <%=rs.getString("rez")%> грн.<br />
            ПДВ становить <%=rs.getString("pdv")%> грн.</p>
        <strong>Вартість  приєднання з ПДВ <%=rs.getString("price")%> грн</strong>
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
