$(document).ready(function(){
     if ($.cookie("permisions")=="0"){
        $('.hide').hide();
        
    } else if($.cookie("permisions")=="-1"){
            $('input[type=button]').hide();
            $('.hide').hide();
            
        };
    $( "#dialog" ).dialog({ 
        autoOpen: false,
        resizable: false,
        width:'300px',
        buttons: {
                
            Завантажити: function() {
                $("#dialog").parent().appendTo($("form:first"));  
                $('form').submit();
                $(this).dialog('close');
            },
            Закрити: function() {
                $(this).dialog('close');
            }
        }
    });
    $( "#confirm" ).dialog({ 
        autoOpen: false,
        resizable: false,
        width:'300px',
        buttons: {
                
            Так: function() {
                $( "#dialog" ).dialog("open"); 
                $(this).dialog('close');
            },
            Ні: function() {
                $('form').submit();
            }
        }
    });
   
});


