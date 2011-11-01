module ApplicationHelper

  # Title helper: define and use the base title of the website
  def title
    base_title = 'Doodoo'
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
