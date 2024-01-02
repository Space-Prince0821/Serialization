require 'yaml'

# Mixin
module BasicSerializable
    # Can change to YAML, JSON or MessagePack
    @@serializer = YAML
  
    def serialize
        obj = {}
        
        instance_variables.map do |var|
            obj[var] = instance_variable_get(var)
        end

        yaml_data = @@serializer.dump obj

        File.open("person.yaml", "w+") do |file|
            file.write(yaml_data)
        end
        puts "Object saved to YAML successfully!"
    end

    def unserialize(file_path)
        yaml_content = File.read(file_path)
        obj = @@serializer.load(yaml_content)

        obj.each do |key, value|
            instance_variable_set(key, value)
        end

        puts "from YAML to object success!"
    end
end

class Person
    include BasicSerializable

    attr_accessor :name, :age, :gender

    def initialize(name, age, gender)
        @name = name
        @age = age
        @gender = gender
    end
end

''' Quick Notes:
    - We can initialize a person object (state)
    - We can call serialize on the object
    - Our objects instance variables are then used
    to loop over, then stored in our obj hash.
    - Dump the hash (YAML, JSON)
'''

# Serialize example
# prince = Person.new("Prince", 25, "Male")
# prince.serialize

# Unserialize example
yaml_person = Person.new("", 0, "")
yaml_person.unserialize("person.yaml")

puts "Name: #{yaml_person.name}"
puts "Age: #{yaml_person.age}"
puts "Gender: #{yaml_person.gender}"