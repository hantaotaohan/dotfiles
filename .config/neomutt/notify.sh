#!/bin/bash
# Windows User 
# In Powershell run > Install-Module -Name BurntToast

#run OfflineIMAP once, with quiet interface
#offlineimap -o -q -u quiet

# Windows User 
# In Powershell run > Install-Module -Name BurntToast

maildirnew="$HOME/mail/bteb/INBOX/new/"
maildirnew1="$HOME/mail/live/Inbox/new/"
new="$(find $maildirnew -type f | wc -l)"
new1="$(find $maildirnew1 -type f | wc -l)"

#count old mail for every maildir
# maildirold="$HOME/Maildir/*/*/cur/"
# old="$(find $maildirold -type f | wc -l)"

if [ $new -gt 0 ] || [ $new1 -gt 0 ]
then
     # dunstify -r 7777 -a "neomutt" normal  "New mail! \n\nBTEB: $new   HOTMAIL: $new1"
     dunstify -i /usr/share/icons/Adwaita/32x32/legacy/mail-unread.png -r 7777 -a "neomutt" -u c critical "New mail! \n\nBTEB: $new   HOTMAIL: $new1"
fi

# powershell.exe -Command New-BurntToastNotification -Text "NewMail", "BTEB：$new",  "HOTMAIL：$new1"
