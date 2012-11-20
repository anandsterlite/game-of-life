require File.expand_path(File.dirname(__FILE__) + '/../../lib/game')
require "test/unit"
require "mocha"
 
class TestMat  < Test::Unit::TestCase
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
  
  #test cases
  def test_set_mat
    @game.expects(:gets).at_most(3).returns("1\n", "1\n", "x\n")
    assert_nothing_raised {@game.set_mat}
    @game.expects(:gets).at_most(4).returns("x\n","1\n", "1\n", "x\n")
    assert_nothing_raised {@game.set_mat}
    @game.expects(:gets).at_most(4).returns("1\n","-1\n", "1\n", "x\n")
    assert_nothing_raised {@game.set_mat}
    @game.expects(:gets).at_most(5).returns("2\n", "2\n", "xx\n", "x x\n", "- -\n")
    assert_nothing_raised {@game.set_mat}    
  end
  
  def test_identify_neighbours
    concrete_mat_xx_xx
    @game.identify_neighbours
    2.times{|r|
      2.times{|c|
        assert_equal 3, @game.neighbour_count(r,c), "indentify neighbours failed"
        }
      }
      
    setup
    concrete_mat__xxx__
    @game.identify_neighbours
    3.times{|r|
      3.times{|c|
        if (c==0 && r==0) || (c==2 && r==2 )|| (c==0 && r==2) || (c==2 && r==0 )|| (c==1 && r==1)
          assert_equal 2, @game.neighbour_count(r,c), "indentify neighbours failed"
        elsif (c==1 && r==0 )||( c==1 && r==2)
          assert_equal 3, @game.neighbour_count(r,c), "indentify neighbours failed"
        else
          assert_equal 1, @game.neighbour_count(r,c), "indentify neighbours failed"
        end
        }
      }  
  end
  
  def test_move_to_next_generation
    concrete_mat__xxx__
    @game.identify_neighbours
    @game.move_to_next_generation
     2.times{|r|
      2.times{|c|
        assert_equal 0, @game.neighbour_count(r,c), "next generation initial values not set properly"
        }
      }
  end
  
end