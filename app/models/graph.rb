class Graph < ApplicationRecord
  validates :date, :calorie ,presence: true

  def self.create_graph(intakes, standards)
    create_graph_hash = {}
    intakes.each do |intake|
      unless standards.where(menu_id: intake.menu_id) == []
        date = intake.date
        menu_cal = intake.menu.calorie
        menu_amount = intake.menu.amount
        standard = standards.where(menu_id: intake.menu_id)
        stn_large = standard[0].large
        stn_medium = standard[0].medium
        stn_small = standard[0].small
        intake_value = Value.find(intake.value_id).name

        if intake_value == '多め' 
          calorie = menu_cal * stn_large / menu_amount 
        elsif intake_value == '普通' 
          calorie = menu_cal * stn_medium / menu_amount 
        elsif intake_value == '少なめ' 
          calorie = menu_cal * stn_small / menu_amount 
        end

        create_graph_hash[:date] = date
        create_graph_hash[:calorie] = calorie
        Graph.create(create_graph_hash)
      end
    end
  end

  def self.destroy_graph(graphs)
    graphs.each do |graph|
      graph.destroy
    end
  end
end
