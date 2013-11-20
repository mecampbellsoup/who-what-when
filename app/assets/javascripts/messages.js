$(document).ready(function () {
  $('#phone_input').formatter({
    'pattern': '({{999}}) {{999}}-{{9999}}',
    'persistent': false
  });

  $('.form-signin').validate({
      rules: {
        'message[receiver]': {
          required: true,
          minlength: 14 /* to play nice with formatter function */
        },
        'message[body]': {
          required: true
        },
        'message[send_at]' : {
          required: true
        }
      },
      showErrors: function(errorMap, errorList) {
           /* Overides default error messages */
      }
  });

  $('.form-signin').on('change keyup', function() {
      if($(this).validate().checkForm()) {
          $('#submit_button').removeClass('disabled').attr('disabled', false);
      } else {
          $('#submit_button').addClass('disabled').attr('disabled', true);
      }
  });

  $('#submit_button').addClass('disabled').attr('disabled', true);

});

