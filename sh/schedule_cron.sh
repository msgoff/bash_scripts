#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "* * * * * bash ~/screenshot.sh" >> mycron
#install new cron file
crontab mycron
rm mycron
