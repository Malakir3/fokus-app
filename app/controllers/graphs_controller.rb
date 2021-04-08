class GraphsController < ApplicationController
  def create
    @intakes = Intake.includes(:menu).where(user_id: current_user.id).order('date DESC').order('timing_id DESC')
    @standards = Standard.includes(:menu).where(user_id: current_user.id)
    Graph.create_graph(@intakes, @standards)
    render template: 'intakes/index'
  end
end
