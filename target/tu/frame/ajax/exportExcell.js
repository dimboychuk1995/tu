$(document).ready(function(){
    $('#excelExport').click(function () {
        var year = $('#selectYear').val();
        var customer = $('#CHcustomer').attr("checked");
        var dataobjects = $('#CHdataobjects').attr("checked");
        var dataobjects2 = $('#CHdataobjects2').attr("checked");
        var tund = $('#CHtund').attr("checked");
        var admision = $('#CHadmision').attr("checked");
        var supplychain = $('#CHsupplychain').attr("checked");
        var pricejoin = $('#CHpricejoin').attr("checked");
        var vkb = $('#CHvkb').attr("checked");
        var change = $('#CHchange').attr("checked");
        var admision2 = $('#CHadmision2').attr("checked");
         var pricejoin_ns = $('#CHpricejoin_ns').attr("checked");
        var str = 'xls_all.jsp?selectYear='+year+'&customer='+customer+'&dataobjects='+dataobjects+
                  '&dataobjects2='+dataobjects2+'&tund='+tund+'&admision='+admision+'&supplychain='+supplychain+
                  '&pricejoin='+pricejoin+'&vkb='+vkb+'&change='+change+'&admision2='+admision2+'&pricejoin_ns='+pricejoin_ns;
              //alert(str);
        window.open(str);
    });
    $('#excelExport2').click(function () {
        var year = $('#selectYear2').val();
        var str = 'xls_nastya.jsp?selectYear='+year;
              //alert(str);
        window.open(str);
    });
    $('#list_deals').click(function () {
        var fromDate = $('input[name=FromDate]').val();
        var tillDate = $('input[name=TillDate]').val();
        var str = 'blank/xls_list_deals.jsp?fromDate='+fromDate+'&tillDate='+tillDate;
              //alert(str);
        window.open(str);
    });
    
});

