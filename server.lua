dofile('config.lua')

-- this server for ws2811//ws2812 leds listens on port32/UDP
-- ``connection'' to a unique controller is maintained by only accepting packages
-- from the same ip with increasing serial if the last accepted package was received
-- less than 1s ago.

-- packet structure:
-- 32B SHA256sum, 4B serial, u8(1), 4B position, [0..157] RGB tuples

-- "returns" every SHA256sum of successful received and applied package
-- hashsums run over serial, command, position and RGB tuples

local packetStruct = {
32, -- sha256
 4, -- serial
 1, -- command
 4  -- position
}
local headerlen = 41 -- sum of packetStruct

local last_packet = -1
send_inhibit = false

function freeToSend()
    send_inhibit = false
end

function rx(sock,packet)
	hash, serial, command, position, data = struct_unpack(packet,packetStruct)
	 -- implement hash comparison
	serial,command,position = unpack(map(uint,{serial,command,position}))
    if serial <= last_packet then print("non-incrementing serial") return -1 end
    len = #data-headerlen
    if position+len>ws_len then print("attempt to write after end of buffer") return -2 end
    retval=1
    if      command==0 then
    elseif command==1 then retval=ws2812.FB_write(position,data)
    elseif command==2 then retval=ws2812.FB_write(position,data:sub(1,3):rep(ws_len))
    elseif command==3 then
		ws2812.writergb(1,data:sub(1,3):rep(50))
		ws2812.writergb(2,data:sub(1,3):rep(145))
		ws2812.writergb(3,data:sub(1,3):rep(150))
    end
	if retval==0 then
		while send_inhibit do end -- wait for any tx to finish
		send_inhibit = true
		sock:send(hash,freeToSend)
		return 0
	else return -1
	end
end

ws2812.init_FB(ws_len,ws_pin)
server = net.createServer(net.UDP)
server:on("receive",rx)
server:listen(32)

-- todo implement "read" also port32/UDP 32B SHA256sum, u32(serial), u8(0), 4B position
