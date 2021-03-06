class EventsController < ApplicationController
  before_action :authenticate, except: :show

  def show
    begin
      @event = Event.find(params[:id])
    rescue => e
      render text: 'nothing', status: 404
    end
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event, notice: '作成しました'
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :place, :content, :start_time, :end_time
    )
  end
end
