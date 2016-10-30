class Matcher
  class NoSolutionAvailable < RuntimeError; end

  attr_reader :people, :exclusions

  def initialize(people, exclusions)
    @people = people
    @exclusions = exclusions
  end

  def match
    begin
      solution = {}
      people.each do |person|
        remaining = people - solution.values
        available = remaining - exclusions[person].to_a
        raise NoSolutionAvailable, "No match for #{person} given #{solution.inspect}" if available.empty?

        selection = available.sample
        solution[person] = selection
      end
      solution
    rescue NoSolutionAvailable => e
      warn e
      people.shuffle!
      retry
    end
  end
end
