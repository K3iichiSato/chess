class Square
    attr_accessor :color, :row, :col, :contains 
    def initialize(color, row, col, contains = :e) 
        @color = color
        @row = row
        @col = col 
        @contains = contains 
    end
end

board = Array.new(8).map!{Array.new(8)}

#every other row
board.each_index do |row| 
    if row % 2 == 0 
        board[row].each_index do |col|
            if col % 2 == 0 
                board[row][col] = Square.new(:w, row, col)
            else
                board[row][col] = Square.new(:b, row, col)
            end
        end
    else 
        board[row].each_index do |col|
            if col % 2 == 0 
                board[row][col] = Square.new(:b, row, col)
            else
                board[row][col] = Square.new(:w, row, col)
            end
        end       
    end 
end

# make row of white pawns 
board[6].each_index do |c|
    board[6][c].contains = :wp 
end

# place white rooks
board[7][0].contains = :wr
board[7][7].contains = :wr

#place white knights
board[7][1].contains = :wn 
board[7][6].contains = :wn 

#place white bishops
board[7][2].contains = :wb
board[7][5].contains = :wb 

#place white queen
board[7][3].contains = :wq 

#place white king 
board[7][4].contains = :wk


# make row of black pawns 
board[1].each_index do |c|
    board[1][c].contains = :bp 
end
# place black rooks
board[0][0].contains = :br
board[0][7].contains = :br

#place black knights
board[0][1].contains = :bn 
board[0][6].contains = :bn 

#place black bishops
board[0][2].contains = :bb
board[0][5].contains = :bb 

#place black queen
board[0][3].contains = :bq 

#place black king 
board[0][4].contains = :bk

p board 


white_square = ["            ","            ","            ","            ","            ","____________"]
         wwp = ["            ","            ","     ()     ","     )(     ","    (__)    ","____________"]
         wwr = ["            ","    _ _ _   ","   [____]   ","    ]__[    ","   [____]   ","____________"]
         wwn = ["            ","     ___    ","   <(@__]   ","    )_)     ","   (___)    ","____________"]
         wwb = ["            ","     {}     ","     <>     ","     )(     ","    (__)    ","____________"]
         wwq = ["    oooo    ","    \\__/    ","     )(     ","     )(     ","   {____}   ","____________"]
         wwk = ["    _+_     ","    \\_/     ","    < >     ","    } {     ","    )_(     ","___{___}____"]

         wbp = ["            ","            ","     ()     ","     )(     ","    (##)    ","____________"]
         wbr = ["            ","    _ _ _   ","   [####]   ","    ]##[    ","   [####]   ","____________"]
         wbn = ["            ","     ___    ","   <(@##]   ","    )#)     ","   (###)    ","____________"]
         wbb = ["            ","     {}     ","     <>     ","     )(     ","    (##)    ","____________"]
         wbq = ["    oooo    ","    \\##/    ","     )(     ","     )(     ","   {####}   ","____________"]
         wbk = ["    _+_     ","    \\#/     ","    <#>     ","    }#\{     ","    )#(     ","___{###}____"]









black_square = ["############","############","############","############","############","############"]
         bwp = ["############","############","#### () ####","#### )( ####","### (__) ###","############"]
         bwr = ["############","####_ _ _###","## [____] ##","### ]__[ ###","## [____] ##","############"]
         bwn = ["############","#####___####","## <(@__] ##","### )_) ####","## (___) ###","############"]
         bwb = ["############","#### {} ####","#### <> ####","#### )( ####","### (__) ###","############"]
         bwq = ["### oooo ###","### \\__/ ###","#### )( ####","#### )( ####","## {____} ##","############"]
         bwk = ["### _+_ ####","### \\_/ ####","### < > ####","### } { ####","### )_( ####","## {___} ###"]
         
         bbp = ["############","############","#### () ####","#### )( ####","### (##) ###","############"]
         bbr = ["############","####_ _ _###","## [####] ##","### ]##[ ###","## [####] ##","############"]
         bbn = ["############","#####___####","## <(@##] ##","### )#) ####","## (###) ###","############"]
         bbb = ["############","#### {} ####","#### <> ####","#### )( ####","### (##) ###","############"]
         bbq = ["### oooo ###","### \\##/ ###","#### )( ####","#### )( ####","## {####} ##","############"]
         bbk = ["### _+_ ####","### \\#/ ####","### <#> ####","### }#\{ ####","### )#( ####","## {###} ###"]



d = ""

line = " _________________________________________________________________________________________________________"

d << line 

board.each_index do |row|
    for i in 0..5
        d << "\n||"
        board[row].each do |sq|
            if sq.color == :w 
                case sq.contains
                when :e
                    d << white_square[i]
                when :wp 
                    d << wwp[i] 
                when :wr 
                    d << wwr[i]
                when :wn
                    d << wwn[i]
                when :wb
                    d << wwb[i]
                when :wq 
                    d << wwq[i]
                when :wk 
                    d << wwk[i]

                when :bp 
                    d << wbp[i] 
                when :br 
                    d << wbr[i]
                when :bn
                    d << wbn[i]
                when :bb
                    d << wbb[i]
                when :bq 
                    d << wbq[i]
                when :bk 
                    d << wbk[i]
                end 

            elsif sq.color == :b 
                case sq.contains
                when :e 
                d << black_square[i]
                when :wp 
                    d << bwp[i]
                when :wr 
                    d << bwr[i]
                when :wn
                    d << bwn[i]
                when :wb 
                    d << bwb[i]
                when :wq
                    d << bwq[i]
                when :wk 
                    d << bwk[i]

                when :bp 
                    d << bbp[i] 
                when :br 
                    d << bbr[i]
                when :bn
                    d << bbn[i]
                when :bb
                    d << bbb[i]
                when :bq 
                    d << bbq[i]
                when :bk 
                    d << bbk[i]
                end
          end
           d << "|"
      end 
       d << "|"
    end 
end 


puts d 






