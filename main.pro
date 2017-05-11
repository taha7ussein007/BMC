% Copyright @ Chums 2016

implement main
    open core

clauses
    run() :-
        _ = bMCForm::display(window::getScreenWindow()),
        messageLoop::run().

end implement main

goal
    formWindow::run(main::run).
