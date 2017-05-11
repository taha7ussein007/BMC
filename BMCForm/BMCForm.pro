% Copyright @ Chums 2016

implement bMCForm
    inherits formWindow
    open core, vpiDomains


clauses
    display(Parent) = Form :-
        Form = new(Parent),
        Form:show().

clauses
    new(Parent):-
        formWindow::new(Parent),
        generatedInitialize().

predicates
    onMultBtnClick : button::clickResponder.

clauses
    onMultBtnClick(_Source) = button::defaultAction:-
        NUM1_STR = firstNum : getText() ,
        NUM2_STR = secondNum : getText(),
        NUM1_ChLST = string::toCharList(NUM1_STR),
        NUM2_ChLST = string::toCharList(NUM2_STR),
        if
            binaryCircuits::multiply(NUM1_ChLST, NUM2_ChLST, RESULT_ChLST)
        then
            RESULT_STR0 = toString(RESULT_ChLST),
            RESULT_STR1 = string::replaceAll(RESULT_STR0, "[" , ""),
            RESULT_STR2 = string::replaceAll(RESULT_STR1, "]" , ""),
            RESULT_STR3 = string::replaceAll(RESULT_STR2, "," , ""),
            RESULT_STR4 = string::replaceAll(RESULT_STR3, "'" , ""),
            result : setText(RESULT_STR4)
        else
            result : setText("Invalid Input!, Please Try Again...")
        end if.

predicates
    onSumBtnClick : button::clickResponder.
clauses
    onSumBtnClick(_Source) = button::defaultAction:-
        NUM1_STR = firstNum : getText() ,
        NUM2_STR = secondNum : getText(),
        NUM1_ChLST = string::toCharList(NUM1_STR),
        NUM2_ChLST = string::toCharList(NUM2_STR),
        if
            binaryCircuits::biToDec(NUM1_ChLST, NUM1)
        and
            binaryCircuits::biToDec(NUM2_ChLST, NUM2)
        then
            DEC_RESULT = NUM1 + NUM2,
            if
                binaryCircuits::decToBi(DEC_RESULT, BI_RESULT_LST)
            then
                RESULT_STR0 = toString(BI_RESULT_LST),
                RESULT_STR1 = string::replaceAll(RESULT_STR0, "[" , ""),
                RESULT_STR2 = string::replaceAll(RESULT_STR1, "]" , ""),
                RESULT_STR3 = string::replaceAll(RESULT_STR2, "," , ""),
                RESULT_STR4 = string::replaceAll(RESULT_STR3, "'" , ""),
                result : setText(RESULT_STR4)
            end if
        else
            result : setText("Invalid Input!, Please Try Again...")
        end if.

predicates
    onSubBtnClick : button::clickResponder.
clauses
    onSubBtnClick(_Source) = button::defaultAction:-
        NUM1_STR = firstNum : getText() ,
        NUM2_STR = secondNum : getText(),
        NUM1_ChLST = string::toCharList(NUM1_STR),
        NUM2_ChLST = string::toCharList(NUM2_STR),
        if
            binaryCircuits::biToDec(NUM1_ChLST, NUM1)
        and
            binaryCircuits::biToDec(NUM2_ChLST, NUM2)
        then
            DEC_RESULT = NUM1 - NUM2,
            if
                binaryCircuits::decToBi(DEC_RESULT, BI_RESULT_LST)
            then
                RESULT_STR0 = toString(BI_RESULT_LST),
                RESULT_STR1 = string::replaceAll(RESULT_STR0, "[" , ""),
                RESULT_STR2 = string::replaceAll(RESULT_STR1, "]" , ""),
                RESULT_STR3 = string::replaceAll(RESULT_STR2, "," , ""),
                RESULT_STR4 = string::replaceAll(RESULT_STR3, "'" , ""),
                result : setText(RESULT_STR4)
            end if
        else
            result : setText("Invalid Input!, Please Try Again...")
        end if.

predicates
    onToDecimalBtnClick : button::clickResponder.
clauses
    onToDecimalBtnClick(_Source) = button::defaultAction:-
        NUM1_STR = firstNum : getText() ,
        NUM2_STR = secondNum : getText(),
        RESULT_STR = result : getText(),
        NUM1_ChLST = string::toCharList(NUM1_STR),
        NUM2_ChLST = string::toCharList(NUM2_STR),
        RESULT_ChLST = string::toCharList(RESULT_STR),
        %First Number:
        if
            binaryCircuits::biToDec(NUM1_ChLST, NUM1)
        then
            firstNum : setText(toString(NUM1))
        else
            firstNum : setText("Invalid Number!")
        end if,
        %Second Number:
        if
            binaryCircuits::biToDec(NUM2_ChLST, NUM2)
        then
            secondNum : setText(toString(NUM2))
        else
            secondNum : setText("Invalid Number!")
        end if,
        %Result:
        if
            list::length(RESULT_ChLST) = 6
        then
            if
                binaryCircuits::bi6ToDec(RESULT_ChLST, RESULT)
            then
                result : setText(toString(RESULT))
            else
                result : setText("Invalid Number!")
            end if
        elseif
            list::length(RESULT_ChLST) = 9
        then
            if
                binaryCircuits::bi9ToDec(RESULT_ChLST, RESULT)
            then
                result : setText(toString(RESULT))
            else
                result : setText("Invalid Number!")
            end if
        else
            result : setText("Invalid Number!")
        end if.

predicates
    onToBinaryBtnClick : button::clickResponder.
clauses
    onToBinaryBtnClick(_Source) = button::defaultAction:-
        NUM1_STR = firstNum : getText() ,
        NUM2_STR = secondNum : getText(),
        RESULT_STR = result : getText(),
        %First Number:
        try
            if
                binaryCircuits::decTo5Bi(toTerm(NUM1_STR), NUM1_BI_LST)
            then
                NUM1_BI_STR0 = toString(NUM1_BI_LST),
                NUM1_BI_STR1 = string::replaceAll(NUM1_BI_STR0, "[" , ""),
                NUM1_BI_STR2 = string::replaceAll(NUM1_BI_STR1, "]" , ""),
                NUM1_BI_STR3 = string::replaceAll(NUM1_BI_STR2, "," , ""),
                NUM1_BI_STR4 = string::replaceAll(NUM1_BI_STR3, "'" , ""),
                firstNum : setText(NUM1_BI_STR4)
            else
                firstNum : setText("Invalid Number!")
            end if
        catch _ do firstNum : setText("Invalid Number!")
        end try,
        %Second Number:
        try
            if
                binaryCircuits::decTo5Bi(toTerm(NUM2_STR), NUM2_BI_LST)
            then
                NUM2_BI_STR0 = toString(NUM2_BI_LST),
                NUM2_BI_STR1 = string::replaceAll(NUM2_BI_STR0, "[" , ""),
                NUM2_BI_STR2 = string::replaceAll(NUM2_BI_STR1, "]" , ""),
                NUM2_BI_STR3 = string::replaceAll(NUM2_BI_STR2, "," , ""),
                NUM2_BI_STR4 = string::replaceAll(NUM2_BI_STR3, "'" , ""),
                secondNum : setText(NUM2_BI_STR4)
            else
                secondNum : setText("Invalid Number!")
            end if
        catch _ do secondNum : setText("Invalid Number!")
        end try,
        %Result:
        try
            if toTerm(RESULT_STR) <= 31
            then
                %Case 6 Digits:
                if
                    binaryCircuits::decToBi(toTerm(RESULT_STR), RESULT_BI_LST)
                then
                    RESULT_BI_STR0 = toString(RESULT_BI_LST),
                    RESULT_BI_STR1 = string::replaceAll(RESULT_BI_STR0, "[" , ""),
                    RESULT_BI_STR2 = string::replaceAll(RESULT_BI_STR1, "]" , ""),
                    RESULT_BI_STR3 = string::replaceAll(RESULT_BI_STR2, "," , ""),
                    RESULT_BI_STR4 = string::replaceAll(RESULT_BI_STR3, "'" , ""),
                    result : setText(RESULT_BI_STR4)
                else
                    result : setText("Invalid Number!")
                end if
            elseif toTerm(RESULT_STR) > 31 and toTerm(RESULT_STR) <= 255
            then
                %Case 9 Digits:
                if
                    binaryCircuits::decTo9Bi(toTerm(RESULT_STR), RESULT_BI_LST)
                then
                    RESULT_BI_STR0 = toString(RESULT_BI_LST),
                    RESULT_BI_STR1 = string::replaceAll(RESULT_BI_STR0, "[" , ""),
                    RESULT_BI_STR2 = string::replaceAll(RESULT_BI_STR1, "]" , ""),
                    RESULT_BI_STR3 = string::replaceAll(RESULT_BI_STR2, "," , ""),
                    RESULT_BI_STR4 = string::replaceAll(RESULT_BI_STR3, "'" , ""),
                    result : setText(RESULT_BI_STR4)
                else
                    result : setText("Invalid Number!")
                end if
            else
                result : setText("Invalid Number!")
            end if
        catch _ do result : setText("Invalid Number!")
        end try.

% This code is maintained automatically, do not update it manually. 23:18:45-19.12.2015
facts
    firstNum : editControl.
    secondNum : editControl.
    result : editControl.
    multBtn : button.
    sumBtn : button.
    subBtn : button.
    toDecimalBtn : button.
    toBinaryBtn : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("BMCForm"),
        setRect(rct(50,40,250,102)),
        setDecoration(titlebar([closeButton,maximizeButton,minimizeButton])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        firstNum := editControl::new(This),
        firstNum:setText("Enter First Number"),
        firstNum:setPosition(4, 6),
        firstNum:setWidth(92),
        secondNum := editControl::new(This),
        secondNum:setText("Enter Second Number"),
        secondNum:setPosition(100, 6),
        secondNum:setWidth(92),
        result := editControl::new(This),
        result:setText("Result..."),
        result:setPosition(4, 22),
        result:setWidth(128),
        multBtn := button::new(This),
        multBtn:setText("Multiply"),
        multBtn:setPosition(4, 40),
        multBtn:setWidth(56),
        multBtn:defaultHeight := true,
        multBtn:setClickResponder(onMultBtnClick),
        sumBtn := button::new(This),
        sumBtn:setText("Sum"),
        sumBtn:setPosition(64, 40),
        sumBtn:setWidth(68),
        sumBtn:defaultHeight := true,
        sumBtn:setClickResponder(onSumBtnClick),
        subBtn := button::new(This),
        subBtn:setText("Subtract"),
        subBtn:setPosition(136, 40),
        subBtn:setWidth(56),
        subBtn:defaultHeight := true,
        subBtn:setClickResponder(onSubBtnClick),
        toDecimalBtn := button::new(This),
        toDecimalBtn:setText("Decimal"),
        toDecimalBtn:setPosition(136, 20),
        toDecimalBtn:setWidth(28),
        toDecimalBtn:defaultHeight := true,
        toDecimalBtn:setClickResponder(onToDecimalBtnClick),
        toBinaryBtn := button::new(This),
        toBinaryBtn:setText("Binary"),
        toBinaryBtn:setPosition(164, 20),
        toBinaryBtn:setWidth(28),
        toBinaryBtn:defaultHeight := true,
        toBinaryBtn:setClickResponder(onToBinaryBtnClick).
% end of automatic code
end implement bMCForm