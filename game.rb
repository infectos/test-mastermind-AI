class Game
  @@win_round=[]
  @@total=0
  def result
    average
    puts "Average turns #{@@average_turns}"
    puts "total #{@@total}"
  end

  def average
    sum = @@win_round.inject(0){|sum,x| sum + x }
    @@average_turns = sum.to_f/@@win_round.length
  end

  def initialize
    @code = [0,0,0,0]
    @code.map! { |i| (rand(6)+1).to_s }
  end

  def play
    until @@total == 10000
    Game.new.to_code
    end
    result
  end

  def to_code
    @round = 0
    @ai = Ai.new
    until self.won?
      @round == 0 ? @player_guess = @ai.initial_guess : @player_guess = @ai.hack(@output)
      @round += 1
      self.hint
    end
    @@win_round << @round if self.won?
    @@total += 1
  end

  def hint
    @output=[]
    @player_guess.each_with_index do |item, index|
      @code.include?(item) ? @output[index] = @player_guess[index].yellow : @output[index] = @player_guess[index].red
      @output[index] = @player_guess[index].green if @code[index] == item
    end
  end

  def won?
    @code == @player_guess
  end

end
