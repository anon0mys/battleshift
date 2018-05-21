# require 'rails_helper'
# require './app/services/ship_placer'
# require './app/services/values/board'
# require './app/services/values/space'
#
# describe ShipPlacer do
#   let(:board) { Board.new(4) }
#   let(:ship)  { Ship.new(2, 'A1', 'A2') }
#   subject     { ShipPlacer.new(board, ship) }
#
#   it 'exists when provided a board and ship' do
#     expect(subject).to be_a ShipPlacer
#   end
#
#   it 'places the ship within a row with empty spaces' do
#     a1 = board.locate_space('A1')
#     a2 = board.locate_space('A2')
#     a3 = board.locate_space('A3')
#     b1 = board.locate_space('B1')
#
#     expect(a1.contents).to be_nil
#     expect(a2.contents).to be_nil
#     expect(a3.contents).to be_nil
#     expect(b1.contents).to be_nil
#
#     subject.run
#
#     expect(a1.contents).to eq(ship)
#     expect(a2.contents).to eq(ship)
#     expect(a3.contents).to be_nil
#     expect(b1.contents).to be_nil
#   end
#
#   it 'places the ship within a column with empty spaces' do
#     a1 = board.locate_space('A1')
#     b1 = board.locate_space('B1')
#
#     neighbor_1 = board.locate_space('A2')
#     neighbor_2 = board.locate_space('B2')
#
#     expect(a1.contents).to be_nil
#     expect(b1.contents).to be_nil
#     expect(neighbor_1.contents).to be_nil
#     expect(neighbor_2.contents).to be_nil
#
#     ship = Ship.new(2, 'A1', 'B1')
#     subject.run
#
#     expect(a1.contents).to eq(ship)
#     expect(b1.contents).to eq(ship)
#     expect(neighbor_1.contents).to be_nil
#     expect(neighbor_2.contents).to be_nil
#   end
#
#   it 'doesn\'t place the ship if it isn\'t within the same row or column' do
#     ship = Ship.new(2, 'A1', 'B2')
#
#     expect { ShipPlacer.new(board, ship).run }.to raise_error(InvalidShipPlacement)
#   end
#
#   it "doesn't place the ship if the space is occupied when placing in columns" do
#     ship   = Ship.new(2, 'A1', 'B1')
#
#     expect { ShipPlacer.new(board, ship).run }.to raise_error(InvalidShipPlacement)
#   end
#
#   it "doesn't place the ship if the space is occupied when placing in rows" do
#     ship = Ship.new(2, 'A1', 'A2')
#
#     expect { ShipPlacer.new(board, ship).run }.to raise_error(InvalidShipPlacement)
#   end
#
#   it "doesn't place the ship if the ship is smaller than the supplied range in a row" do
#     ship = Ship.new(2, 'A1', 'A3')
#
#     expect { ShipPlacer.new(board, ship).run }.to raise_error(InvalidShipPlacement)
#   end
#
#   it "doesn't place the ship if the ship is smaller than the supplied range in a column" do
#     ship = Ship.new(2, 'A1', 'C1')
#
#     expect { ShipPlacer.new(board, ship).run }.to raise_error(InvalidShipPlacement)
#   end
# end
