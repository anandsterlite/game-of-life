#Rules used by game, organized as Mat dimension

module Mat
  module Rule
      module Default
          def calculate_next_generation
                raise "Abstract method"
          end
      end
  end
end

module Mat_2d
  module Rule
      module Default
          # the default rule for two dimensional mat
          def calculate_next_generation
                @x.times{ |r|
                   @y.times{|c| 
                       n = @mat[r][c].count_neighbours
                       @mat[r][c].next_generation = @mat[r][c].is_alive
                       @mat[r][c].next_generation = false if n < 2 || n > 3
                       @mat[r][c].next_generation = true if n == 3
                      }
                      
                }  
          end
      end
  end
end