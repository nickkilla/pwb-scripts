require 'socket'

def usage
    puts 'ruby smtp-user-vrfy.rb -u <filename of users> -h <filename of hosts> -o <output file>'
    puts 'users file should have a single username per line'
    puts 'hosts file should have a single host per line'
    puts 'output file is optional'
    exit
end

usage() if ARGV.count < 4 and ARGV[0] != '-u' and ARGV[2] != '-h'

users = File.expand_path(ARGV[1])
hosts = File.expand_path(ARGV[3])

log = nil

if ARGV.count > 5 and ARGV[4] == '-o'
    log = File.open(File.expand_path(ARGV[5]), 'w')
    puts "logging to #{log}"
end

File.open(hosts, 'r') do |hf|
    hf.each_line do |host|
        msg = "Checking users on #{host.chomp}"
        puts msg
        log.puts "#{msg}\n" unless log.nil?

        Socket.tcp(host.chomp, 25) do |s|
            #banner = s.recvfrom 1024
            #puts banner

            File.open(users, 'r') do |uf|
                uf.each_line do |user|
                    s.send "vrfy #{user.chomp}\r\n", 0
                    result = s.recvfrom 1024
                    puts result
                    log.puts "\t #{result[0]}\n" unless log.nil?
                end
            end
        end
    end
end

log.close unless log.nil?