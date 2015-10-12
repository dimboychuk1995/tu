<%--
    Document   : db_8
    Created on : 18.12.2012, 13:52:42
    Author     : Roman Vintonyak
--%>

<%--
    Document: Моніторинг якості надання послуг
    Alter on :30.07.2015
    Authot   : Dima Boychuk
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.*"%>

<%
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
        //String FromDate = (String) request.getParameter("FromDate");
        //String TillDate = (String) request.getParameter("TillDate");

        //PreparedStatement pstmt = Conn.prepareStatement("{call dbo.oblik_uklad_dog_nad_dost_elmer_tu(?,?)}");
        String ss;
        ss = "Declare @dt Date SET @dt = '2012-11-01'  SELECT "
                + "'S1.1' AS kod_poslugu,"
                + "'' AS kod_source,"
                + " isnull(case when customer_type=0 and department_id<>240 then isnull(f_name,'')+' '+isnull(substring(s_name,1,1),'')+'. '+isnull(substring(t_name,1,1),'')+'.' "
                + "	when customer_type=0 and department_id=240 AND s_name IS NULL AND t_name is null then isnull(f_name,'') "
                + " when customer_type=0 and department_id=240 AND s_name IS not NULL and t_name IS not NULL then isnull(f_name,'')+' '+isnull(substring(s_name,1,1),'')+'. '+isnull(substring(t_name,1,1),'')+'.'"
                + " else Juridical end,'') as zamovnyk, "
                + " case when TC_V2.[customer_locality] is not null and TC_V2.[customer_locality]>0 then "
                + " (select case "
                + "     when [type]=1 then 'м.' "
                + "     when [type]=2 then 'c.' "
                + "     when [type]=3 then 'cмт.' "
                + "     end as [type] from TC_LIST_locality t where t.id=cust.id)+ "
                + " isnull(cust.name,'')+', вул.'+ isnull(TC_V2.[customer_adress],'') "
                + "     when TC_V2.[customer_locality] is null or TC_V2.[customer_locality]=0 then "
                + "         isnull(TC_V2.customer_adress,'') "
                + " else (select case "
                + "     when [type]=1 then 'м.' "
                + "     when [type]=2 then 'c.' "
                + "     when [type]=3 then 'cмт.' "
                + "  end as [type] from TC_LIST_locality t where t.id=cust.id)+ "
                + " isnull(cust.name,'') end as customer_adress, "
                + "ISNULL(customer_telephone,'') as customer_telephone,"
                + "'' AS another,"
                + "isnull(convert (varchar(10),registration_date,104),'') as date_registration,"
                + "'' AS zatr_cal,"
                + "'' AS zatr_rob,"
                + "isnull(convert (varchar(10),initial_registration_date_rem_tu,104),'') as initial_date,"
                + "ISNULL(DATEDIFF(day,registration_date,initial_registration_date_rem_tu),'') AS kilkist_kal_dn,"
                + "isnull(cast(case when @dt>'" + request.getParameter("FromDate") + "'then NULL else (CAST(DATEDIFF(day,registration_date,initial_registration_date_rem_tu) AS INT)-CAST((SELECT COUNT(*) FROM [TestDB].[dbo].[Calendar] WHERE ([CalendarDate] BETWEEN registration_date AND initial_registration_date_rem_tu) AND isHoliday=1) AS int)) end as varchar(5)),'' )AS rob_dn,"
                + "'' AS prum"
                + " FROM [" + db + "].[dbo].[TC_V2]"
                + " left join [" + db + "].[dbo].TC_LIST_locality cust on [" + db + "].[dbo].TC_V2.customer_locality=cust.id "
                + "where registration_date>='" + request.getParameter("FromDate") + "' and  registration_date<='" + request.getParameter("TillDate") + "'and (type_join !='" + (Integer)3 + "'or type_join IS NULL)";

        //System.err.println(ss.toString());
        pstmt = c.prepareStatement(ss);
        rs = pstmt.executeQuery();
        String tmp = "";
        int inz = 1;

%>
<style type="text/css">
    <!--
    td.vertical{
        writing-mode:tb-rl;
        filter:flipH flipV;
    }
    -->
</style>
<%--=ss--%>
    <table width="100%"  height="140%" border="1" align="center" cellpadding="0" cellspacing="0" class="tabl">
    <tr>
        <td rowspan="3" align="center">№ п/п </td>
        <td width="90" rowspan="3" align="center" style="mso-rotate:90" >Код послуги (додаток 3)</td>
        <td width="40" rowspan="3" align="center" style="mso-rotate:90">Код джерела інформації</td>
        <td width="66" colspan="4" rowspan="1" align="center">Інформація про споживача</td>
        <td width="90" rowspan="3" align="center">Дата початку надання послуги</td>
        <td width="150" rowspan="2" colspan="2" align="center">Затримка виконання послуги з вини споживача та третіх осіб</td>
        <td width="90" rowspan="3" align="center">Дата завершення надання послуги</td>
        <td width="150" rowspan="2" colspan="2" align="center">Тривалість надання послуги(з вирахуванням часу затримки)</td>
        <td rowspan="3" width="100" align="center">Примітки</td>
    </tr>
    <tr>
        <td width="200" rowspan="2" align="center">Прізвище, ім’я, по-батькові або  юридична назва споживача</td>
        <td width="150" rowspan="2"  align="center">Адреса</td>
        <td width="100" rowspan="2" align="center">Телефон</td>
        <td width="100" rowspan="2" align="center">Інше</td>
    </tr>
    <tr>
        <td width="100" align="center">кал.д.</td>
        <td width="100" align="center">роб.д.</td>
        <td width="100" align="center">кал.д.</td>
        <td width="100" align="center">роб.д.</td>
    </tr>
            <% while (rs.next()) {%>
    <tr>
        <td align="center"> <%out.print(inz++);%></td>
        <td align="center"> &nbsp;<%out.print(tmp = rs.getString(1));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(2));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(3));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(4));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(5));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(6));%></td>
        <td align="center"> &nbsp;<%out.print(tmp = rs.getString(7));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(8));%></td>
        <td align="center"> &nbsp;<%out.print(tmp = rs.getString(9));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(10));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(11));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(12));%></td>
        <td align="center"> <%out.print(tmp = rs.getString(13));%></td>

    </tr>
            <%}
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(c);
            ic.close();
        }
    %>
