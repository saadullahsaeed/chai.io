module ApplicationHelper

  def page_heading text, sub=''
    "<div class=\"page-header\"><h3>#{text} <small>#{sub}</small></h3></div>".html_safe
  end


  def page_heading_for_resource resource
    resource_name = resource.class.name
    if resource.new_record?
      prefix = 'New'
      sub = "Create a new #{resource_name}"
    else
      prefix = 'Edit'
      sub = ''
    end
    page_heading "#{prefix} #{resource_name}", sub
  end



  def link_to_button text, path
    link_to text, path, {:class => 'btn btn-default'}
  end

end
