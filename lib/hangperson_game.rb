class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  
  # def guess function
  
  def guess(guess_char)
    # since case in insensitive
    if guess_char == ''
      raise ArgumentError, "Invalid Input. Cannot be empty string.
      Please enter a letter"
    end
    if guess_char == 'nil'
      raise ArgumentError, "Invalid Input. Cannot be nil.
      Please enter a letter"
    end
    if !((guess_char =~ /[a-z]/) or (guess_char =~ /[A-Z]/))
      raise ArgumentError, "Invalid Input. Please enter a letter"
    end
    
    guess_char = guess_char.downcase
    
    #if the guess is in the word 
    if @word.include?(guess_char)
      #  if the guess_char NOT in the guess string
      if !@guesses.include?(guess_char)
        @guesses += guess_char
      else
        # already guess, will return false
        return false
      end
    # guess wrong char, and not in the wrong_guesses, add to wrong_guesse 
    else
      if !@wrong_guesses.include?(guess_char)
        @wrong_guesses += guess_char
      else
        # already make the same wrong guess char before
        return false
      end
    end
  end



  def word_with_guesses
    word_length = @word.length
    guess_length = @guesses.length
    displayed = '-' * word_length
    for guess_inedx in (0..(guess_length -1)) do
      for word_inedx in (0..(word_length -1)) do
        if @word[word_inedx] == @guesses[guess_inedx]
          displayed[word_inedx] = @word[word_inedx]
        end
      end
    end
    return displayed
  end

# def word_with_guesses
#     word_len = @word.length
#     rtn_str = "-" * word_len
#     @guesses.each_char do |word_char|
#       (0..word_len-1).each do |index|
#         if @word[index] == word_char
#           rtn_str[index] = word_char
#         end
#       end
#     end
#     return rtn_str
#   end
  
  
  def check_win_or_lose
    if !word_with_guesses.include?('-')
      return :win
    end
    if @wrong_guesses.length >= 7
      return :lose
    end
    return :play
  end
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
