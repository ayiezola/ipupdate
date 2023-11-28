#!/usr/bin/bash

# Set curl command to update the IP
command="curl https://api.dnsexit.com/dns/ud/?apikey=??? -d host=xxx.xx.xx.xx"

if [ -d "/var/log" ]; then
 command="$command >> /var/log/ipupdate.log"
fi

# Get the existing crontab content
existing_crontab=$(crontab -l 2>/dev/null)

# Check if the command is already in crontab
if [[ $existing_crontab == *"$command"* ]]; then
    echo "Scheduled job already exists in crontab."
else
    # Add the scheduled job to the existing crontab content
    new_crontab="${existing_crontab}
*/12 * * * * $command"

    # Install the modified crontab
    echo "$new_crontab" | crontab -
    echo "Scheduled job added to crontab."
