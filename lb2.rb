# exercise 1

word = nil
number = nil


def workword(word)
tochar = nil
lengthword = nil

lengthword = word.chomp.length

tochar = word[lengthword-2..-1]

if tochar[0] == 'c' and tochar[1] == 's'
puts 2**lengthword.to_i
else
puts word.reverse
end
end

print "Word: "
word = gets
print "Number: "
number = gets.to_i

workword(word)



# exercise 2

pokemons = []

def addpokemons(pokemons)


countpokemons = nil
namepokemon = nil
colorpokemon = nil

puts 'How many pokemon to add? '
countpokemons = gets.to_i

for i in 0..countpokemons-1

   puts "Pokemon #{i+1}"
   print 'Name: '
namepokemon = gets.chomp
print 'Color: '
   colorpokemon = gets.chomp
pokemons << {name: namepokemon, color: colorpokemon}

end
puts pokemons
end

addpokemons(pokemons)
