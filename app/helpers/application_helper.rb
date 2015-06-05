module ApplicationHelper
  def generate_hash_for_statistic(object)
    object.inject({}){|result, current| result.merge({current.date => current.sum})}
  end

  def errors_output
    content_tag :div, class: 'flash-messages' do
      flash.map do |name, msg|
        content_tag :div, class: "alert alert-dismissable alert-#{name}" do
          content_tag(:span, '&times;'.html_safe, class: :close, 'data-dismiss' => 'alert') + msg
        end
      end.join().html_safe
    end
  end
end
