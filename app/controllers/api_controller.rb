class ApiController < ApplicationController
  respond_to :xml

  before_filter :load_api_call_params
  before_filter :load_subscription, :except => :create


  # sample @api_call_params
  #merchantAuthentication:
  #  name: XXXXXXXXX
  #  transactionKey: XXXXXXXXXXXXXXX
  #subscription:
  #  billTo:
  #    city:
  #    address:
  #    company:
  #    zip:
  #    lastName: Barabaka
  #    country:
  #    firstName: Sabaka
  #    state:
  #  amount: "199.00"
  #  payment:
  #    creditCard:
  #      expirationDate: 2013-10
  #      cardNumber: "4111111111111111"
  #  paymentSchedule:
  #    startDate: "2011-02-04"
  #    interval:
  #      unit: months
  #      length: "12"
  #    totalOccurrences: "9999"
  #xmlns: AnetApi/xml/v1/schema/AnetApiSchema.xsd
  def create
    #logger.info @api_call_params.inspect
    @subscription = Subscription.new({
      :status           => 'active',
      :start_date       => @api_call_params[:subscription][:paymentSchedule][:startDate],
      :amount_cents     => @api_call_params[:subscription][:amount].to_i * 100,
      :interval_length  => @api_call_params[:subscription][:paymentSchedule][:interval][:length],
      :interval_unit    => @api_call_params[:subscription][:paymentSchedule][:interval][:unit],
      :occurences       => @api_call_params[:subscription][:paymentSchedule][:totalOccurrences]
    })

    if @subscription.save
      resp = base_response.deep_merge({
        :subscriptionId => @subscription.subscription_id
      })
    else
      resp = error_response
    end
    xml = resp.to_xml(:root => 'ARBCreateSubscriptionResponse')
    logger.info xml
    render :xml => xml
  end


  #merchantAuthentication:
  #  name: XXXXXXXXX
  #  transactionKey: XXXXXXXXXXXXXXX
  #subscriptionId: "8542344"
  #subscription:
  #  payment:
  #    creditCard:
  #      expirationDate: 2013-12
  #      cardNumber: "4111111111111111"
  #  paymentSchedule:
  #    startDate: "2011-01-19"
  #    totalOccurrences: "9999"
  #xmlns: AnetApi/xml/v1/schema/AnetApiSchema.xsd
  def update
    unless @subscription and @current_responce
      resp = not_found_response
    else
      @subscription.update_attributes(
        :start_date => @api_call_params[:subscription][:paymentSchedule][:startDate],
        :occurences => @api_call_params[:subscription][:paymentSchedule][:totalOccurrences]
      )
    end
    xml = resp.to_xml(:root => 'ARBUpdateSubscriptionRequest')
    logger.info xml
    render :xml => xml
  end

  #merchantAuthentication:
  #  name: XXXXXXXXX
  #  transactionKey: XXXXXXXXXXXXXXX
  #subscriptionId: "10000000"
  #xmlns: AnetApi/xml/v1/schema/AnetApiSchema.xsd
  def status
    unless @subscription and @current_responce
      resp = not_found_response
    else
      resp = base_response.deep_merge({
        :status => @current_responce.status
      })
    end
    xml = resp.to_xml(:root => 'ARBGetSubscriptionStatusResponse')
    logger.info xml
    render :xml => xml
  end

  #merchantAuthentication:
  #  name: XXXXXXXXX
  #  transactionKey: XXXXXXXXXXXXXXX
  #subscriptionId: "10000000"
  #xmlns: AnetApi/xml/v1/schema/AnetApiSchema.xsd
  def cancel
    unless @subscription #and @current_responce
      resp = not_found_response
    else
      @subscription.update_attributes(:status => 'canceled')
      @subscription.cancel! if @current_responce
      resp = base_response
    end
    xml = resp.to_xml(:root => 'ARBUpdateSuARBCancelSubscriptionResponse')
    logger.info xml
    render :xml => xml
  end

protected

  def base_response
    {
      :refId => 'Sample',
      :messages => {
        :resultCode => 'Ok',
        :message    => {
          :code => 'I00001',
          :text => 'Successful'
        }
      }
    }
  end

  def error_response
    base_response.deep_merge({
      :messages => {
        :resultCode => 'Error',
        :message    => {
          :code => 'E00027',
          :text => 'The test transaction was unsuccessful.'
        }
      }
    })
  end

  def not_found_response
    error_response.deep_merge({
      :messages => {
        :resultCode => 'Error',
        :message => {
          :code => 'E00035',
          :text => 'The subscription cannot be found.'
        }
      }
    })
  end

  def load_api_call_params
    @api_call         = params.keys.grep(/ARB/).to_s
    @api_call_params  = params[@api_call]
  end

  def load_subscription
    @subscription = Subscription.find_by_subscription_id(@api_call_params[:subscriptionId])
    @current_responce = @subscription.planned_responces.current if @subscription
  end

end
