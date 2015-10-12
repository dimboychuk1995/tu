<%-- 
    Document   : dicPS_FID
    Created on : 31 ???? 2010, 14:35:30
    Author     : AsuSV
--%>
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
    HttpSession ses=request.getSession();
    String db=new String();
    if(!ses.getAttribute("fbdb_name").equals(null)){ db=(String)ses.getAttribute("fbdb_name");}
    else{db=ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name",request);}
    //  String  db="fb300";
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/"+db);
    DataSource ds1 = (DataSource)ic.lookup("java:comp/env/jdbc/"+db);
    DataSource ds2 = (DataSource)ic.lookup("java:comp/env/jdbc/"+db);
    Connection c = ds.getConnection();
    Connection c1 = ds1.getConnection();
    Connection c2 = ds2.getConnection();
    PreparedStatement pstmt = c.prepareStatement("select dovidnikps110kv.ptr,dovidnikps110kv.nameps110 from dovidnikps110kv");
    ResultSet rs = pstmt.executeQuery();
    PreparedStatement pstmt1;
    PreparedStatement pstmt2;
    ResultSet rs1;
    ResultSet rs2;
%>
<table border="1">
<%   int  j=1;
     while(rs.next()){
            pstmt1 = c1.prepareStatement("select aktnebalansu.ptr, aktnebalansu.fider10kv from aktnebalansu where aktnebalansu.kodps=(?)");
            pstmt1.setString(1,rs.getString(1));
            rs1 = pstmt1.executeQuery();

%>
<tr>
<td><%= rs.getString(2)%></td>
<td><table border="1" width="100%">
    <%
            while(rs1.next()){
                    pstmt2 = c2.prepareStatement("select fiderdani.tp ,fiderdani.tp from fiderdani where fiderdani.name=(?) group by fiderdani.tp ");
                    pstmt2.setString(1,rs1.getString(2));
                    rs2 = pstmt2.executeQuery();
                %>
                <tr>
                <td><%= rs1.getString(2)%></td>
                <td>
                    <div class="navi"></div>
                    <div class="scrollable">
                        <div class="items" style="overflow:scroll">
                        <%
                        while(rs2.next()){
                        %>
                        <div class="item"><%= rs2.getString(2)%></div>
                        <%
                        }
                         %>
                    </div>
                    </div>
                </td>
                </tr>
                <%
            }
            
    %>
    </table></td>
</tr>
<%}
    SQLUtils.closeQuietly(rs);
    SQLUtils.closeQuietly(pstmt);
    SQLUtils.closeQuietly(c);
    ic.close();
%>
</table>

