sudo dpkg  --add-architecture i386
team_viewer=teamviewer_i386.deb

tv_error()
{


			sudo apt -f install
			sudo apt update
			sudo dpkg -i teamviewer_i386.deb

}


if [ ! -f "$team_viewer" ];
		then
			wget https://download.teamviewer.com/download/teamviewer_i386.deb
			sudo dpkg --add-architecture i386
			sudo dpkg -i teamviewer_i386.deb && echo "ok" || tv_error


fi


tv_error
wget https://go.skype.com/skypeforlinux-64.deb
sudo dpkg -i skypeforlinux-64.deb

