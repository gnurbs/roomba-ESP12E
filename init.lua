dofile('config.lua')
ws2812.init_FB(ws_len, ws_pin)
ws2812.FB_write(0,white2k7:rep(ws_len))

dofile('lib.lua')
wifi.setmode(wifi.STATION)
wifi.sta.config(ESSID,PSK)
ip = wifi.sta.getip()
dofile('server.lua')

