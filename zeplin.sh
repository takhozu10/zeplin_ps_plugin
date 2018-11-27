#!/bin/bash
#
# # #
# MIT License
#
# Copyrigth (c) 2018 Tak Hozumi.
#
#   Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
#   associated documentation files (the "Software"), to deal in the Software without restriction, including
#   without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
#   following conditions:
#
#   The above copyright notice and this permission notice shall be included in all copies or substantial
#   portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
#   NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
#   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# # #

# # #
# Zeplin Adobe Photoshop Integration
#
# Written by: Tak Hozumi : End User Support Engineer : Big Lots Stores, Inc.
#
# Created on: Nov 26, 2018
# Modified on:
# Version: 1.0.0
# # #

## Set VARIABLE
loggedinuser=$(stat -f%Su /dev/console)

cd /tmp
curl -L -o 'io.zeplin.photoshop-plugin.zip' "https://rink.hockeyapp.net/api/2/apps/cf961a67634546e1907efc9e96664190?format=zip"
curl -L -o 'io.zeplin.photoshop-panel.zip' "https://rink.hockeyapp.net/api/2/apps/28b2b8cb22e849c0b30669350c503068?format=zip"
unzip 'io.zeplin.photoshop-plugin.zip'
unzip 'io.zeplin.photoshop-panel.zip'

if [[ -e '/Applications/Adobe Photoshop CC 2018/Adobe Photoshop CC 2018.app' ]];
then
  #Install Zeplin Photoshop Plugin
  echo 'Installing Zeplin Intengration for Photoshop CC 2018'
  cp -R '/tmp/io.zeplin.photoshop-plugin' '/Applications/Adobe Photoshop CC 2018/Plug-ins/Generator/'
fi

if [[ -e '/Applications/Adobe Photoshop CC 2017/Adobe Photoshop CC 2017.app' ]];
then
  #Install Zeplin Photoshop plugin
  echo 'Installing Zeplin Intengration for Photoshop CC 2017'
  cp -R '/tmp/io.zeplin.photoshop-plugin' '/Applications/Adobe Photoshop CC 2017/Plug-ins/Generator/'
fi

cp -R '/tmp/io.zeplin.photoshop-panel' "/Users/$loggedinuser/Library/Application Support/Adobe/CEP/extensions/"
echo "Installed Photoshop panel for user $loggedinuser"

/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
  -windowType utility -title "Zeplin Photoshop Integration" -alignHeading center -alignDescription left \
  -description 'Now when you restart your Photoshop, you should see the panel in the menu up top: “Window > Extensions > Zeplin”' -button1 Ok -defaultButton 1 &
