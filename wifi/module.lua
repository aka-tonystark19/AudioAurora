tmr = require("tmr")

-- Connect to WiFi
wifi.setmode(wifi.STATION)
--wifi.sta.config("AudioAurora1", "AudioAurora")
wifi.sta.config({ssid="AudioAurora", pwd="AudioAurora"})

wifi.sta.connect();


---- a simple HTTP server
srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
  conn:on("receive", function(sck, payload)
    --print(payload)

--    function sleep(seconds)
--        os.execute("sleep " .. tonumber(seconds))
--    end
    
    local str = payload
    uart.write(0,0);
    for i = 1, #str do
        local char = string.sub(str, i, i)
--        sleep(0.2)
        uart.write(0,char)
--        if(char == '?' || char == '~')  
--        then 
--            print(char)
--            --send acknowledgement to nodejs server
--            sck:send("A")
--        else
--            uart.write(0,char)     
    end
--    for i = 1, #myString*2-1 do
--        if i % 2 == 0 then
--        uart.write("#")
--    else
--        uart.write(string.sub(myString, (i+1)/2, (i+1)/2))
--    end
-- end
--    uart.write(0,"\n")
    conn:send("ACK"); 
--    uart.write(0,payload)
--    sck:send("HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n<h1> Hello, NodeMCU. </h1>")
  end)
--  conn:on("sent", function(sck) sck:close() end)
end)

--cfg =
--{
--    ip="192.168.137.42",
--    netmask="255.255.255.0",
--    gateway="192.168.1.1"
--}
--wifi.sta.setip(cfg)


