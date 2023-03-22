tmr = require("tmr")

wifi.setmode(wifi.STATION)
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