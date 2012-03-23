$(document).ready(function(){
    $.ajaxSetup({
      beforeSend: function(xhr) {
        var token = $('meta[name="_csrf"]').attr('content');
        xhr.setRequestHeader('X_CSRF_TOKEN', token);
      }
    });

	var formMessage = function(type, message) {
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
	}

    $('#subscribe-form').submit(function(){
        $.ajax({
            type: "POST",
            url: '/subscribe.json',
            data: $(this).serialize(),
            success: function(response){
                $('.success, .error').remove();
				formMessage(response.result, response.message);
                if(response.result == 'success') {
                    $('#subscribe-email-input').val("");
                }
            },
            error: function(data, status, err) {
                alert('알 수 없는 에러가 발생했습니다. = ' + JSON.stringify(data));
            }
        });
        return false;
    });
});