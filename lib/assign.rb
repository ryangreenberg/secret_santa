require 'yaml'

module Assign
  USAGE = "Usage: assign <config_file.yml>"
  YMDHMS = "%Y-%m-%d_%H-%M-%S"

  def self.main(args)
    config_file = args.first
    abort USAGE unless config_file
    config = YAML.load_file(config_file)

    people = config["people"].map {|ea| Person.from(ea) }
    exclusions = Exclusion.from_groups(people, config["exclusion_groups"])
    exclusions.each do |k, v|
      debug "#{k}: not #{v.to_a.map {|ea| ea.name }.join(', ')}"
    end

    matcher = Matcher.new(people, exclusions)
    assignments = matcher.match
    assignments.each do |giver, recipient|
      debug "#{giver.name} => #{recipient.name}"
    end

    obscured_assignments = Obfuscator.obfuscate(people, assignments)

    datetime = Time.now.strftime(YMDHMS)
    basename = File.basename(config_file, ".yml")
    output_file = "#{basename}_assignments_#{datetime}.yml"
    File.open(output_file, "w") do |file|
      file.write(YAML.dump(obscured_assignments))
    end

    puts "Stored giver/recipient assignments in #{output_file}"
    output_file
  end
end
