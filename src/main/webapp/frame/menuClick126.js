function httpGet(theUrl)
{
    var xmlHttp = null;

    xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", theUrl, false );
    xmlHttp.send( null );
    return xmlHttp.responseText;
};
function menuClick(id) {
    switch (id)
    {
        case "open":
            location.replace('grid.jsp');
            break
        case "new_f":
            window.open('inscustomer.jsp', '_parent', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');
            break
        case "chengestu":
            window.open('changestu/changestuxp.jsp?tu_id=-1', '_blank', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=500');
            break
        case "reminder":
            location.replace('main.jsp');
            // window.open('remindernew.jsp', '_parent', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');
            break
        case "search":
            location.replace('search.jsp');
            break
        case "chengespas":
            location.replace('pass.jsp');
            break
        case "rep0":
            window.open('xls.jsp');
            break
        case "rep3":
            $('#dialog').dialog('open');
            // window.open('xls_all.jsp');
            //   window.open('xlstest.jsp');

            break
        case "rep31":
            $('#dialog_nastya').dialog('open');
            break
        case "rep32":
            $('#dialog_list_deals').dialog('open');
            break
        case "rep4":
            window.open('xls_vkb.jsp');
            break
        case "rep41":
            window.open('xls_vkb_ns.jsp');
            break
        case "rep42":
            window.open('xls_vkb_from14.jsp');
            break
        case "rep5":
            window.open('diff_days.jsp');
            break
        case "rep9":
            window.open('blank/no_payment.jsp');
            break
        case "rep6":
            window.open('xls_info.jsp');
            break
        case "rep7":
            window.open('xls_info_ns.jsp');
            break
        case "rep8":
            window.open('xls_info_ns_1.jsp');
            break
        case "rep1":
            location.replace('report.jsp?rep=2');
            break
        case "about":
            window.open('help/about.html', '_blank', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=500, resize=no, Height=350');
            break
        case "needhelp":
            window.open('hvvid.jsp', '_blank', 'Toolbar=0, Scrollbars=1, Resizable=0, Width=900, resize=no, Height=850');
            break
        case "close":
            location.replace('login.do?method=exit');
            break
        case "dic1":
            location.replace('dictionaries.do?dic=functionality&method=empty');
            break
        case "dic2":
            location.replace('dictionaries.do?dic=locality&method=empty');
            break
        case "dic3":
            location.replace('dictionaries.do?dic=type_contract&method=empty');
            break
        case "dic4":
            location.replace('dictionaries.do?dic=reason_tc&method=empty');
            break
        case "dic5":
            location.replace('dictionaries.do?dic=term_tc&method=empty');
            break
        case "dic6":
            location.replace('dictionaries.do?dic=CUSTOMER_SOC_STATUS&method=empty');
            break
        case "dic7":
            location.replace('dictionaries.do?dic=PERFORMER&method=empty');
            break
        case "dic8":
            location.replace('dic_rem.jsp');
            break
        case "dic9":
            location.replace('dictionaries.do?dic=EXECUTOR_VKB&method=empty');
            break
        case "dic10":
            location.replace('dictionaries.do?dic=EXECUTOR_VKB_BUILD&method=empty');
            break
        case "dic11":
            location.replace('dic_ps.jsp');
            break
    }
    return true;
}

