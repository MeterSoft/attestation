module ApplicationHelper
	def link_to_remove_fields(name, f, klass = nil, title = nil)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", class: klass, title: title)
  end
  
  def link_to_add_fields(name, f, association, klass = nil, title = nil)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: klass, title: title)
  end

  def admin?
    resource_class == Admin
  end

  def user?
    resource_class == User
  end

  def devise_session_controller?
    controller.controller_name == "sessions"
  end
end
