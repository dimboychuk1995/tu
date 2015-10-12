function rem(id_rem){
    if((id_rem==0))
    {
        $('.rem').attr('disabled','true');
    }
}
function date_vud_zam(is_wr){
    if(is_wr!='')
    {
        $('.date_vud_zam').attr('disabled','true');
    }
}
function admissionacces(id_rem,is_wr){
    if((id_rem==0))
    {
        $('.admission').attr('disabled','true');
    }
}
function customeracces(id_rem,is_wr){
    if((id_rem==0)||(is_wr!=''))
    {
        $('.customer').attr('disabled','true');
    }
}
function main_cont(){
    if($("#type_contract_sel").attr("value")=='1'){
        $("#main_contract_div").hide();
    }else  $("#main_contract_div").show();
}
function cust_soc_stat(){
    if($("#customer_type_hid").attr("value")=='0'){
        $("#customer_type_div").html("Побутовий");
        $("#customer_type_hid").attr("value","0");
        $("#juridical_div").hide();
    }else {
        $("#customer_type_div").html("Юридичний");
        $("#customer_type_hid").attr("value","1");
        $("#juridical_div").show();
    }
}
function cust_soc_stat_ch(){
    alert($("#1_1").attr("value"));
    if($("#1_1").attr("value")=='1'){
        $("#customer_type_div").html("Побутовий");
        $("#customer_type_hid").attr("value","0");
        $("#juridical_div").hide();
    }else {
        $("#customer_type_div").html("Юридичний");
        $("#customer_type_hid").attr("value","1");
        $("#juridical_div").show();
    }
}
function dataobjectsacces(id_rem,is_wr){
    if((id_rem==0)||(is_wr!=''))
    {
        $('.dataobjects').attr('disabled','true');
    }
}
function designacces(id_rem,is_wr){
    if((id_rem==0)||(is_wr!=''))
    {
        $('.design').attr('disabled','true');
    }
}
function suplychainacces(id_rem,is_wr){
    if((id_rem==0))
    {
        $('.suplychain').attr('disabled','true');
    }
}
function tundacces(id_rem,is_wr){
    if((id_rem==0))
    {
        $('.tund').attr('disabled','true');
    }
}

