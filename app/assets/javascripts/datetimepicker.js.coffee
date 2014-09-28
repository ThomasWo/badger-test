#= require jquery.xdan.datetimepicker

@setupDateTimePicker = (container) ->
  defaults = {
    formatDate: 'y-m-d',
    format: 'Y-m-d H:i',
    allowBlank: true,
    defaultSelect: false,
    validateOnBlur: false
  }

  entries = $(container).find('input.datetimepicker')
  entries.each (index, entry) ->
    options = $(entry).data 'datepicker-options'
    $(entry).datetimepicker $.extend(defaults, options)

$ ->
  setupDateTimePicker $('body')
