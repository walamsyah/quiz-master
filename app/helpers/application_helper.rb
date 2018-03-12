module ApplicationHelper
  def true_or_false_icon(status)
    return '<i class="icon__true"></i>' if status
    '<i class="icon__false"></i>'
  end
end
