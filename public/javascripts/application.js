$(document).ready(function(){
    $.ajaxSetup({
      beforeSend: function(xhr) {
        var token = $('meta[name="_csrf"]').attr('content');
        xhr.setRequestHeader('X_CSRF_TOKEN', token);
      }
    });

    $('#subscribe-form').submit(function(){
        $.ajax({
            type: "POST",
            url: '/subscribe',
            data: $("#subscribe-form").serialize(),
            success: function(response){
                $('.success, .error').remove();
                $('#description').append("<div class='" + response.result + "'>" + response.message + "</div>");
            },
            error: function(data, status, err) {
                alert('알 수 없는 에러가 발생했습니다. = ' + JSON.stringify(data));
            }
        });
        return false;
    });
});