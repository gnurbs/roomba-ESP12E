-- this contains site configuration
-- pixel format: [ G,R,B ]


wakeup_pin = 8
gpio.mode(8, gpio.OUTPUT)
gpio.write(wakeup_pin, gpio.HIGH)

ESSID = 'APF_swooooosh'

