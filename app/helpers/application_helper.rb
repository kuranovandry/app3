module ApplicationHelper
  def generate_hash_for_statistic(object)
    object.inject({}){|result, current| result.merge({current.date => current.sum})}
  end

  def errors_output
    flash.each do |name, msg|
      content_tag :div, msg, class: "alert alert-#{name}"
    end
  end
end
