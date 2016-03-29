<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%  response.setHeader("Content-Disposition","inline;filename=calc_ns_join_1.doc") ;
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    HttpSession ses = request.getSession();
    String db = new String();
    if (ses.getAttribute("db_name")!=null) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try {
        c = ds.getConnection();
           String sql = "DECLARE @connection_price NUMERIC(10,2)  \n"
           + "		,@ps_rez NUMERIC(10,2)  \n"
           + "		,@sum_pow NUMERIC(10,2) \n"
           + "		,@Pj_max NUMERIC(10,2) \n"
           + "		,@K NUMERIC(10,2) \n"
           + "		,@dPj NUMERIC (10,2) = 0\n"
           + "        ,@Pdelta_j NUMERIC(10,2) \n"
           + "        ,@Pjnov_max NUMERIC(10,2) \n"
           + "        ,@Bps_cap NUMERIC(10,2) \n"
           + "        ,@Bj_unmount NUMERIC(10,2) \n"
           + "        ,@Bps_sob NUMERIC(10,2) \n"
           + "        ,@Hpj NUMERIC(10,2) \n"
           + "        ,@P NUMERIC(10,2) \n"
           + "        ,@Bpr_lin NUMERIC(10,2) \n"
           + "        ,@Bpkd NUMERIC (10,2) \n"
           + "        ,@Pij NUMERIC (10,2) \n"
           + "        ,@tu_id INT =" + request.getParameter("tu_id")
           + "        ,@price_conn NUMERIC (10,2) = 417.42 \n"
           + " SET @connection_price =(SELECT CASE WHEN (isnull(tv.request_power,0.00))<=15 THEN 1035.05 \n"
           + "					  WHEN (isnull(tv.request_power,0))>15 AND (isnull(tv.request_power,0))<=150 THEN 1061.64 \n"
           + "					  WHEN (isnull(tv.request_power,0))>150 AND (isnull(tv.request_power,0))<=500 THEN 1724.42 \n"
           + "					  WHEN (isnull(tv.request_power,0))>500 AND (isnull(tv.request_power,0))<=10000 THEN 1845.80 \n"
           + "					  ELSE 0 END FROM TC_V2 tv where tv.id=@tu_id) \n"
           + " SET @ps_rez =  \n"
           + "	ISNULL((SELECT Cast(Sum(A.[Power]) AS NUMERIC(10,2) ) FROM  \n"
           + "			(SELECT Isnull(CASE WHEN (SELECT Count(id) FROM SUPPLYCH WHERE SUPPLYCH.tc_id=TC_V2.id GROUP BY supplych.tc_id)>1  \n"
           + "			 AND Upper(reliabylity_class_1) LIKE 'FALSE' AND Upper(reliabylity_class_2) LIKE 'FALSE'  \n"
           + "			 AND Upper(reliabylity_class_3) LIKE 'TRUE' AND (sp.[power]<>0 and sp.[power] IS NOT NULL) THEN sp.[POWER]  \n"
           + "			 ELSE TC_V2.request_power END,'') AS [power] FROM TC_V2  \n"
           + "			 LEFT JOIN SUPPLYCH sp ON sp.tc_id=TC_V2.id  \n"
           + "			 LEFT JOIN [TUweb].[dbo].[status_document] ON ([TUweb].[dbo].[status_document].status_id=TC_V2.state_contract)  \n"
           + "			 WHERE TC_V2.type_contract=1  \n"
           + "			 AND NULLIF(date_admission_consumer,'') IS NULL  \n"
           + "			 AND isnull(state_contract,0) NOT IN (2,3,5,7,8,13)  \n"
           + "			 AND sp.ps_10_disp_name=(SELECT ps_10_disp_name FROM SUPPLYCH s WHERE s.tc_id=@tu_id)) A),0)  \n"
           + "SET @sum_pow =  \n"
           + "ISNULL(( \n"
           + "		SELECT rt.SumPow FROM ResultTP rt \n"
           + "		WHERE rt.tp_name= \n"
           + "		( \n"
           + "			SELECT ptw.ps_name FROM TUWeb.dbo.ps_tu_web ptw WHERE ptw.ps_id= \n"
           + "			( \n"
           + "				SELECT s.ps_10_disp_name FROM SUPPLYCH s WHERE s.tc_id=@tu_id \n"
           + "			) \n"
           + "		) \n"
           + "),0) \n"
           + "SET @K =  \n"
           + "ISNULL(( \n"
           + "		SELECT case \n"
           + "		         WHEN rt.cnt BETWEEN 1 AND 10 THEN 0.9 \n"
           + "                 WHEN rt.cnt BETWEEN 11 AND 50 THEN 0.67 \n"
           + "                 WHEN rt.cnt BETWEEN 51 AND 100 THEN 0.53 \n"
           + "                 WHEN rt.cnt BETWEEN 101 AND 250 THEN 0.43 \n"
           + "                 WHEN rt.cnt BETWEEN 251 AND 500 THEN 0.36 \n"
           + "                 WHEN rt.cnt BETWEEN 501 AND 750 THEN 0.29 \n"
           + "                 WHEN rt.cnt BETWEEN 751 AND 1000 THEN 0.24 \n"
           + "                 WHEN rt.cnt BETWEEN 1001 AND 10000 THEN 0.2 \n"
           + "                 WHEN rt.cnt BETWEEN 10001 AND 100000 THEN 0.16 \n"
           + "                 WHEN rt.cnt BETWEEN 100001 AND 1000000 THEN 0.12 \n"
           + "                 WHEN rt.cnt >1000001 THEN 0.12 \n"
           + "                 ELSE 1 \n"
           + "                 END \n"
           + "		FROM ResultTP rt \n"
           + "		WHERE rt.tp_name= \n"
           + "		( \n"
           + "			SELECT ptw.ps_name FROM TUWeb.dbo.ps_tu_web ptw WHERE ptw.ps_id= \n"
           + "			( \n"
           + "				SELECT s.ps_10_disp_name FROM SUPPLYCH s WHERE s.tc_id=@tu_id \n"
           + "			) \n"
           + "		) \n"
           + "),1) \n"
           + "SET @Pj_max = isnull((SELECT	CASE WHEN ptw.ps_nom_nav_2 is NULL THEN ISNULL(0.92*ptw.ps_nom_nav,0) \n"
           + "			 WHEN ptw.ps_nom_nav>=ptw.ps_nom_nav_2 then isnull(0.92*ptw.ps_nom_nav_2*1.4,0) \n"
           + "			 WHEN ptw.ps_nom_nav<ptw.ps_nom_nav_2 then isnull(0.92*ptw.ps_nom_nav*1.4,0) \n"
           + "			 ELSE 0 END \n"
           + "FROM TUWeb.dbo.ps_tu_web ptw \n"
           + "WHERE ptw.ps_id=(SELECT s.ps_10_disp_name FROM SUPPLYCH s WHERE s.tc_id=@tu_id)),0) \n"
           + "SET @Pjnov_max = (SELECT  ISNULL(s.ps_10_pow_after_rec,0) AS ps_10_pow_after_rec FROM TC_V2 tv  --Номінальна потужність підстанції після реконструкції  \n"
           + "		LEFT JOIN SUPPLYCH s ON s.tc_id = tv.id	where tv.id=@tu_id)  \n"
           + "if(@Pj_max * 1/@K - (@sum_pow+@ps_rez))>=0 begin SET @dPj = @Pj_max * 1/@K - (@sum_pow+@ps_rez) end \n"
           + "SET @Pdelta_j = (@Pjnov_max-@Pj_max)/@K \n"
           + "SET @Bps_cap = (select ISNULL(cap_costs_build,0) FROM TC_V2 tv LEFT JOIN SUPPLYCH s ON s.tc_id = tv.id	where tv.id=@tu_id) \n"
           + "SET @Bpr_lin = (select ISNULL(tv.price_rec_build,0) FROM TC_V2 tv LEFT JOIN SUPPLYCH s ON s.tc_id = tv.id	where tv.id=@tu_id) \n"
           + "SET @Bj_unmount = (select ISNULL(tv.unmount_devices_price,0) FROM TC_V2 tv LEFT JOIN SUPPLYCH s ON s.tc_id = tv.id	where tv.id=@tu_id) \n"
           + "SET @Bpkd = (select ISNULL(tv.devellopment_price,0) FROM TC_V2 tv LEFT JOIN SUPPLYCH s ON s.tc_id = tv.id	where tv.id=@tu_id) \n"
           + "SET @Hpj = (@Bps_cap + @Bj_unmount)/@Pdelta_j \n"
           + "SET @Bps_sob = @connection_price+@price_conn \n"
           + "SET @P = (select (ISNULL(tv.request_power,0)-ISNULL(tv.power_old,0)) FROM TC_V2 tv LEFT JOIN SUPPLYCH s ON s.tc_id = tv.id	where tv.id=@tu_id) \n"
           + "SET @Pij = @dPj * 250 + (@P-@dPj) * @Hpj + @Bpr_lin + @Bps_sob - @Bpkd \n"
           + "SELECT   \n"
           + "        CASE tv.customer_type \n"
           + "				WHEN 0 THEN ISNULL(tv.f_name,'') + ' ' + ISNULL(tv.s_name,'') + ' ' + ISNULL(tv.t_name,'') \n"
           + "				ELSE isnull(tv.juridical,'')  \n"
           + "        END AS [name] \n"
           + "        ,tv.number AS number \n"
           + "		,@P AS request_power --Заявлена потужність   \n"
           + "		,ISNULL(@connection_price,0) AS connection_price --Витрати з видачі технічних умов \n"
           + "		,@Bpr_lin AS price_rec_build --Вартість будівництва та/або реконструкції електричних мереж \n"
           + "		,(@ps_rez+@sum_pow) AS Pi_dog --Приєднана потужність i споживача або Замовника за договором \n"
           + "		,@Bpkd AS devellopment_price --вартість розробки проекту ПКД \n"
           + "		,250 AS Hpj --Вартість резерву абонованої приєднаної потужності \n"
           + "		,@price_conn  AS price_conn --Витрати на підключення  \n"
           + "		,@Bj_unmount AS unmount_devices_price --Вартість оприбуткована демонтованого устаткування \n"
           + "		,(@sum_pow+@ps_rez) AS p_i_dog --Приєднана потужність i споживача або Замовника за договором про постачання  \n"
           + "		,@Bps_cap AS cap_costs_build --Величина капітальних витрат з будівництва та/або реконструкції  \n"
           + "		,ISNULL(s.ps_10_pow_after_rec,0) AS ps_10_pow_after_rec --Номінальна потужність підстанції після реконструкції  \n"
           + "		,@Pj_max AS p_max -- Максимально допустима потужність трансформатора  \n"
           + "		,@K AS koef \n"
           + "		,case when @dPj<0 then 0 else @dPj end AS dPj \n"
           + "		,@Pdelta_j AS Pdelta_j \n"
           + "		,@Hpj AS Hpj_nov \n"
           + "		,@Bps_sob AS Bps_sob  \n"
           + "		,@Pij AS rez  \n"
           + "		,CAST(@Pij*.2 AS NUMERIC(10,2)) AS pdv  \n"
           + "		,CAST(@Pij*1.2 AS NUMERIC(10,2)) AS price  \n"
           + "		FROM TC_V2 tv \n"
           + "		LEFT JOIN SUPPLYCH s ON s.tc_id = tv.id \n"
           + "		where tv.id=@tu_id";
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
            Вартість підключення споживача в електромережу <em> B<sub>підк</sub></em>=<%=rs.getString("price_conn")%> грн.<br />
            Приєднана потужність i споживача або Замовника за договором про постачання (користування) <em>P<sub>i</sub><sup>дог</sup></em>=<%=rs.getString("Pi_dog")%><br />
            Величина капітальних витрат з будівництва та/або реконструкції електричних мереж <em>В<sub>пр j</sub><sup>пс кап</sup></em>=<%=rs.getString("cap_costs_build")%> грн.<br />
            Номінальна потужність підстанції після реконструкції <em>P<sub>макс</sub><sup>j нов</sup></em>=<%=rs.getString("ps_10_pow_after_rec")%><br />
            Максимально допустима потужність трансформатора <em>P<sub>макс</sub><sup>j</sup></em>=<%=rs.getString("p_max")%><br />
            Коефіцієнт використання потужності <em>К<sub>вик</sub></em>=<%=rs.getString("koef")%><br />
            Вартість оприбуткована демонтованого устаткування <em>B<sub>демонт</sub></em>=<%=rs.getString("unmount_devices_price")%><br />
            <strong><h3>Розрахунок:</h3> </strong>
            Резерв приєднаної абонованої потужності<br><em>&#916;P<sup>j</sup></em>=<em>P<sub>макс</sub><sup>j</sup></em>*1/<em>К<sub>вик</sub></em>-<em>P<sub>i</sub><sup>дог</sup></em>=<%=rs.getString("p_max")%>*1/<%=rs.getString("koef")%>-<%=rs.getString("Pi_dog")%>=<%=rs.getString("dPj")%>.<br />
            Збільшення резерву приєднаної абонованої потужності за джерелом живлення <br><em>P<sub>&#916;</sub><sup>j</sup></em>=(<em>P<sub>макс</sub><sup>j нов</sup></em>-<em>P<sub>макс</sub></em>)*1/<em>К<sub>вик</sub></em>=(<%=rs.getString("ps_10_pow_after_rec")%>-<%=rs.getString("p_max")%>)*1/<%=rs.getString("koef")%>=<%=rs.getString("Pdelta_j")%>.<br />
            Питома вартість резерву абонованої приєднаної потужності на джерелі живлення j <br><em>H<sub>p</sub><sup>j нов</sup></em>=(<em>В<sub>пр j</sub><sup>пс кап</sup></em>-<em>В<sub>демонт</sub><sup>j</sup></em>)/<em>P<sub>&#916;</sub><sup>j</sup></em>=(<%=rs.getString("cap_costs_build")%>-<%=rs.getString("unmount_devices_price")%>)/<%=rs.getString("Pdelta_j")%>=<%=rs.getString("Hpj_nov")%> грн.<br />
            Сума фактичних витрат (без ПДВ) на приєднання <br><em>B<sub>пр j</sub><sup>пс соб</sup></em>=<em>B<sub>підк</sub></em>+<em>B<sub>ТУ</sub></em>=<%=rs.getString("price_conn")%>+<%=rs.getString("connection_price")%>=<%=rs.getString("Bps_sob")%> грн.<br />
            Плата за приєднання електроустановки без ПДВ  становить:</p>
        <p><em>П<sub>i</sub><sup>j</sup></em>=<em>P<sub>заявл</sub></em>/<em>P<sub>заявл</sub></em>(<em>&#916;P<sup>j</sup></em><em>* H<sub>p</sub><sup>j</sup></em> +(<em>P<sub>заявл</sub></em>-<em>&#916;P<sup>j</sup></em>)*<em>H<sub>p</sub><sup>j нов</sup></em> + <em> B<sub>прj</sub><sup>лін </sup></em> + <em>B<sub>пр j</sub><sup>пс соб</sup></em> - <em>B<sub>ПКД</sub></em>)<br />
            <br />
            П=<%=rs.getString("request_power")%>/<%=rs.getString("request_power")%>(<%=rs.getString("dPj")%> * <%=rs.getString("Hpj")%> + (<%=rs.getString("request_power")%> - <%=rs.getString("dPj")%>)*<%=rs.getString("Hpj_nov")%>+<%=rs.getString("price_rec_build")%> + <%=rs.getString("Bps_sob")%> - <%=rs.getString("devellopment_price")%>) = <%=rs.getString("rez")%> грн.<br />
            ПДВ 20% становить <%=rs.getString("pdv")%> грн.</p>
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
