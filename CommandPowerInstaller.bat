@echo off

set "url=https://raw.githubusercontent.com/ArtikLamartik/CommandPower/main/CP.bat"

set "output_file=CP.bat"

curl -o "%output_file%" "%url%"

if exist "%output_file%" (
    echo File downloaded successfully.
) else (
    echo Failed to download the file.
)

set "owner=ArtikLamartik"
set "repo=CommandPower"

set "folder=CommandPower"

set "api_url=https://api.github.com/repos/%owner%/%repo%/zipball/main"

set "output_file=%repo%.zip"

curl -L -o "%output_file%" "%api_url%"

if exist "%output_file%" (
    echo File downloaded successfully.
) else (
    echo Failed to download the file.
    exit /b
)

set "output_folder=%USERPROFILE%\Desktop\DeleteThis"

mkdir "%output_folder%"

powershell -Command Expand-Archive -Path "%output_file%" -DestinationPath "%output_folder%"

if exist "%output_folder%" (
    echo Folder extracted successfully to the desktop.
) else (
    echo Failed to extract the folder.
)

del "%output_file%"
ren "%output_folder%\ArtikLamartik-CommandPower-eaff792" "CommandPower"
move "%output_folder%\CommandPower\CommandPower" "%USERPROFILE%\Desktop"