class HourInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    # @builder.select(attribute_name, hour_options, { :selected => selected_value }, { :class => "input-medium" })
    @builder.select(attribute_name, hour_options, { :selected => selected_value }, { :class => "form-control" })
  end

  private

  # The "Selecione..." string could also be translated with something like: I18n.t("helpers.select.prompt')
  # def hour_options
  #   hour = [['Pilih...', '00:00:00']]
  #   (8..21).each do |h|
  #     %w(00 15 30 45).each do |m|
  #       hour.push ["#{h}h#{m}", "#{"%02d" % h}:#{m}:00"]
  #     end
  #   end
  #   hour
  # end

  def hour_options
    hour = [['Pilih...', '00:00']]
    (0..23).each do |h|
      %w(00).each do |m|
        hour.push ["#{h}:#{m}", "#{h}:#{m}"]
      end
    end
    hour
  end

  def selected_value
    value = object.send(attribute_name)
    value && value.strftime("%H:%M:%S")
  end
end