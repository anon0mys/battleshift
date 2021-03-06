require 'rails_helper'
require './app/services/ship_placer'
require './app/services/values/board'
require './app/services/values/space'

describe ShipPlacer do
  let(:board) { build(:board) }

  it 'exists when provided a board and ship' do
    ship = Ship.new(2, 'A1', 'A2')
    ship_placer = ShipPlacer.new(board, ship)

    expect(ship_placer).to be_a ShipPlacer
  end

  it 'places a horizontal ship' do
    a1 = board.locate_space("A1")
    a2 = board.locate_space("A2")
    a3 = board.locate_space("A3")
    b1 = board.locate_space("B1")

    ship = Ship.new(2, 'A1', 'A2')
    ship_placer = ShipPlacer.new(board, ship)

    ship_placer.run

    expect(a1.ship).to eq(ship)
    expect(a2.ship).to eq(ship)
    expect(a3.ship).to be_nil
    expect(b1.ship).to be_nil
  end

  it 'places a vertical ship' do
    a1 = board.locate_space("A1")
    a2 = board.locate_space("A2")
    b1 = board.locate_space("B1")
    b2 = board.locate_space("B2")

    ship = Ship.new(2, 'A1', 'B1')
    ship_placer = ShipPlacer.new(board, ship)

    ship_placer.run

    expect(a1.ship).to eq(ship)
    expect(b1.ship).to eq(ship)
    expect(a2.ship).to be_nil
    expect(b2.ship).to be_nil
  end

  it 'doesn\'t place the ship if it isn\'t within the same row or column' do
    ship = Ship.new(2, 'A1', 'B2')
    ship_placer = ShipPlacer.new(board, ship)

    ship_placer.run

    expect(ship_placer.messages).to include('Ship must be in either the same row or column.')
  end

  it "doesn't place the ship if the space is occupied when placing in columns" do
    ship_1   = Ship.new(2, 'A1', 'B1')
    ship_2   = Ship.new(2, 'A1', 'B1')

    ShipPlacer.new(board, ship_1).run

    ship_placer = ShipPlacer.new(board, ship_2)

    ship_placer.run

    expect(ship_placer.messages).to include('Attempting to place ship in a space that is already occupied.')
  end

  it "doesn't place the ship if the space is occupied when placing in rows" do
    ship_1 = Ship.new(2, 'A1', 'A2')
    ship_2 = Ship.new(2, 'A1', 'A2')

    ShipPlacer.new(board, ship_1).run

    ship_placer = ShipPlacer.new(board, ship_2)

    ship_placer.run

    expect(ship_placer.messages).to include('Attempting to place ship in a space that is already occupied.')
  end

  it "doesn't place the ship if the ship is smaller than the supplied range in a row" do
    ship = Ship.new(2, 'A1', 'A3')
    ship_placer = ShipPlacer.new(board, ship)

    ship_placer.run

    expect(ship_placer.messages).to include('Ship size must be equal to the number of spaces you are trying to fill.')
  end

  it "doesn't place the ship if the ship is smaller than the supplied range in a column" do
    ship = Ship.new(2, 'A1', 'C1')
    ship_placer = ShipPlacer.new(board, ship)

    ship_placer.run

    expect(ship_placer.messages).to include('Ship size must be equal to the number of spaces you are trying to fill.')
  end

  it "doesn't place the ship if the ship is larger than the supplied range in a row" do
    ship = Ship.new(3, 'A1', 'A2')
    ship_placer = ShipPlacer.new(board, ship)

    ship_placer.run

    expect(ship_placer.messages).to include('Ship size must be equal to the number of spaces you are trying to fill.')
  end

  it "doesn't place the ship if the ship is larger than the supplied range in a column" do
    ship = Ship.new(3, 'A1', 'B1')
    ship_placer = ShipPlacer.new(board, ship)

    ship_placer.run

    expect(ship_placer.messages).to include('Ship size must be equal to the number of spaces you are trying to fill.')
  end
end
