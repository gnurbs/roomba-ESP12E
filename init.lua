dofile('config.lua')

dofile('lib.lua')
wifi.setmode(wifi.STATION)
wifi.sta.config(ESSID,PSK)
ip = wifi.sta.getip()
dofile('server.lua')

