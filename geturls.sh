#!/bin/bash

# I use this to get a list of links viewable on the current window 
#in gnu screen.  
#I add the following to my .screenrc:
#
##linkscan
#bindkey "^[u" eval 'hardcopy .screen_hardcopy.txt' split 'focus down' 'screen -t links geturls.sh'
#-dmh 20190528
screen -X eval "hardcopy .screen_hardcopy.txt"

url_list=$(grep -o http[s]*://[A-Za-z0-9/\.%~_-+]* ~/.screen_hardcopy.txt)

count=0
for url in $url_list
do
	let count=$count+1
	echo " $count) $url"
done
if [[ count -eq 0 ]]; then
	echo "There are no links my friend."
	sleep 6 
	exit 1
fi

count=0

read -p "Make your link selection:" link_no

for url in $url_list; do
	let count=$count+1
	if [[ $count == $link_no ]]; then
		if [[ $url =~ .*.png ]] || [[ $url =~ .*jpg ]]; then
			feh --scale-down --auto-zoom $url	
		else
			firefox $url
		fi
	fi
done



