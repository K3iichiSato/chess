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
    def straight(board)
        valid_moves = []
        if square.row != 7                         #iterate through columns downwards. add squares if empty or opposing piece 
            for i in (square.row+1)..7           
                s = board[i][square.col]
                if s.contains == :e 
                    valid_moves << s
                elsif s.contains.is_a?(Piece) && s.contains.color != color 
                    valid_moves << s 
                    break
                else
                    break 
                end
            end
        end
        if square.row != 0                         #iterate through columns upwards. add squares if empty or opposing piece 
            for i in (7-(square.row-1))..7    
                i = 7-i                          #iterate towards 0 
                s = board[i][square.col]
                if s.contains == :e 
                    valid_moves << s
                elsif s.contains.is_a?(Piece) && s.contains.color != color 
                    valid_moves << s 
                    break
                else
                    break 
                end
            end
        end
        if square.col != 0                         #iterate through rows to left
            for i in (7-(square.col-1))..7       
                i = 7-i                        #iterate towards 0 
                s = board[square.row][i]
                if s.contains == :e 
                    valid_moves << s
                elsif s.contains.is_a?(Piece) && s.contains.color != color 
                    valid_moves << s 
                    break
                else
                    break 
                end
            end
        end
        if square.col != 7                         #iterate through rows to right
            for i in (square.col+1)..7      
                s = board[square.row][i]
                if s.contains == :e 
                    valid_moves << s
                elsif s.contains.is_a?(Piece) && s.contains.color != color 
                    valid_moves << s 
                    break
                else
                    break 
                end
            end
        end
        valid_moves
    end 
    def diagonal(board)
        valid_moves = [] 
        current_square = square
        while current_square.row > 0 && current_square.col < 7 do         
            current_square = board[current_square.row-1][current_square.col+1]      # top right diagonal  
            if current_square != nil && current_square.contains == :e 
                valid_moves << current_square
            elsif current_square != nil && current_square.contains.is_a?(Piece) && current_square.contains.color != color
                valid_moves << current_square
                break
            else
                break
            end
        end
        current_square = square 
        while current_square.row > 0 && current_square.col > 0 do      
            current_square = board[current_square.row-1][current_square.col-1]      # top left diagonal  
            if current_square != nil && current_square.contains == :e 
                valid_moves << current_square
            elsif current_square != nil && current_square.contains.is_a?(Piece) && current_square.contains.color != color
                valid_moves << current_square
                break
            else
                break
            end
        end
        current_square = square 
        while current_square.row < 7 && current_square.col > 0 do        
            current_square = board[current_square.row+1][current_square.col-1]         # bottom left diagonal  
            if current_square != nil && current_square.contains == :e 
                valid_moves << current_square
            elsif current_square != nil && current_square.contains.is_a?(Piece) && current_square.contains.color != color
                valid_moves << current_square
                break
            else
                break
            end
        end
        current_square = square 
        while current_square.row < 7 && current_square.col < 7 do        
            current_square = board[current_square.row+1][current_square.col+1]         # bottom right diagonal  
            if current_square != nil && current_square.contains == :e 
                valid_moves << current_square
            elsif current_square != nil && current_square.contains.is_a?(Piece) && current_square.contains.color != color
                valid_moves << current_square
                break
            else
                break
            end
        end
        valid_moves
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
            s = board[square.row-1][square.col]
            valid_moves <<  s if s.contains == :e
            s = board[square.row-2][square.col]
            valid_moves << s if move == 0 && s.contains == :e#move 2 sq on first move
            s = board[square.row-1][square.col-1] if square.col > 0
            valid_moves << s if s.contains.is_a?(Piece) && s.contains.color == :b    #capture left diagonal 
            s = board[square.row-1][square.col+1] if square.col < 7
            valid_moves << s if s.contains.is_a?(Piece) && s.contains.color == :b   #capture right diagonal 
        elsif color == :b
            s = board[square.row+1][square.col]
            valid_moves << s if s.contains == :e 
            s = board[square.row+2][square.col] if square.row < 6
            valid_moves << s if move == 0 && s.contains == :e 
            s = board[square.row+1][square.col-1] if square.col > 0 
            valid_moves << s if s.contains.is_a?(Piece) && s.contains.color == :w    #capture left diagonal 
            s = board[square.row+1][square.col+1] if square.col < 7  
            valid_moves << s if s.contains.is_a?(Piece) && s.contains.color == :w   #capture right diagonal 
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
    def valid_moves(board)
        straight(board)
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
    def valid_moves(board)
        valid_moves = []
        possible_moves = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
        possible_moves.each do |diff|
            row = square.row + diff[0]
            next if row < 0 || row > 7
            col = square.col + diff[1]
            next if col < 0 || col > 7 
            s = board[row][col]
            next if s.contains.is_a?(Piece) && s.contains.color == color 
            valid_moves << s
        end
        valid_moves
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
    def valid_moves(board)
        diagonal(board)
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
    def valid_moves(board)
        valid_moves = []
        possible_moves = [[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]]
        possible_moves.each do |diff|
            row = square.row + diff[0]
            next if row < 0 || row > 7
            col = square.col + diff[1]
            next if col < 0 || row > 7 
            s = board[row][col]
            next if s.contains.is_a?(Piece) && s.contains.color == color 
            valid_moves << s
        end
        valid_moves
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
    def valid_moves(board)
        straight(board) + diagonal(board)
    end 
end 

class Board
    attr_accessor :board, :captured_w, :captured_b, :active_w, :active_b, :w_king, :b_king
    def initialize 
    @board = Array.new(8).map!{Array.new(8)}
    @captured_w = []
    @captured_b = []
    @active_w = [] 
    @active_b = []
    @w_king = nil
    @b_king = nil 

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
    end 

    def add_piece(piece)
        piece.square.contains = piece 
        active_w << piece if piece.color == :w 
        active_b << piece if piece.color == :b
        piece 
    end


    def set_board 
    @board[6].each_index do |c|
        add_piece(Pawn.new(:w, @board[6][c]))
    end
    @board[1].each_index do |c|
        add_piece(Pawn.new(:b, @board[1][c])) 
    end

    add_piece(Rook.new(:w, @board[7][0]))
    add_piece(Rook.new(:w, @board[7][7]))

    add_piece(Rook.new(:b, @board[0][0]))
    add_piece(Rook.new(:b, @board[0][7]))

    add_piece(Knight.new(:w, @board[7][1])) 
    add_piece(Knight.new(:w, @board[7][6]))

    add_piece(Knight.new(:b, @board[0][1]))
    add_piece(Knight.new(:b, @board[0][6]))  

    add_piece(Bishop.new(:w, @board[7][2]))
    add_piece(Bishop.new(:w, @board[7][5]))

    add_piece(Bishop.new(:b, @board[0][2]))
    add_piece(Bishop.new(:b, @board[0][5]))

    add_piece(Queen.new(:w, @board[7][3]))
    add_piece(Queen.new(:b, @board[0][3]))

    @w_king = add_piece(King.new(:w, @board[7][4]))
    @b_king = add_piece(King.new(:b, @board[0][4]))
    end
    def check?(king)
        check = attacked?(king.square, king.color) 
    end  


    def attacked?(square, color)
        attacked = false 
        if color == :w 
            active_b.each do |pc|
                attacked = true if pc.valid_moves(board).include?(square)
            end
        elsif color == :b 
            active_w.each do |pc| 
                attacked = true if pc.valid_moves(board).include?(square)
            end
        end
        attacked 
    end
    def capture(square)
        object = square.contains
        if object.is_a?(Piece) && object.color == :w
            captured_w << object 
            active_w.delete(object)
        elsif object.is_a?(Piece) && object.color == :b
            captured_b << object 
            active_b.delete(object)
        end
    end
    def move(from, to)
        piece = from.contains 
        if piece != :e && piece.valid_moves(board).include?(to)
            capture(to)
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
    attr_accessor :bo, :turn
    def initialize
        @bo = Board.new
        @bo.set_board
        @turn = 1
        @color = :w 
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
    def valid_string (i)
        valid = true 
        return valid = false if i.length != 4
        return valid = false if key(i[0]) == nil 
        return valid = false if key(i[2]) == nil 
        return valid = false if !(1..8).include?(i[1].to_i) 
        return valid = false if !(1..8).include?(i[3].to_i) 
        return valid = false if read_input_start(i).contains.is_a?(Piece) && read_input_start(i).contains.color != @color 
        valid
    end
    def input 
        loop do 
            i = gets.chomp
            if valid_string(i) == true 
                valid_response = bo.move(read_input_start(i),read_input_finish(i)) 
            else
                valid_response = false 
            end
            if valid_response == false 
                puts "Invalid Move."
            else 
                break
            end
        end
    end
    def solicit_move
        if @color == :w
            "Enter white move: " 
        else
            "Enter black move: "
        end
    end

    def play 
        bo.display 
        loop do
            if turn % 2 != 0 
                @color = :w 
            else
                @color = :b
            end
            printf solicit_move
            input 
            p bo.check?(bo.w_king)
            p bo.check?(bo.b_king)
            bo.display
            @turn += 1 
        end
    end 
end 
#Game.new.play


