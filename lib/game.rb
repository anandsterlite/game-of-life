#Facade class for entire game

require File.expand_path(File.dirname(__FILE__) + '/cell')
require File.expand_path(File.dirname(__FILE__) + '/mat')
class Game
  include Mat
  @mat
  def initialize dimension = 2
    @x = 0
    @y = 0
    Game.module_eval { include Kernel.const_get "Mat_#{dimension.to_s}d" }
  end
  
  #initiate game for users
  def start
    set_mat
    identify_neighbours
    print "\nINPUT:"
    display
    next_step
  end
  
  #Move the game to consecutive generations
  def next_step
    calculate_next_generation
    move_to_next_generation
    print "\nNEXT GENERATION:"
    display
  end

end