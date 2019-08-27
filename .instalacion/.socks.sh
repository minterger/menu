#!/bin/bash
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
[[ ! -d ~/.Menu ]] && rm -rf /bin/menu
${comando[0]} > /dev/null 2>&1
${comando[1]} > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}

fun_socks () {
	clear
    if ps x | grep proxy.py|grep -v grep 1>/dev/null 2>/dev/null; then
    	sks='\033[1;32mON'
    	sockspt=$(netstat -nplt |grep 'python' | awk -F ":" {'print $2'} | cut -d " " -f 1 | xargs)
    	var_sks1="DESATIVAR SOCKS"
    else
    	sks='\033[1;31mOFF'
    	sockspt="\033[1;31mINDISPONIVEL"
    	var_sks1="ATIVAR SOCKS"
    fi
    echo -e "\E[44;1;37m            ADMINISTRAR PROXY SOCKS             \E[0m"
    echo ""
    echo -e "\033[1;33mPUERTAS\033[1;37m: \033[1;32m$sockspt"
    echo ""
	echo -e "\033[1;33m[\033[1;31m1\033[1;33m] \033[1;33m$var_sks1\033[0m"
	echo -e "\033[1;33m[\033[1;31m2\033[1;33m] \033[1;33mABRIR PUERTA\033[0m"
	echo -e "\033[1;33m[\033[1;31m3\033[1;33m] \033[1;33mALTERAR STATUS\033[0m"
	echo -e "\033[1;33m[\033[1;31m0\033[1;33m] \033[1;33mVOLVER\033[0m"
	echo ""
	echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;37m "; read resposta
	if [[ "$resposta" = '1' ]]; then
		if ps x | grep proxy.py|grep -v grep 1>/dev/null 2>/dev/null; then
			clear
			echo -e "\E[41;1;37m             PROXY SOCKS              \E[0m"
			echo ""
			fun_socksoff () {
				for pidproxy in  `screen -ls | grep ".proxy" | awk {'print $1'}`; do
					screen -r -S "$pidproxy" -X quit
				done
				if grep -w "SSHPlus" /etc/rc.local > /dev/null 2>&1; then
					sed -i '/proxy.py/d' /etc/rc.local
				fi
				sleep 1
				screen -wipe > /dev/null
			}
			echo -e "\033[1;32mDESATIVANDO O PROXY SOCKS\033[1;33m"
			echo ""
			fun_bar 'fun_socksoff'
			echo ""
			echo -e "\033[1;32mPROXY SOCKS DESATIVADO COM SUCESSO!\033[1;33m"
			sleep 3
			fun_socks
		else
			clear
			echo -e "\E[44;1;37m             PROXY SOCKS              \E[0m"
		    echo ""
		    echo -ne "\033[1;32mQUAL PORTA DESEJA ULTILIZAR \033[1;33m?\033[1;37m: "; read porta
		    if [[ -z "$porta" ]]; then
		    	echo ""
		    	echo -e "\033[1;31mPorta invalida!"
		    	sleep 3
		    	clear
		    	fun_conexao
		    fi
		    #verif_ptrs
		    fun_inisocks () {
		    	sleep 1
		    	var_ptsks2=$(sed -n "12 p" ~/.Menu/.instalacion/proxy.py | awk -F = '{print $2}')
		    	sed -i "s/$var_ptsks2/ $porta/g" ~/.Menu/.instalacion/proxy.py
		    	sleep 1
		    	screen -dmS proxy python ~/.Menu/.instalacion/proxy.py
		    	if grep -w "SSHPlus" /etc/rc.local > /dev/null 2>&1; then
		    		echo ""
		    	else
		    		sed -i '$ iscreen -dmS proxy python /etc/SSHPlus/proxy.py' /etc/rc.local
			    fi
		    }
		    echo ""
		    echo -e "\033[1;32mINICIANDO O PROXY SOCKS\033[1;33m"
		    echo ""
		    fun_bar 'fun_inisocks'
		    echo ""
		    echo -e "\033[1;32mPROXY SOCKS ATIVADO COM SUCESSO\033[1;33m"
		    sleep 3
		    fun_socks
		fi
	elif [[ "$resposta" = '2' ]]; then
		if ps x | grep proxy.py|grep -v grep 1>/dev/null 2>/dev/null; then
			clear
			echo -e "\E[44;1;37m            PROXY SOCKS             \E[0m"
			echo ""
			echo -e "\033[1;33mPORTAS EM USO: \033[1;32m$sockspt"
			echo ""
			echo -ne "\033[1;32mQUAL PORTA DESEJA ULTILIZAR \033[1;33m?\033[1;37m: "; read porta
			if [[ -z "$porta" ]]; then
				echo ""
				echo -e "\033[1;31mPorta invalida!"
				sleep 3
				clear
				fun_conexao
			fi
			#verif_ptrs
			echo ""
			echo -e "\033[1;32mINICIANDO O PROXY SOCKS NA PORTA \033[1;31m$porta\033[1;33m"
			echo ""
			abrirptsks () {
				sleep 1
				screen -dmS proxy python ~/.Menu/.instalacion/proxy.py $porta
				sleep 1
			}
			fun_bar 'abrirptsks'
			echo ""
			echo -e "\033[1;32mPROXY SOCKS ATIVADO COM SUCESSO\033[1;33m"
			sleep 3
			fun_socks
		else
			clear
			echo -e "\033[1;31mFUNCAO INDISPONIVEL\033[1;33m"
			sleep 2
			fun_socks
		fi
	elif [[ "$resposta" = '3' ]]; then
		if ps x | grep proxy.py|grep -v grep 1>/dev/null 2>/dev/null; then
			clear
			msgsocks=$(cat ~/.Menu/.instalacion/proxy.py |grep -E "MSG =" | awk -F = '{print $2}' |cut -d "'" -f 2)
			echo -e "\E[44;1;37m             PROXY SOCKS              \E[0m"
			echo ""
			echo -e "\033[1;33mSTATUS: \033[1;32m$msgsocks"
			echo""
			echo -ne "\033[1;32mINFORME SEU STATUS\033[1;31m:\033[1;37m "; read msgg
			if [[ -z "$msgg" ]]; then
				echo ""
				echo -e "\033[1;31mStatus invalido!"
				sleep 3
				fun_conexao
			fi
			fun_msgsocks () {
				msgsocks2=$(cat ~/.Menu/.instalacion/proxy.py |grep "MSG =" | awk -F = '{print $2}')
				sed -i "s/$msgsocks2/ '$msgg'/g" ~/.Menu/.instalacion/proxy.py
				sleep 1
			}
			echo ""
			echo -e "\033[1;32mALTERANDO STATUS!"
			echo ""
			fun_bar 'fun_msgsocks'
			restartsocks () {
				if ps x | grep proxy.py|grep -v grep 1>/dev/null 2>/dev/null; then
					for pidproxy in  `screen -ls | grep ".proxy" | awk {'print $1'}`; do
						screen -r -S "$pidproxy" -X quit
					done
					screen -wipe > /dev/null
					sleep 1
					screen -dmS proxy python ~/.Menu/.instalacion/proxy.py
				fi
			}
			echo ""
			echo -e "\033[1;32mREINICIANDO PROXY SOCKS!"
			echo ""
			fun_bar 'restartsocks'
			echo ""
			echo -e "\033[1;32mSTATUS ALTERADO COM SUCESSO!"
			sleep 3
			fun_socks
		else
			clear
			echo -e "\033[1;31mFUNCAO INDISPONIVEL\033[1;33m"
			sleep 2
			fun_socks
		fi
	elif [[ "$resposta" = '0' ]]; then
		echo ""
		echo -e "\033[1;31mRetornando...\033[0m"
		sleep 2
		exit 1
	else
		echo ""
		echo -e "\033[1;31mOpcao invalida !\033[0m"
		sleep 2
		fun_socks
	fi

}
fun_socks