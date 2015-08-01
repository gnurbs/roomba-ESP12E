dofile('config.lua')
node.led(0)
wifi.setmode(wifi.STATION)
wifi.sta.config(ESSID,PSK)
ip = wifi.sta.getip()
dofile('server.lua')

