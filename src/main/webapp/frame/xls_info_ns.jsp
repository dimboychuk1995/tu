<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8"%>
<%--@page contentType="text/html" pageEncoding="UTF-8"--%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%   response.setHeader("Content-Disposition","inline;filename=info_ns.xls") ;
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
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
    try {
        c = ds.getConnection();
        if (request.getParameter("number") == null) {
            pstmt = c.prepareStatement("{call dbo.[ZvitInfoN9NSJ]()}");
        } else {
            pstmt = c.prepareStatement("{call dbo.Find_Customer_excel(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            pstmt.setString(1, (String) request.getParameter("number"));
            pstmt.setString(2, (String) request.getParameter("juridical"));
            pstmt.setString(3, (String) request.getParameter("f_name"));
            pstmt.setString(4, (String) request.getParameter("object_name"));
            pstmt.setString(5, (String) request.getParameter("name_locality"));
            pstmt.setString(6, (String) request.getParameter("object_adress"));
            pstmt.setString(7, (String) request.getParameter("request_power_from"));
            pstmt.setString(8, (String) request.getParameter("request_power_till"));
            pstmt.setString(9, (String) request.getParameter("develloper_company"));
            pstmt.setString(10, (String) request.getParameter("performer_proect_to_point"));
            pstmt.setString(11, (String) request.getParameter("performer_proect_after_point"));
            pstmt.setString(12, (String) request.getParameter("customer_type"));
            pstmt.setString(13, (String) request.getParameter("customer_soc_status"));
            pstmt.setString(14, (String) request.getParameter("initial_registration_date_rem_tu_from"));
            pstmt.setString(15, (String) request.getParameter("initial_registration_date_rem_tu_till"));
            pstmt.setString(16, (String) request.getParameter("date_admission_consumer_from"));
            pstmt.setString(17, (String) request.getParameter("date_admission_consumer_till"));
            pstmt.setString(18, (String) request.getParameter("date_contract_from"));
            pstmt.setString(19, (String) request.getParameter("date_contract_till"));
            pstmt.setString(20, (String) request.getParameter("ps_10_disp_name"));
            pstmt.setString(21, (String) request.getParameter("ps_35_disp_name"));
            pstmt.setString(22, (String) request.getParameter("fid_10_disp_name"));
            pstmt.setString(23, (String) request.getParameter("do1"));
            pstmt.setString(24, (String) request.getParameter("do2"));
            pstmt.setString(25, (String) request.getParameter("do3"));
        }
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();
        int inz = 1;
%>
<%--=request.getParameter("number")%><%=request.getQueryString()--%>
<table border="1" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">РЕМ</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">№п/п</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Соціальний статус</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Номер та дата договору про приєднання (технічних умов)</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Замовник/Споживач електричної енергії (найменування, адреса)</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Приєднана потужність,    Pp, кВт</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Ставка плати (для    стандартного приєднання) або доля участі Замовника в розвитку мереж для    нестандартного приєднання</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Надходження коштів за    договором про приєднання, тис.грн</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Дата оплати за нестандартне приєднання</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Рівень напруги в    точці приєднання, кВ</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Точка забезпечення    потужності назва лінії електропередач та номер опори (відстань до кабельної    врізки) та/або  назва (номер)    підстанції  згідно системи кодифікації    назв</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Вартість виїзду на об'єкт (без ПДВ), грн</td>
        <td colspan="4" rowspan="0" align="center" valign="middle"  bgcolor="#CCCCCC">Необхідність будівництва (реконструкції, переоснащення,    модернізації) підстанції напругою в кВ<br />
            (з переліком відповідних робіт: заміна трансформатора, вимикача,    розподільчого пристрою тощо)</td>
        <td colspan="4" rowspan="0" align="center" valign="middle"  bgcolor="#CCCCCC">Необхідність будівництва чи реконструкції ЛЕП у км напругою, кВ    (із зазначенням типу ЛЕП: ПЛ або КЛ)</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Фактичні капітальні витрати на приєднання Bфакт.кап, тис. грн</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Дата приймання БМР</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Фактичні витрати на приєднання, що формують виробничу собівартість Bфакт.соб, тис. грн</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Вартість розвитку мереж згідно з проектною документацією, тис. грн</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Дата введення в експлуатацію</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Балансова вартість    демонтованого устаткування та обладнання, яке підлягає подальшому    використанню, тис. грн.</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Номер ТП</td>
        <td colspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Номінальна потужність трансформаторів</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Завантаженість заміри</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Абонована приєднана потужність за результатами надання послуги з приєднання, кВт</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Мінімальне значення резерву потужності за джерелом живлення, кВт</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Дата подання напруги</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Ступінь приєднання</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Дата приймання інших витрат</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Інші витрати, грн.</td>
        <td rowspan="2" align="center" valign="middle"  bgcolor="#CCCCCC">Адреса об'єкта</td>
    </tr>
    <tr>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">110/35/10(6)</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">110/10(6)</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">35/10(6)</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">10(6)/0,4</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">110</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">35</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">10(6)</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">0,4</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">I трансформатор</td>
        <td rowspan="1" align="center" valign="middle"  bgcolor="#CCCCCC">II трансформатор</td>
    </tr>

    <% while (rs.next()) {%>
    <tr> <td align="center" valign="middle"><%= rs.getString(1)%></td>
        <td height="21" align="center" valign="middle"> <%out.print(inz++);%></td>
        <td align="center" valign="middle"> <%= rs.getString(2)%></td>
        <td align="center" valign="middle"> <%= rs.getString(3)%></td>
        <td align="center" valign="middle"> <%= rs.getString(4)%></td>
        <td align="center" valign="middle"> <%= rs.getString(5)%></td>
        <td align="center" valign="middle"> <%= rs.getString(6)%></td>
        <td align="center" valign="middle"> <%= rs.getString(7)%></td>
        <td align="center" valign="middle"> <%= rs.getString(8)%></td>
        <td align="center" valign="middle"> <%= rs.getString(9)%></td>
        <td align="center" valign="middle"> <%= rs.getString(10)%></td>
        <td align="center" valign="middle"> <%= rs.getString(11)%></td>
        <td align="center" valign="middle"> <%= rs.getString(12)%></td>
        <td align="center" valign="middle"> <%= rs.getString(13)%></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="center" valign="middle"> <%= rs.getString(14)%></td>
        <td align="center" valign="middle"> <%= rs.getString(15)%></td>
        <td align="center" valign="middle"> <%= rs.getString(16)%></td>
        <td align="center" valign="middle"> <%= rs.getString(17)%></td>
        <td align="center" valign="middle"> <%= rs.getString(18)%></td>
        <td align="center" valign="middle"> <%= rs.getString(19)%></td>
        <td align="center" valign="middle"> <%= rs.getString(20)%></td>
        <td align="center" valign="middle"> <%= rs.getString(21)%></td>
        <td align="center" valign="middle"> <%= rs.getString(22)%></td>
        <td align="center" valign="middle"> <%= rs.getString(23)%></td>
        <td align="center" valign="middle"> <%= rs.getString(24)%></td>
        <td align="center" valign="middle"> <%= rs.getString(25)%></td>
        <td align="center" valign="middle"> <%= rs.getString(26)%></td>
        <td align="center" valign="middle"> <%= rs.getString(27)%></td>
        <td align="center" valign="middle"> <%= rs.getString(28)%></td>
        <td align="center" valign="middle"> <%= rs.getString(29)%></td>
        <td align="center" valign="middle"> <%= rs.getString(30)%></td>
        <td align="center" valign="middle"> <%= rs.getString(31)%></td>
        <td align="center" valign="middle"> <%= rs.getString(32)%></td>
        <td align="center" valign="middle"> <%= rs.getString(33)%></td>
        
        
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
</table>
