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

  var submitField = {};

  $('#submit_button').on('click', function() {

    $.each($('#duck-form input'), function(i, formObj) {
        var name = formObj.name;
        var val = formObj.value;
        if (name != "commit") {
          submitField[name] = val;
        }
    });

    $.ajax({
      url: '/messages',
      type: "POST",
      data: submitField,
      success: function(data) {
        $('#duck-form').trigger("reset");
        $('.bubble').addClass('showDuck');
        setTimeout(function(){
          $('.bubble').removeClass('showDuck', 500);
        }, 2500);
        $('#submit_button').addClass('disabled').attr('disabled', true);
      }
    });

  });

});

