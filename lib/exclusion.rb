require 'set'

class Exclusion
  def self.from_groups(people, exclusion_groups)
    groups = exclusion_groups.map do |group|
      group.map {|p_str| people.find {|p| p.name == p_str}.tap {|p| check(p, p_str)} }
    end

    exclusions = Hash[people.map do |person|
      not_self = [person]
      not_from_groups = exclusion_groups.select {|g| g.include?(person) }.flatten
      [person, Set.new(not_self + not_from_groups)]
    end]
  end

  def self.check(matching_person, person_string)
    if matching_person.nil?
      raise ArgumentError, "could not find matching person for '#{person_string}' in group"
    end
  end
end