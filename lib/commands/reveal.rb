require 'yaml'

module Commands::Reveal
  USAGE = "Usage: reveal <assignments_file.yml>"
  YMDHMS = "%Y-%m-%d_%H-%M-%S"

  def self.main(args)
    assignments_file = args.first
    abort USAGE if assignments_file.nil?

    assignments = Obfuscator.decode(YAML.load_file(assignments_file))
    assignments.each do |giver, recipient|
      puts "#{giver.name} => #{recipient.name}"
    end
  end
end
