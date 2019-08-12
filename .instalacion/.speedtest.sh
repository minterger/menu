#!/bin/bash
if [ -f /usr/bin/speedtest ]; then
echo -e "\033[1;32mSpeedtest ya esta instalado\033[0m"
echo
echo -n "Desea desinstalar S (si) o N (no): "
read opcion
case $opcion in
s) clear;
echo -e "Desinstalando Speedtest:\e[1;31m";
echo ;
apt-get remove -y speedtest-cli >/dev/null 2>/dev/null;
echo ;
echo -e "\e[1;32mDesinstalado\nPresiona una tecla para continuar...";
read foo;
exit 1;;
S) clear;
echo -e "Desinstalando Speedtest:\e[1;31m";
echo ;
apt-get remove -y speedtest-cli >/dev/null 2>/dev/null;
echo ;
echo -e "\e[1;32mDesinstalado\nPresiona una tecla para continuar...";
read foo;
exit 1;;
n) clear;
echo -e "\e[1;32mPresiona una tecla para continuar...";
read foo;
exit 1;;
N) clear;
echo -e "\e[1;32mPresiona una tecla para continuar...";
read foo;
exit 1;;
esac
else
clear
fi
if [ -f /usr/bin/speedtest-cli ]; then
echo -e "\033[1;32mSpeedtest ya esta instalado\033[0m"
echo
echo -n "Desea desinstalar S (si) o N (no): "
read opcion
case $opcion in
s) clear;
echo -e "Desinstalando Speedtest:\e[1;31m";
echo ;
apt-get remove -y speedtest-cli >/dev/null 2>/dev/null;
echo ;
echo -e "\e[1;32mDesinstalado\nPresiona una tecla para continuar...";
read foo;
exit 1;;
S) clear;
echo -e "Desinstalando Speedtest:\e[1;31m";
echo ;
apt-get remove -y speedtest-cli >/dev/null 2>/dev/null;
echo ;
echo -e "\e[1;32mDesinstalado\nPresiona una tecla para continuar...";
read foo;
exit 1;;
n) clear;
echo -e "\e[1;32mPresiona una tecla para continuar...";
read foo;
exit 1;;
N) clear;
echo -e "\e[1;32mPresiona una tecla para continuar...";
read foo;
exit 1;;
esac
else
clear
fi

echo -e "\033[1;31m           Instalador Speedtest.net\n\033[1;37mInstalando Speedtest.net...\033[0m"
apt-get update >/dev/null 2>/dev/null
apt-get install -y speedtest-cli >/dev/null 2>/dev/null

echo -e "\033[1;32m             Instalacion completada\033[0m"
