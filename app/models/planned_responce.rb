class PlannedResponce < ActiveRecord::Base
  belongs_to :subscription

  def cancel
    update_attributes(:status => 'canceled')
  end
end
