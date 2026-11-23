require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split

    @valid_letters = @word.present? && @word.chars.all? do |letter|
      @word.chars.count(letter) <= @letters.count(letter)
    end

    if @valid_letters
      url = "https://dictionary.lewagon.com/#{@word.downcase}"
      response = URI.open(url).read
      result = JSON.parse(response)

      if result["found"]
        @message = "Congratulations! #{@word} is a valid English word!"
      else
        @message = "Sorry, #{@word} is not a valid English word!"
      end
    else
      @message = "Sorry, #{@word} can't be built out of the grid!"
    end
  end
end
