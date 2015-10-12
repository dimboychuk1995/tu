function customeracces(id_rem,is_wr){
    if((id_rem==0)||(is_wr!=''))
    {
        $('.customer').attr('disabled','true');
    }
}
function main_cont(){
    if($("#type_contract_sel").val()=='1'){
        $("#main_contract_div").hide();
    }else  $("#main_contract_div").show();
}
function cust_soc_stat(){
    if($("#customer_type_hid").val()=='0'){
        $("#customer_type_div").html("Побутовий");
        $("#customer_type_hid").val("0");
        $("#juridical_div").hide();
    }else {
        $("#customer_type_div").html("Юридичний");
        $("#customer_type_hid").val("1");
        $("#juridical_div").show();
    }
}
function cust_soc_stat_ch(){
    if($("#1_1").val() == '1'){
        $("#customer_type_div").html("Побутовий");
        $("#customer_type_hid").val("0");
        $("#juridical_div").hide();
    }else {
        $("#customer_type_div").html("Юридичний");
        $("#customer_type_hid").val("1");
        $("#juridical_div").show();
    }
}

