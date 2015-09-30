# ESP12E WiFi microcontroller for Roombas

track and (remote-) control Roombas

## Hardware
current focus - see [hardware branch](https://github.com/gnurbs/roomba-ESP12E/tree/hardware)
- connects to Roomba's serial Port
- ESP12E module
- buck power converter
- serial header for programming / observing Roomba / ESP12E communication for debugging
- expansion header with unused ESP12E pins 

## ESP12E Software
we're using the [nodemcu Firmware](https://github.com/nodemcu/nodemcu-firmware)
- udp2uart: udp <-> uart proxy. Broken as we need hardware to continue
- server.lua: very limited Rooomba controlling HTTP server that can trigger wakeup, short straight drive and clean
- lib.lua: helper functions one would expect in the std library, added and with functionality as needed
