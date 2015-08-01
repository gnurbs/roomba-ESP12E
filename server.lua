----------------
-- Web Server --
----------------
print("Starting Web Server...")
-- Create a server object with 30 second timeout
srv = net.createServer(net.TCP, 30)

-- server listen on 80, 
-- if data received, print data to console,
-- then serve up a sweet little website
srv:listen(80,function(conn)
	conn:on("receive", function(conn, payload)
		--print(payload) -- Print data from browser to serial terminal
	
		function esp_update()
            mcu_do=string.sub(payload,postparse[2]+1,#payload)
            
            if mcu_do == "wakeup" then 
				gpio.write(wakeup_pin, gpio.LOW)
				tmr.delay(500000)
				gpio.write(wakeup_pin, gpio.HIGH)

            end
            
            if mcu_do == "Read+ADC" then
            	adc_value = adc.read(adc_id)
				print("ADC: ", adc_value)
            end
        end

        --parse position POST value from header
        postparse={string.find(payload,"mcu_do=")}
        --If POST value exist, set LED power
        if postparse[2]~=nil then esp_update()end


		-- CREATE WEBSITE --
        
        -- HTML Header Stuff
        conn:send('HTTP/1.1 200 OK\n\n')
        conn:send('<!DOCTYPE HTML>\n')
        conn:send('<html>\n')
        conn:send('<head><meta  content="text/html; charset=utf-8">\n')
        conn:send('<title>ESP8266 Blinker Thing</title></head>\n')
        conn:send('<body><h1>ESP8266 Blinker Thing!</h1>\n')
       	
        -- Labels
        conn:send('<p>ADC Value: '..adc_value..'</p><br>')
        conn:send('<p>PWM Frequency (Input High): '..adc_value..'Hz</p>')
			conn:send('<p>or</p>')
        conn:send('<p>PWM Duty Cycle (Input Low): '..(adc_value * 100 / 1024)..'%</p><br>')

       	-- Buttons 
       	conn:send('<form action="" method="POST">\n')
       	conn:send('<input type="submit" name="mcu_do" value="wakeup">\n')
        conn:send('<input type="submit" name="mcu_do" value="fahren">\n')
        conn:send('<input type="submit" name="mcu_do" value="musik">\n')
        conn:send('</body></html>\n')
        conn:on("sent", function(conn) conn:close() end)
	end)
end)

                  


