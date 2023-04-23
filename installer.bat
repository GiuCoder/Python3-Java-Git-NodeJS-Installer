@echo off

REM Check if running with administrative privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :skip
) else (
    echo Administrator permissions required. Restarting script...
    pause >nul
    cd /d "%~dp0"
    powershell Start-Process cmd.exe -ArgumentList '/c %~dpnx0' -Verb runAs
    exit /b
)

:skip

REM Check if Chocolatey is installed
where /q choco && (
    echo Chocolatey is already installed.
) || (
    echo Chocolatey is not installed. Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
)

REM Install Git
set /p install_git=Do you want to install Git? (Y/N)
if /i "%install_git%"=="Y" (
    echo Installing Git...
    choco install git -y
) else (
    echo Git not selected for installation.
)

REM Install Python3
set /p install_python=Do you want to install Python3? (Y/N)
if /i "%install_python%"=="Y" (
    echo Installing Python3...
    choco install python -y
) else (
    echo Python3 not selected for installation.
)

REM Install Node.js
set /p install_nodejs=Do you want to install Node.js? (Y/N)
if /i "%install_nodejs%"=="Y" (
    echo Installing Node.js...
    choco install nodejs -y
) else (
    echo Node.js not selected for installation.
)

REM Install Java
set /p install_java=Do you want to install Java? (Y/N)
if /i "%install_java%"=="Y" (
    echo Installing Java...
    choco install adoptopenjdk -y
) else (
    echo Java not selected for installation.
)

REM Check if programs have been installed
echo.
echo Checking if programs have been installed...
set git_installed=false
set python_installed=false
set nodejs_installed=false
set java_installed=false

REM Check if Git is installed
where /q git && (
    set git_installed=true
)

REM Check if Python3 is installed
where /q python && (
    set python_installed=true
)

REM Check if Node.js is installed
where /q node && (
    set nodejs_installed=true
)

REM Check if Java is installed
where /q java && (
    set java_installed=true
)

REM Display installation status
echo.
if %git_installed%==true (
    echo Git is installed.
) else (
    echo Git is not installed.
)

if %python_installed%==true (
    echo Python3 is installed.
) else (
    echo Python3 is not installed.
)

if %nodejs_installed%==true (
    echo Node.js is installed.
) else (
    echo Node.js is not installed.
)

if %java_installed%==true (
    echo Java is installed.
) else (
    echo Java is not installed.
)

REM End of script
pause>nul
exit
