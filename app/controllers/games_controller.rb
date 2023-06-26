require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (1..10).map{ ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split(' ')
    # raise
    if valid?(@word, @letters) == false
      @result = "Sorry but <strong>#{@word}</strong> can't be built out of #{@letters.join(', ')}"
    elsif english?(@word) == true
      @result = "<strong>Congratulations!</strong> #{@word} is a valid English word!"
    else
      @result = "Sorry but <strong>#{@word}</strong> does not seem to be a valid English word..."
    end
  end

  def valid?(word, letters)
    word.chars.all? { |letter| word.chars.count(letter) <= letters.count(letter) }
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    word_data = JSON.parse(word_serialized)
    word_data["found"]
  end
end
