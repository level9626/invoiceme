module ApplicationHelper
  def previous_path
    URI((request.referer || invoices_path)).path
  end
end
