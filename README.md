# raspberry-chromium-kiosk
Installs packages and sets up an chromium kiosk mode for public displays or so..

Testet Raspbian version Raspbian Buster with desktop September 2019

Usage

If you already have an image, you can aktivate SSH in Linux using the raspbian-image-enable-ssh script on http://aoakley.com/articles/2016-12-05-raspbian-enable-ssh.php
Alternatively, there is JFox-sk/raspbian-ssh. But I didn't test it.

1.
First set up your Raspberry with
  sudo raspi-config
Make sure to set your network settings and time settings. The time settings are needed to perform a dayly reboot. 

2.
Then you can change the two script variables.
-URL:  points to the website you want to show. 
-REFRESH_MIN: the refresh time of the webpage.

The reboot time is hardcoded on the end of the file. It reboots will be performed at 00:00 o'clock.

3.
Then you can run the file, it will automatically reboot. And start chromium in kiosk mode.
  Run the script with sudo!
