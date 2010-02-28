require 'Qt4'

class Bingo
  class Number < Qt::Widget
    
    def initialize(parent=nil)
      super
      @lcd = Qt::LCDNumber.new(2)
      @lcd.setPalette(Qt::Palette.new(Qt::green))
      @lcd.setSegmentStyle(Qt::LCDNumber::Outline)
      @lcd.show
      @marked = false
      layout = Qt::VBoxLayout.new
      layout.addWidget(@lcd)
      setLayout(layout)
    end
    
    def value=(value)
      @value = value
      @lcd.display @value
    end
    
    def value
      @value
    end
    
    def mark
      @lcd.setSegmentStyle(Qt::LCDNumber::Filled)
      @lcd.setAutoFillBackground(true)
      @lcd.repaint()
      @marked = true
    end
    
    def marked?
      @marked
    end
    
  end
end