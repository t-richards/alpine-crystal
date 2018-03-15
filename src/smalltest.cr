require "http/server"

STDIN.blocking = true
STDOUT.blocking = true
STDERR.blocking = true

server = HTTP::Server.new("0.0.0.0", 4000) do |context|
  context.response.content_type = "text/plain"
  context.response.print "Hello world!"
end

puts "Listening on http://0.0.0.0:4000"
server.listen
