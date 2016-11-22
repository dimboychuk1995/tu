/**
 * Created by us9522 on 03.11.2016.
 */
function deleteUserAjax(id) {
    var msg   = $('#formDeletedUser' + id).serialize();
    $.ajax({
        type: 'POST',
        url: '/UserController',
        data: msg,
        success: function(data) {
            $('#results').html(data);
            var row = document.getElementById(id);
            var table = row.parentNode;
            while ( table && table.tagName != 'TABLE' )
                table = table.parentNode;
            if ( !table )
                return;
            table.deleteRow(row.rowIndex);
        },
        error:  function(xhr, str){
            alert('Помилка видалення даних: ' + xhr.responseCode);
        }
    });
}

function deleteRow(r) {
    var i = r.parentNode.parentNode.rowIndex;
    document.getElementById("usersTable").deleteRow(i);
}