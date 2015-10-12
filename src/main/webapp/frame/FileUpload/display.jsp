<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
</head>
<body>
 
	File uploaded to : <%= request.getAttribute("uploadedFilePath") %>
	<br/><br/>
        <a href="<%= request.getAttribute("uploadedFilePath") %>" target="_blank">
        Click here to download it</a>
 
</body>
</html>