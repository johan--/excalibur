module ApplicationHelper
  def app_name
    # return "futsalHero"
    return "Kapiten"
  end

  def title(value)
    unless value.nil?
      # @title = "#{value} | Fustal"
      @title = "#{value}"
    end
  end

  def link_to_in_li(body, url, html_options = {})
    active = "active" if current_page?(url)
    content_tag :li, class: "mt" do
      link_to body, url, class: active
    end
  end

  def link_fa_to(icon_name, text, link)
    active = "active" if current_page?(link)
    link_to link, class: active do
      content_tag(:i, ' ', class: "fa fa-#{icon_name}") +
      content_tag(:span, text)
    end
  end

  def into_hub(user)
    if user.admin?
      admin_root_path
    elsif user.operator?
      biz_root_path
    else
      user_root_path
    end
  end

  def idr_money(number)
    number_to_currency(number, unit: "Rp ", separator: ",", 
                       delimiter: ".", negative_format: "(%u%n)",
                       raise: true, precision: 0)
# => R$1234567890,50
  end

  def idr_no_symbol(number)
    number_to_currency(number, unit: "", separator: ",", 
                       delimiter: ".", negative_format: "(%u%n)",
                       raise: true, precision: 0)
# => R$1234567890,50
  end

  # Upload directly to Cloudinary with form tag
  def cl_form_tag(callback_url, options={}, &block)
    form_options = options.delete(:form) || {}
    form_options[:method] = :post
    form_options[:multipart] = true

    options[:timestamp] = Time.now.to_i
    options[:callback] = callback_url
    if options[:transformation]
      options[:transformation] = Cloudinary::Utils.
        generate_transformation_string(options[:transformation])
    end

    options[:signature] = Cloudinary::Utils.
      api_sign_request(options, Cloudinary.config.api_secret)

    options[:api_key] = Cloudinary.config.api_key

    url = "https://api.cloudinary.com/v1_1/"
    url<< "#{Cloudinary.config.cloud_name}/image/upload"

    form_tag(url, form_options) do
      content = []

      options.each do |name, value|
        content<< hidden_field_tag(name, value)
      end

      content<< capture(&block)

      content.join("\n").html_safe
    end
  end

end
