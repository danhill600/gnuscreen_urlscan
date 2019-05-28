#!/bin/bash

# I use this to get a list of links viewable on the current window 
#in gnu screen.  
#I add the following to my .screenrc:
#
##linkscan
#bindkey "^[u" eval 'hardcopy .screen_hardcopy.txt' split 'focus down' 'screen -t links geturls.sh'
#-dmh 20190528
url_list=$(grep -o http[s?]://[A-Za-z0-9/\.%~_-]* ~/.screen_hardcopy.txt)

count=0
for url in $url_list
do
	let count=$count+1
	echo " $count) $url"
done
count=0

read -p "Make your link selection:" link_no

for url in $url_list
do
	let count=$count+1
	if [ $count == $link_no ]
		then
			firefox $url
	fi
done

screen -S main -X remove 


