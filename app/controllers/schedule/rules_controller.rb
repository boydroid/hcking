# encoding: utf-8

class Schedule::RulesController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    authorize! :update, @event

    rule = {}
    day_hashes = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
    rule[day_hashes[params[:day_of_week].to_i]] = [params[:week_number].to_i]
    @event.schedule.add_recurrence_rule IceCube::Rule.monthly.day_of_week(rule)

    if !@event.save
      redirect_to(@event, :alert => 'Datum konnte nicht hinzugefügt werden.')
    else
      redirect_to(@event, :notice => 'Datum hinzugefügt.')
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    authorize! :update, @event

    rule = @event.schedule.rrules[params[:id].to_i]
    @event.schedule.remove_recurrence_rule(rule)

    if !@event.save
      redirect_to(@event, :alert => 'Datum konnte nicht entfernt werden.')
    else
      redirect_to(@event, :notice => 'Datum entfernt.')
    end
  end

end
