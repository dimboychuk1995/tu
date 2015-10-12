<%-- 
    Document   : db_6
    Created on : 11 лют 2011, 10:22:06
    Author     : AsuSV
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.*"%>
<%
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb");
    try {
        c = ds.getConnection();
        pstmt = c.prepareStatement("{call dbo.ZvitVykonPoRalizTUTaVartostiZvitPeriod(?,?)}");
        String FromDate = (String) request.getParameter("FromDate");
        String TillDate = (String) request.getParameter("TillDate");
        pstmt.setString(1, FromDate);
        pstmt.setString(2, TillDate);
        rs = pstmt.executeQuery();
        String tmp = "", i = "18";
        rsmd = rs.getMetaData();
        int numCols = rsmd.getColumnCount();

%>


<table width="76%" border="0" align="center">
    <tr>
        <td width="87%" align="center">Аналіз рознесення "Бази даних ТУ" за <u><%=request.getParameter("FromDate")%> - <%=request.getParameter("TillDate")%></u><br>
            <div align="center"></div></td>
    </tr>
</table>


<table border="1" cellspacing="0" cellpadding="0" align="center" class="tabl" width="76%">
    <tr>
        <td width="35" rowspan="2" align="center">№ п/п </td>
        <td width="129" rowspan="2" align="center" bgcolor="#CCCCCC"><strong>Назва РЕМ</strong> </td>
        <td colspan="2" align="center">Всього допущених </td>
        <%-- <td colspan="2" align="center">Всього допущених у звітному періоді по виданих ТУ з поч. 2009р.</td>--%>
        <%--<td rowspan="2" align="center">Позначка б/м </td>
        <td rowspan="2" align="center">Всього рознесених, шт</td>--%>
        <td colspan="2" align="center">РЕМ/ВАТ</td>
        <td colspan="2" align="center">ПП Альфаелектро </td>
        <td colspan="2" align="center">НЕП</td>
        <td colspan="2" align="center">ДП</td>
        <td colspan="2" align="center">Інші</td>
    </tr>
    <tr>
        <td width="52" align="center">шт.</td>
        <td width="62" align="center">грн.</td>
        <td align="center">шт.</td>
        <td align="center">грн.</td>
        <td align="center">к-сть</td>
        <td align="center">грн.</td>
        <td width="44" align="center">к-сть</td>
        <td width="38" align="center">грн.</td>
        <td width="40" align="center">к-сть</td>
        <td width="31" align="center">грн.</td>
        <td width="46" align="center">к-сть</td>
        <td width="38" align="center">грн.</td>
        <%--<td width="50" align="center">к-сть</td>
        <td width="46" align="center">грн.</td>--%>
    </tr>
    <%
        while (rs.next()) {
    %>
    <tr>
        <td align="center">
            <%
                tmp = rs.getString(1);
                if (!tmp.equals("18")) {
                        out.print(tmp = rs.getString(1));
                    }%></td>
        <td bgcolor="#CCCCCC"><%out.print(tmp = rs.getString(2));%></td>
        <td align="center">
            <%
                out.print(tmp = rs.getString(3));
            %>
        </td>
        <td align="center"><%
            out.print(tmp = rs.getString(4));
            %>
        </td>
        <td align="center"><%
            out.print(tmp = rs.getString(5));
            %>
        </td>
        <td align="center"><%
            out.print(tmp = rs.getString(6));
            %>
        </td>
        <td align="center"><%
            out.print(tmp = rs.getString(7));
            %>
        </td>
        <td align="center"><%
            out.print(tmp = rs.getString(8));
            %>
        </td>
        <td align="center"><%
            out.print(tmp = rs.getString(9));
            %>
        </td>
        <td align="center"><%
            out.print(tmp = rs.getString(10));
            %>
        </td>
        <td align="center"><%
            out.print(tmp = rs.getString(11));
            %>
        </td>
        <td align="center"><%
            out.print(tmp = rs.getString(12));
            %>
        </td>
        <td align="center"><%
            out.print(tmp = rs.getString(13));
            %>
        </td>
        <td align="center"><%
            out.print(tmp = rs.getString(14));
            %>
        </td>
        <%--  <td align="center"><%
              out.print(tmp= rs.getString(15));
              %>
              </td>
          <td align="center"><%
              out.print(tmp= rs.getString(16));
              %>
              </td>
          <td align="center"><%
              out.print(tmp= rs.getString(17));
              %>
              </td>
          <td align="center"><%
              out.print(tmp= rs.getString(18));
              %>
              </td>--%>
    </tr>
    <%}%>
</table>
<%} catch (SQLException e) {
        e.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    }
%>