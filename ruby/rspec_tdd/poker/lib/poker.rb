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

  def inspect
    { 'pot' => @pot, 'ante' => @ante, 'players' => @players }.inspect
  end

  def play
    @players.each { |player| player.hand.populate_roster }

    until @winner
      self.betting_round
      self.discarding_round
      self.betting_round
      @winner = true #End loop
    end

    system "clear"
    puts "Finding the winner:"
    self.find_winner
    self.final_pot_total
    true
  end

  def betting_round
    valid_actions = ["fold", "see", "raise"]

    @players.each_with_index do |player, idx|
      system "clear"
      if !player.folded
        self.render
        puts "What would Player #{ @players.index(@current_player) + 1 } like to do? (fold, see, or raise)"
        player_input = gets.chomp

        until valid_actions.include?(player_input)
          puts "Not a valid action; try again!"
          puts "What would Player #{ @players.index(@current_player) + 1 } like to do? (fold, see, or raise)"
          player_input = gets.chomp
        end

        if player_input == "fold"
          player.fold
        elsif player_input == "raise"
          puts "How much do you want to ante?"
          new_ante_amount = gets.chomp.to_i
          player.raise(new_ante_amount)
          puts "New ante: #{ new_ante_amount }"
          self.ante = new_ante_amount
          self.pot += new_ante_amount
        elsif player_input == "see"
          player.see
          self.pot += self.ante
        end        
      end

      @current_player = @players[(idx + 1) % @players.length]
    end
  end

  def discarding_round
    valid_positions = ["1", "2", "3", "4", "5"]

    @players.each_with_index do |player, idx|
      system "clear"
      if !player.folded
        self.render
        puts "Which cards would you like to discard? (Type in position(s) of the card(s) in your hand)"
        discard_input = gets.chomp.split("").select { |char| valid_positions.include?(char) }.map { |index| index.to_i - 1}

        until discard_input.length < 4
          puts "Not valid input; try again!"
          puts "Which cards would you like to discard? (Type in position(s) of the card(s) in your hand)"
          discard_input = gets.chomp.split("").select { |char| valid_positions.include?(char) }.map { |index| index.to_i - 1}
        end

        puts "Discarded:"
        if discard_input.empty?
          puts "N/A"
        else
          discard_input.each { |card_index| puts "#{ player.hand.roster[card_index.to_i].suit }, #{ player.hand.roster[card_index.to_i].value }" }
        end

        sleep(2.5)
        player.discard(discard_input)
        player.hand.populate_roster
      end

      @current_player = @players[(idx + 1) % @players.length]
    end
  end

  def find_winner
    best_winner = @players.first

    @players.each_with_index do |player, idx|
      player.hand.calculate_roster
      puts "Player #{ idx + 1 }'s final standing"

      if !player.folded
        final_sorted_hand = player.hand.roster.sort_by! { |card| CARD_RANK.index(card.value) }
        puts "Final hand, sorted by value: #{ final_sorted_hand.map { |card| "#{ card.suit.to_s } #{ card.value }" } }"
        puts "#{ player.hand.type } (Rank #{ player.hand.hand_ranking})"

        if player.hand.type == "High Card"
          puts "Highest card: #{ final_sorted_hand.last.suit.to_s } #{ final_sorted_hand.last.value }"
        end
        puts ""

        if player.hand.hand_ranking < best_winner.hand.hand_ranking
          best_winner = player
        elsif player.hand.hand_ranking == best_winner.hand.hand_ranking
          if CARD_RANK.index(final_sorted_hand.last.value) > CARD_RANK.index(best_winner.hand.roster.last.value)
            best_winner = player
          end
        end
      else
        puts "Player folded"
        puts ""
      end
    end

    puts "Winner is P1ayer #{ @players.index(best_winner) + 1 }!"

    if !@players[@players.index(best_winner)].folded
      @players[@players.index(best_winner)].pot += self.pot
      self.pot = 0
    end
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
      if player == @current_player
        puts "Player #{ @players.index(player) + 1 } cards: #{ player.hand.roster.map { |card| "#{ card.suit.to_s } #{ card.value }" } }"
      else
        puts "Player #{ @players.index(player) + 1} cards: #{ player.hand.roster.map { |card| "X" } }"
      end      
    end

    puts "==============================="
  end

  def final_pot_total
    puts "Final pot for players after this round:"
    @players.each { |player| puts "Player #{ @players.index(player) + 1 }: #{ player.pot }" }
  end
end