function checkForm(form) {
// Заранее объявим необходимые переменные
var el, // Сам элемент
elName, // Имя элемента формы
value, // Значение
type; // Атрибут type для input-ов
// Массив списка ошибок, по дефолту пустой
var errorList = [];
// Хэш с текстом ошибок (ключ - ID ошибки)
var errorText = {
1 : "Не заповнено поле 'Дата звернення '",
2 : "Не заповнено поле '№ звернення '",
3 : "Не заповнено поле 'Прізвище І.П.'",
4 : "Не заповнено поле 'Установчий документ'",
5 : "Не заповнено поле 'Розрахунковий рахунок'",
6 : "Не заповнено поле 'МФО, Банк'",
7 : "Не заповнено поле 'Ідентифікаційний номер'",
8 : "Не заповнено поле 'Адреса'",
9 : "Не заповнено поле 'Соц. статус'",
10: "Не заповнено поле 'Hаселений пункт'",
11: "Не заповнено поле 'Підстава видачі ТУ'",
12: "Не заповнено поле 'Назва'",
13: "Не заповнено поле 'Функціональне призначення'",
14: "Не заповнено поле 'населеного пункту'",
15: "Не заповнено поле 'Адреса'",
16: "Не заповнено поле 'Сума за ТУ'",
17: "Не заповнено поле 'Дата оплати'",
18: "Не заповнено поле 'Прогнозована межа балансової належності'",
19: "Не заповнено поле ''",
20: "Не заповнено поле ''"
}
// Получаем семейство всех элементов формы
// Проходимся по ним в цикле
for (var i = 0; i < form.elements.length; i++) {
    el = form.elements[i];
    elName = el.nodeName.toLowerCase();
    value = el.value;
    if (elName == "input") { // INPUT
        // Определяем тип input-а
        type = el.type.toLowerCase();
        // Разбираем все инпуты по типам и обрабатываем содержимое
        switch (type) {
            case "text" :
                if (el.name == "registration_date" && value == "") errorList.push(1);
                if (el.name == "no_zvern" && value == "") errorList.push(2);
                if (el.name == "customer_name" && value == "") errorList.push(3);
                if (el.name == "constitutive_documents" && value == "") errorList.push(4);
                //if (el.name == "bank_account" && value == "") errorList.push(5);
                //if (el.name == "bank_mfo" && value == "") errorList.push(6);
                if (el.name == "bank_identification_number" && value == "") errorList.push(7);
                if (el.name == "customer_adress" && value == "") errorList.push(8);
                if (el.name == "object_name" && value == "") errorList.push(12);
                if (el.name == "object_adress" && value == "") errorList.push(15);
                if (el.name == "connection_price" && value == "") errorList.push(16);
                if (el.name == "tc_pay_date" && value == "") errorList.push(17);
            break;
            case "checkbox" :
            // Ничего не делаем, хотя можем
            break;
            case "radio" :
            // Ничего не делаем, хотя можем
            break;
            default :
            // Сюда попадают input-ы, которые не требуют обработки
            // type = hidden, submit, button, image
            break;
        }
    }// else if (elName == "textarea") { // TEXTAREA
     //   if (value == "") errorList.push(4);
    //}
    else if (elName == "select") { // SELECT
        //if (el.name == "customer_soc_status" && value == "0") errorList.push(9);
        if (el.name == "customer_locality" && value == "0") errorList.push(10);
        if (el.name == "reason_tc" && value == "0") errorList.push(11);
        if (el.name == "functionality" && value == "0") errorList.push(13);
        if (el.name == "name_locality" && value == "0") errorList.push(14);
        if (el.name == "connection_treaty_number" && value == "0") errorList.push(18);
        if (el.name == "point_zab_pover" && value == "0") errorList.push(18);
        //if (el.name == "customer_adress" && value == "") errorList.push(8);
    }
    else {
    // Обнаружен неизвестный элемент ;)
    }
}
// Финальная стадия
// Если массив ошибок пуст - возвращаем true
if (!errorList.length) return true;
// Если есть ошибки - формируем сообщение, выовдим alert
// и возвращаем false
var errorMsg = "При заповненні форми допущені наступні помилки:\n\n";
for (i = 0; i < errorList.length; i++) {
    errorMsg += errorText[errorList[i]] + "\n";
}
alert(errorMsg);
return false;
}

function isDigit(){
        //alert(event.keyCode);
        if (!((event.keyCode >= 48)&&(event.keyCode <= 57)||(event.keyCode == 46)||(event.keyCode == 44)||(event.keyCode == 47)))
        event.returnValue = false;
    }
function checkFormChTC(form) {
// Заранее объявим необходимые переменные
var el, // Сам элемент
elName, // Имя элемента формы
value, // Значение
type; // Атрибут type для input-ов
// Массив списка ошибок, по дефолту пустой
var errorList = [];
// Хэш с текстом ошибок (ключ - ID ошибки)
var errorText = {
1 : "Вкажіть номер технічних умов які продовжуються",
2 : "Не заповнено поле '№ звернення '"
}
// Получаем семейство всех элементов формы
// Проходимся по ним в цикле
for (var i = 0; i < form.elements.length; i++) {
    el = form.elements[i];
    elName = el.nodeName.toLowerCase();
    value = el.value;
    if (elName == "input") { // INPUT
        // Определяем тип input-а
        type = el.type.toLowerCase();
        // Разбираем все инпуты по типам и обрабатываем содержимое
        switch (type) {
            case "text" :
                //if (el.name == "registration_date" && value == "") errorList.push(1);
            break;
            case "checkbox" :
            // Ничего не делаем, хотя можем
            break;
            case "radio" :
            // Ничего не делаем, хотя можем
            break;
            default :
            // Сюда попадают input-ы, которые не требуют обработки
            // type = hidden, submit, button, image
            break;
        }
    }// else if (elName == "textarea") { // TEXTAREA
     //   if (value == "") errorList.push(4);
    //}
    else if (elName == "select") { // SELECT
        if (el.name == "tu_id" && value == "0") errorList.push(1);
        //if (el.name == "customer_adress" && value == "") errorList.push(8);
    }
    else {
    // Обнаружен неизвестный элемент ;)
    }
}
// Финальная стадия
// Если массив ошибок пуст - возвращаем true
if (!errorList.length) return true;
// Если есть ошибки - формируем сообщение, выовдим alert
// и возвращаем false
var errorMsg = "Помилка введення \n";
for (i = 0; i < errorList.length; i++) {
    errorMsg += errorText[errorList[i]] + "\n";
}
alert(errorMsg);
return false;
}

