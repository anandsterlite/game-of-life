require File.expand_path(File.dirname(__FILE__) + '/../../lib/game')
require "test/unit"
require "mocha"
 
class TestGame  < Test::Unit::TestCase
  #test setup
  def setup
    @game = Game.new 2
    @game.stubs("print")
  end
  
  #testcases
  def test_start
    @game.expects(:gets).at_most(5).returns("3\n", "3\n", "- x -\n", "- x -\n", "- x -\n")
    @game.start
     3.times{|r|
      3.times{|c|
        if (c==0 && r==0) || (c==2 && r==2 )|| (c==0 && r==2) || (c==2 && r==0 )|| (c==1 && r==1)
          assert_equal 2, @game.neighbour_count(r,c), "first generation failed"
        elsif (c==1 && r==0 )||( c==1 && r==2)
          assert_equal 3, @game.neighbour_count(r,c), "first generation failed"
        else
          assert_equal 1, @game.neighbour_count(r,c), "first generation failed"
        end
        }
      }
  end

  def test_next_step
    @game.expects(:gets).at_most(5).returns("3\n", "3\n", "- x -\n", "- x -\n", "- x -\n")
    @game.start
    @game.next_step
    @game.next_step
     3.times{|r|
      3.times{|c|
        if (c==0 && r==0) || (c==2 && r==2 )|| (c==0 && r==2) || (c==2 && r==0 )|| (c==1 && r==1)
          assert_equal 2, @game.neighbour_count(r,c), "consecutive generations failed"
        elsif (c==1 && r==0 )||( c==1 && r==2)
          assert_equal 3, @game.neighbour_count(r,c), "consecutive generations failed"
        else
          assert_equal 1, @game.neighbour_count(r,c), "consecutive generations failed"
        end
        }
      }
  end  
  
end