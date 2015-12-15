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
        valid_moves =  board[square.row-1][square.col] if board[square.row-1][square.col] == :e
        valid_moves << board[square.row-2][square.col] if move == 0 #move 2 sq on first move
        valid_moves << board[square.row-1][square.col-1] if board[square.row-1][square.col-1].contains.is_a?(Piece)    #capture left diagnal
        valid_moves << board[square.row-1][square.col+1] if board[square.row-1][square.col+1].contains.is_a?(Piece)   #capture right diagnal
        elsif color == :b
        valid_moves =  board[square.row+1][square.col] if board[square.row+1][square.col] == :e 
        valid_moves << board[square.row+2][square.col] if move == 0
        valid_moves << board[square.row+1][square.col-1] if board[square.row+1][square.col-1].contains.is_a?(Piece)    #capture left diagnal
        valid_moves << board[square.row+1][square.col+1] if board[square.row+1][square.col+1].contains.is_a?(Piece)   #capture right diagnal
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

class Board
    attr_accessor :board 
    def initialize 
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
    end 


    def move(from, to)
        piece = from.contains 
        if piece != :e && piece.valid_moves(@board).include?(to)
            to.contains = piece 
            piece.square = to 
            from.contains = :e 
            piece.move += 1 
            true
        else
            false
        end
    end 

    def display
    d = ""
    letters= "\n        A            B            C            D            E            F            G            H"
    number = 8 
    d << letters 
    line = "\n _________________________________________________________________________________________________________"
    d << line 
    @board.each_index do |row|
        for i in 0..5
            d << "\n"
            if i == 3 
                d << number.to_s 
                number -= 1
            else
                d << " "
            end
            d << "||"
            @board[row].each do |sq|
                if sq.contains == :e 
                    d << sq.display[i]
                else
                    d << sq.contains.display[i]
                end 
                d << "|"
            end
            d << "|"   
            d << (number+1).to_s if i == 3 
        end 
    end 
    d << letters
    puts d 
    end 
end

class Game 
    attr_accessor :bo
    def initialize
    @bo = Board.new
    end

    def key(letter)
        list = ('a'..'h').to_a
        list.find_index(letter)
    end
    def row (row)
        -(row.to_i-8)
    end
    def read_input_start (i)
        bo.board[row(i[1])][key(i[0])]
    end 
    def read_input_finish (i)
        bo.board[row(i[3])][key(i[2])]
    end
    def input (i = gets.chomp)
        bo.move(read_input_start(i),read_input_finish(i))
    end

    def play 
        bo.display 
        loop do
        p input 
        bo.display
        end
    end 
end 
#Game.new.play


