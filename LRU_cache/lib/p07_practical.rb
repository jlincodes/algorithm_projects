require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash = HashMap.new()
  string.chars.each do |char|
    if hash.include?(char)
      hash.delete(char)
    else
      hash.set(char, 1)
    end
  end
  if hash.count <= 1
    return true
  else
    return false
  end
end
