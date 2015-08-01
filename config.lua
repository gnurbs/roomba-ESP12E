-- this contains site configuration
-- pixel format: [ G,R,B ]


wakeup_pin = 8
gpio.mode(8, gpio.OUTPUT)
gpio.write(wakeup_pin, gpio.HIGH)

uart.setup( 0, 115200, 8, 0, 1, 0 )
-- start
uart.write( 0, 128)
tmr.delay(50000)
uart.write( 0, 130)
tmr.delay(50000)

ESSID = 'APF_swooooosh'

