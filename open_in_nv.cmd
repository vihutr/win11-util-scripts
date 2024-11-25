:: Reconstruct the full file path from all arguments
set "filePath="
:loop
if "%~1"=="" goto afterLoop
set "filePath=%filePath% %~1"
shift
goto loop

:afterLoop
:: Trim leading space
set "filePath=%filePath:~1%"

:: Pass the reconstructed path to Neovim
echo %filePath%
start alacritty -e nvim "\""%filePath%"""
