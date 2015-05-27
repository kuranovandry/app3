module ApplicationHelper
  def generate_hash_for_statistic(object)
    object.inject({}){|result, current| result.merge({current.date => current.sum})}
  end
end
