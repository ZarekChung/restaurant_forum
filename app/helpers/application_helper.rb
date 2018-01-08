module ApplicationHelper
  def icon_link_to(label, path,icon)
   # define_base do 
          link_to path do
            content_tag :span, class: "glyphicon glyphicon-#{icon}" do
            label
            end
          end #end link_to 
  #  end      
  end

  def define_base
    link_to_unless_current path do
      content_tag :span, class: "glyphicon glyphicon-#{icon}" do
      label
      end
    end  
  end


end
