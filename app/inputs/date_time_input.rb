class DateTimeInput < SimpleForm::Inputs::DateTimeInput
  def input(wrapper_options)
    #template.content_tag(:div, super)
    "#{@builder.text_field(attribute_name, input_html_options)}".html_safe
  end
end