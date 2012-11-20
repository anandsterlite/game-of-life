#Modules implemente mat behaviour for different dimension

require File.expand_path(File.dirname(__FILE__) + '/rules')
#Mat interface
module Mat
  include Rule::Default
  def set_mat 
    raise "Abstract method"   
  end
  
  def identify_neighbours
    raise "Abstract method"   
  end

  def calculate_next_generation
    raise "Abstract method"   
  end
  
  def move_to_next_generation
    raise "Abstract method" 
  end

  def print_neighbours
    raise "Abstract method"  
  end
  
  def display_future
    raise "Abstract method" 
  end

  def display
    raise "Abstract method" 
  end
  
  def print_neighbours_count
    raise "Abstract method" 
  end
end

#2D concrete mat
module Mat_2d
  include Rule::Default
  
  #sets concrete mat
  def set_mat 
    mat_size
    mat_input
  end
  
  #mat size input
  def mat_size
    while @x == 0
      print "\nRows : "
      input = gets.chop
      begin
        @x = input.to_i
      rescue
      end
    end
    while @y == 0
      print "\nColumns : "
      input = gets.chop
      begin
        @y = input.to_i
      rescue
      end
    end
  end
  
  #fills mat values
  def mat_input
    @mat = Hash.new
    @x.times{ |r|
        @mat[r] = Hash.new
        row = nil
          print "Enter : "
          @y.times{|c| print "(#{r},#{c}) " }
        while row.nil?
          print "\n"
          begin
          input = gets.chop.split(' ')
          raise Exception.new("Enter valid input x or - : ") if input.any? {|i| i != 'x' && i != '-'}
          raise Exception.new("Enter #{@y} values : ") if input.size < @y
          row = input if input.size == @y
          rescue Exception => msg
            print msg
            @y.times{|c| print "(#{r},#{c}) " }
          end
        end
        @y.times{|c|
          @mat[r][c] = (row[c].downcase == 'x' ?  Cell.new(true) : Cell.new(false))
        }
    }  
  end
  
  #identify neighbours for each cell in the mat
  def identify_neighbours
    @x.times{ |r|
       @y.times{|c| 
           #+1,+1 0,+1 +1,0
           @mat[r][c].add_neighbour @mat[r+1][c+1] unless  @mat[r+1].nil? || @mat[r+1][c+1].nil?
           @mat[r][c].add_neighbour @mat[r][c+1] unless  @mat[r].nil? || @mat[r][c+1].nil?
           @mat[r][c].add_neighbour @mat[r+1][c] unless  @mat[r+1].nil? || @mat[r+1][c].nil?
           
           #-1,-1 0,-1 -1,0
           @mat[r][c].add_neighbour @mat[r-1][c-1] unless   @mat[r-1].nil? || @mat[r-1][c-1].nil?
           @mat[r][c].add_neighbour @mat[r-1][c] unless   @mat[r-1].nil? || @mat[r-1][c].nil?
           @mat[r][c].add_neighbour @mat[r][c-1] unless   @mat[r].nil? || @mat[r][c-1].nil?
           
           #+1,-1 -1,+1
           @mat[r][c].add_neighbour @mat[r-1][c+1] unless   @mat[r-1].nil? || @mat[r-1][c+1].nil?
           @mat[r][c].add_neighbour @mat[r+1][c-1] unless   @mat[r+1].nil? || @mat[r+1][c-1].nil?
           
          }
          
    }   
  end
  
  #Move the game to next generation
  def move_to_next_generation
    @x.times{ |r|
        @y.times{|c| 
          @mat[r][c].step_generation
        }
    }  
  end
  
  #Display mat in user console
  def display
    print "\n"
    @x.times{ |r|
        @y.times{|c| 
          print @mat[r][c].is_alive ? "X " : "- "
          }
        print "\n"
    }
  end
  
  #
  # Debug/Development methods
  #
  
  #Debug method implemeneted for testing and development
  def display_future
    print "\n"
    @x.times{ |r|
        @y.times{|c| 
          print @mat[r][c].next_generation ? "X " : "- "
          }
        print "\n"
    }
  end
  
  #Debug method implemeneted for testing and development
  def print_neighbours_count
    @x.times{ |r|
        @y.times{|c| 
          print @mat[r][c].count_neighbours.to_s + " "
          }
        print "\n"
    }
  end
  
  #Debug method implemeneted for testing and development
  def neighbour_count x,y
    @mat[x][y].count_neighbours
  end
  
  #Debug method implemeneted for testing and development
  def print_neighbours
    @x.times{ |r|
       @y.times{|c| 
           #+1,+1 0,+1 +1,0
           print @mat[r+1].nil? || @mat[r+1][c+1].nil? ? "x " : "- "
           print @mat[r].nil? || @mat[r][c+1].nil? ? "x " : "- "
           print @mat[r+1].nil? || @mat[r+1][c].nil? ? "x " : "- "
           
           #-1,-1 0,-1 -1,0
           print  @mat[r-1].nil? || @mat[r-1][c-1].nil? ? "x " : "- "
           print  @mat[r-1].nil? || @mat[r-1][c].nil? ? "x " : "- "
           print  @mat[r].nil? || @mat[r][c-1].nil? ? "x " : "- "
           
           #+1,-1 -1,+1
           print  @mat[r-1].nil? || @mat[r-1][c+1].nil? ? "x " : "- "
           print  @mat[r+1].nil? || @mat[r+1][c-1].nil? ? "x " : "- "
           print "\n"
           
          }
          
    }   
  end
  
end
