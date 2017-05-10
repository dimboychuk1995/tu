<%-- 
    Document   : fiz
    Created on : 29 бер 2011, 11:15:06
    Author     : asupv
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.*"%>
<%@page contentType="application/msword" pageEncoding="UTF-8"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.ArrayList,java.util.List"%>
<%response.setHeader("Content-Disposition", "inline;filename=akt_oz.doc");
    Connection c = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    NumberFormat nf = NumberFormat.getInstance();
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
        String qry = "SELECT ISNULL(CAST(tv.department_id AS VARCHAR(5)) ,'') department_id \n"
                + "      ,ISNULL(CAST(tv.commissioning_price AS VARCHAR(10)) ,'') AS  \n"
                + "       commissioning_price \n"
                + "      ,ISNULL([object_name] ,'') AS [object_name] \n"
                + "      ,CASE  \n"
                + "            WHEN lc.type=1 THEN 'м.' \n"
                + "            WHEN lc.type=2 THEN 'с.' \n"
                + "            WHEN lc.type=3 THEN 'смт.' \n"
                + "            ELSE '' \n"
                + "       END  \n"
                + "      +CASE  \n"
                + "            WHEN NULLIF(lc.id ,0) IS NULL AND NULLIF([object_adress] ,'') IS  \n"
                + "                 NOT NULL THEN ISNULL([object_adress] ,'') \n"
                + "            WHEN NULLIF(lc.id ,0) IS NOT NULL AND NULLIF([object_adress] ,'')  \n"
                + "                 IS NOT NULL THEN ISNULL(lc.name ,'')+', вул.'+ISNULL([object_adress] ,'') \n"
                + "            WHEN NULLIF(lc.id ,0) IS NOT NULL AND NULLIF([object_adress] ,'')  \n"
                + "                 IS NULL THEN ISNULL(lc.name ,'') \n"
                + "            ELSE '' \n"
                + "       END AS object_adress \n"
                + "      ,isnull(tj.name,'-') as type_join "
                + "      ,CASE  type_jobs_vkb"
                + "            WHEN 1 THEN 'будівництва' \n"
                + "            WHEN 2 THEN 'реконструкції' \n"
                + "            WHEN 3 THEN 'технічного переоснащення' \n"
                + "            ELSE '' \n"
                + "       END AS type_jobs_vkb \n"
                + "      ,ISNULL(s.selecting_point ,'') AS selecting_point \n"
                + "      ,ISNULL(bank_identification_number ,'') AS bank_identification_number \n"
                + "      ,ISNULL( \n"
                + "           CAST( \n"
                + "               CAST( \n"
                + "                   (tv.commissioning_price-(tv.counter_price/1.2)) AS NUMERIC(10 ,2) \n"
                + "               ) AS VARCHAR(20) \n"
                + "           ) \n"
                + "          ,'' \n"
                + "       ) AS enter \n"
                + "      ,ISNULL( \n"
                + "           CAST( \n"
                + "               CAST((tv.counter_price/1.2) AS NUMERIC(10 ,2)) AS VARCHAR(20) \n"
                + "           ) \n"
                + "          ,'' \n"
                + "       ) AS counter_price \n"
                + "      ,CASE  \n"
                + "            WHEN tv.ch_1033 IS NOT NULL AND UPPER(tv.ch_1033)='TRUE' THEN '1033' \n"
                + "            ELSE '' \n"
                + "       END AS ch_1033 \n"
                + "      ,CASE  \n"
                + "            WHEN tv.ch_1044 IS NOT NULL AND UPPER(tv.ch_1044)='TRUE' THEN '1044' \n"
                + "            ELSE '' \n"
                + "       END AS ch_1044 \n"
                + ",replace(isnull(cast(tv.l_build_kl_10 as varchar(20)),''),'.',',') as l_build_kl_10 "
                + ",replace(isnull(cast(tv.l_built_pl_10 as varchar(20)),''),'.',',') as l_built_pl_10 "
                + ",replace(isnull(cast(tv.l_built_kl_04 as varchar(20)),''),'.',',') as l_built_kl_04 "
                + ",replace(isnull(cast(tv.l_built_pl_04 as varchar(20)),''),'.',',') as l_built_pl_04 "
                + ",LEFT(PARSENAME(REPLACE(r.Director ,' ' ,'.') ,2) ,1)+'.'+ LEFT(PARSENAME(REPLACE(r.Director ,' ' ,'.') ,1) ,1)+'.'+"
                + "' '+PARSENAME(REPLACE(r.Director ,' ' ,'.') ,3) AS                 d_name"
                + ", r.rem_name"
                + ", isnull(s.inv_num_04,'') as inv_num_04"
                + ", isnull(tv.counter_type,'') as counter_type"
                + ", isnull(tv.counter_number,'') as counter_number"
                + ", case cast(s.join_point as varchar(5)) "
                + "     when '1' then '3Ф' "
                + "     when '2' then '3Ф' "
                + "     when '11' then '1Ф' "
                + "     when '21' then '1Ф' "
                + "     else  '' end as type1f3f"
                + " FROM   TC_V2 tv \n"
                + "       LEFT JOIN TC_LIST_locality lc \n"
                + "            ON  (lc.id=tv.name_locality) \n"
                + " left join TUWEB.dbo.rem r on tv.department_id=r.rem_id"
                + " left join SUPPLYCH s on tv.id=s.tc_id"
                + " left join [TUweb].[dbo].[type_join] tj on tv.type_join=tj.id"
                + " where tv.id=" + request.getParameter("tu_id");

        pstmt = c.prepareStatement(qry);
        rs = pstmt.executeQuery();
        rsmd = rs.getMetaData();
        int numCdls = rsmd.getColumnCount();
        rs.next();
        String sql = "SELECT ISNULL(cf.fullname,'') AS fullname, isnull(cf.name,'') AS name \n"
                + "  FROM Tuweb.dbo.Split((SELECT Nullif(TC_V2.selectedValues,'null') from dbo.TC_V2 WHERE id=" + request.getParameter("tu_id") + "),',') A \n"
                + "LEFT JOIN TUWeb.dbo.classification_field cf ON cf.id=A.data \n"
                + "";
        Statement pstmt1 = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        ResultSet rs1 = pstmt1.executeQuery(sql);

        int i = 1;
        String tmp = "";
        
        String sql2 = "SELECT isnull(cf.name,'') AS name "
                + "  FROM Tuweb.dbo.Split((SELECT Nullif(TC_V2.selectedValues,'null') from dbo.TC_V2 WHERE id=" + request.getParameter("tu_id") + "),',') A \n"
                + "LEFT JOIN TUWeb.dbo.classification_field cf ON cf.id=A.data "
                + "";
        Statement pstmt2 = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        ResultSet rs2 = pstmt2.executeQuery(sql);
        List<String> fields_list = new ArrayList();
        while(rs2.next()){
            if(rs2.getString("name").length()>0)
            fields_list.add(rs2.getString("name"));
        }
        SQLUtils.closeQuietly(rs2);
        SQLUtils.closeQuietly(pstmt2);
        %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <script type="text/javascript">
            $(document).ready(function(){
               
            });
        </script>   
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="word_page_format_1.jsp"/>
        <style>
            .tab { 
                border-collapse: collapse; 
                border: 2px solid; 
            }
            em,.line,#field{margin:0; padding:0;}
            .tab TD { 
                border-width: 1px; 
                border-style: solid; 

            }
            .rekv td,.rekv td p, .rekv p u, .rekv u{font-family: Arial; font-size: 11pt;}
        </style>
    </head>
    <body>
        <table width="640">
            <tr >
                <td colspan="2"><strong><u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;АТ“ Прикарпаттяобленерго ”&nbsp;&nbsp;&nbsp;&nbsp;</u></strong></td>
                <td colspan="2"><strong>Типова форма №  03-1</strong><strong><u></u></strong></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><sup>підприємство,   організація</sup></td>
                <td colspan="2">Затверджена наказом Мінстату України</td>
            </tr>
            <tr>
                <td height="21" colspan="2">&nbsp;</td>
                <td colspan="2">від 29.12.1995 р. № 352</td>
            </tr>
            <tr>
                <td width="148" height="21">Ідентифікаційний код</td>
                <td width="126" rowspan="2"><table width="109"  style="border-style:solid; border-width:1px; ">
                        <tr><td width="117" height="21"><center>00131564</center></td>
                        </tr></table></td>
                <td width="143">Код за УКУД </td>
                <td width="203" rowspan="2"><table width="109"  style="border-style:solid; border-width:1px; ">
                        <tr>
                            <td width="117" height="21">&nbsp;</td>
                        </tr>
                    </table></td>
            </tr>
            <tr>
                <td height="21">за  ЄДРПОУ</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td height="21" colspan="2">&nbsp;</td>
                <td colspan="2"><div align="right"><strong> ЗАТВЕРДЖУЮ</strong></div></td>
            </tr>
            <tr>
                <td height="21" colspan="2"><p>&nbsp;</p></td>
                <td colspan="2"><div align="right"><u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;  О.С.Сеник</u></div></td>
            </tr>
            <tr>
                <td height="21" colspan="2">&nbsp;</td>
                <td colspan="2"><div align="right"><strong><sup> підпис                                           &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; і., по  б., прізвище</sup>
                        </strong>
                        </p>
                    </div></td>
            </tr>
            <tr>
                <td height="28" colspan="2">&nbsp;</td>
                <td colspan="2"><p align="right"><u>“    ”</u>  <u>                                         201 р.  </u></p></td>
            </tr>
            <tr>
                <td colspan="2"> <h4 align="center"><strong>АКТ<br />
                            ПРИЙМАННЯ – ПЕРЕДАЧІ<br/>
                            (ВНУТРІШНЬОГО ПЕРЕМІЩЕННЯ)<br/>
                            ОСНОВНИХ ЗАСОБІВ</strong></h4></td>
                <td colspan="2"><table width="343" cellpadding="0" cellspacing="0"  class="tab">
                        <tr>
                            <td width="70"><p align="center">Номер документа</p></td>
                            <td width="87"><p align="center">Дата складання</p></td>
                            <td width="112"><p align="center">Код особи, яка відповідає за збереження основних засобів</p></td>
                            <td width="131"><p align="center">Код виду операції</p></td>
                        </tr>
                        <tr>
                            <td width="70" ><p>&nbsp;</p></td>
                            <td width="87"><p align="center">&nbsp;</p></td>
                            <td width="112"><p align="center">&nbsp;</p></td>
                            <td width="131"><p>&nbsp;</p></td>
                        </tr>
                    </table></td>
            </tr>
        </table> 
        <table  cellspacing="0" cellpadding="0" width="702" align="center" class="tab">
            <tr>
                <td width="36">Здавач</td>
                <td width="48"><p align="center">Одер-жувач</p></td>
                <td width="96" colspan="2"><p align="center">Дебет</p></td>
                <td width="98" colspan="2"><p align="center">Кредит</p></td>
                <td width="57" rowspan="2"><p align="center">Первісна    (балансова) вар-<br>
                        тість</p></td>
                <td width="104" colspan="2"><p align="center">Шифр</p></td>
                <td width="126" colspan="2"><p align="center">Код</p></td>
                <td width="96" colspan="2"><p align="center">Норма амортизац.    відрахувань</p></td>
                <td width="42" rowspan="2"><p align="center">Попра-вочний    коефі-цієнт</p></td>
            </tr>
            <tr>
                <td width="84" colspan="2">Цех, відділ,    дільниця, лінія</td>
                <td width="48">Раху-нок,    субра-хунок</td>
                <td width="48"><p align="center"> код аналі-тич-ного обліку</p></td>
                <td width="46"><p align="center">Рахунок,    субрахунок</p></td>
                <td width="51" valign="top"><p align="center">&nbsp;</p>
                    <p align="center">код аналі-тич-ного    обліку</p></td>
                <td width="47"><p align="center">Інвентар-<br>
                        ний</p></td>
                <td width="57"><p align="center">Заво-дський</p></td>
                <td width="78"><p align="center">рахунка<br>
                        та об’єкта    ана-літичного обліку (для віднесення амортиз. відрахув.)</p></td>
                <td width="48"><p align="center">норми    амортизаційних відрахувань</p></td>
                <td width="48"><p align="center">На повне    відновлення</p></td>
                <td width="48"><p align="center">На капіта-льний    ремонт</p></td>
            </tr>
            <tr>
                <td width="36"><p align="center">1</p></td>
                <td width="48"><p align="center">2</p></td>
                <td width="48"><p align="center">3</p></td>
                <td width="48"><p align="center">4</p></td>
                <td width="46" valign="top"><p align="center">5</p></td>
                <td width="51"><p align="center">6</p></td>
                <td width="57"><p align="center">7</p></td>
                <td width="47"><p align="center">8</p></td>
                <td width="57"><p align="center">9</p></td>
                <td width="78"><p align="center">10</p></td>
                <td width="48"><p align="center">11</p></td>
                <td width="48"><p align="center">12</p></td>
                <td width="48"><p align="center">13</p></td>
                <td width="42"><p align="center">14</p></td>
            </tr>
            <tr>
                <td width="36"><p align="center">060</p></td>
                <td width="48"><p align="center"><%=rs.getString("department_id")%></p></td>
                <td width="48"><p align="center">103.1</p></td>
                <td width="48"><p align="center">&nbsp;</p></td>
                <td width="46"><p align="center">151.1</p></td>
                <td width="51"><p align="center">&nbsp;</p></td>
                <td width="57"><p align="center"><%=rs.getString("commissioning_price")%></p></td>
                <td width="47"><p align="center"><%=rs.getString("inv_num_04")%></p></td>
                <td width="57"><p align="center">&nbsp;</p></td>
                <td width="78"><p align="center">&nbsp;</p></td>
                <td width="48"><p align="center">&nbsp;</p></td>
                <td width="48"><p align="center">&nbsp;</p></td>
                <td width="48"><p align="center">&nbsp;</p></td>
                <td width="42"><p align="center">&nbsp;</p></td>
            </tr>
            <tr>
                <td width="36"><p align="center">517</p></td>
                <td width="48"><p>&nbsp;</p></td>
                <td width="48"><p align="center">&nbsp;</p></td>
                <td width="48"><p>&nbsp;</p></td>
                <td width="46" valign="top"><p>&nbsp;</p></td>
                <td width="51"><p align="right">&nbsp;</p></td>
                <td width="57"><p>&nbsp;</p></td>
                <td width="47"><p>&nbsp;</p></td>
                <td width="57"><p>    </p></td>
                <td width="78"><p>&nbsp;</p></td>
                <td width="48"><p>&nbsp;</p></td>
                <td width="48"><p>&nbsp;</p></td>
                <td width="48"><p>&nbsp;</p></td>
                <td width="42"><p>&nbsp;</p></td>
            </tr>
            <tr>
                <td width="36"><p align="center">&nbsp;</p></td>
                <td width="48"><p align="center">&nbsp;</p></td>
                <td width="48"><p align="center">&nbsp;</p></td>
                <td width="48"><p align="center">&nbsp;</p></td>
                <td width="46" valign="top"><p align="center">&nbsp;</p></td>
                <td width="51"><p align="center">&nbsp;</p></td>
                <td width="57"><p align="center">&nbsp;</p></td>
                <td width="47"><p align="center">&nbsp;</p></td>
                <td width="57"><p align="center">&nbsp;</p></td>
                <td width="78"><p align="center">&nbsp;</p></td>
                <td width="48"><p align="center">&nbsp;</p></td>
                <td width="48"><p align="center">&nbsp;</p></td>
                <td width="48"><p align="center">&nbsp;</p></td>
                <td width="42"><p align="center">&nbsp;</p></td>
            </tr>
        </table>
        На підставі наказу №3, <u>            <em>АТ“Прикарпаттяобленерго”</em> </u><br />
        <em>від  ”<u>04 </u>”  <u>січня 2016р.</u>  </em><br />
        Проведений огляд <%=rs.getString("selecting_point")%> <%=rs.getString("type_join")%>, що приймається (передається) в експлуатацію від <u><%=rs.getString("type_jobs_vkb")%> підрядним  способом.</u> <br />
        В момент приймання  (передачі) об’єкт знаходиться в <%=rs.getString("object_adress")%>.
        <table cellspacing="0" cellpadding="0" class="tab">
            <tr>
                <td colspan="2"><br />
                    Устаткування </td>
                <td width="228" rowspan="2"><p align="center">Сума амортизації (зносу) за даними переоцінки на <u>__                ,</u> або за документами    придбання</p></td>
                <td width="78" rowspan="2"><p align="center">Рік випуску (побудови)</p></td>
                <td width="94" rowspan="2"><p align="center">Дата введення в експлуатацію (місяць, рік)</p></td>
                <td width="84" rowspan="2"><p align="center">Номер паспорта</p></td>
            </tr>
            <tr>
                <td width="45"><p align="center">вид</p></td>
                <td width="67"><p align="center">код</p></td>
            </tr>
            <tr>
                <td width="45" valign="top"><p align="center">15</p></td>
                <td width="67" valign="top"><p align="center">16</p></td>
                <td width="228" valign="top"><p align="center">17</p></td>
                <td width="78" valign="top"><p align="center">18</p></td>
                <td width="94" valign="top"><p align="center">19</p></td>
                <td width="84" valign="top"><p align="center">20</p></td>
            </tr>
            <tr>
                <td width="45" valign="top"><p><em>&nbsp;</em></p></td>
                <td width="67" valign="top"><p><em>&nbsp;</em></p></td>
                <td width="228" valign="top"><p>&nbsp;</p></td>
                <td width="78" valign="top"><p align="center">2014 р.</p></td>
                <td width="94" valign="top"><p align="center">____.2014 р.</p></td>
                <td width="84" valign="top"><p><em>&nbsp;</em></p></td>
            </tr>
        </table>
        <p><strong>Коротка характеристика об’єкта</strong>

           


            <% if(fields_list.isEmpty()){%>
                    <br>Технічне переоснащення ПЛ-0,4 кВ - <%=rs.getString("commissioning_price")%> грн.
                    <%}%>
            <%
            while (rs1.next()) {
                    String l_built_pl_04 = rs.getString("l_built_pl_04").replace(".", ",");
                    String l_built_kl_04 = rs.getString("l_built_kl_04").replace(".", ",");
                    String l_built_pl_10 = rs.getString("l_built_pl_10").replace(".", ",");
                    String l_build_kl_10 = rs.getString("l_build_kl_10").replace(".", ",");
                    String object_name = rs.getString("object_name");
                    String enter = rs.getString("enter").replace(".", ",");;
                    String counter_price = rs.getString("counter_price").replace(".", ",");
                    String type1f3f = rs.getString("type1f3f");
                    String counter_type = rs.getString("counter_type");
                    String counter_number = rs.getString("counter_number");
                  //  String commissioning_price = rs.getString("commissioning_price");
                    if((fields_list.contains("1033063")||fields_list.contains("1033071")) && fields_list.size()==1){%>
                    <br>Технічне переоснащення ПЛ-0,4 кВ - <%=enter%> грн.
                    <%}%>
                   
            <br />
            <%=rs1.getString("fullname").replace("l_built_pl_04", l_built_pl_04).replace("l_built_kl_04", l_built_kl_04)
                        .replace("l_build_kl_10", l_build_kl_10).replace("l_built_pl_10", l_built_pl_10)
                        .replace("object_name", object_name).replace("enter", enter).replace("counter_price", counter_price)
                        .replace("counter_type", counter_type).replace("counter_number", counter_number).replace("type1f3f", type1f3f)%>

            <%}%>
            <br>
            <br>
            <em>МВЗ – <%=rs.getString("department_id")%></em><em> </em><em>F2321   </em><br />
            <em>Група ОЗ –<%=rs.getString("ch_1033")%> <%=rs.getString("ch_1044")%></em><br />
            <% rs1.beforeFirst();%>
            <% rs1.next();%>
            <em>Поле класифікації – <%=rs1.getString("name")%>
                <% while (rs1.next()) {%>
                <div id="field" style="text-indent: 140px"><%=rs1.getString("name")%></em></div>
                <%}%>
        Термін експлуатації – 30  р.<br/> 
        Термін експлуатації – 6 р.<br/>
        <br clear=all style="page-break-before:always">

        Об'єкт технічним  умовам відповідає (не відповідає)        <span class="line"><u>_______________відповідає__________</u></span>
        <span class="line"><center><sup>вказати, що  саме не відповідає</sup></center></span>
        Доробка не потрібна  (потрібна)
        <u>_______________не потрібна__________________________</u><br>
        <span class="line"><center><sup>вказати,що  саме потрібно</sup></center></span><br>
        Підсумки іспитів об'єкта  <u>___________відповідає нормам ПВЕ__________________________</u>
    <p>______________________________________________________________________________<br>
        Висновок  комісії: перевести на основні засоби (<%=rs.getString("type_join")%>).<br />
        _____________________________________________________________________________<br>
        _____________________________________________________________________________ <br>
        Додаток.  Перелік технічної документації  _____________________________________________________________________________<br>
        _____________________________________________________________________________</p>
    <table class="rekv" border="0" cellspacing="0" cellpadding="0" align="left" width="675" style="font-size:12px">
        <tr>
            <td width="107" valign="top">
                <strong>Голова комісії</strong></td>
            <td width="231" valign="top"><p align="center"><em>Заступник технічного<br/> 
                        <u> _____директора з РМ _</u></em><u>___</u></p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td width="128" valign="bottom"><div align="center">_____________</div></td>
            <td width="11" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="bottom" align="center"><u>___<em>В.М.Бондаренко</em>___</u></td>
        </tr>
        <tr>
            <td valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(посада) </p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(підпис) </p></td>
            <td width="11" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(ПІБ) </p></td>
        </tr>
        <tr>
            <td valign="top"><strong>Члени комісії</strong></td>
            <td valign="top"><p align="center"><u> __<em>Фінансовий  директор</em></u>__</p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="bottom"><div align="center">_____________                </div></td>
            <td width="11" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="bottom"><div align="center"><u>_____<em>С.О.Єфімов</em>_____</u></div></td>
        </tr>
        <tr>
            <td valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(посада) </p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(підпис) </p></td>
            <td width="11" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(ПІБ) </p></td>
        </tr>
        <tr>
            <td valign="top"><p>&nbsp;</p></td>
            <td valign="top"><p align="center"><u> ____<em>Начальник ВТС</em></u><em>_</em>____</p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="bottom"><div align="center">_____________                </div></td>
            <td width="11" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="bottom"><div align="center"><u>___<em>__С.В.Фелик_</em>_____</u></div></td>
        </tr>
        <tr>
            <td valign="top"><p>&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(посада) </p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(підпис) </p></td>
            <td width="11" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(ПІБ) </p></td>
        </tr>
        <tr>
            <td valign="top"><p>&nbsp;</p></td>
            <td valign="bottom"><p align="center"><em>Ст. бухгалтер групи<br/>
                        <u>_обліку основних засобів_</u></em></p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="bottom"><p align="center">_____________</p>
            </td>
            <td width="11" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="bottom"><div align="center"><u>_____<em>О.П. Зіняк</em>____</u></div>
        </tr>
        <tr>
            <td valign="top"><p>&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(посада) </p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(підпис) </p></td>
            <td width="11" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(ПІБ)&nbsp;&nbsp; </p></td>
        </tr>
        <tr>
            <td width="107" valign="top"><p>&nbsp;</p></td>
            <td width="231" valign="bottom"><p align="center"><em>Директор філії<br/>
                        <u>&quot;<%=rs.getString("rem_name")%>_РЕМ"</u></em><u></u></p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td width="127" valign="bottom"><p align="center">_____________</p></td>
            <td width="12" valign="top"><p align="center">&nbsp;</p></td>
            <td width="180" valign="bottom"><p align="center"><u>__<em><%=rs.getString("d_name")%></em>__</u> </p>
        </tr>
        <tr>
            <td valign="top"><p>&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(посада) </p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(підпис) </p></td>
            <td width="12" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(ПІБ)&nbsp;&nbsp; </p></td>
        </tr>
    </table>

    <p>&nbsp;</p>
    <p>Об'єкт основних засобів</p>
    <table border="0" cellspacing="0" cellpadding="0" align="left" width="640" class="rekv">
        <tr>
            <td width="108" valign="top"><p align="right"><strong>Прийняв</strong></p>
            </td>
            <td width="203" valign="top"><p align="center"><u>____<em>Майстер ВДЕМ-1</em>___</u></p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td width="137" valign="top"><div align="center">_____________                </div></td>
            <td width="10" valign="top"><p align="center">&nbsp;</p></td>
            <td width="164" valign="top"><u>____________________</u></td>
        </tr>
        <tr>
            <td valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(посада) </p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(підпис) </p></td>
            <td width="10" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(ПІБ) </p></td>
        </tr>
        <tr>
            <td valign="top"><p align="right"><strong>                </strong></p></td>
            <td valign="top"><p align="center"><u>______<em>Майстер ВП</em>______</u></p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><div align="center">_____________                </div></td>
            <td width="10" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><u>____________________</u></td>
        </tr>
        <tr>
            <td valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(посада) </p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(підпис) </p></td>
            <td width="10" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(ПІБ) </p></td>
        </tr>
        <tr>
            <td valign="top"><p align="right"><strong>Здав</strong></p></td>
            <td valign="top"><p align="center"><u> ____<em>Начальник ВКБ</em></u>_____</p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="bottom"><div align="center">_____________                </div></td>
            <td width="10" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="bottom"><u>____<em>О.М.Мандзюк_</em>___</u></td>
        </tr>
        <tr>
            <td valign="top"><p>&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(посада) </p></td>
            <td width="18" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(підпис) </p></td>
            <td width="10" valign="top"><p align="center">&nbsp;</p></td>
            <td valign="top"><p align="center" style="font-size: 11px;">(ПІБ) </p></td>
        </tr>
    </table>
    <p> </p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>              Відмітка бухгалтерії про відкриття картки або переміщення об'єкта <br>
        &quot;___&quot; _______________ 2015  р.<br>
        Головний (старший)  бухгалтер_____________</p>
    <p>&nbsp;</p>
</body>
<%} catch (SQLException e) {
        e.printStackTrace();
    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    }
%>
</html>
