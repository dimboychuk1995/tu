<%@ page contentType="text/xml;charset=UTF-8" language="java"%><?xml version="1.0" encoding="UTF-8"?><%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<toolbar>
    <logic:notEqual value="128" parameter="rol">
        <item id="new_f" type="button"  img="new_dis.gif" text="Новий Споживач" imgdis="new_dis.gif"/>
        <item id="sep1" type="separator"/>
    </logic:notEqual>
    <item id="open" type="button"  img="open.gif" text="Показати список ТУ" imgdis="open_dis.gif"/>
    <logic:notEqual value="128" parameter="rol">
    <item id="reminder" type="button"  img="open.gif" text="Показати список протермінованих" imgdis="open_dis.gif"/>
    </logic:notEqual>
    <item id="search" type="button"  img="search.jpeg" text="Пошук споживача" imgdis="search.jpeg"/>
    <logic:notEqual value="128" parameter="rol">
        <item id="chengestu" type="button" img="open.gif" text="Журнал змін в ТУ" imgdis="open_dis.gif"/>
    </logic:notEqual>
</toolbar>