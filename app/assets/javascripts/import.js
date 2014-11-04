$('#submit').on('click', function(e) {
  e.preventDefault();
  console.log("in import");

  var file = $('#file')[0].files[0],
      form_data = new FormData(),
      action = $(this).parent().attr('action'),
      redirect_uri = action.substr(0, action.indexOf('/import'));

  form_data.append('data', file);

  $.ajax({
    type: 'POST',
    url: action,
    cache: false,
    contentType: false,
    processData: false,
    data: form_data,
    success: function(data) {
      location.href = redirect_uri;
    },
    error: function() {
      alert('Unable to parse data.');
    }
  });
});
