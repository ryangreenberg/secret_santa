Person = Struct.new(:name, :email)
class Person
  EMAIL_PATTERN = /(.+)? <(.+?@.+?)>/
  def self.from(str)
    m = str.match(EMAIL_PATTERN)
    if m
      Person.new(m[1], m[2])
    else
      raise ArgumentError, "Invalid format for name and email: '#{str}'"
    end
  end

  def to_s
    "#{name} <#{email}>"
  end
end
