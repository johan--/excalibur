module ApplicationHelper

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

  def idr_concat(number)
    con = (number / 1000000).round(2)
    idr_no_symbol(con)
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
end