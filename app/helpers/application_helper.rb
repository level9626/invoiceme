module ApplicationHelper
  def previous_path
    URI((request.referer || '')).path
  end
end
