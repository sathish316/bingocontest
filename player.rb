require 'Qt4'
require 'number'

class Bingo
  
  class Player < Qt::Widget
    
    def initialize(parent = nil)
      super
      setFixedSize(500,600)
      @num_of_bingos = 0
      
      @nameText = Qt::Label.new
      @nameText.setFont(Qt::Font.new('Times', 20, Qt::Font::Bold))
      
      bingoGrid = Qt::GridLayout.new
      @cells = []
      for row in 0...5
        for col in 0...5
          @cells[row] ||= []
          number = Bingo::Number.new(self)
          @cells[row][col] = number
          bingoGrid.addWidget(number, row, col)
        end
      end
      
      @bingo = [text('B'), text('I'),text('N'),text('G'),text('O')]
      row = 5
      for col in 0...5
        bingoGrid.addWidget(@bingo[col], row, col)
      end
      
      @guessText = Qt::Label.new
      @guessText.setFont(Qt::Font.new('Times', 50, Qt::Font::Bold))
      
      layout = Qt::VBoxLayout.new      
      layout.addWidget(@nameText)
      layout.addLayout(bingoGrid)
      layout.addWidget(@guessText)
      setLayout(layout)
    end
    
    def fill(numbers)
      for row in 0...5
        for col in 0...5
          @cells[row][col].value = numbers.pop
        end
      end
    end
    
    def name=(name)
      @nameText.text = name
    end
    
    def select_number
      #TODO get from bot
      num = (rand()*25).to_int
      @guessText.text = num
      @guessText.repaint()
      mark(num)
      num
    end
    
    def number_selected(number)
      #TODO tell bot
      @guessText.text = ''
      @guessText.repaint()
      mark(number)
    end
    
    def bingo_count
      rowcount = colcount = d1count =  d2count = 0
      for row in 0...5
        count = 0
        for col in 0...5
          count += 1 if @cells[row][col].marked?
        end
        rowcount += 1 if count == 5
      end
      
      for col in 0...5
        count = 0
        for row in 0...5
          count += 1 if @cells[row][col].marked?
        end
        colcount += 1 if count == 5
      end
      
      count = 0
      for i in 0...5
        count += 1 if @cells[i][i].marked?
      end
      d1count = 1 if count == 5
      
      count = 0
      for i in 0...5
        count += 1 if @cells[i][4-i].marked?
      end
      d2count = 1 if count == 5
      
      rowcount + colcount + d1count + d2count
    end
    
    private
    
    def text(text)
      t = Qt::Label.new
      font = Qt::Font.new('Times', 25, Qt::Font::Bold)
      t.setFont(font)
      t.setPalette(Qt::Palette.new(Qt::green))
      t.setAlignment(Qt::AlignCenter)
      t.text = text
      t
    end
    
    def mark(num)
      for row in 0...5 
        for col in 0...5 
          number = @cells[row][col]
          if(number.value == num)
            number.mark
          end
        end
      end
      mark_bingo(bingo_count)
    end
    
    def mark_bingo(count)
      (0...count).each do |i|
        if(i < 5)
          @bingo[i].setAutoFillBackground(true)
          @bingo[i].repaint()
        end
      end
    end
    
  end
end