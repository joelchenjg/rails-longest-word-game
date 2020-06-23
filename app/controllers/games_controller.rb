require "open-uri"

class GamesController < ApplicationController

    def new
        vowels = %w(A E I O U)
        alpha = ("A".."Z").to_a - vowels
        keys = Array.new(5) { vowels.sample }
        5.times { keys << alpha[rand(alpha.size)] }
        @letters = keys.shuffle!
    end

    def score
        @word = (params[:word] || "").upcase
        @letters = params[:letters].split
        url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
        serialized = open(url).read
        @score = JSON.parse(serialized)
        @english_word = @score["found"]

        @included = @word.split('').all? { |letter| @word.count(letter) <= @letters.count(letter) }
    end

end
