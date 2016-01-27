module CapybaraExtension
  def drag_by(right_by, down_by)
    base.drag_by(right_by, down_by)
  end
end
::Capybara::Node::Element.send :include, CapybaraExtension