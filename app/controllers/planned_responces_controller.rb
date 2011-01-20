class PlannedResponcesController < ApplicationController
  # GET subscriptions/1/planned_responces
  # GET subscriptions/1/planned_responces.xml
  def index
    @planned_responces = Subscription.find(params[:subscription_id]).planned_responces

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @planned_responces }
    end
  end

  # GET subscriptions/1/planned_responces/1
  # GET subscriptions/1/planned_responces/1.xml
  def show
    @planned_responce = Subscription.find(params[:subscription_id]).planned_responces.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @planned_responce }
    end
  end

  # GET subscriptions/1/planned_responces/new
  # GET subscriptions/1/planned_responces/new.xml
  def new
    @planned_responce = Subscription.find(params[:subscription_id]).planned_responces.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @planned_responce }
    end
  end

  # GET subscriptions/1/planned_responces/1/edit
  def edit
    @planned_responce = Subscription.find(params[:subscription_id]).planned_responces.find(params[:id])
  end

  # POST subscriptions/1/planned_responces
  # POST subscriptions/1/planned_responces.xml
  def create
    @planned_responce = Subscription.find(params[:subscription_id]).planned_responces.build(params[:planned_responce])

    respond_to do |format|
      if @planned_responce.save
        format.html { redirect_to([@planned_responce.subscription, @planned_responce], :notice => 'Planned responce was successfully created.') }
        format.xml  { render :xml => @planned_responce, :status => :created, :location => [@planned_responce.subscription, @planned_responce] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @planned_responce.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT subscriptions/1/planned_responces/1
  # PUT subscriptions/1/planned_responces/1.xml
  def update
    @planned_responce = Subscription.find(params[:subscription_id]).planned_responces.find(params[:id])

    respond_to do |format|
      if @planned_responce.update_attributes(params[:planned_responce])
        format.html { redirect_to([@planned_responce.subscription, @planned_responce], :notice => 'Planned responce was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @planned_responce.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE subscriptions/1/planned_responces/1
  # DELETE subscriptions/1/planned_responces/1.xml
  def destroy
    subscription = Subscription.find(params[:subscription_id])
    @planned_responce = subscription.planned_responces.find(params[:id])
    @planned_responce.destroy

    respond_to do |format|
      format.html { redirect_to subscription_planned_responces_url(subscription) }
      format.xml  { head :ok }
    end
  end
end
