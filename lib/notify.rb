require 'mustache'
require 'yaml'

module Notify
  USAGE = "Usage: notify <config_file.yml> <assignments_file.yml>"

  def self.main(args)
    config_file = args[0]
    assignments_file = args[1]
    abort USAGE if config_file.nil? || assignments_file.nil?

    config = YAML.load_file(config_file)
    assignments = Obfuscator.decode(YAML.load_file(assignments_file))
    Mailer.configure(config["email"])

    message = config["message"]
    subject = message["subject"]
    template = message["body"]
    from_address = message["from"]

    messages = assignments.map do |giver, recipient|
      template_vars = {
        :giver => giver.template_vars,
        :recipient => recipient.template_vars
      }

      body = Mustache.render(template, template_vars)
      debug(body)

      message = Mailer.make_message(from_address, giver.email, subject, body)
      debug(message)

      message
    end

    print "About to send #{messages.size} emails. Continue? [y/N] "
    if STDIN.gets =~ /y/i
      messages.each do |m|
        print "Sending message to #{m.to}..."
        m.deliver!
        puts "OK"
      end
    end
  end
end
