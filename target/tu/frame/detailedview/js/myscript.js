function permision(){
 if ($.cookie("permisions")=="-1") {
    $(":input:not(input[type=button],input[type=hidden],.admAndCon),select:not(.admAndCon),textarea").attr('disabled','disabled');
    $("a.del,a#new,a#edit").click( function(){
        return false;
    });
 };
}

