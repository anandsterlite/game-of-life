require File.expand_path(File.dirname(__FILE__) + '/../../lib/cell')
require "test/unit"
require "mocha"
 
class TestCell  < Test::Unit::TestCase
  def test_step_generation
    cell = Cell.new true
    cell.step_generation
    assert_equal false, cell.is_alive, "step generation failed"
    assert_equal false, cell.next_generation, "step generation failed"
    
    cell = Cell.new false
    cell.next_generation = true
    cell.step_generation
    assert_equal true, cell.is_alive, "step generation failed"
    assert_equal false, cell.next_generation, "step generation failed"
  end
  
  def test_count_neighbours
    cell_true = Cell.new true
    cell_false = Cell.new false
    cell = Cell.new false
    cell.add_neighbour cell_true
    assert_equal 1, cell.count_neighbours, "neighbours count wrong"
    cell.add_neighbour cell_false
    cell.add_neighbour cell_true
    cell.add_neighbour cell_false
    assert_equal 2, cell.count_neighbours, "neighbours count wrong"
  end
  
  def test_add_neighbour
    cell_true = Cell.new true
    cell_false = Cell.new false
    cell = Cell.new false
    cell.add_neighbour cell_false
    cell.add_neighbour cell_true
    cell.add_neighbour nil
    assert_equal 1, cell.count_neighbours, "add neighbour fails"   
  end
end