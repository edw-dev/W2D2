class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses
  def self.random_word
        DICTIONARY.sample
  end
  def initialize
    
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length,"_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end
  def already_attempted?(char)
    @attempted_chars.include?(char)
  end
  def get_matching_indices(passed_char)
    arr = []
    @secret_word.each_char.with_index {|char, i| arr << i if char == passed_char}
    arr
  end
  def fill_indices(char, arr)
    arr.each {|idx| @guess_word[idx]=char}
  end
  def try_guess(char)
    if self.already_attempted?(char)
      print "that has already been attempted"
      false
    elsif !self.get_matching_indices(char).empty?
      @attempted_chars << char
      self.fill_indices(char, self.get_matching_indices(char))
      return true
    else
      @attempted_chars << char
      @remaining_incorrect_guesses -= 1
      return true
    end
  end
  def ask_user_for_guess
    print "Enter a char:"
    self.try_guess(gets.chomp)
  end
  def win?
    print "WIN" if @guess_word.join("") == @secret_word
    @guess_word.join("") == @secret_word
  end
  def lose?
    print "LOSE" if @remaining_incorrect_guesses == 0
    @remaining_incorrect_guesses == 0
  end
  def game_over?
    print @secret_word if self.win? || self.lose?
    return true if self.win? || self.lose?
    return false
  end

end
