class ApiController < ApplicationController
  respond_to :xml

  def gateway
    case params.keys.to_s
    when /ARBGetSubscriptionStatusRequest/
      status
    else
      logger.info 'NOT FOUND'
    end
  end

  def status
    resp = {
      :refId => 'Sample',
      :messages => {
        :code => 'I00001',
        :text => 'Successful'
      }
    }
    logger.info(resp.to_xml(:root => 'ARBGetSubscriptionStatusResponse') )
    render :text => resp.to_xml(:root => 'ARBGetSubscriptionStatusResponse')
  end

end
