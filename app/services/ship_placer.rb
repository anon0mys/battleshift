class ShipPlacer
  attr_reader :board, :ship, :message

  def initialize(board, ship)
    @board    = board
    @ship     = ship
    @messages = []
  end

  def run
    if same_row?
      place_in_row
    elsif same_column?
      place_in_column
    else
      raise InvalidShipPlacement.new("Ship must be in either the same row or column.")
    end
  end

  def message
    @messages.join(' ')
  end

  private

  def same_row?
    ship.start_space[0] == ship.end_space[0]
  end

  def same_column?
    ship.start_space[1] == ship.end_space[1]
  end

  def place_in_row
    begin
      row = ship.start_space[0]
      range = ship.start_space[1]..ship.end_space[1]
      msg = "Ship size must be equal to the number of spaces you are trying to fill."
      raise InvalidShipPlacement unless range.count == ship.length
      range.map { |column| place_ship(row, column) }
    rescue InvalidShipPlacement => e
      @messages << e.message
    end
  end

  def place_in_column
    column = ship.start_space[1]
    range  = ship.start_space[0]..ship.end_space[0]
    raise InvalidShipPlacement unless range.count == ship.length
    range.map { |row| place_ship(row, column) }
  end

  def place_ship(row, column)
    coordinates = "#{row}#{column}"
    space = board.locate_space(coordinates)
    if space.occupied?
      raise InvalidShipPlacement.new("Attempting to place ship in a space that is already occupied.")
    else
      space.occupy!(ship)
    end
    ship_objs = []
    board.board.map do |row|
      row.map do |space|
        ship_objs << space[space.keys.first].ship
      end
    end
    if ship_objs.uniq.length == 2
      @messages << 'Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.'
    else
      @messages << 'Successfully placed ship with a size of 2. You have 0 ship(s) to place.'
    end
  end
end

class InvalidShipPlacement < StandardError
  def initialize(msg = "Invalid ship placement")
    super
  end
end
