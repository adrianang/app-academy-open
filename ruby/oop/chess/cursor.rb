require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board, :selected
  attr_accessor :selected_piece_pos

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
    @selected_piece_pos = nil
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  def toggle_selected
    @selected = !@selected

    @selected_piece_pos = @cursor_pos if @selected
    @selected_piece_pos = [] if !@selected
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    self.board.error_msg = nil

    case key
    when :return, :space
      if !self.board[@cursor_pos].is_a?(NullPiece) && !@selected
        self.toggle_selected
      elsif @selected
        self.board.move_piece(@selected_piece_pos, @cursor_pos)
        self.toggle_selected
      elsif (@selected_piece_pos == @cursor_pos) && selected
        self.toggle_selected
      end

      return @cursor_pos
    when :left, :right, :up, :down
      update_pos(key)
      return nil
    when :ctrl_c
      exit
    end
  end

  def update_pos(diff)
    new_pos = [self.cursor_pos[0] + MOVES[diff][0], self.cursor_pos[1] + MOVES[diff][1]]
    @cursor_pos = new_pos if (0...8).include?(new_pos[0]) && (0...8).include?(new_pos[1])
  end
end