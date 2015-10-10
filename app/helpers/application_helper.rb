module ApplicationHelper
  
  def app_name
    return "siKapiten"
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
      content_tag(:i, ' ', class: "menu-icon fa fa-#{icon_name}") +
      content_tag(:span, " #{text}")
    end
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



end
