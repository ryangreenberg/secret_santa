def debug(obj)
  obj.tap { p obj if ENV["DEBUG"] }
end
