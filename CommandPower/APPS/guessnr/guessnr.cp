@echo off
:guessNumber
set /a "targetNum=%random% %% 100 + 1"
set /a "attempts=0"

echo Welcome to Guess the Number!
echo I've picked a number between 1 and 100.
echo Try to guess it!
echo Made By WinXp
echo From WinBatchBox
echo.

:guessLoop
set /p "userGuess=Your guess: "
set /a "attempts+=1"

if %userGuess%==exit (
    exit
) else if %userGuess% lss %targetNum% (
    echo Too low! Try again.
    goto guessLoop
) else if %userGuess% gtr %targetNum% (
    echo Too high! Try again.
    goto guessLoop
) else (
    echo Congratulations! You guessed the number %targetNum% in %attempts% attempts.
    echo.
    pause
    cls
    goto guessNumber
)