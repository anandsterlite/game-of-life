require File.expand_path(File.dirname(__FILE__) + '/../../lib/game')
require "test/unit"
require "mocha"
 
class TestRules  < Test::Unit::TestCase
  #test setup
  def setup
    @game = Game.new 2
    @game.stubs("print")
  end
  
  def concrete_mat_xx_xx
    @game.expects(:gets).at_most(4).returns("2\n", "2\n", "x x\n", "x x\n")
    @game.set_mat
  end
  
  def concrete_mat__xxx__
    @game.expects(:gets).at_most(5).returns("3\n", "3\n", "- - -\n", "x x x\n", "- - -\n")
    @game.set_mat   
  end
  
  def concrete_mat_x_x_x_
    @game.expects(:gets).at_most(5).returns("3\n", "3\n", "- x -\n", "- x -\n", "- x -\n")
    @game.set_mat   
  end
  
  #testcases
  def test_calculate_next_generation
    concrete_mat_x_x_x_
    @game.identify_neighbours
    @game.calculate_next_generation
    @game.move_to_next_generation
     3.times{|r|
      3.times{|c|
        if (c==0 && r==0) || (c==2 && r==2 )|| (c==0 && r==2) || (c==2 && r==0 )|| (c==1 && r==1)
          assert_equal 2, @game.neighbour_count(r,c), "next generation calculated wrongly"
        elsif (c==1 && r==0 )||( c==1 && r==2)
          assert_equal 3, @game.neighbour_count(r,c), "next generation calculated wrongly"
        else
          assert_equal 1, @game.neighbour_count(r,c), "next generation calculated wrongly"
        end
        }
      }
    
    setup
    concrete_mat_xx_xx
    @game.identify_neighbours
    @game.calculate_next_generation
    @game.move_to_next_generation
    2.times{|r|
      2.times{|c|
        assert_equal 3, @game.neighbour_count(r,c), "next generation calculated wrongly"
        }
      }  
  end
end