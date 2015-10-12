<%@ page contentType="text/xml;charset=UTF-8" language="java"%><?xml version="1.0" encoding="UTF-8"?>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<menu>
    <item id="file" text="Файл">
        <logic:notEqual value="128" parameter="rol">
            <item id="new_f" text="Новий Споживач" img="new.gif"/>
        </logic:notEqual>
        <item id="file_sep_1" type="separator"/>
        <item id="open" text="Показати список ТУ" img="open.gif"/>
        <logic:notEqual value="128" parameter="rol">
        <item id="chengestu" text="Журнал змін в ТУ" img="open.gif"/>
        </logic:notEqual>
        <item id="file_sep_2" type="separator"/>
        <logic:notEqual value="128" parameter="rol">
            <item id="chengespas" text="Змінити пароль" img="settings.gif"/>
        </logic:notEqual>
        <item id="file_sep_3" type="separator"/>
        <item id="close" text="Close" img="close.gif"/>
    </item>
    
        <item id="report" text="Звіти">
            <logic:equal value="128" parameter="rol">
                <item id="rep31" text="Сформувати звіт в EXCEL" />
                <item id="rep32" text="Сформувати звіт Перелік договорів про постачання (користування) е. е." />
            </logic:equal>
            <logic:notEqual value="128" parameter="rol">
            <item id="rep0" text="Експортувати в EXCEL" />
            <item id="rep3" text="Експортувати в EXCEL всі РЕМ" />

            <item id="rep4" text="Звіт для ВКБ в EXCEL всі РЕМ(стандартне)" />
            <item id="rep41" text="Звіт для ВКБ в EXCEL всі РЕМ(нестандартне)" />
            <item id="rep5" text="Звіт Термін виконання робіт по приєднанню" />
            <item id="rep9" text="Звіт Відсутність плати за стандартне приєднання" />
            <item id="rep6" text="Звіт Інформація щодо фактичних витрат з приєднання електроустановок(стандартне)" />
            <item id="rep7" text="Звіт Інформація щодо фактичних витрат з приєднання електроустановок(нестандартне)" />
            <item id="rep8" text="Звіт Інформація щодо фактичних витрат з приєднання електроустановок(нестандартне2)" />
            <item id="rep1" text="Звіти" />
            <item id="rep2" text="-----" />
            </logic:notEqual>
        </item>
       <logic:notEqual value="128" parameter="rol">
        <item id="dic" text="Довідники">
            <item id="dic2" text="Населені пункти" />
            <item id="dic7" text="Виконавці" />
            <item id="dic11" text="Підстанції" />
            <item id="dic8" text="Довідник по РЕМ"/>
            <item id="dic9" text="Виконавці ВКБ" />
            <item id="dic10" text="Виконавці будівельно-монтажних робіт ВКБ" />

            <logic:notEqual value="255" parameter="rol">
                <item id="dic1" text="Функціональне призначення обекта" />
                <item id="dic3" text="Тип договору" />
                <item id="dic4" text="Причина видачі" />
                <item id="dic5" text="Термін продовження" />
                <item id="dic6" text="Соціальний статус" />
            </logic:notEqual>
        </item>
    </logic:notEqual>
    <item id="help" text="Допомога">
        <item id="about" text="Про програму..." img="about.gif"/>
        <item id="needhelp" text="Допомога" img="help.gif"/>
    </item>
</menu>