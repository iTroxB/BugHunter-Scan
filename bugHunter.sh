#!/bin/bash
# Author: iTrox
# https://patorjk.com/software/taag/#p=display&f=Grande&t=BugHunter%20Scan



######################################################
#################### COLOURS EDIT ####################
######################################################
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"



###################################################
#################### FUNCTIONS ####################
###################################################

# Bye Ctrl+C
function ctrl_c(){
    echo -e "\n\n ${red}[!] Exit...${end}\n"
    tput cnorm && exit 1
}
trap ctrl_c INT

# Banner
print_banner() {
    echo;
    echo -e " ${yellow}  ____              _    _             _               _____ ${end}"
	echo -e " ${yellow} |  _ \\            | |  | |           | |             / ____| ${end}"
	echo -e " ${yellow} | |_) |_   _  __ _| |__| |_   _ _ __ | |_ ___ _ __  | (___   ___ __ _ _ __ ${end}"
	echo -e " ${yellow} |  _ <| | | |/ _\` |  __  | | | | '_ \\| __/ _ \\ '__|  \___ \\ / __/ _\` | '_ \ ${end}"
	echo -e " ${yellow} | |_) | |_| | (_| | |  | | |_| | | | | ||  __/ |     ____) | (_| (_| | | | | ${end}"
	echo -e " ${yellow} |____/ \\__,_|\\__, |_|  |_|\\__,_|_| |_|\\__\\___|_|    |_____/ \\___\\__,_|_| |_| ${end}"
	echo -e " ${yellow}               __/ | ${end}"
	echo -e " ${yellow}              |___/ ${end}\n\n"
	echo -e "  ${turquoise}Footprinting tool for Bug Bounty${end}"
	echo -e "  ${turquoise}Version 1.1${end}"
    echo -e "  ${turquoise}Made by iTrox${end}\n"
	echo -e "  ${turquoise}bugHunter [-h] or [--help] to view help menu${end}\n"
}

# Update system and install tools
upHunter(){
	if [[ $(echo $OSTYPE) == "linux-gnu" ]]; then
		if [ -e /etc/arch-release ]; then
			echo -e "\n ${turquoise}[➤]${end} ${gray}Under development for Arch Linux environment...${end}"
		elif [ -e /etc/debian_version ]; then
			
			# System update and upgrade
			cd /root
			dist_name=$(cat /etc/os-release | head -n 2 | tail -n 1 | awk '{print $1}' | cut -d '=' -f 2 | cut -c 2-)
			echo -e "\n ${turquoise}[➤]${end} ${gray}Updating${end} ${blue}"$dist_name" $(uname)${end} ${gray}repositories...${end} \n"
			apt update
			echo -e "\n ${green}[✔]${end} ${gray}Updating${end} ${blue}"$dist_name" $(uname)${end} ${gray}ok...${end} \n"
			sleep 1
			echo -e "\n ${turquoise}[➤]${end} ${gray}Upgrading${end} ${blue}"$dist_name" $(uname)${end} ${gray}system...${end} \n"
			apt upgrade -y
			echo -e "\n ${green}[✔]${end} ${gray}Upgrading${end} ${blue}"$dist_name" $(uname)${end} ${gray}ok...${end} \n"
			sleep 1
			echo -e "\n ${turquoise}[➤]${end} ${gray}Dist-upgrading${end} ${blue}"$dist_name" $(uname)${end}${gray}...${end} \n"
			apt dist-upgrade -y
			echo -e "\n ${green}[✔]${end} ${gray}Dist-upgrade${end} ${blue}"$dist_name" $(uname)${end} ${gray}ok...${end} \n"
			sleep 1
			echo -e "\n ${turquoise}[➤]${end} ${gray}Updating system database for file search...${end}"
			updatedb &>/dev/null
			echo -e "\n ${green}[✔]${end} ${gray}Updatedb${end} ${blue}"$dist_name" $(uname)${end} ${gray}ok...${end} \n"
			sleep 1

			# Install BugBounty tools
			
			# go
			if [ "$(which go)" == "/usr/bin/go" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}go${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}go${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}go${end}${gray}...${end}"
				apt install golang-go -y
				echo -e "\n ${green}[✔]${end} ${blue}go${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# firefox
			if [ "$(which firefox-esr)" == "/usr/bin/firefox-esr" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}firefox-esr${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}firefox-esr${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}firefox-esr${end}${gray}...${end}"
				apt install firefox-esr -y
				echo -e "\n ${green}[✔]${end} ${blue}firefox-esr${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# whois
			if [ "$(which whois)" == "/usr/bin/whois" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}whois${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}whois${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}whois${end}${gray}...${end}"
				apt install whois -y
				echo -e "\n ${green}[✔]${end} ${blue}whois${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# zaproxy
			if [ "$(which zaproxy)" == "/usr/bin/zaproxy" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}zaproxy${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}zaproxy${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}zaproxy${end}${gray}...${end}"
				apt install zaproxy -y
				echo -e "\n ${green}[✔]${end} ${blue}zaproxy${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# mapcidr
			if [ "$(which mapcidr)" == "/usr/bin/mapcidr" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}mapcidr${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}mapcidr${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}mapcidr${end}${gray}...${end}"
				rm -rf /usr/bin/mapcidr
				go install github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest
				ln -s $HOME/go/bin/mapcidr /usr/bin/mapcidr
				echo -e "\n ${green}[✔]${end} ${blue}mapcidr${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# dnsx
			if [ "$(which dnsx)" == "/usr/bin/dnsx" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}dnsx${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}dnsx${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}dnsx${end}${gray}...${end}"
				apt install dnsx -y
				echo -e "\n ${green}[✔]${end} ${blue}dnsx${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# amass
			if [ "$(which amass)" == "/usr/bin/amass" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}amass${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}massdns${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}amass${end}${gray}...${end}"
				rm -rf /usr/bin/amass
				rm -rf $HOME/go/bin/amass
				go install github.com/owasp-amass/amass/v4/...@master
				ln -s $HOME/go/bin/amass /usr/bin/amass
				echo -e "\n ${green}[✔]${end} ${blue}amass${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# cero
			if [ "$(which cero)" == "/usr/bin/cero" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}cero${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}cero${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}cero${end}${gray}...${end}"
				rm -rf /usr/bin/cero
				go install github.com/glebarez/cero@latest
				ln -s $HOME/go/bin/cero /usr/bin/cero
				echo -e "\n ${green}[✔]${end} ${blue}cero${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# katana
			if [ "$(which katana)" == "/usr/bin/katana" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}katana${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}katana${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}katana${end}${gray}...${end}"
				rm -rf /usr/bin/katana
				go install github.com/projectdiscovery/katana/cmd/katana@latest
				ln -s $HOME/go/bin/katana /usr/bin/katana
				echo -e "\n ${green}[✔]${end} ${blue}katana${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# httpx
			if [ "$(which httpx)" == "/usr/bin/httpx" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}httpx${end} ${gray}installed...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Reinstalling${end} ${blue}httpx${end}${gray}...${end}"
				rm -rf /usr/bin/httpx
				rm -rf $HOME/go/bin/httpx
				go install github.com/projectdiscovery/httpx/cmd/httpx@latest
				ln -s $HOME/go/bin/httpx /usr/bin/httpx
				echo -e "\n ${green}[✔]${end} ${blue}httpx${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}httpx${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}httpx${end}${gray}...${end}"
				rm -rf /usr/bin/httpx
				rm -rf $HOME/go/bin/httpx
				go install github.com/projectdiscovery/httpx/cmd/httpx@latest
				ln -s $HOME/go/bin/httpx /usr/bin/httpx
				echo -e "\n ${green}[✔]${end} ${blue}httpx${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# unfurl
			if [ "$(which unfurl)" == "/usr/bin/unfurl" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}unfurl${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}unfurl${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}unfurl${end}${gray}...${end}"
				rm -rf /usr/bin/unfurl
				go install github.com/tomnomnom/unfurl@latest
				ln -s $HOME/go/bin/unfurl /usr/bin/unfurl
				echo -e "\n ${green}[✔]${end} ${blue}unfurl${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# gau
			if [ "$(which gau)" == "/usr/bin/gau" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}gau${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}gau${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}gau${end}${gray}...${end}"
				rm -rf /usr/bin/gau
				go install github.com/lc/gau/v2/cmd/gau@latest
				ln -s $HOME/go/bin/gau /usr/bin/gau
				echo -e "\n ${green}[✔]${end} ${blue}gau${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# ctfr
			if [ "$(which ctfr)" == "/usr/bin/ctfr" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}ctfr${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}ctfr${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}ctfr${end}${gray}...${end}"
				git clone https://github.com/UnaPibaGeek/ctfr.git /tmp/ctfr
				pip3 install -r /tmp/ctfr/requirements.txt
				mv /tmp/ctfr/ctfr.py /usr/bin/ctfr
				chmod +x /usr/bin/ctfr
				rm -fr /tmp/ctfr
				echo -e "\n ${green}[✔]${end} ${blue}ctfr${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# gowitness
			if [ "$(which gowitness)" == "/usr/bin/gowitness" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}gowitness${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}gowitness${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}gowitness${end}${gray}...${end}"
				rm -rf /usr/bin/gowitness
				go install github.com/sensepost/gowitness@latest
				ln -s $HOME/go/bin/gowitness /usr/bin/gowitness
				echo -e "\n ${green}[✔]${end} ${blue}gowitness${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# gobuster
			if [ "$(which gobuster)" == "/usr/bin/gobuster" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}gobuster${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}gobuster${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}gobuster${end}${gray}...${end}"
				apt install gobuster -y
				echo -e "\n ${green}[✔]${end} ${blue}gobuster${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# analyticsrelationships
			if [ "$(which analyticsrelationships)" == "/usr/bin/analyticsrelationships" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}analyticsrelationships${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}analyticsrelationships${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}analyticsrelationships${end}${gray}...${end}"
				git clone https://github.com/Josue87/AnalyticsRelationships.git /tmp/analytics
				pip3 install -r /tmp/analytics/Python/requirements.txt
				mv /tmp/analytics/Python/analyticsrelationships.py /usr/bin/analyticsrelationships
				chmod +x /usr/bin/analyticsrelationships
				sed -i '1s/^/#!\/usr\/bin\/env python\n/' /usr/bin/analyticsrelationships
				rm -fr /tmp/analytics
				echo -e "\n ${green}[✔]${end} ${blue}analyticsrelationships${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# nuclei
			if [ "$(which nuclei)" == "/usr/bin/nuclei" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}nuclei${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}nuclei${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}nuclei${end}${gray}...${end}"
				apt install nuclei -y
				echo -e "\n ${green}[✔]${end} ${blue}nuclei${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# nuclei-templates
			find_nucleitemp=$(find / -type d -iname "nuclei-templates" -print -quit 2>/dev/null)
			if [ -n "$find_nucleitemp" ] && [ "$find_nucleitemp" == "/opt/nuclei-templates" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}nuclei-templates${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}nuclei-templates${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}nuclei-templates${end}${gray}...${end}"
				git clone https://github.com/projectdiscovery/nuclei-templates.git /opt/nuclei-templates
				echo -e "\n ${green}[✔]${end} ${blue}nuclei-templates${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi

			# SecLists
			find_seclists=$(find /usr/share/wordlists -type d -iname "seclists" -print -quit 2>/dev/null)
			if [ -n "$find_seclists" ] && [ "$find_seclists" == "/usr/share/wordlists/SecLists" ]; then
				echo -e "\n ${green}[✔]${end} ${gray}The${end} ${blue}SecLists${end} ${gray}directory exist in the path${end} ${blue}/usr/share/wordlists/${end}"
			else
				echo -e "\n ${red}[✘]${end} ${gray}The${end} ${blue}SecLists${end} ${gray}directory doesn't exist...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Downloading${end} ${blue}SecLists${end} ${gray}repository from GitHub...${end}"
				git clone https://github.com/danielmiessler/SecLists.git /usr/share/wordlists/SecLists
				echo -e "\n ${green}[✔]${end} ${blue}SecLists${end} ${gray}directory has been created...${end}"
				sleep 1
			fi
		else
			echo -e "\n ${red}[✘]${end} ${gray}Unsupported Linux distribution${end}"
			exit 1
			tput cnorm
		fi
	else
		echo -e "\n ${red}[!] This script runs only on Linux systems...${end}"
		exit 1
		tput cnorm
	fi
}


# Run BugHunter Scan
runHunter(){
	echo -n -e "\n ${turquoise}[➤]${end} ${gray}Insert target domain:${end}"
	read -p " " domain; echo

	mkdir /root/$domain
	echo -e "\n ${green}[✔]${end} ${gray}Directory${end} ${blue}$domain${end} ${gray}created in /root/ path${end}"

	ip_address=$(ping -c 1 $domain | head -n 1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}')
	echo -e " ${green}[✔]${end} ${gray}Target domain:${end} ${blue}$domain${end} ${green}→${end} ${gray}IP Address:${end} ${blue}$ip_address${end}\n"

	sleep 2

	# nslookup
	mkdir -p "/root/$domain/nslookup"
	nsDir="/root/$domain/nslookup"
	echo -e "\n ${turquoise}[➤]${end} ${gray}Getting DNS server information with nslookup over $domain ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}nslookup -type=ns $domain > "$nsDir/nslookup-type_NS.txt" $domain ${end}"
	nslookup -type=ns $domain > "$nsDir/nslookup-type_NS.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}nslookup -type=A $domain > "$nsDir/nslookup-type_A.txt" ${end}"
	nslookup -type=A $domain > "$nsDir/nslookup-type_A.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}nslookup -query=PTR $ip_address > "$nsDir/nslookup-type_PTR.txt" ${end}"
	nslookup -query=PTR $ip_address > "$nsDir/nslookup-type_PTR.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}nslookup -query=ANY $domain > "$nsDir/nslookup-type_ANY.txt" ${end}"
	nslookup -query=ANY $domain > "$nsDir/nslookup-type_ANY.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}nslookup -query=TXT $domain > "$nsDir/nslookup-type_TXT.txt" ${end}"
	nslookup -query=TXT $domain > "$nsDir/nslookup-type_TXT.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}nslookup -query=MX $domain > "$nsDir/nslookup-type_MX.txt" ${end}"
	nslookup -query=MX $domain > "$nsDir/nslookup-type_MX.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish nslookup...${end}\n"
	
	sleep 2

	# dig
	mkdir -p "/root/$domain/dig"
	digDir="/root/$domain/dig"
	echo -e "\n ${turquoise}[➤]${end} ${gray}Getting DNS server information with dig over $domain ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}dig NS $domain > "$digDir/dig_NS.txt" ${end}"
	dig NS $domain > "$digDir/dig_NS.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}dig $domain @1.1.1.1 > "$digDir/dig_A.txt" ${end}"
	dig $domain @1.1.1.1 > "$digDir/dig_A.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}dig -x $ip_address @1.1.1.1 > "$digDir/dig_PTR.txt" ${end}"
	dig -x $ip_address @1.1.1.1 > "$digDir/dig_PTR.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}dig any $domain @1.1.1.1 > "$digDir/dig_ANY.txt" ${end}"
	dig any $domain @1.1.1.1 > "$digDir/dig_ANY.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}dig txt $domain @1.1.1.1 > "$digDir/dig_TXT.txt" ${end}"
	dig txt $domain @1.1.1.1 > "$digDir/dig_TXT.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}dig mx $domain @1.1.1.1 > "$digDir/dig_MX.txt" ${end}"
	dig mx $domain @1.1.1.1 > "$digDir/dig_MX.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish dig...${end}\n"

	sleep 2

	# whois
	mkdir -p "/root/$domain/whois"
	whoisDir="/root/$domain/whois"
	echo -e "\n ${turquoise}[➤]${end} ${gray}Querying public information on $domain and $ip_address with whois ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}whois $ip_address > "$whoisDir/whois_IP.txt" ${end}"
	whois $ip_address > "$whoisDir/whois_IP.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}whois -h whois.radb.net $ip_address > "$whoisDir/whois_radb.txt" ${end}"
	whois -h whois.radb.net $ip_address > "$whoisDir/whois_radb.txt"
	# ----------------------------------------------------------------------------------------------------
	AS=$(whois -h whois.radb.net $ip_address | grep -w 'origin' | awk '{print $2}')
	echo -e " ${yellow}→${end} ${gray}whois -h whois.radb.net -- '-i origin $AS' > "$whoisDir/whois_AS.txt" ${end}"
	whois -h whois.radb.net -- "-i origin $AS" > "$whoisDir/whois_AS.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}whois -h whois.radb.net -- '-i origin $AS' | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u > "$whoisDir/whois_AS-IPs.txt" ${end}"
	whois -h whois.radb.net -- "-i origin $AS" | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u > "$whoisDir/whois_AS-IPs.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish whois...${end}\n"
	
	sleep 2

	# mapcidr
	# mkdir -p "/root/$domain/mapcidr"
	# mapDir="/root/$domain/mapcidr"
	echo -e "\n ${turquoise}[➤]${end} ${gray}mapcidr: In development... ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish mapcidr...${end}\n"

	sleep 2

	# subfinder
	mkdir -p "/root/$domain/subfinder"
	subDir="/root/$domain/subfinder"
	echo -e "\n ${turquoise}[➤]${end} ${gray}Discovering subdomains of $domain with subfinder ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}subfinder -d $domain -o "$subDir/subfinder_subdomains.txt" ${end}"
	subfinder -d $domain -o "$subDir/subfinder_subdomains.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish subfinder...${end}\n"

	sleep 2

	# dnsx
	mkdir -p "/root/$domain/dnsx"
	dnsxDir="/root/$domain/dnsx"
	echo -e "\n ${turquoise}[➤]${end} ${gray}Querying DNS to discover subdomains and records with dnsx over $domain ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}dnsx -l "$subDir/subfinder_subdomains.txt" -o "$dnsxDir/dnsx_subdomains.txt" ${end}"
	dnsx -l "$subDir/subfinder_subdomains.txt" -o "$dnsxDir/dnsx_subdomains.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish dnsx...${end}\n"

	sleep 2

	# httpx
	mkdir -p "/root/$domain/httpx"
	httpxDir="/root/$domain/httpx"
	echo -e "\n ${turquoise}[➤]${end} ${gray}Discover lives subdomains with httpx over $domain ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}httpx -l "$subDir/subfinder_subdomains.txt" -silent -o "$httpxDir/httpx_allsubdomains.txt" ${end}"
	httpx -l "$subDir/subfinder_subdomains.txt" -o "$httpxDir/httpx_allsubdomains.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${yellow}→${end} ${gray}httpx -l "$subDir/subfinder_subdomains.txt" -silent -cname -title -tech-detect -status-code -mc 200,301,302,400,401,403,404,500,503 -ip -cdn -probe -o "$httpxDir/httpx_commonHTTPcode.txt" ${end}"
	httpx -l "$subDir/subfinder_subdomains.txt" -cname -title -tech-detect -status-code -mc 200,301,302,400,401,403,404,500,503 -ip -cdn -probe -o "$httpxDir/httpx_commonHTTPcode.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${yellow}→${end} ${gray}httpx -l "$subDir/subfinder_subdomains.txt" -silent -status-code -mc 200 -probe -o "$httpxDir/httpx_HTTP200.txt" ${end}"
	httpx -l "$subDir/subfinder_subdomains.txt" -status-code -mc 200 -probe -o "$httpxDir/httpx_HTTP200.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${yellow}→${end} ${gray}cat "$httpxDir/httpx_HTTP200.txt" | cut -d ' ' -f 1 | sed 's/^https:\/\///' > "$httpxDir/httpx_HTTP200-subdomains.txt" ${end}"
	cat "$httpxDir/httpx_HTTP200.txt" | cut -d ' ' -f 1 | sed 's/^https:\/\///' > "$httpxDir/httpx_HTTP200-subdomains.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish httpx...${end}\n"

	sleep 2

	# analyticsrelationship
	mkdir -p "/root/$domain/analyticsRelationships"
	analyticsDir="/root/$domain/analyticsRelationships"
	echo -e "\n ${turquoise}[➤]${end} ${gray}Querying Google Analytics IDs for domains and/or subdomains with analyticsrelationships over $domain ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}httpx -l "$subDir/subfinder.txt" -silent -o "$httpxDir/httpx_allsubdomains.txt" ${end}"
	analyticsrelationships --url https://$domain > "$analyticsDir/analyticsRelationships.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish analyticsrelationships...${end}\n"

	sleep 2

	# cero
	mkdir -p "/root/$domain/cero"
	ceroDir="/root/$domain/cero"
	echo -e "\n ${turquoise}[➤]${end} ${gray}Searching domain names of arbitrary host SSL certificates with cero over $domain ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}cero -d $domain > "$ceroDir/cero.txt" ${end}"
	cero -d $domain > "$ceroDir/cero.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish cero...${end}\n"

	sleep 2

	# katana
	mkdir -p "/root/$domain/katana"
	katanaDir="/root/$domain/katana"
	echo -e "\n ${turquoise}[➤]${end} ${gray}Performing crawling and spidering with katana over $domain ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}katana -u $domain -o "$katanaDir/katana.txt" ${end}"
	katana -u $domain -o "$katanaDir/katana.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}katana -u $domain -jc -kf robotstxt,sitemapxml,securitytxt -o "$katanaDir/katana_filtered.txt" ${end}"
	katana -u $domain -jc -kf robotstxt,sitemapxml,securitytxt -o "$katanaDir/katana_filtered.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}cat $katanaDir/katana.txt $katanaDir/katana_filtered.txt | unfurl --unique domains > "$katanaDir/katana_domains.txt" ${end}"
	cat $katanaDir/katana.txt $katanaDir/katana_filtered.txt | unfurl --unique domains > "$katanaDir/katana_domains.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish katana...${end}\n"

	sleep 2

	# ctfr
	mkdir -p "/root/$domain/ctfr"
	ctfrDir="/root/$domain/ctfr"
	echo -e "\n ${turquoise}[➤]${end} ${gray}Searching certificate transparency logs for subdomains with ctfr over $domain ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}ctfr -org -d $domain -o "$ctfrDir/ctfr.txt" ${end}"
	ctfr -org -d $domain -o "$ctfrDir/ctfr.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}ctfr -org -d $domain | unfurl --unique domains > "$ctfrDir/ctfr_subdomains.txt" ${end}"
	cat "$ctfrDir/ctfr.txt" | unfurl --unique domains > "$ctfrDir/ctfr_subdomains.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish ctfr...${end}\n"

	sleep 2

	# gau
	mkdir -p "/root/$domain/gau"
	gauDir="/root/$domain/gau"
	echo -e "\n ${turquoise}[➤]${end} ${gray}Obtaining known URLs by Open Threat Exchange from AlienVault, Wayback Machine and Common Crawl with gau on $domain ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}gau --threads 2 $domain --o "$gauDir/gau.txt" ${end}"
	gau --threads 2 $domain --o "$gauDir/gau.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}ctfr -org -d $domain | unfurl --unique domains > "$ctfrDir/ctfr_subdomains.txt" ${end}"
	cat "$gauDir/gau.txt" | unfurl --unique domains > "$gauDir/gau_subdomains.txt"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish gau...${end}\n"

	sleep 2

	# amass
	mkdir -p "/root/$domain/amass"
	amassDir="/root/$domain/amass"
	echo -e "\n ${turquoise}[➤]${end} ${gray}amass: In development $domain ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	#echo -e "\n ${turquoise}[➤]${end} ${gray}Scanning with amass over $domain ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	#organization=$(echo $domain | cut -d '.' -f 1)
	#echo -e " ${yellow}→${end} ${gray} HERE ${end}"
	#amass intel -org "$organization" -max-dns-queries 15 -rf ../resolvers.txt > amass_horizontal1.txt
	# ----------------------------------------------------------------------------------------------------
	#organization=$(echo $domain | cut -d '.' -f 1)
	#echo -e " ${yellow}→${end} ${gray} HERE ${end}"
	#amass intel -asn 8911,50313,394161 -max-dns-queries 15 -rf ../resolvers.txt > amass_horizontal2.txt
	# ----------------------------------------------------------------------------------------------------
	#organization=$(echo $domain | cut -d '.' -f 1)
	#echo -e " ${yellow}→${end} ${gray}gau --threads 2 $domain --o "$gauDir/gau.txt" ${end}"
	#amass enum -d $domain -max-dns-queries 15 -rf ../resolvers.txt > amass_vertical.txt
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish amass...${end}\n"

	sleep 2

	# Getting unique subdomains
	#mkdir -p "/root/$domain/subdomain"
	#subDir="/root/$domain/subdomain"
	echo -e "\n ${turquoise}[➤]${end} ${gray}Obtaining unique and live subdomains from $domain scanning ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	echo -e " ${yellow}→${end} ${gray}gau --threads 2 $domain --o "$gauDir/gau.txt" ${end}"
	# ----------------------------------------------------------------------------------------------------
	echo -e "\n ${green}[✔]${end} ${gray}Finish amass...${end}\n"

	sleep 2

	# gowitness
	#mkdir -p "/root/$domain/gowitness"
	#gowitnessDir="/rosot/$domain/gowitness"
	#echo -e "\n ${turquoise}[➤]${end} ${gray}Taking multiple screenshots of web pages with gowitness on the main domain scope ${end}\n"
	# ----------------------------------------------------------------------------------------------------
	#echo -e " ${yellow}→${end} ${gray}gau --threads 2 $domain --o "$gauDir/gau.txt" ${end}"
	#gowitness file -f "AQUIFALTA" -P "$gowitnessDir/screenshots/"  --chrome-path /usr/bin/firefox-esr
	# ----------------------------------------------------------------------------------------------------
	#echo -e "\n ${green}[✔]${end} ${gray}Finish gowitness...${end}\n"
}

# Help menu
help_menu() {
    echo -e "\n ${yellow}Usage:${end}"
	echo -e " ${yellow}Menu options:${end}\n"
    echo -e " 	${turquoise}1${end}, ${purple}upHunter${end}	${gray}Updates the system and installs the required tools for BugBounty environment${end}"
	echo -e " 			${gray}Tools installed:${end}"
	echo -e " 			 ${yellow}→${end} ${gray}whois${end}"
	echo -e "			 ${yellow}→${end} ${gray}zaproxy${end}"
	echo -e "			 ${yellow}→${end} ${gray}mapcidr${end}"
	echo -e "			 ${yellow}→${end} ${gray}dnsx${end}"
	echo -e "			 ${yellow}→${end} ${gray}massdns${end}"
	echo -e "			 ${yellow}→${end} ${gray}cero${end}"
	echo -e "			 ${yellow}→${end} ${gray}katana${end}"
	echo -e "			 ${yellow}→${end} ${gray}httpx${end}"
	echo -e "			 ${yellow}→${end} ${gray}unfurl${end}"
	echo -e "			 ${yellow}→${end} ${gray}gau${end}"
	echo -e "			 ${yellow}→${end} ${gray}ctfr${end}"
	echo -e "			 ${yellow}→${end} ${gray}gowitness${end}"
	echo -e "			 ${yellow}→${end} ${gray}analyticsrelationships${end}"
	echo -e "			 ${yellow}→${end} ${gray}gobuster${end}"
	echo -e "			 ${yellow}→${end} ${gray}nuclei${end}"
	echo -e "			 ${yellow}→${end} ${gray}nuclei-templates${end}"
	echo -e "			 ${yellow}→${end} ${gray}SecLists${end} \n"
    echo -e " 	${turquoise}2${end}, ${purple}runHunter${end}	${gray}Start with the footprinting and fingerprinting process${end}\n"
}

# Menu options function
menu_function(){
	while true; do
		echo -e "\n ${turquoise}[➤]${end} ${gray}Select option want to execute (enter the option number):${end} \n"
		echo -e " 	${turquoise}1)${end} ${purple}upHunter${end}"
		echo -e " 	${turquoise}2)${end} ${purple}runHunter${end}"
		echo -e " 	${turquoise}3)${end} ${purple}Exit${end} \n"

		read -p " -> Insert option number: " number; echo

		case $number in
			1) # upHunter
				upHunter
				;;
			2) # runHunter
				runHunter
				;;
			3) # exit
				echo -e " ${red}[!] Bye Hunter...${end} \n"
				exit 0
				;;
			*)
				echo -e "${red}[!] Error: Invalid format.\n[*] Try again.${end} \n"
				# exit 1
				;;
		esac
	done
}

# REDIRECT: HELP MENU
if [[ "$1" = "-h" || "$1" = "--help" ]]; then
	help_menu
    exit 0
fi

# Main function
main_function(){
	if [ "$(id -u)" == "0" ]; then
		menu_function
	else
		echo -e "\n ${red}[!] Please, connect as root user${end}\n"
		tput cnorm
	fi
}



####################################################
#################### RUN SCRIPT ####################
####################################################
clear
print_banner
main_function
