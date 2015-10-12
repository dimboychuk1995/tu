<%-- 
    Document   : form
    Created on : 16 черв 2010, 20:27:09
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.Connection"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="codebase/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="codebase/jquery-1.3.2.min.js"></script>
        <script type="text/javascript" src="codebase/jquery-ui-1.7.2.custom.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){

                $(function() {
                    $(".datepicker").datepicker();
                });

            });
        </script>
    </head>
    <body>
        <table>
            <%
            //HttpSession ses=request.getSession();
            //String db=(String)ses.getAttribute("db_name");
            String form_name = request.getParameter("form_name");
            InitialContext ic = new InitialContext();
            DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/TUWeb");
            Connection Conn = ds.getConnection();
            String SQL = "Select * from TC_forms where form_id ='"+form_name+"' order by field_position";
            Statement stmt = Conn.createStatement();
            ResultSet rs = stmt.executeQuery(SQL);
            while(rs.next()){
            %><tr><td>
                    <%if(rs.getString(5).equals("separator")){%><hr><%}else{%>
                    <div style="float:left"><%=rs.getString(4)%></div><div style="float:right"><div style="float:left"><%
     if(rs.getString(5).equals("text"))
     {
                            %><input type="text" name="<%=rs.getString(2)%>" class="<%=rs.getString(6)%>" > <%
     }
     if(rs.getString(5).equals("select"))
     {
                            %><select name="<%=rs.getString(2)%>" >
                                <%
                                 Statement stmt1 = Conn.createStatement();
                                 ResultSet rs1 = stmt1.executeQuery("Select * from TC_LIST_locality");
                                 while(rs1.next()){
                                %><option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option><%
                                 }
                                 rs1.close();
                                 stmt1.close();
                                %>
                            </select> <%
                         }
                            %>
                        </div><div style="float:right">123</div></div>
                    <%}%></td></tr><%
                    }
                    rs.close();
                    stmt.close();
                    Conn.close();
                    ic.close();
                    %>
        </table>
    </body>
</html>
