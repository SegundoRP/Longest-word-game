require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    # byebug
    @sugerencia = params[:suggestion]
    @letras = params[:letters]
    @include = include?(@letras, @sugerencia)
    @palabra = english_word?(@sugerencia)
  end

  def english_word?(attempt)
  url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
  user_serialized = URI.open(url).read
  dictionary = JSON.parse(user_serialized)
  return dictionary["found"]
  end

  def include?(grid, attempt)
  attempt.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
  end

end
