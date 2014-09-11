$('#submit').on('click', function(e) {
  e.preventDefault();
  console.log("in import");

  var file = $('#file')[0].files[0],
      form_data = new FormData();

  form_data.append('csv', file);

  $.ajax({
    type: 'POST',
    url: '/import',
    cache: false,
    contentType: false,
    processData: false,
    data: form_data,
    success: function(data) {
      alert("Success!");
    },
    error: function() {
      alert('Unable to parse data.');
    }
  });
});
