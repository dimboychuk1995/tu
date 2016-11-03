<%--
  Created by IntelliJ IDEA.
  User: us9522
  Date: 01.11.2016
  Time: 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.util.Iterator"%>
<%@page import="oblenergo.users.UserController"%>
<%@page import="Model.User"%>

<html>
<head>
      <!--[IF IE]>
      <script type="text/javascript">
        alert('Рекомендовано використовувати інший браузер (наприклад Chrome, Firefox)!');
      </script>
      <![endif]-->
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Довідник користувачів</title>
      <link href="../../css/bootstrap.min.css" rel="stylesheet" type="text/css">
      <link href="../../css/users.css" rel="stylesheet" type="text/css">
      <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
      <script src="../../js/jquery-1.11.0.min.js"></script>
      <!-- Include all compiled plugins (below), or include individual files as needed -->
      <script src="../../js/bootstrap.min.js"></script>
      <script src="../../js/jsonDelete/jsonDeleteUser.js"></script>
</head>
<body>
    <jsp:useBean id="userList" class="oblenergo.users.UserController" />
    <div class="container-fluid">
        <table id="usersTable" class="table table-hover table-bordered table-striped">
          <thead>
            <tr>
              <th class ="col-md-1">name</th>

              <th class ="col-md-2">PIP</th>
              <th class ="col-md-1">tab_no</th>
              <th class ="col-md-1">idRem</th>
              <th class ="col-md-1">role</th>
              <th class ="col-md-1">tel_number</th>
              <th class ="col-md-1">permission</th>
              <th class ="col-md-1"></th>
              <th class ="col-md-1"></th>
            </tr>
          </thead>
          <tbody>
            <%
              for (User user : userList.AllUsers()){
            %>
            <form>
            <tr>
              <td class=""><input id="name" class="form-control" name="name" value="<%=user.getName()%>"></td>
              <td class=""><input id="PIP" class="form-control" name="PIP" value="<%=user.getPIP()%>"></td>
              <td class=""><input id="tab_no" class="form-control"   name="tab_no" value="<%=user.getTab_no()%>"></td>
              <td class=""><input id="idRem" class="form-control" name="idRem" value="<%=user.getIdRem()%>"></td>
              <td class=""><input id="role" class="form-control" name="role" value="<%=user.getRole()%>"></td>
              <td class=""><input id="tel_number" class="form-control" name="tel_number" value="<%=user.getTel_number()%>"></td>
              <td class=""><input id="permission" class="form-control" name="permission" value="<%=user.getPermission()%>"></td>
              <td class=""><button id="sendForm" type="submit" class="btn btn-success">Зберегти</button></td>
            </form>
            <form action="javascript:void(null);" class="cancel_of_order" id="formDeletedUser<%=user.getId()%>" onsubmit="deleteUserAjax(<%=user.getId()%>)">
                <%--<input class="form-control" id="id" type="text" name="id" type="hidden" value="<%=user.getId()%>" />--%>
                <input id="del_user" type="hidden" name="del_user" value="<%=user.getId()%>"/>
                <td class=""><button id="" value="delete" type="submit" class="btn btn-danger">Видалити користувача</button></td>
            </form>
            </tr>

            <%}%>

          </tbody>
        </table>
    </div>
</body>
</html>
