<%-- 
    Document   : uploadfiles
    Created on : 25 черв 2010, 10:02:04
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="javazoom.upload.*,java.util.Hashtable" %>
<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="c:/uploads" />
</jsp:useBean>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%
      if (MultipartFormDataRequest.isMultipartFormData(request))
      {
         // Uses MultipartFormDataRequest to parse the HTTP request.
         MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
         String todo = null;
         if (mrequest != null) todo = mrequest.getParameter("todo");
	     if ( (todo != null) && (todo.equalsIgnoreCase("upload")) )
	     {
                Hashtable files = mrequest.getFiles();
                if ( (files != null) && (!files.isEmpty()) )
                {
                    UploadFile file = (UploadFile) files.get("uploadfile");
                    if (file != null) out.println("<li>Form field : uploadfile"+"<BR> Uploaded file : "+file.getFileName()+" ("+file.getFileSize()+" bytes)"+"<BR> Content Type : "+file.getContentType());
                    // Uses the bean now to store specified by jsp:setProperty at the top.
                    upBean.store(mrequest, "uploadfile");
                }
                else
                {
                  out.println("<li>No uploaded files");
                }
	     }
         else out.println("<BR> todo="+todo);
      }
%>
        <form method="post" action="uploadfiles.jsp" name="upform" enctype="multipart/form-data">
          <table width="60%" border="0" cellspacing="1" cellpadding="1" align="center" class="style1">
            <tr>
              <td align="left"><b>Виберіть файл для завантаження :</b></td>
            </tr>
            <tr>
              <td align="left">
                <input type="file" name="uploadfile" size="50">
                </td>
            </tr>
            <tr>
              <td align="left">
                        <input type="hidden" name="todo" value="upload">
                <input type="submit" name="Submit" value="Завантажити">
                <input type="reset" name="Reset" value="Відмінити">
                </td>
            </tr>
          </table>
        </form>
        <a href="changestuxp.jsp">Повернутись до "журналу змін"</a>
    </body>
</html>
