ESSID = 'APF_swooooosh'

wifi.setmode(wifi.STATION)
wifi.sta.config(ESSID,PSK)
srv = net.createServer(net.UDP)
reqAnsLen = { 26,10,6,10 }

-- setup UART to 115200 8N1
uart.setup(0,115200,8,0,1,0)

-- poke roomba awake
gpio.mode(8,gpio.OUTPUT)
gpio.write(8,1)
tmr.delay(50000)
gpio.write(8,0)
gpio.mode(8,gpio.INPUT)

-- light up user LED
gpio.mode(0,gpio.OUTPUT)
gpio.write(0,0) -- low is the new high, i.e. LED is connected to vcc

function uart_rx_cb(c)
    -- writes from uart to data
    -- the uart rx callback is extremely strange:
    -- it goes into a loop if it does not deregister itself. SWTF.
    -- maybe it does not go into loop, but rather while rx cb registered no chars
    -- go to lua shell, so it is effectively disconnected

    srv:send(c)
    uart.on('data')
end

function rx2uart(sock,cmd)
    if cmd:byte(1) == 142 then
        local len = reqAnsLen[cmd:byte(2)]
        -- deregister callback if no data received
        tmr.alarm(0,30,0,function() uart.on('data') end)
        uart.on('data',len,uart_rx_cb,0)
    end
    uart.write(0,cmd)
 end

srv:listen(33)
srv:on('receive',rx2uart)
