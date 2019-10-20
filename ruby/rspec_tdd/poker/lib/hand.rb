# require_relative "card"
require_relative "deck"

class Hand
  attr_accessor :roster, :type, :deck
  CARD_RANK = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
  HAND_RANK = [
      "Royal Flush",
      "Straight Flush",
      "Four of a Kind",
      "Full House",
      "Flush",
      "Straight",
      "Three of a Kind",
      "Two Pair",
      "Pair",
      "High Card"
    ] 

  def initialize(deck)
    @roster = []
    @type = nil
    @deck = deck
  end

  def populate_roster
    until @roster.length == 5
      @roster << @deck.stack.pop
    end
  end

  def calculate_roster
    suits = []
    ranks = []
    @roster.each do |card|
      suits << card.suit if !suits.include?(card.suit)
      ranks << CARD_RANK.index(card.value)
    end

    sorted_ranks = ranks.sort
    sorted_ranks_diff = sorted_ranks.map { |rank| rank - sorted_ranks.first } 
    sorted_ranks_counter = Hash.new(0)
    sorted_ranks.each do |rank|
      sorted_ranks_counter[rank] += 1
    end

    case
      when (suits.count == 1) && (sorted_ranks == [8, 9, 10, 11, 12])
        @type = "Royal Flush"
      when (suits.count == 1) && (sorted_ranks != [8, 9, 10, 11, 12]) && (sorted_ranks_diff == [0, 1, 2, 3, 4])
        @type = "Straight Flush"
      when (sorted_ranks_diff[1..-1].count(sorted_ranks_diff[1..-1][0]) == 4)
        @type = "Four of a Kind"
      when (sorted_ranks_counter.values.sort == [2, 3])
        @type = "Full House"
      when (suits.count == 1)
        @type = "Flush"
      when (sorted_ranks_diff == [0, 1, 2, 3, 4])
        @type = "Straight"
      when (sorted_ranks_counter.values.sort.last == 3)
        @type = "Three of a Kind"
      when (sorted_ranks_counter.values[1..-1] == [2, 2])
        @type = "Two Pair"
      when (sorted_ranks_counter.values[1..-1].last == 2)
        @type = "Pair"
      else
        @type = "High Card"
    end
  end

  def hand_ranking
    if @type
      return HAND_RANK.index(@type)
    end

    nil
  end
end