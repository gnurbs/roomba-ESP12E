dofile('config.lua')

gpio.mode(0,gpio.OUTPUT)
gpio.write(0,gpio.LOW) -- low is the new high, i.e. LED on

wifi.setmode(wifi.STATION)
wifi.sta.config(ESSID,PSK)
tmr.delay(500000)
dofile('server.lua')
dofile('uart_rx_timeout.lua')
