module ApplicationHelper
  def body_class(class_name="default_class")
    content_for :body_class, class_name
  end
  
  def render_double_button(icon_name, top, bottom, link, ajax=false)
    link_to link, class: "btn btn-primary btn-block btn-round-lg", remote: ajax do
      content_tag(:i, ' ', class: "fa fa-#{icon_name} fa-3x pull-left") +
      content_tag(:span, " #{top}") + tag(:br) +
      content_tag(:b, "#{bottom}")
    end    
  end
  
  def app_name
    return "Kapiten"
  end

  def title(value)
    unless value.nil?
      # @title = "#{value} | Fustal"
      @title = "#{value}"
    end
  end

  def current_user?(user)
    if current_user == user then true else false end
  end


  def link_to_in_li(body, url, html_options = {})
    active = "active" if current_page?(url)
    content_tag :li, class: "mt" do
      link_to body, url, class: active
    end
  end

  def link_fa_to(icon_name, text, link, remote=false)
    # active = "active" if current_page?(link)
    link_to link, class: "btn btn-labeled btn-info", remote: remote do
      content_tag(:i, ' ', class: "fa fa-#{icon_name}") +
      content_tag(:span, " #{text}")
    end
  end

  def youtube_embed(youtube_url)
    youtube_id = youtube_url.split("=").last
    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}")
  end

  def into_hub(user)
    if user.admin?
      admin_root_url(subdomain: "")
    else
      user_root_url(subdomain: "")
    end
  end

  def idr_money(number)
    number_to_currency(number.to_i, precision: 0, unit: "Rp ", separator: ",", 
                       delimiter: ".", negative_format: "(%u%n)",
                       raise: true)
# => R$1234567890,50
  end

  def idr_no_symbol(number)
    number_to_currency(number, unit: "", separator: ",", 
                       delimiter: ".", negative_format: "(%u%n)",
                       raise: true, precision: 0)
# => R$1234567890,50
  end

  def idr_concat(number, divider)
    con = (number / divider)
    number_with_precision(con, precision: 0)
  end

  def language_picker
    if I18n.locale == :en
      "English"
    else
      "Bahasa Indonesia"
    end
  end

   def percent_of(n)
    n.to_f * 100.0
   end

  def embedded_svg filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end   
end