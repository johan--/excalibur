module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Fustal"
    end
  end
end
