module ApplicationHelper

  #Return a title on a per-page basis
  def title
    base_title = "SAT Words"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
    image_tag("logo.png", :alt => "SAT Words", :class => "round")
  end
end
