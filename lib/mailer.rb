require 'mail'

class Mailer
  def self.configure(config)
    username     = get(config, "username")
    password     = get(config, "password")
    server       = get(config, "server")
    port         = get(config, "port")

    Mail.defaults do
      delivery_method :smtp, {
        :address              => server,
        :port                 => port,
        :domain               => 'localhost.localdomain',
        :user_name            => username,
        :password             => password,
        :authentication       => :plain,
        :enable_starttls_auto => true
      }
    end
  end

  def self.make_message(_from, _to, _subject, _body)
    Mail.new do
      from     _from
      to       _to
      subject  _subject
      body     _body
    end
  end

  def self.get(obj, key)
    value = obj[key].tap do |v|
      if v.nil?
        raise RuntimeError, "Missing required key '#{key}' in config #{obj}."
      end
    end
  end
  private_class_method :get

end
