$(document).ready(function(){
    $.ajaxSetup({
      beforeSend: function(xhr) {
        var token = $('meta[name="_csrf"]').attr('content');
        xhr.setRequestHeader('X_CSRF_TOKEN', token);
      }
    });

    var Message = {
        display: function(type, message) {
            var typeClass = type + "-message"
            var target = "<div class='" + typeClass + "'>" + message + "</div>";
            $('#subscribe-form').append(target);
            $('.' + typeClass).live('click', function(){
                $(this).stop(true).slideUp(function(){ $(this).remove() });
            }).css({
                opacity: 0.7,
                cursor: 'pointer'
            }).hide().slideDown().delay(3000).slideUp(function(){
                $(this).remove();
            });
        },
        remove: function(){
            $('.success-message, .error-message').remove();
        }
    }

    $('#subscribe-form').submit(function(){
        Message.remove();
        $('.loading').remove();

        var button = $(this).find('input[name$="commit"]');
        button.after("<p class='loading'>Loading...</p>");

        $.ajax({
            type: "POST",
            url: '/subscribe.json',
            data: $(this).serialize()
        })
        .done(function(response) {
            $('.loading').remove();
            Message.display(response.result, response.message);
            if(response.result == 'success') {
                $('input[name$="subscriber[email]"]').val("");
            }
        })
        .fail(function(data, status, err){
            alert('알 수 없는 에러가 발생했습니다. = ' + JSON.stringify(data));
        });
        return false;
    });
});