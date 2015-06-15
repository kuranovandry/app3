module ApplicationHelper
  def generate_hash_for_statistic(object)
    object.inject({}) { |a, e| a.merge(e.date => e.sum) }
  end

  def errors_output
    content_tag :div, class: 'flash-messages' do
      flash.map do |name, msg|
        content_tag :div, class: "alert alert-dismissable alert-#{name}" do
          content_tag(:span, '&times;'.html_safe, class: :close, 'data-dismiss' => 'alert') + msg
        end
      end.join.html_safe
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: 'add_fields', data: { id: id, fields: fields.gsub('\n', '') })
  end
end
