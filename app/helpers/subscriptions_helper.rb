module SubscriptionsHelper
  def arb_statuses
    %w(active expired suspended canceled terminated).map{|el| [el, el]}
  end
end
