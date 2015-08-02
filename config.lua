-- this contains site configuration
-- pixel format: [ G,R,B ]


wakeup_pin = 8
gpio.mode(8, gpio.OUTPUT)
gpio.write(wakeup_pin, gpio.HIGH)

uart.setup( 0, 115200, 8, 0, 1, 0 )
-- start

function roomba_tx(a)
    -- this sends a single byte to roomba - TODO: extend to arbitrary length!
    uart.write(0,string.char(a))
    tmr.delay(50000)
end

roomba_tx(128)
roomba_tx(130)
roomba_tx(135)

ESSID = 'APF_swooooosh'

