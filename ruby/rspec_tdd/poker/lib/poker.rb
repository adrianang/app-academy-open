require_relative "deck"
require_relative "player"

class Poker
  attr_accessor :deck, :players, :current_player, :pot, :ante
  CARD_RANK = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

  def initialize(num_players)
    @deck = Deck.new
    @players = Array.new(num_players) { Player.new(@deck, self) }
    @current_player = @players.first
    @pot = 1000
    @ante = 10
    @winner = nil
  end

  def play
    @players.each do |player|
      player.hand.populate_roster
    end

    until @winner
      # Betting round
      @players.each_with_index do |player, idx|
        self.render
        puts "What would Player #{ @players.index(@current_player) + 1 } like to do? (fold, see, or raise)"
        player_input = gets.chomp

        if player_input == "fold"
          player.folded = true
        end

        if player_input == "raise"
          puts "How much do you want to ante?"
          new_ante_amount = gets.chomp.to_i
          puts "New ante: #{ new_ante_amount }"
          player.raise(new_ante_amount)
          self.ante = new_ante_amount
          self.pot += new_ante_amount
        end

        if player_input == "see"
          player.see
          self.pot += self.ante
        end

        @current_player = @players[(idx + 1) % @players.length]
      end

      # Potential discarding round
      @players.each_with_index do |player, idx|
        if !player.folded
          self.render
          puts "Which cards would you like to discard? (Type in position(s) of the card(s) in your hand)"
          discard_input = gets.chomp.split(",").map { |index| index.to_i - 1}
          puts "Discarded:"
          discard_input.each do |card_index|
            puts "#{ player.hand.roster[card_index.to_i].suit }, #{ player.hand.roster[card_index.to_i].value }"
          end

          player.discard(discard_input)
          player.hand.populate_roster
        end

        @current_player = @players[(idx + 1) % @players.length]
      end

      # Final action for player
      @players.each_with_index do |player, idx|
        if !player.folded
          self.render
          puts "What would Player #{ @players.index(@current_player) + 1 } like to do? (fold, see, or raise)"
          player_input = gets.chomp

          if player_input == "fold"
            player.folded = true
          end

          if player_input == "raise"
            puts "How much do you want to ante?"
            new_ante_amount = gets.chomp.to_i
            puts "New ante: #{ new_ante_amount }"
            player.raise(new_ante_amount)
            self.ante = new_ante_amount
            self.pot += new_ante_amount
          end

          if player_input == "see"
            player.see
            self.pot += self.ante
          end
        
        # @current_player = @players[(idx + 1) % @players.length]
        end

        @current_player = @players[(idx + 1) % @players.length]
      end

      # End loop
      @winner = true
    end

    puts "Finding the winner:"
    @players.each_with_index do |player, idx|
      player.hand.calculate_roster
      puts "Player #{ idx + 1 }'s final standing"
      final_sorted_hand = player.hand.roster.sort_by { |card| CARD_RANK.index(card.value) }
      puts "Final (sorted by value) hand: #{ final_sorted_hand.map { |card| "#{ card.suit.to_s } #{ card.value }" } }"
      puts player.hand.type
      puts player.hand.hand_ranking

      if player.hand.type == "High Card"
        puts "Highest card: #{ final_sorted_hand.last.suit.to_s } #{ final_sorted_hand.last.value }"
      end
      puts ""
    end

    puts "Winner is P1ayer #{ @players.index(self.best_winner) + 1 }!"
  end

  def render
    puts ""
    puts "=========== POKER ============="
    puts "Current player: #{ @players.index(@current_player) + 1 }"
    puts "Your current pot: #{ @current_player.pot }"
    puts "==============================="
    puts "Amount in Pot: #{ @pot }"
    puts "Current ante amount: #{ @ante }"
    puts "==============================="

    @players.each do |player|
      # if player == @current_player
        puts "Player #{ @players.index(player) + 1 } cards: #{ player.hand.roster.map { |card| "#{ card.suit.to_s } #{ card.value }" } }"
      # else
        # puts "Player #{ @players.index(player) + 1} cards: #{ player.hand.roster.map { |card| "X" } }"
      # end      
    end
  end

  def best_winner
    best_winner = @current_player
    @players.each do |player|
      if player.hand.hand_ranking < best_winner.hand.hand_ranking
        best_winner = player
      end
    end

    best_winner
  end
end