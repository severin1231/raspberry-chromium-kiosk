#!/bin/bash

#### info:
# Autor:     Béla Richartz
# Created:   13. Jan 2020
# Last edit: 30. Jan 2020

#### function:
# Install script for Raspberry Kiosk mode (Webpage).
# Performs update / upgrade
# and installs the packages chromium, x11-xserver-utils, unclutter, xdotool.
# creates script for refreshing webpage
# Then Changes startup file (/etc/xdg/lxsession/LXDE-pi/autostart)
# sets auto reboot at 0:00 o'clock, so dont forget to se the time.
# perform a reboot to finish install


#### Variables
###############################
URL="https://www.linux.org/"
REFRESH_MIN="2"			        # Don't use floating-point number. Example: Use 2/4*3 instead of 1.5 
###############################


# update / upgrade
sudo apt-get update && sudo apt-get upgrade -y


# installing packages
sudo apt-get install -y chromium-browser x11-xserver-utils unclutter xdotool


# Create reload script
touch /home/pi/reload_chromium.sh
sudo chmod +x /home/pi/reload_chromium.sh
sudo echo "
#!/bin/bash
while true; do
        sleep $((60*$REFRESH_MIN))
        xdotool key \"ctrl+r\"
done
" > /home/pi/reload_chromium.sh



# Rewriting the "autostart" file
sudo mv /etc/xdg/lxsession/LXDE-pi/autostart /etc/xdg/lxsession/LXDE-pi/autostart_old
sudo touch /etc/xdg/lxsession/LXDE-pi/autostart
sudo chmod 644 /etc/xdg/lxsession/LXDE-pi/autostart
sudo echo "
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
# @xscreensaver -no-splash

/home/pi/reload_chromium.sh

@point-rpi
@xset s off
@xset -dpms
@xset s noblank

@sed -i 's/\"exited_cleanly\": false/\"exited_cleanly\": true/' ~/.config/chromium/Default/Preferences
@chromium-browser  --disable-restore-session-state --disable-session-crashed-bubble --noerrdialogs --disable-features=TranslateUI --disable-infobars --incognito --kiosk $URL
" > /etc/xdg/lxsession/LXDE-pi/autostart


# Configure dayly reboot
sudo echo "
0 0 * * * root reboot
" >> /etc/crontab

# rebooting the raspberry
sudo reboot

##############################
#### End of functionality ####
##############################


#### Doku
# This script is an automation of the tutorial written by 'Dan Purdy' from 2014
# URL:          https://www.danpurdy.co.uk/wp-content/cache/page_enhanced/www.danpurdy.co.uk/web-development/raspberry-pi-kiosk-screen-tutorial/_index.html

# EOF
