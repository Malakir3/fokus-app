class GraphsController < ApplicationController
  def index
    @intakes = Intake.includes(:menu).where(user_id: current_user.id)
    @standards = Standard.includes(:menu).where(user_id: current_user.id)
  end

  def create
    @intakes = Intake.includes(:menu).where(user_id: current_user.id)
    @standards = Standard.includes(:menu).where(user_id: current_user.id)    
    Graph.create_graph(@intakes, @standards)
  end

  def erase
    @graphs = Graph.all
    Graph.destroy_graph(@graphs)
  end
end
