module ParamsRouter
  class Base
    def name
      self.class.name.split('::').last
    end
    def matches?(request)
      request.params.keys.include?(name)
    end
  end
  class ARBGetSubscriptionStatusRequest < Base; end
  class ARBCreateSubscriptionRequest    < Base; end
  class ARBUpdateSubscriptionRequest    < Base; end
  class ARBCancelSubscriptionRequest    < Base; end
end
