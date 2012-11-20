#Cell properties and behaviours of its own

class Cell
  
  attr_accessor :is_alive
  attr_accessor :next_generation
  
  def initialize life
    @is_alive = life
    @next_generation = false
    @neighbours = []
  end
  
  def step_generation
    @is_alive = @next_generation
    @next_generation = false
  end
  
  def count_neighbours
    lifes = 0
    @neighbours.each{ |n| 
      lifes += 1 if n.is_alive 
    }
    return lifes
  end
  
  def add_neighbour n
    return unless n
    @neighbours << n
  end

end


