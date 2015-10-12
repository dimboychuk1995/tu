function jqgrid_constructor(url){
    var height = $(window).height() - 178;
    $('#le_table').jqGrid({
                  url:url,
                  datatype: 'json',
                  mtype: 'GET',
                  colNames:['Редагувати','Дата подання заяви','Соц. статус','Юрид. назва замовника','Прізвище',
                            'Імя','Споживач','Номер договору (ТУ)','Тип договору','Тип приєднання','Вихідна дата реєстрації ТУ у РЕМ',
                            'Сума за Ту','Вартість приєдання, грн','Дата оплати за приєднання','Розробник Договору (ТУ)','Стан договору (ТУ)','Назва','Адреса',
                            'Заявлена потужність','Категорія надійності електропостачання','Точка забезпечення потужності','Термін надання послуги з приєднання, днів','Назва підстанції','№ існуючого ТП та проектного після допуску',
                            'назва приєднання','Дата підключення','Організація - розробник ПКД','Вартість розробки ПКД',
                            'Дата оплати за розробку ПКД','Дата передачі акту прийому-здачі гол.інженеру','Дата погодження гол.інж. акту прийому-здачі','Дата завершення БМР','Дата подання напруги'],
                  colModel :[
                    {name:'id', index:'id', width:80,searchoptions:{sopt:['eq','ne','bw','cn']}},
                    {name:'registration_date', index:'registration_date',formatter: 'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'d.m.Y'}, width:180,searchoptions:{sopt:['eq','ne','bw','cn']}},
                    {name:'customer_soc_status', index:'customer_soc_status', width:190,searchoptions:{sopt:['eq','ne','bw','cn']}},
                    {name:'juridical', index:'juridical', width:160,searchoptions:{sopt:['eq','ne','bw','cn']}},
                    {name:'f_name', index:'f_name', width:160},
                    {name:'s_name', index:'s_name', width:130},
                    {name:'customer_type', index:'customer_type', width:180, formatter:'select', editoptions:{value:':Все; 0:Побутовий; 1:Юридичний;'}},
                    {name:'number', index:'number', width:180},
                    {name:'type_contract', index:'type_contract', width:180, formatter:'select', editoptions:{value:':Все; 1:Основний; 2:Будмайданчик;'}},
                    {name:'type_join', index:'type_join', width:180, formatter:'select', editoptions:{value:':; 1:стандартне; 2:нестандартне;'}},
                    {name:'initial_registration_date_rem_tu', index:'initial_registration_date_rem_tu', width:180,formatter: 'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'d.m.Y'}},
                    {name:'connection_price', index:'connection_price', width:180, formatter:'currency',formatoptions:{prefix: '', suffix:' грн.'}},
                    {name:'price_join', index:'price_join', width:180, formatter:'currency',formatoptions:{prefix: '', suffix:' грн.'}},
                    {name:'date_pay_join', index:'date_pay_join', width:180,formatter: 'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'d.m.Y'}},
                    {name:'executor_company', index:'executor_company', width:180, formatter:'select', editoptions:{value:':PEM; 1:ВТП; 0:PEM;'}},
                    {name:'state_contract', index:'state_contract', width:180, hidden: true},
                    {name:'object_name', index:'object_name', width:180, hidden: true},
                    {name:'object_adress', index:'object_adress', width:180, hidden: true},
                    {name:'request_power', index:'request_power', width:180, hidden: true},
                    {name:'reliabylity_class', index:'reliabylity_class', width:180, hidden: true},
                    {name:'point_zab_power', index:'point_zab_power', width:180,hidden: true},
                    {name:'term_for_joining', index:'term_for_joining', width:180},
                    {name:'ps_35_disp_name', index:'ps_35_disp_name', width:180, hidden: true},
                    {name:'ps_10_disp_name', index:'ps_10_disp_name', width:180, hidden: true},
                    {name:'fid_10_disp_name', index:'date_connect_consumers', width:180, hidden: true},
                    {name:'date_connect_consumers', index:'date_connect_consumers', width:180, hidden: true,formatter: 'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'d.m.Y'},hidden: true},
                    {name:'develloper_company', index:'develloper_company', width:180, hidden: true},
                    {name:'devellopment_price', index:'devellopment_price', width:180, hidden: true},
                    {name:'pay_date_devellopment', index:'pay_date_devellopment', width:180, formatter: 'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'d.m.Y'},hidden: true},
                    {name:'date_giving_akt', index:'date_giving_akt', width:180, formatter: 'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'d.m.Y'},hidden: true},
                    {name:'date_admission_akt', index:'date_admission_akt', width:180, formatter: 'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'d.m.Y'},hidden: true},
                    {name:'date_start_bmr', index:'date_start_bmr', width:180, formatter: 'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'d.m.Y'},hidden: true},
                    {name:'date_filling_voltage', index:'date_filling_voltage', width:180, formatter: 'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'d.m.Y'},hidden: true}],
                  pager: $('#le_tablePager'),
                  rowNum:100,
                  rowList:[100,200,500],
                  sortname: 'id',
                  sortorder: 'desc',
                  viewrecords: true,
                  height: height,
                  width: 1000,
                  afterInsertRow: function(row_id, row_data){
	                                if (row_data.initial_registration_date_rem_tu == '01.01.1900') {
	                                    row_data.initial_registration_date_rem_tu = '';
	                                }
                                        if (row_data.customer_soc_status == 'ПП') {
	                                    $('#le_table').jqGrid('setCell',row_id,'customer_soc_status','',{'color':'#FF00FF'});
	                                }else if(row_data.customer_soc_status == 'Громадянин'){
	                                    $('#le_table').jqGrid('setCell',row_id,'customer_soc_status','',{'color':'red'});
	                                }else{
	                                    $('#le_table').jqGrid('setCell',row_id,'customer_soc_status','',{'background-color': '#999999'});
	                                }

                                        if (row_data.customer_type == '0') {
	                                    $('#le_table').jqGrid('setCell',row_id,'customer_type','',{'color':'#FF00FF'});
	                                }else {
	                                    $('#le_table').jqGrid('setCell',row_id,'customer_type','',{'color':'red'});
	                                }
                                        if (row_data.executor_company == '0') {
	                                    $('#le_table').jqGrid('setCell',row_id,'executor_company','',{'color':'#FF00FF'});
	                                }else {
	                                    $('#le_table').jqGrid('setCell',row_id,'executor_company','',{'color':'red'});
	                                }
	                            }
                });
                $("input").css("height","20px");
                $("#le_table").jqGrid('navGrid','#le_tablePager',{view:false, del:false, add:false, edit:false},
                                            {}, // default settings for edit
                                            {}, // default settings for add
                                            {}, // delete instead that del:false we need this
                                            {closeOnEscape:true, multipleSearch:true, closeAfterSearch:true}, // search options
                                            {} );
                $('#le_table').jqGrid('navSeparatorAdd','#le_tablePager');
                $('#le_table').jqGrid('navButtonAdd','#le_tablePager',{
                    caption: 'Налаштувати колонки',
                    title: 'Показати або приховати колонки в таблиці',
                    buttonicon: 'ui-icon-wrench',
                    onClickButton: function(){ $('#le_table').jqGrid('setColumns',{colnameview:false,updateAfterCheck: true });},
                    position:'last'
                });
    }

