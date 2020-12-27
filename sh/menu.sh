#!/bin/bash
# A menu driven shell script sample template 
## ----------------------------------
# Step #1: Define variables
# ----------------------------------
#https://bash.cyberciti.biz
EDITOR=vim

RED='\033[0;41;30m'
STD='\033[0;0;39m'
 
# ----------------------------------
# Step #2: User defined function
# ----------------------------------
# grep -zP "(?s)def .*?\n[^\s]" sets.py --color=always


pause(){

read -p "Press [Enter] key to continue..." fackEnterKey
}
data_file(){
	ls
	echo "Input Filename"
        read filename
	cat  $filename  > data
	echo $filename > filename
	mkdir data_files
}

# do something in two()
w_get(){
	echo "wget url, Please paste url"
        echo "F to use the urls in the data file"
	read url
	if [ "$url" == "F" ];then
		for line in $(cat data);do echo "$line";done
	else 
		echo "Enter the file name to save to"
		read html
		wget -O $html  $url 
		filename=$html
		cat $html > data
		echo $filename > filename
	fi
	pause
}


grep_forward(){
        echo "type in keywords or patters to search for"


	pattern =""

	while [ "$pattern" != "Q" ]
	echo "type in words or patterns to filter content"
	echo "Q to quit"
	echo "result will be saved in data"
	do
	cat data
	read pattern
	if [ "$pattern" == "Q" ];then
	break
	fi
             
	clear
	if [ "$pattern" == "R"  ];then 
	
	
	cat data|rev | grep -oP "$pattern.*"  > /tmp/data
        cat /tmp/data > data

	else
	
		cat data | grep -oP "$pattern.*"  > /tmp/data
		cat /tmp/data > data
	fi
	#read pattern
	done


#cat $1
#i="True"
#echo "Q to quit"
#delete_patters=""
#while [ "$i" != "Q" ]
#do
#read i j
#delete_patterns+="$i|"
#echo $delete_patters
#sed -re 's/"'${delete_patterns::-1}'"/"'$j'"/g' $1
#done
}

grep_backwards(){
        echo "type in keywords or patters to search for"
        cat $(cat filename)>data

        pattern =""

        while [ "$pattern" != "Q" ]
        echo "type in words or patterns to filter content"
        echo "Q to quit"
        echo "result will be saved in data"
        do
        cat data
        read pattern
        if [ "$pattern" == "Q" ];then
        break
        fi

        clear
        cat data | grep -oP ".*$pattern"  > /tmp/data
        cat /tmp/data > data
        #read pattern
        done
}




browse(){
	cat data|fzf -m --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all --print-query >/tmp/data
	cat /tmp/data > data
	sed -n '1p' data >> queries
	sed -e '1d' data
}


six(){

	 cat $(cat  filename) > data

}

seven(){

i="True"
echo "Q to quit"
delete_patters=""
while [ "$i" != "Q" ]
do
cat data
echo "input pattern or word to remove"
read i

delete_patterns+="$i|"
echo $delete_patters
sed -re 's/"'${delete_patterns::-1}'"//g' data > /tmp/data
cat /tmp/data > data
cat data
done


}
eight(){
cat data | fzf --query "'.edu" | "'.com"
}

queries(){
cat data | fzf --query "$(tail -n 1000  queries |fzf)" -m --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all --print-query > /tmp/data
cat /tmp/data > data
}

save(){
echo "Input File name"
read fname
cat data > $fname
}


loop(){
echo "pass the filename to be looped over and the function to apply to the data"
echo "such as loop_file_1 echo"
read fname
read fnctn
for line in $(cat $fname );do $fnctn $line;done
pause
}


vocab(){
cat data | sed -re 's/\./\n/g'|sed -re 's/^\s//g'|sed -re 's/\s/\n/g'|grep -ivwf stop_words|sed -re 's/\,|:|\(|\)|\[|\]|\"|\?//g'|grep -v "[0-9]"|sed -n '/.\{5\}/p'|sed -re "s/^'|\-\-$|;//g"|sort|uniq -c |sort -n| tee vocab
cat vocab|grep -E "[A-Z].*" > vocab_caps
grep -vf vocab_caps vocab >/tmp/vocab
cat /tmp/vocab > lc_vocab
paste lc_vocab vocab_caps| expand -t 13|more
pause
echo "an upper case filter has been saved to vocab_caps"
}


md5_revised(){
#only works for local directory, but has the correct naming convention.
#time find . -type f |xargs -P 0 md5sum|tee $(pwd|rev|cut -d"/" -f1|rev)"_md5s_"$(date|sed -re 's/\s+/_/g')
time find . -type f |xargs -P 0 md5sum | tee data
pause
}


EDIT_MENU(){
vim menu.sh
}

g_hub_repos(){
echo "input username"
read username
w3m https://api.github.com/users/$username/repos > /tmp/repos
less /tmp/repos  | sed -re 's/\,/\n/g'|grep html_url|cut -d":" -f2-|tr -d '"'|sort | uniq > data
cat data >> repos
}

g_clone(){
for line in $(cat data);do git clone "$line".git ;done
mkdir ../g_clone
find . -type d -maxdepth 1 -exec mv "{}" ../g_clone \;
pause
}

ram_disk(){
echo "How much ram do you want to allocate to your ramdisk in MB?"
free -h|grep available -A 1 --color=always 
read ram_mbs
sudo mkdir /mnt/ramdisk
sudo mount -t tmpfs -o size="$ram_mbs"m tmpfs /mnt/ramdisk
df -h | grep ramdisk --color=always
pause
}


urls ()
{
	cat data | grep -P "(?:http|href).*?(\s|$)|\w+\.(com|org|net|gov).*?(\s|$)" -o | sort > /tmp/data
	cat /tmp/data > data
}

flatten_dir(){

move(){  echo $line;ftype=$line; mkdir  "$ftype"_ft; find . -type f -name "*."$ftype -exec mv --backup=t {} "$ftype"_ft/ \;; }
for line in $(cat ftypes);do dest="$line"_ft;echo $dest;ls $dest|wc -l;move $line;ls $dest|wc -l;done
pause
}



Install(){
echo "installing w3m git redis vim fzf"
echo ""
sudo add-apt-repository universe
sudo apt-get update
sudo apt install w3m git redis-server vim
sudo apt install python-pip
sudo pip install --upgrade pip
pip install jupyter
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
source ~/.bashrc
source menu.sh
}


sed_replace(){
src=""
while [ "$src" != "Q" ]
do
cat data
echo "input pattern to replace: Q to quit"
read src
echo "replace with ? "?
read dst
echo sed -re "s/$src/$dst/g" data >> sed_file
sed -re "s/$src/$dst/g" data > /tmp/data
cat /tmp/data > data
done
pause
}


git_push(){
git add -A
echo "input message"
read message
git commit -m $message
git push 

}


f_types(){
find . -type f|rev|cut -d"." -f1|rev|grep -v "/"|sort|uniq -c|grep -v "~"|rev|cut -d" " -f1|rev>ftypes
}
# function to display menus
stats(){
echo "results saved in stats"
cat data|sort|uniq -c | sort -n >stats
cat stats
pause
}

show_menus() {
	clear
        cat test
	echo ""
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo "						 M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""
echo ""
echo " S.  Set Data File Name                      B.   Browse Data                  ST.  Stats                          M.  MD5 Checksum on Directory"
echo "                                                                       "
echo "SD. Set Working Directory                   GF.   Grep Forward                 WG.  Wget Urls "
echo "                                                                   "
echo "FD. Flatten Directory by File Type                                              W.  W3m  Urls"
echo ""
echo "FT. list file types -> ftypes file          SR.   Sed Replace                  FF.  Firefox Urls"
echo "                              "
echo "SF. save file                                R.   Reset file                    G.  list Public Github Repos                    "
echo " "
echo " E. Edit Menu                                                                  GC.  Git clone selected Repos"
echo ""
echo " I. Install Application Dependencies                                           GP.  Git add, commit push for local dir"
echo ""
echo "RD. Create Ram Disk"
echo ""
echo ""



}
# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 3 form the menu option.
read_options(){
	local choice
	read -p "Enter choice [ 1 - 10] " choice
	case $choice in
		S|s) data_file ;;
		WG|wg) w_get ;;
		B|b) browse ;;
		4) queries ;;
		GF|gf) grep_forward ;;
		R|r) six ;;
		SF|sf) save;;
		RD|rd) ram_disk ;;
		9) loop;;
		M|m) md5_revised ;;
		E|e) EDIT_MENU ;;
		G|g) g_hub_repos ;;
		GC|gc) g_clone ;; 
		V|v) vocab ;;
		U|u) urls ;;
		FD|fd) flatten_dir ;;
		I|i) Install ;;
                SR|sr) sed_replace ;;
	        GP|gp) git_push ;;
	        FT|ft) f_types ;;
		ST|st) stats ;;
		0) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
esac
}

# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
 
	show_menus
	read_options
done

