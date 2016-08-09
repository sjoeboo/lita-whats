module Lita
  module Handlers
    class Whats < Handler
      # insert handler code here
      route(/^whats\s+(.+)/, :whats, command: true, help: {
        "whats <hostname>" => "Runs 'whats' for the given hostname"
      })

      def whats(response)
        hostname = response.matches[0][0]
        whats_cmd = "whats -q -j #{hostname}"
        output = `#{whats_cmd}`
        message = ""
        JSON.parse(output).each_pair do |k,v|
          message = message + "*#{k}*:  #{v}\n"
        end
        response.reply message
      end
      Lita.register_handler(self)
    end
  end
end
