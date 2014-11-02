class DatetimepickerInput < SimpleForm::Inputs::StringInput
  def input_html_classes
    super.push("datetimepicker")
  end

  def input_type
    :string
  end

  def input_html_options
    super.tap do |opts|
      opts[:data] ||= {}
      opts[:data].merge! datepicker_options
      opts[:value] ||= value
    end
  end

  def value
    val = object.send(attribute_name)
    return DateTime.new(val.year, val.month, val.day, val.hour, val.min).strftime("%Y-%m-%d %H:%M") if val.is_a?(Time)
    return val if val.nil?
    val.to_s
  end

  private
    def datepicker_options
      options = self.options.fetch(:datepicker_options, {})
      options = Hash[options.map{ |k, v| [k.to_s.camelcase(:lower), v] }]
      { datepicker_options: options }
    end
end
