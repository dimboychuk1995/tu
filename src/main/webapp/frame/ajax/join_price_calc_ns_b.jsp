<%@page import="ua.ifr.oe.tc.list.SQLUtils" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/json.tld" prefix="json" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page
        import="javax.sql.DataSource,java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException" %>
<% HttpSession ses = request.getSession();
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server

    String price_el_dev = new String();
    String price_el_dev_1 = new String();
    String p_price_join = new String();
    String customer_participate = new String();
    String db = new String();
    if (!ses.getAttribute("db_name").equals(null)) {
        db = (String) ses.getAttribute("db_name");
    } else {
        db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
    }
    InitialContext ic = null;
    DataSource ds = null;
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        ic = new InitialContext();
        ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
        c = ds.getConnection();
        System.out.println(request.getParameter("tu_id"));
        String SQL = ""
        + "DECLARE @connection_price NUMERIC(10,2)  \n"
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
                + "SET @Hpj = (@Bps_cap - @Bj_unmount)/@Pdelta_j \n"
                + "SET @Bps_sob = @connection_price+@price_conn \n"
                + "SET @P = (select (ISNULL(tv.request_power,0)-ISNULL(tv.power_old,0)) FROM TC_V2 tv LEFT JOIN SUPPLYCH s ON s.tc_id = tv.id	where tv.id=@tu_id) \n"
                + "SET @Pij = @dPj * 250 + (@P-@dPj) * @Hpj + @Bpr_lin + @Bps_sob - @Bpkd \n"

                + "SELECT "
                + "((((ISNULL(reliabylity_class_1_val,0) - ISNULL(reliabylity_class_1_val_old,0))*2) + ((ISNULL(reliabylity_class_2_val,0) - ISNULL(reliabylity_class_2_val_old,0))*2) + ((ISNULL(reliabylity_class_3_val,0) - ISNULL(reliabylity_class_3_val_old,0))))*250+ISNULL(tv.price_rec_build,0)+ISNULL(tv.fact_costs_build,0)-isnull(tv.devellopment_price,0)) as price_el_dev, \n"
                + "ISNULL(cast(((ISNULL(tv.cap_costs_build,0)-ISNULL(tv.unmount_devices_price,0))/NULLIF(s.ps_10_inc_rez,0)) AS NUMERIC(10,2)),0) AS p_price_join, \n"
                + "@Pij AS price_el_dev_1 \n"
                + ",ISNULL(CAST(((ISNULL(tv.request_power,0)/NULLIF(tv.sum_join_pow,0))* ((ISNULL(tv.sum_join_pow,0) -  ISNULL(s.ps_10_reserv,0))/(NULLIF(s.ps_10_inc_rez,0)))*ISNULL(tv.cap_costs_build,0)) AS NUMERIC(15,2)),0) AS customer_participate \n"
                + " FROM   TC_V2 tv \n"
                + " left join [SUPPLYCH] s on tv.id = s.tc_id \n"
                + " where tv.id='" + request.getParameter("tu_id") + "'";
        pstmt = c.prepareStatement(SQL);
        System.out.println(SQL);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            price_el_dev = rs.getString("price_el_dev");
            price_el_dev_1 = rs.getString("price_el_dev_1");
            p_price_join = rs.getString("p_price_join");
            customer_participate = rs.getString("customer_participate");
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    }
    pageContext.setAttribute("price_el_dev", price_el_dev);
    pageContext.setAttribute("price_el_dev_1", price_el_dev_1);
    pageContext.setAttribute("p_price_join", p_price_join);
    pageContext.setAttribute("customer_participate", customer_participate);
%>
<json:object>
    <json:property name="price_el_dev"> ${price_el_dev}</json:property>
    <json:property name="price_el_dev_1"> ${price_el_dev_1}</json:property>
    <json:property name="p_price_join"> ${p_price_join}</json:property>
    <json:property name="customer_participate"> ${customer_participate}</json:property>
</json:object>

