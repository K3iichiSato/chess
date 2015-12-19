require 'spec_helper'

describe Game do 
	before :each do 
		@a = Game.new 
	end 

	context '#row' do
		it 'translates row number to array index' do 
		expect(@a.row(1)).to eql 7
		expect(@a.row(2)).to eql 6
		expect(@a.row(8)).to eql 0
		end
	end 
	context '#key' do
		it 'translates letter to array index' do 
		expect(@a.key('a')).to eql 0
		expect(@a.key('e')).to eql 4
		expect(@a.key('h')).to eql 7
		end
	end 
	context '#read_input_start' do 
		it 'takes first 2 characters of input, translates to array square' do 
			expect(@a.read_input_start('a4a5')).to eql @a.bo.board[4][0]
			expect(@a.read_input_start('d1')).to eql @a.bo.board[7][3]
			expect(@a.read_input_start('h2')).to eql @a.bo.board[6][7]
		end
	end 
	context '#read_input_finish' do 
		it 'takes last 2 characters of input, translates to array square' do 
			expect(@a.read_input_finish('a4a5')).to eql @a.bo.board[3][0]
		end
	end  
	context 'Pawn#valid_moves' do 
		it 'has valid moves' do 
			pawn = @a.bo.board[6][0].contains
			expect(pawn).to be_a(Pawn)
			valid = pawn.valid_moves(@a.bo.board)
			expect(valid).to eql([@a.bo.board[5][0], @a.bo.board[4][0]])
		end
		it 'has square' do 
			expect(@a.bo.board[6][0].contains.square).to eql(@a.bo.board[6][0])
		end 
		it 'can find out if square contains :e' do 
			board = @a.bo.board
			pawn = @a.bo.board[6][0].contains
			square = pawn.square 
			expect(board[square.row-1][square.col].contains).to eql :e
		end

	end
	context '#valid_string' do 
		it 'returns true for a2a4' do 
			expect(@a.valid_string('a2a4')).to eql true 
		end
	end 
end 
describe Board do 
	before :each do 
		@bo = Board.new
		@bo.set_board
	end
	context '#move' do 
		it 'can move left pawn' do 
			pawn = @bo.board[6][0].contains 
			expect(pawn).to be_a(Pawn)
			@bo.move(@bo.board[6][0],@bo.board[4][0])
			expect(@bo.board[6][0].contains).to eql :e 
			expect(@bo.board[4][0].contains).to eql pawn
		end
		it 'can move right pawn' do 
			pawn = @bo.board[6][7].contains
			@bo.move(@bo.board[6][7],@bo.board[4][7])
			expect(@bo.board[6][7].contains).to eql :e 
			expect(@bo.board[4][7].contains).to eql pawn 
		end		

		it 'can move pawn twice' do 
			pawn = @bo.board[6][0].contains
			@bo.move(@bo.board[6][0],@bo.board[4][0])
			@bo.move(@bo.board[4][0],@bo.board[3][0])
			expect(@bo.board[3][0].contains).to eql pawn
		end
		it 'can move black pawn to end' do 
			board = @bo.board
			@bo.move(board[1][4],board[3][4])
			@bo.move(board[3][4],board[4][4])
			@bo.move(board[4][4],board[5][4])
			@bo.move(board[5][4],board[6][3])
			@bo.move(board[6][3],board[7][4])
			expect(board[7][4].contains).to be_a(Pawn)
		end
	end 
	context '#capture' do 
		it 'appends captured array with piece' do 
			square = @bo.board[6][0]
			@bo.capture(square)
			expect(@bo.captured_w).to eql [square.contains]
		end
	end 
end 
describe Rook do 
	context '#valid_moves' do 
		it 'returns column and row of empty squares' do
			@bo = Board.new 
			rook = Rook.new(:w, @bo.board[7][0])
			@bo.board[7][0].contains = rook
			expect(rook.valid_moves(@bo.board)).to eql [@bo.board[6][0],@bo.board[5][0],@bo.board[4][0],@bo.board[3][0],@bo.board[2][0],@bo.board[1][0],@bo.board[0][0],@bo.board[7][1],@bo.board[7][2],@bo.board[7][3],@bo.board[7][4],@bo.board[7][5],@bo.board[7][6],@bo.board[7][7]]
		end
	end 
end
describe Bishop do 
	before :each do 
		@bo = Board.new 
	end 
	context '#valid_moves' do 
		it 'returns diagonal squares' do
			bishop = Bishop.new(:w, @bo.board[7][0])
			@bo.board[7][0].contains = bishop 
			expect(bishop.valid_moves(@bo.board)).to eql [@bo.board[6][1],@bo.board[5][2],@bo.board[4][3],@bo.board[3][4],@bo.board[2][5],@bo.board[1][6],@bo.board[0][7]]
		end
		it 'only returns empty squares if blocked by same color piece' do 
			bishop = Bishop.new(:w, @bo.board[7][0])
			@bo.board[7][0].contains = bishop 
			@bo.board[4][3].contains = Pawn.new(:w, @bo.board[4][3])
			expect(bishop.valid_moves(@bo.board)).to eql [@bo.board[6][1],@bo.board[5][2]]
		end 
		it 'only returns empty squares if blocked by same color piece' do 
			bishop = Bishop.new(:w, @bo.board[7][0])
			@bo.board[7][0].contains = bishop 
			@bo.board[4][3].contains = Pawn.new(:b, @bo.board[4][3])
			expect(bishop.valid_moves(@bo.board)).to eql [@bo.board[6][1],@bo.board[5][2],@bo.board[4][3]]
		end 
		it 'returns diagonal squares' do
			bishop = Bishop.new(:w, @bo.board[0][7])
			@bo.board[0][7].contains = bishop 
			expect(bishop.valid_moves(@bo.board)).to eql [@bo.board[1][6],@bo.board[2][5],@bo.board[3][4],@bo.board[4][3],@bo.board[5][2],@bo.board[6][1],@bo.board[7][0]]
		end
		it 'returns diagonal squares' do
			bishop = Bishop.new(:w, @bo.board[0][0])
			@bo.board[0][0].contains = bishop 
			expect(bishop.valid_moves(@bo.board)).to eql [@bo.board[1][1],@bo.board[2][2],@bo.board[3][3],@bo.board[4][4],@bo.board[5][5],@bo.board[6][6],@bo.board[7][7]]
		end
		it 'returns left diagonal squares' do
			bishop = Bishop.new(:w, @bo.board[7][7])
			@bo.board[7][7].contains = bishop 
			expect(bishop.valid_moves(@bo.board)).to eql [@bo.board[6][6],@bo.board[5][5],@bo.board[4][4],@bo.board[3][3],@bo.board[2][2],@bo.board[1][1],@bo.board[0][0]]
		end
		it 'returns diagonal squares' do
			bishop = Bishop.new(:w, @bo.board[7][5])
			@bo.board[7][5].contains = bishop 
			expect(bishop.valid_moves(@bo.board)).to eql [@bo.board[6][6],@bo.board[5][7],@bo.board[6][4],@bo.board[5][3],@bo.board[4][2],@bo.board[3][1],@bo.board[2][0]]
		end
	end 
end 
describe Queen do 
	before :each do 
		@bo = Board.new 
	end 
	it 'returns proper squares' do 
		queen = Queen.new(:w, @bo.board[7][0])
		@bo.board[7][0].contains = queen 
		expect(queen.valid_moves(@bo.board)).to eql [@bo.board[6][0],@bo.board[5][0],@bo.board[4][0],@bo.board[3][0],@bo.board[2][0],@bo.board[1][0],@bo.board[0][0],@bo.board[7][1],@bo.board[7][2],@bo.board[7][3],@bo.board[7][4],@bo.board[7][5],@bo.board[7][6],@bo.board[7][7],@bo.board[6][1],@bo.board[5][2],@bo.board[4][3],@bo.board[3][4],@bo.board[2][5],@bo.board[1][6],@bo.board[0][7]]
	end 
end 








