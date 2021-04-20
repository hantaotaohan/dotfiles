#!/bin/bash
# Windows User 
# In Powershell run > Install-Module -Name BurntToast

maildirnew="$HOME/mail/bteb/INBOX/new/"
maildirnew1="$HOME/mail/live/Inbox/new/"
new="$(find $maildirnew -type f | wc -l)"
new1="$(find $maildirnew1 -type f | wc -l)"

if [ $new -gt 0 ] || [ $new1 -gt 0 ]
then
    powershell.exe -Command New-BurntToastNotification -Text "NewMail", "BTEB：$new",  "HOTMAIL：$new1"
fi
