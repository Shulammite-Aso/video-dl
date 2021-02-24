#!/bin/bash

# A script to install youtube-dl and download online videos on major operating systems
# Amarachi S. Aso 22/2/2021

# Check version of youtube-dl to know if it is installed
version=$( youtube-dl --version )

function forLinux {
   # checkDistro=$( cat /etc/*-release | grep DISTRIB_ID=Ubuntu )
   # if [ $checkDistro ]
   # then
   #     sudo apt install youtube-dl
   # else
        wget https://yt-dl.org/downloads/latest/youtube-dl && chmod u+rx youtube-dl

        mkdir ~/ydl && mv ./youtube-dl ~/ydl/.
        echo "PATH=$PATH:$HOME/ydl" >> ~/.bashrc && . ~/.bashrc

   # fi    
}

function forMac {
   # checkForBrew=$( brew help )
   # if [ $checkForBrew ]
   # then
   #     brew install youtube-dl
   # else
        wget https://yt-dl.org/downloads/latest/youtube-dl && chmod u+rx youtube-dl

        mkdir ~/ydl && mv ./youtube-dl ~/ydl/.
        echo "PATH=$PATH:$HOME/ydl" >> ~/.bashrc && . ~/.bashrc

   # fi    
}

function forWindows {
    # First install choco, so that we're able to install youtube-dl from terminal
    installChoco=$( Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) )

    if [ $? == 0  ]
    then
        choco install youtube-dl
    else
        echo could not install choco
        exit
    
     fi
}

# Check if youtube-dl is not already installed
# If true, check operating stystem and intall youtube-dl

if [ ! $varsion ]
then

    if [ $OSTYPE == "linux-gnu" ] 
    then
        forLinux

    elif [ $OSTYPE == "darwin" ] 
    then
        forMac

    elif [ $OSTYPE == "cygwin" ] 
    then
        forWindows
    fi

fi

# Download the specified video

echo Hello, do you want to download this video in audio format? reply with yes or no.
read format

if [ $format == "yes" ] 
    then
        echo $1
        youtube-dl -f 140 $1

    elif [ $format == "no" ] 
    then
        echo $1
        youtube-dl $1

    else 
        echo Please only answer with yes or no.
        exit
fi
