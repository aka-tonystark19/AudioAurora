----wifi.setmode(wifi.STATIONAP)
----wifi.ap.config({ssid="AudioAuroraWiFi", auth=wifi.OPEN})
---- connect to WiFi access point (DO NOT save config to flash)
--wifi.setmode(wifi.STATION)
--station_cfg={}
--station_cfg.ssid = "AudioAurora1"
--station_cfg.pwd = "AudioAurora"
--station_cfg.save = false
--wifi.sta.config(station_cfg)
--
--
----
--cfg =
--{
--    ip="192.168.137.42",
--    netmask="255.255.255.0",
--    gateway="192.168.1.1"
--}
--
--wifi.sta.setip(cfg)
--ip, nm, gw=wifi.sta.getip()
--print("\nIP Info:\nIP Address: "..ip.." \nNetmask: "..nm.." \nGateway Addr: "..gw.."\n")
--
--
--
--
--uart.write(0,'1')
--
--


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
    print(payload)
    uart.write(0,payload)
    sck:send("HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n<h1> Hello, NodeMCU. </h1>")
  end)
  conn:on("sent", function(sck) sck:close() end)
end)

--cfg =
--{
--    ip="192.168.137.42",
--    netmask="255.255.255.0",
--    gateway="192.168.1.1"
--}
--wifi.sta.setip(cfg)


