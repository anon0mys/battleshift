require 'rails_helper'
require './app/services/ship_placer'
require './app/services/values/board'
require './app/services/values/space'

describe ShipPlacer do
  let(:board) { build(:board) }

  it 'exists when provided a board and ship' do
    ship = build(:ship)
    ship_placer = ShipPlacer.new(board, ship)

    expect(ship_placer).to be_a ShipPlacer
  end

  it 'places a horizontal ship' do
    ship = build(:ship)
    ship_placer = ShipPlacer.new(board, ship)

    ship_placer.run

    expect(a1.ship).to eq(ship)
    expect(a2.ship).to eq(ship)
    expect(a3.ship).to be_nil
    expect(b1.ship).to be_nil
  end

  it 'places the ship within a column with empty spaces' do
    a1 = board.locate_space('A1')
    b1 = board.locate_space('B1')

    neighbor_1 = board.locate_space('A2')
    neighbor_2 = board.locate_space('B2')

    expect(a1.ship).to be_nil
    expect(b1.ship).to be_nil
    expect(neighbor_1.ship).to be_nil
    expect(neighbor_2.ship).to be_nil

    ship = Ship.new(2, 'A1', 'A2')
    subject.run

    expect(a1.ship).to eq(ship)
    expect(b1.ship).to eq(ship)
    expect(neighbor_1.ship).to be_nil
    expect(neighbor_2.ship).to be_nil
  end

  it 'doesn\'t place the ship if it isn\'t within the same row or column' do
    ship = Ship.new(2, 'A1', 'B2')

    expect { ShipPlacer.new(board, ship).run }.to raise_error(InvalidShipPlacement)
  end

  it "doesn't place the ship if the space is occupied when placing in columns" do
    ship   = Ship.new(2, 'A1', 'B1')

    expect { ShipPlacer.new(board, ship).run }.to raise_error(InvalidShipPlacement)
  end

  it "doesn't place the ship if the space is occupied when placing in rows" do
    ship = Ship.new(2, 'A1', 'A2')

    expect { ShipPlacer.new(board, ship).run }.to raise_error(InvalidShipPlacement)
  end

  it "doesn't place the ship if the ship is smaller than the supplied range in a row" do
    ship = Ship.new(2, 'A1', 'A3')

    expect { ShipPlacer.new(board, ship).run }.to raise_error(InvalidShipPlacement)
  end

  it "doesn't place the ship if the ship is smaller than the supplied range in a column" do
    ship = Ship.new(2, 'A1', 'C1')

    expect { ShipPlacer.new(board, ship).run }.to raise_error(InvalidShipPlacement)
  end
end
