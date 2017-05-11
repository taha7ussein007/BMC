% Copyright @ Chums 2016

class binaryCircuits
    open core

predicates %public
    multiply : (list {char} NUM1, list {char} NUM2, list {char} RESULT) determ (i,i,o).
    biToDec : (list {char} BINUM, integer DECNUM) determ (i,o).
    bi9ToDec : (list {char} BINUM, integer DECNUM) determ (i,o).
    bi6ToDec : (list {char} BINUM, integer DECNUM) determ (i,o).
    decToBi : (integer DECNUM, list {char} BINUM) determ (i,o).
    decTo5Bi : (integer DECNUM, list {char} BINUM) determ (i,o).
    decTo9Bi : (integer DECNUM, list {char} BINUM) determ (i,o).
end class binaryCircuits