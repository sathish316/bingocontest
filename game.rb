require 'Qt4'
require 'set'

class Bingo
  
  class Game < Qt::Widget
  
    slots 'play()'
    
    def initialize(parent=nil)
      super
      @guesses = Set.new
      @delay = 1
      showMaximized()
    end
    
    def player1=(player)
      @player1 = player
    end
    
    def player2=(player)
      @player2 = player
    end
    
    def init
      playButton = Qt::PushButton.new('Play',self)
      playButton.setFont(Qt::Font.new('Times', 25, Qt::Font::Bold))
      playButton.resize(120,60)
      connect(playButton, SIGNAL('clicked()'), self, SLOT('play()'))
      layout = Qt::HBoxLayout.new
      layout.addWidget(@player1)
      layout.addWidget(playButton)
      layout.addWidget(@player2)
      setLayout(layout)
    end
    
    private 
    
    def play
      while(true)
        player1
        if(@player1.bingo_count == 5)
          break
        end
        if(@player2.bingo_count == 5)
          break
        end
        sleep(@delay)
        
        player2
        if(@player2.bingo_count == 5)
          break
        end
        if(@player1.bingo_count == 5)
          break
        end
        sleep(@delay)
      end      
    end
    
    def player1
      num = nil
      while num.nil? || @guesses.include?(num)
        num = @player1.select_number
      end        
      
      puts "player 1 guessed #{num}"
      @guesses << num
      @player2.number_selected(num)
    end
    
    def player2
      num = nil
      while num.nil? || @guesses.include?(num)
        num = @player2.select_number
      end       
      
      puts "player 2 guessed #{num}"
      @guesses << num       
      @player1.number_selected(num)
    end        
    
  end
  
end