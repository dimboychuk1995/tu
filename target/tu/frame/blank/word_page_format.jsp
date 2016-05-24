<%-- 
    Document   : word_page_format
    Created on : 25 лип 2011, 9:15:28
    Author     : AsuSV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style type="text/css">
    <!--
    body,td,th {
        font-size: 100%;
    }
    .style1 {
        font-size: 10pt;
        font-weight: bold;
    }
    .shablon {
        font-size: 12pt;
        font-weight: bold;
    }
    @page Section1
    {
        margin:1.0cm 1.0cm 1.0cm 2.0cm;
    }
    div.Section1
    {page:Section1;}
    -->
    <xml>
    <w:WordDocument>
    <w:View>Print</w:View>
    <w:GrammarState>Clean</w:GrammarState>
    <w:HyphenationZone>21</w:HyphenationZone>
    <w:ValidateAgainstSchemas/>
    <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
    <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
    <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
    <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
    </w:WordDocument>
    </xml>
</style>