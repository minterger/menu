#!/bin/bash
instalar () {
  echo -e "\033[1;32mInstalando Script\033[0m"
  cd ~
  wget https://github.com/minterger/vpsmanager
  unzip menu.zip?dl=0 >/dev/null 2>/dev/null
  rm -r menu.zip?dl=0
  cd .Menu >/dev/null 2>/dev/null
  sudo cp menu.sh /bin/menu >/dev/null 2>/dev/null
  sudo chmod +x /bin/menu >/dev/null 2>/dev/null
  echo -e "\033[1;32mScript instalado con exito"
  echo
  echo -e "\033[1;32mPara ejecutarlo use menu\033[0m"
}

if [ -f /bin/menu ]
then
    echo -e "\033[1;32mBorrando Version anterior\033[0m"
    rm -r /bin/menu
    rm -r ~/.Menu
    echo
    instalar
else
    instalar
fi
