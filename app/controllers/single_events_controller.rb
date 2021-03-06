# encoding: utf-8

class SingleEventsController < ApplicationController
  def show
    @single_event = SingleEvent.find(params[:id])
    @event = @single_event.event
  end

  def edit
    @single_event = SingleEvent.find(params[:id])
  end

  def update
    @single_event = SingleEvent.find(params[:id])
    @single_event.topic = params[:single_event][:topic]
    @single_event.description = params[:single_event][:description]

    if @single_event.save
      flash[:notice] = "SingleEvent wurde bearbeitet"
    else
      flash[:error] = "Beim Speichern ist ein Fehler aufgetreten"
    end

    redirect_to :method => "show", :event_id => @single_event.event.id, :id => @single_event.id
  end

end
