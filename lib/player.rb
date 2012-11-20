#Class dedicated for handling player options at console

require File.expand_path(File.dirname(__FILE__) + '/game')
class Player
 
 # User starts palying game from here
 def self.play 
  option = ''
  while ! ['exit', 'quit', 'x', 'q', '3'].include? option
    print "\n"
    puts '1 - new game', '2 - next generation', "3 - quit"
    print "INPUT : "
    option = gets.chop
    case option
      when '1', 'new game', 's'
        game = Game.new
        game.start
      when '2', 'next generation', 'next', 'n'
        unless game
          game = Game.new
          game.start
          next
        end
        game.next_step
    end
  end
 end
 
 self.play
  
end
