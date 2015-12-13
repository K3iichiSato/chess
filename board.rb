class Square
    attr_accessor :color, :row, :col, :contains 
    def initialize(color, row, col, contains = :e) 
        @color = color
        @row = row
        @col = col 
        @contains = contains 
    end
    def display
        if color == :w
            ["            ","            ","            ","            ","            ","____________"]
        elsif color == :b 
            ["############","############","############","############","############","############"]
        end
    end
end

class Piece
        attr_accessor :color, :square, :move  
    def initialize(color, square)
        @color = color 
        @square = square 
        @move = 0
    end
end

class Pawn < Piece 
    def display 
        if square.color == :w
            if color == :w
                ["            ","            ","     ()     ","     )(     ","    (__)    ","____________"]
            elsif color == :b 
                ["            ","            ","     ()     ","     )(     ","    (##)    ","____________"]
            end
        elsif square.color == :b
            if color == :w
                ["############","############","#### () ####","#### )( ####","### (__) ###","############"]
            elsif color == :b 
                ["############","############","#### () ####","#### )( ####","### (##) ###","############"]
            end
        end
    end
    def valid_moves(board)

        valid_moves = []
        if color == :w 
        valid_moves = [board[square.row-1][square.col],board[square.row-2][square.col]] 
        elsif color == :b
        valid_moves = [board[square.row+1][square.col],board[square.row+2][square.col]]
        end
        valid_moves
    end 

end 
class Rook < Piece 
    def display 
        if square.color == :w
            if color == :w
                ["            ","    _ _ _   ","   [____]   ","    ]__[    ","   [____]   ","____________"]
            elsif color == :b 
                ["            ","    _ _ _   ","   [####]   ","    ]##[    ","   [####]   ","____________"]
            end
        elsif square.color == :b
            if color == :w
                ["############","####_ _ _###","## [____] ##","### ]__[ ###","## [____] ##","############"]
            elsif color == :b 
                ["############","####_ _ _###","## [####] ##","### ]##[ ###","## [####] ##","############"]
            end
        end
    end
end 
class Knight < Piece 
    def display 
        if square.color == :w
            if color == :w
                ["            ","     ___    ","   <(@__]   ","    )_)     ","   (___)    ","____________"]
            elsif color == :b 
                ["            ","     ___    ","   <(@##]   ","    )#)     ","   (###)    ","____________"]
            end
        elsif square.color == :b
            if color == :w
                ["############","#####___####","## <(@__] ##","### )_) ####","## (___) ###","############"]
            elsif color == :b 
                ["############","#####___####","## <(@##] ##","### )#) ####","## (###) ###","############"]
            end
        end
    end
end 
class Bishop < Piece 
    def display 
        if square.color == :w
            if color == :w
                ["            ","     {}     ","     <>     ","     )(     ","    (__)    ","____________"]
            elsif color == :b 
                ["            ","     {}     ","     <>     ","     )(     ","    (##)    ","____________"]
            end
        elsif square.color == :b
            if color == :w
                ["############","#### {} ####","#### <> ####","#### )( ####","### (__) ###","############"]
            elsif color == :b 
                ["############","#### {} ####","#### <> ####","#### )( ####","### (##) ###","############"]
            end
        end
    end
end 
class King < Piece 
    def display 
        if square.color == :w
            if color == :w
                ["    _+_     ","    \\_/     ","    < >     ","    } {     ","    )_(     ","___{___}____"]
            elsif color == :b 
                ["    _+_     ","    \\#/     ","    <#>     ","    }#\{     ","    )#(     ","___{###}____"]
            end
        elsif square.color == :b
            if color == :w
                ["### _+_ ####","### \\_/ ####","### < > ####","### } { ####","### )_( ####","## {___} ###"]
            elsif color == :b 
                ["### _+_ ####","### \\#/ ####","### <#> ####","### }#\{ ####","### )#( ####","## {###} ###"] 
            end
        end
    end
end 
class Queen < Piece 
    def display 
        if square.color == :w
            if color == :w
                ["    oooo    ","    \\__/    ","     )(     ","     )(     ","   {____}   ","____________"]
            elsif color == :b 
                ["    oooo    ","    \\##/    ","     )(     ","     )(     ","   {####}   ","____________"]
            end
        elsif square.color == :b
            if color == :w
                ["### oooo ###","### \\__/ ###","#### )( ####","#### )( ####","## {____} ##","############"]
            elsif color == :b 
                ["### oooo ###","### \\##/ ###","#### )( ####","#### )( ####","## {####} ##","############"]
            end
        end
    end
end 

@board = Array.new(8).map!{Array.new(8)}

#every other row
@board.each_index do |row| 
    if row % 2 == 0 
        @board[row].each_index do |col|
            if col % 2 == 0 
                @board[row][col] = Square.new(:w, row, col)
            else
                @board[row][col] = Square.new(:b, row, col)
            end
        end
    else 
        @board[row].each_index do |col|
            if col % 2 == 0 
                @board[row][col] = Square.new(:b, row, col)
            else
                @board[row][col] = Square.new(:w, row, col)
            end
        end       
    end 
end



 
@board[6].each_index do |c|
    @board[6][c].contains = Pawn.new(:w, @board[6][c])
end
@board[1].each_index do |c|
    @board[1][c].contains = Pawn.new(:b, @board[1][c]) 
end

@board[7][0].contains = Rook.new(:w, @board[7][0])
@board[7][7].contains = Rook.new(:w, @board[7][7])

@board[0][0].contains = Rook.new(:b, @board[0][0])
@board[0][7].contains = Rook.new(:b, @board[0][7])

@board[7][1].contains = Knight.new(:w, @board[7][1]) 
@board[7][6].contains = Knight.new(:w, @board[7][6]) 

@board[0][1].contains = Knight.new(:b, @board[0][1])  
@board[0][6].contains = Knight.new(:b, @board[0][6])  

@board[7][2].contains = Bishop.new(:w, @board[7][2]) 
@board[7][5].contains = Bishop.new(:w, @board[7][5]) 

@board[0][2].contains = Bishop.new(:b, @board[0][2]) 
@board[0][5].contains = Bishop.new(:b, @board[0][5])  

@board[7][3].contains = Queen.new(:w, @board[7][3])
@board[0][3].contains = Queen.new(:b, @board[0][3])

@board[7][4].contains = King.new(:w, @board[7][4])
@board[0][4].contains = King.new(:b, @board[0][4])


def valid_square(square)
    v_sq = []
    square.contains.valid_moves.each do |r|
        v_sq << @board[r[0]][r[1]]
    end 
    v_sq
end


def move(from, to)
    piece = from.contains 
    if piece != :e && piece.valid_moves(@board).include?(to)
        to.contains = piece 
        piece.square = to 
        from.contains = :e 
        true
    else
        false
    end
end 

def display
d = ""
line = " _________________________________________________________________________________________________________"
d << line 
@board.each_index do |row|
    for i in 0..5
        d << "\n||"
        @board[row].each do |sq|
            if sq.contains == :e 
                d << sq.display[i]
            else
                d << sq.contains.display[i]
            end 
            d << "|"
        end
        d << "|"   
    end 
end 
puts d 
end 

display 
gets.chomp
move(@board[6][4],@board[4][4])
display 
=begin
gets.chomp

move(@board[6][4],@board[5][4])
display

=end 

