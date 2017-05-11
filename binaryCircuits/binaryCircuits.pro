% Copyright @ Chums 2016

implement binaryCircuits
    open core

    class predicates
        andGate : (char X, char Y, char Z) determ (i,i,o).
        orGate : (char X, char Y, char Z) determ (i,i,o).
        xorGate : (char X, char Y, char Z) determ (i,i,o).
    clauses
        andGate(X, Y, Z) :-
            if
                X = '0' and Y ='0' then Z = '0'
            elseif
                X = '0' and Y = '1' then Z = '0'
            elseif
                X = '1' and Y = '0' then Z = '0'
            elseif
                X = '1' and Y = '1' then Z = '1'
            else
                fail
            end if.
        orGate(X, Y, Z) :-
            if
                X = '0' and Y ='0' then Z = '0'
            elseif
                X = '0' and Y = '1' then Z = '1'
            elseif
                X = '1' and Y = '0' then Z = '1'
            elseif
                X = '1' and Y = '1' then Z = '1'
            else
                fail
            end if.
        xorGate(X, Y, Z) :-
            if
                X = '0' and Y ='0' then Z = '0'
            elseif
                X = '0' and Y = '1' then Z = '1'
            elseif
                X = '1' and Y = '0' then Z = '1'
            elseif
                X = '1' and Y = '1' then Z = '0'
            else
                fail
            end if.

    class predicates
        fa : (char D1, char D2, char Cin, char Sum, char Cout) determ (i,i,i,o,o).
    clauses
        fa(D1, D2, Cin, Sum, Cout):-
            xorGate(D1, D2, X),
            andGate(D1, D2, Y),
            andGate(X, Cin, Z),
            xorGate(Cin, X, Sum),
            orGate(Y, Z, Cout).

    clauses
        multiply([A0,A4,A3,A2,A1],[B0,B4,B3,B2,B1],[R0,R8,R7,R6,R5,R4,R3,R2,R1]):-
            xorGate(A0,B0,R0),
            andGate(A1,B1,D1),
            fa(D1,'0','0',R1,COUT1), % 1
            andGate(A2,B1,D2),
            fa(D2,'0',COUT1,SUM2,COUT2), % 2
            andGate(A3,B1,D3),
            fa(D3,'0',COUT2,SUM3,COUT3), % 3
            andGate(A4,B1,D4),
            fa(D4,'0',COUT3,SUM4,COUT4), % 4
            andGate(A1,B2,D5),
            fa(D5,SUM2,'0',R2,COUT5), % 5
            andGate(A2,B2,D6),
            fa(D6,SUM3,COUT5,SUM6,COUT6), % 6
            andGate(A3,B2,D7),
            fa(D7,SUM4,COUT6,SUM7,COUT7), % 7
            andGate(A4,B2,D8),
            fa(D8,COUT4,COUT7,SUM8,COUT8), % 8
            andGate(A1,B3,D9),
            fa(D9,SUM6,'0',R3,COUT9), % 9
            andGate(A2,B3,D10),
            fa(D10,SUM7,COUT9,SUM10,COUT10), % 10
            andGate(A3,B3,D11),
            fa(D11,SUM8,COUT10,SUM11,COUT11), % 11
            andGate(A4,B3,D12),
            fa(D12,COUT8,COUT11,SUM12,COUT12), % 12
            andGate(A1,B4,D13),
            fa(D13,SUM10,'0',R4,COUT13), % 13
            andGate(A2,B4,D14),
            fa(D14,SUM11,COUT13,R5,COUT14), % 14
            andGate(A3,B4,D15),
            fa(D15,SUM12,COUT14,R6,COUT15), % 15
            andGate(A4,B4,D16),
            fa(D16,COUT12,COUT15,R7,R8). % 16

        biToDec([BS,B8,B4,B2,B1], DEC):-
            if BS = '1' then Sign = -1
            elseif BS = '0' then Sign = 1
            else fail end if,
            if B8 = '1' then T4 = 8
            elseif B8 = '0' then T4 = 0
            else fail end if,
            if B4 = '1' then T3 = 4
            elseif B4 = '0' then T3 = 0
            else fail end if,
            if B2 = '1' then T2 = 2
            elseif B2 = '0' then T2 = 0
            else fail end if,
            if B1 = '1' then T1 = 1
            elseif B1 = '0' then T1 = 0
            else fail end if,
            DEC = (T4 + T3 + T2 + T1) * Sign.

        bi9ToDec([BS,B128,B64,B32,B16,B8,B4,B2,B1], DEC):-
            if BS = '1' then Sign = -1
            elseif BS = '0' then Sign = 1
            else fail end if,
            if B128 = '1' then T8 = 128
            elseif B128 = '0' then T8 = 0
            else fail end if,
            if B64 = '1' then T7 = 64
            elseif B64 = '0' then T7 = 0
            else fail end if,
            if B32 = '1' then T6 = 32
            elseif B32 = '0' then T6 = 0
            else fail end if,
            if B16 = '1' then T5 = 16
            elseif B16 = '0' then T5 = 0
            else fail end if,
            if B8 = '1' then T4 = 8
            elseif B8 = '0' then T4 = 0
            else fail end if,
            if B4 = '1' then T3 = 4
            elseif B4 = '0' then T3 = 0
            else fail end if,
            if B2 = '1' then T2 = 2
            elseif B2 = '0' then T2 = 0
            else fail end if,
            if B1 = '1' then T1 = 1
            elseif B1 = '0' then T1 = 0
            else fail end if,
            DEC = (T8 + T7 + T6 + T5 + T4 + T3 + T2 + T1) * Sign.

        bi6ToDec([BS,B16,B8,B4,B2,B1], DEC):-
            if BS = '1' then Sign = -1
            elseif BS = '0' then Sign = 1
            else fail end if,
            if B16 = '1' then T5 = 16
            elseif B16 = '0' then T5 = 0
            else fail end if,
            if B8 = '1' then T4 = 8
            elseif B8 = '0' then T4 = 0
            else fail end if,
            if B4 = '1' then T3 = 4
            elseif B4 = '0' then T3 = 0
            else fail end if,
            if B2 = '1' then T2 = 2
            elseif B2 = '0' then T2 = 0
            else fail end if,
            if B1 = '1' then T1 = 1
            elseif B1 = '0' then T1 = 0
            else fail end if,
            DEC = (T5 + T4 + T3 + T2 + T1) * Sign.

        decToBi(SDEC, [BS,B16,B8,B4,B2,B1]):-
            if SDEC < 0 then BS = '1', DEC = (SDEC * -1)
            elseif SDEC >= 0 then BS = '0', DEC = SDEC
            else fail end if,
            if DEC >= 16 then B16 = '1', T5 = DEC-16
            elseif DEC < 16 then B16 = '0', T5 = DEC
            else fail end if,
            if T5 >= 8 then B8 = '1', T4 = T5-8
            elseif T5 < 8 then B8 = '0', T4 = T5
            else fail end if,
            if T4 >= 4 then B4 = '1', T3 = T4-4
            elseif T4 < 4 then B4 = '0', T3 = T4
            else fail end if,
            if T3 >= 2 then B2 = '1', T2 = T3-2
            elseif T3 < 2 then B2 = '0', T2 = T3
            else fail end if,
            if T2 >= 1 then B1 = '1'
            elseif T2 < 1 then B1 = '0'
            else fail end if.

        decTo5Bi(SDEC, [BS,B8,B4,B2,B1]):-
            if SDEC < 0 then BS = '1', DEC = (SDEC * -1)
            elseif SDEC >= 0 then BS = '0', DEC = SDEC
            else fail end if,
            if DEC >= 8 then B8 = '1', T4 = DEC-8
            elseif DEC < 8 then B8 = '0', T4 = DEC
            else fail end if,
            if T4 >= 4 then B4 = '1', T3 = T4-4
            elseif T4 < 4 then B4 = '0', T3 = T4
            else fail end if,
            if T3 >= 2 then B2 = '1', T2 = T3-2
            elseif T3 < 2 then B2 = '0', T2 = T3
            else fail end if,
            if T2 >= 1 then B1 = '1'
            elseif T2 < 1 then B1 = '0'
            else fail end if.

        decTo9Bi(SDEC, [BS,B128,B64,B32,B16,B8,B4,B2,B1]):-
            if SDEC < 0 then BS = '1', DEC = (SDEC * -1)
            elseif SDEC >= 0 then BS = '0', DEC = SDEC
            else fail end if,
            if DEC >= 128 then B128 = '1', T8 = DEC-128
            elseif DEC < 128 then B128 = '0', T8 = DEC
            else fail end if,
            if T8 >= 64 then B64 = '1', T7 = T8-64
            elseif T8 < 64 then B64 = '0', T7 = T8
            else fail end if,
            if T7 >= 32 then B32 = '1', T6 = T7-32
            elseif T7 < 32 then B32 = '0', T6 = T7
            else fail end if,
            if T6 >= 16 then B16 = '1', T5 = T6-16
            elseif T6 < 16 then B16 = '0', T5 = T6
            else fail end if,
            if T5 >= 8 then B8 = '1', T4 = T5-8
            elseif T5 < 8 then B8 = '0', T4 = T5
            else fail end if,
            if T4 >= 4 then B4 = '1', T3 = T4-4
            elseif T4 < 4 then B4 = '0', T3 = T4
            else fail end if,
            if T3 >= 2 then B2 = '1', T2 = T3-2
            elseif T3 < 2 then B2 = '0', T2 = T3
            else fail end if,
            if T2 >= 1 then B1 = '1'
            elseif T2 < 1 then B1 = '0'
            else fail end if.

end implement binaryCircuits