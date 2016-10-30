require 'digest/sha1'

class Obfuscator
  def self.obfuscate(people, assignments)
    result = {}
    result["people"] = people.map {|ea| ea.to_s }
    result["salt"] = salt = sha1(rand)[0..6]
    result["assignments"] = Hash[assignments.map do |giver, recipient|
      [giver.to_s, obscure(recipient, salt)]
    end]
    result
  end

  def self.decode(result)
    salt = result["salt"]
    people = result["people"].map {|ea| Person.from(ea) }
    people_by_hash = Hash[people.map {|p| [obscure(p, salt), p]}]
    Hash[result["assignments"].map do |giver, recipient|
      [Person.from(giver), people_by_hash[recipient]]
    end]
  end

  def self.sha1(v)
    Digest::SHA1.hexdigest(v.to_s)
  end

  def self.obscure(person, salt)
    sha1(salt + person.name)
  end
end