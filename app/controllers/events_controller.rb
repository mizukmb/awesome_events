class EventsController < ApplicationController
  before_action :authenticate

  def new
    @event = currenst_user.created_events.build
  end
end
