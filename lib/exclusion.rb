require 'set'

class Exclusion
  def self.from_groups(people, exclusion_groups, direct_exclusions)
    groups = exclusion_groups.map do |group|
      group.map {|name| find_person(people, name) }
    end

    directs = direct_exclusions.map {|p1, p2| [find_person(people, p1), find_person(people, p2)] }

    exclusions = Hash[people.map do |person|
      not_self = [person]
      not_from_groups = groups.select {|g| g.include?(person) }.flatten
      not_directly_excluded = directs.select {|p1, p2| p1 == person }.map {|p1, p2| p2 }.flatten
      [person, Set.new(not_self + not_from_groups + not_directly_excluded)]
    end]
  end

  def self.check(matching_person, person_string)
    if matching_person.nil?
      raise ArgumentError, "could not find matching person for '#{person_string}' in group"
    end
  end

  def self.find_person(people, name)
    people.find {|p| p.name == name}.tap {|p| check(p, name)}
  end
end