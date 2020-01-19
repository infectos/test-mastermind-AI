
class Ai
  attr_reader :initial_guess
  def initialize
   @initial_guess=["1","1","2","2"]
   @possible_digits=['1','2','3','4','5','6']
   @avalible_guesses = [@possible_digits, @possible_digits, @possible_digits, @possible_digits]
  end

  def hack(array)
    @right_digits = []
    @yellow_digits = []
    output = @initial_guess
    
    #saves wrong and right digits
    array.each_with_index do |item, index|
      
      if item[/31/]# red
        @avalible_guesses.each_with_index do |a, i|
          @avalible_guesses[i] -= [item[/(?<=m)./]] if a.is_a?(Array)
        end

      end
      
      
      if item[/32/]# green
        @right_digits << item[/(?<=m)./]
        @avalible_guesses[index] = item[/(?<=m)./]
      end

      if item[/33/] # yellow
        @yellow_digits << item[/(?<=m)./]
        @avalible_guesses[index] = @avalible_guesses[index] - [item[/(?<=m)./]]
      end

    end

    checked_digits=[]

    @avalible_guesses.each_with_index do |item, index|
      output[index] = item if item.is_a?(String)

      if item.is_a?(Array)
        maybe_digits = @yellow_digits & item
        maybe_digits -= checked_digits
        maybe_digits = item - @right_digits - checked_digits if maybe_digits.length == 0
        maybe_digits = item if maybe_digits.length == 0
        output[index] = maybe_digits[rand(maybe_digits.length)]
        checked_digits<<output[index]
      end

    end
    
    output
  end
end
