<%-- 
    Document   : AccountConnection
    Created on : 26 січ 2010, 16:33:44
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
<script type="text/javascript" src="../../codebase/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../../codebase/tiny_mce/jquery.tinymce.js"></script>
<script type="text/javascript">
	$().ready(function() {
		$('textarea.tinymce').tinymce({
			// Location of TinyMCE script
			script_url : '../../codebase/tiny_mce/tiny_mce.js',

			// General options
			theme : "advanced",
			plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist",

			// Theme options
			theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
			theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
			theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
			theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",
			theme_advanced_toolbar_location : "top",
			theme_advanced_toolbar_align : "left",
			theme_advanced_statusbar_location : "bottom",
			theme_advanced_resizing : true,

			// Example content CSS (should be your site CSS)
			content_css : "css/content.css",

			// Drop lists for link/image/media/template dialogs
			template_external_list_url : "lists/template_list.js",
			external_link_list_url : "lists/link_list.js",
			external_image_list_url : "lists/image_list.js",
			media_external_list_url : "lists/media_list.js",

			// Replace values for the template plugin
			template_replace_values : {
				username : "Some User",
				staffid : "991234"
			}
		});
	});
</script>
</head>
<body>

<div>
        <textarea id="elm1" name="elm1" rows="15" cols="80" style="width: 80%" class="tinymce">
              <p align="center"><strong>Договір № 2808-1906 </strong>(30/2010)<strong> </strong><br>
                <strong>про надання доступу до  електричних мереж </strong></p>
                       <table width="80%" border="0" align="center">
                         <tr>
                           <td width="70%">м. Івано-Франківськ </td>
                      <td>“___” ___________ 2010 р.</td>
                    </tr>
                       </table>
                <p align="justify"><strong>Відкрите акціонерне товариство «Прикарпаттяобленерго»</strong>, надалі ― <strong>Електропередавальна організація (далі – ЕО)</strong>, що здійснює  ліцензовану діяльність з передачі електроенергії, в особі технічного директора  ВАТ «Прикарпаттяобленерго» Сеника Олега  Степановича, який діє на підставі довіреності № 14 від 10.05.2017 року, з  однієї сторони, та <strong>Товариство з обмеженою  відповідальністю «ТТК»</strong>, в особі директора Костецького Віктора Богдановича,  який діє на підставі Статуту від 20.04.2006 року, з іншої сторони, далі ― Сторони,  уклали цей Договір про надання доступу електроустановок Замовника до  електричних мереж ЕО (надалі ― Договір).<br>
                При виконанні умов цього Договору, а також  вирішенні всіх питань, що не обумовлені цим Договором, сторони зобов'язуються  керуватися Законом України “Про електроенергетику”, Законом України &quot;Про  архітектурну діяльність&quot;, Законом України “Про основи містобудування”, постановами  Кабінету Міністрів України “Про Порядок надання архітектурно-планувального  завдання та технічних умов щодо інженерного забезпечення об'єкта архітектури і  визначення розміру плати за їх видачу” № 2328 від 20.12.1999 р., “Про порядок  прийняття в експлуатацію закінчених будівництвом об’єктів” № 923 від 08.10.2008  р. та іншими нормативно-правовими актами. <br>
                Підписавши цей Договір, Сторони підтверджують,  що відповідно до законодавства та установчих документів, мають право укладати  цей Договір, його укладання відповідає справжнім намірам сторін, які  ґрунтуються на правильному розумінні предмету та всіх інших умов договору,  наслідків його виконання та свідомо бажають настання цих наслідків.
                <p align="center"><strong>1 Предмет Договору</strong></p>
                <p align="justify">  1.1 ЕО здійснює надання послуги з доступу електроустановок <u>(нежитлове  приміщення в м. Івано-Франківськ, вул. Франка, 25 А)</u> Замовника до своїх  електричних мереж після виконання Замовником технічних умов, своїх зобов’язань  по даному договору, укладення Замовником договору про постачання електричної  енергії та інших договорів передбачених Правилами користування електричною  енергією.<u></u><br>
                  1.2 З метою  тимчасового електрозабезпечення будівельних струмоприймачів та потреб Замовника  на об’єкті, між Замовником та ЕО мереж укладається договір про постачання  електричної енергії для електрозабезпечення будівельних струмоприймачів у  встановленому законодавством України порядку і діє до завершення терміну дії  даного Договору.<br>
                  1.3  Прогнозована межа балансової належності електромереж встановлюється: <u>в ВРП-0,4 кВ будинку  № 25 А по вул. Франка від ТП 10/0,4 кВ № 3.</u> <br>
                  1.4 Клас  напруги в точці підключення буде становити 0,4 кВ, 2&nbsp;клас.</p>
                <p align="center"><strong>2 Обов'язки сторін</strong></p>
                <p align="justify">  2.1 ЕО зобов'язаний підключити електроустановки Замовника до своїх  електромереж в термін до 5 днів після виконання Замовником вимог пункту 2.2  цього Договору в повному обсязі, прийняття електроустановки Замовника в  експлуатацію, оформлення акту допуску на підключення електроустановки  Замовника.<br>
                  2.2 Замовник, до завершення терміну дії даного Договору, зобов'язаний:
                Виконати в повному обсязі вимоги технічних  умов №<strong> </strong><strong>2808-1906</strong><strong> </strong>(30/2010) від «___» __________2010 року (Додаток № 1).
                Передати у власність ЕО електричні мережі побудовані  (реконструйовані) згідно технічних умов (Додаток 1) до прогнозованої межі балансової  належності у відповідності до вимог чинного законодавства.
                До підключення електроустановки Замовника до  електричної мережі ЕО оплатити вартість допуску та підключення згідно  виставленого рахунку та укласти договори, передбачені Правилами користування  електричною енергією.
                Укласти за згодою сторін договір підряду на  виконання робіт у мережах ЕО. </p>
                <p align="center"><strong>3  Відповідальність сторін</strong></p>
                <p align="justify">  3.1 ЕО несе відповідальність за зміст, обґрунтованість  виданих технічних умов. <br>
                  3.2 Замовник несе відповідальність за достовірність  наданих ЕО документів, належне виконання вимог даного Договору та технічних  умов (Додаток 1), розроблення проектної документації, її узгодження з ЕО та  іншими зацікавленими особами. <br>
                  3.3 Сторони не відповідають за невиконання  умов цього Договору, якщо це спричинено дією обставин непереборної сили. Факт  дії обставин непереборної сили підтверджується відповідними документами. </p>
                <p align="center"><strong>4  Порядок вирішення спорів </strong></p>
                <p align="justify">  4.1 Усі спірні питання, пов'язані з виконанням  цього Договору, вирішуються шляхом переговорів між сторонами. <br>
                4.2 У разі недосягнення згоди спір вирішується  в судовому порядку відповідно до законодавства України. Спори, що виникають при  укладенні, зміні та (або) розірванні Договору, справи у спорах про визнання  договору недійсним або пов’язаних з виконанням даного договору, розглядаються в  судах за місцем знаходження ЕО.</p>
                <p align="center"><strong>5  Строк дії Договору </strong></p>
                <p align="justify">  5.1 Цей Договір набирає чинності з моменту  його підписання і діє протягом двох років з дати підписання.<br>
                  5.2 Сторони мають право достроково виконати  покладені на них зобов’язання по Договору. У разі дострокового виконання  зобов’язань сторін згідно умов Договору може мати місце дострокове припинення  Договору за згодою сторін або на підставах, передбачених чинним в Україні  законодавством. <br>
                  5.3 Договір може бути змінено або розірвано в  односторонньому порядку на вимогу ЕО у разі порушення Замовником вимог п. п.  2.2.1, 2.2.3 та 2.3 даного Договору, про що Замовника повідомляється окремим  письмовим повідомленням. Дане повідомлення вважається невід’ємною частиною  Договору. Замовник має право на протязі 20 днів з дня отримання повідомлення  виконати зобов’язання по договору та повідомити про це ЕО.<br>
                  5.4 У разі розірвання Договору згідно п. 5.3,  а також в інших випадках дострокового розірвання договору, оплачені Замовником кошти  за видачу технічних умов та погодження проектної документації, ЕО не  повертаються.<br>
                  5.5 Термін дії Договору може бути продовжений  за згодою сторін.</p>
                <p align="center"><strong>6  Інші умови Договору </strong></p>
                <p align="justify">
                6.1 Після одержання проекту Договору Замовник у  20-ти денний термін повертає ЕО підписаний примірник Договору. У разі наявності  заперечень до умов Договору Замовник у цей же термін надсилає протокол  розбіжностей чи повідомляє ЕО про відмову від укладення Договору.<br/>6.2 У разі недотримання порядку, зазначеного в п. 6.1  цього Договору, Договір вважається неукладеним (таким, що не відбувся).
                <br/>6.3 Додатки до цього Договору є невід’ємними  частинами цього Договору. Усі зміни та доповнення до Договору оформляються  письмово, підписуються уповноваженими особами та скріплюються печатками з обох  сторін, крім повідомлення передбаченого п. 5.3 та п. 6.5 даного Договору.
                <br/>6.4 Цей Договір укладений у двох примірниках, які  мають однакову юридичну силу для Замовника та ЕО.<br/>
                6.5 У разі, якщо на час дії даного Договору  відбулися зміни в чинному законодавстві України, ЕО в односторонньому порядку  вносяться зміни, які доводяться до Замовника окремим письмовим повідомленням.  Дане повідомлення вважається невід’ємною частиною Договору.<br/>
                6.6 Відшкодування витрат понесених Замовника на  будівництво електромереж, які передані ЕО у власність згідно п. 2.2.2 цього  Договору, відбувається у розмірі та у порядку встановлених Кабінетом Міністрів  України.<br/>
                6.7 Замовник має, немає (необхідне підкреслити)  статус платника податку на прибуток підприємств на загальних умовах.<br/>
                6.8 ЕО має статус платника податку на прибуток  підприємств на загальних умовах.</p>
                <p align="center"><strong>7  Місцезнаходження сторін</strong></p>
                <table border="1" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="384" valign="top"><p align="left"><strong>Електропередавальна організація:</strong></p></td>
                    <td width="287" valign="top"><p>Замовник</p></td>
                  </tr>
                  <tr>
                    <td width="384" valign="top"><p><strong>ВАТ «Прикарпаттяобленерго»</strong><strong> </strong><br>
                      м. Івано-Франківськ, вул. Індустріальна, 34<br>
                      Код ЄДРПОУ 00131564<br>
                      п/р 26000011732450 в Івано-Франківське відділення №340 ПАТ «Укрсоцбанк»<br>
                      Код МФО 300023<br>
                      <strong>Технічний директор </strong><br>
                  <strong>ВАТ «Прикарпаттяобленерго»</strong></p>
                    ______________________________<strong>О.  С. Сеник</strong></td>
                    <td width="287" valign="top"><p><strong>ТзОВ «ТТК»</strong></p>
                      <p>76006 м. Івано-Франківськ, вул. Симоненка, 1<br>
                        р/р  _____________________________ МФО ___________<br>
                        _________________________________________________<br>
                        Код ЄДРПОУ 20530616<br>
                  <strong>Директор</strong></p>
                      <strong>_____________________________В.  Б. Костецький</strong></td>
                  </tr>
                </table>
                <p align="justify">&nbsp;</p>
                <p align="justify">&nbsp;</p>
        </textarea>
</div>
</body>
</html>
