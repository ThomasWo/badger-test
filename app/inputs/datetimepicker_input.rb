class DatetimepickerInput < SimpleForm::Inputs::StringInput
  def input_html_classes
    super.push("datetimepicker")
  end

  def input_type
    :string
  end
end
