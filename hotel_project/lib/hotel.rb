require_relative "./room.rb"

class Hotel
  def initialize(name,hash)
    @name = name
    @rooms = {}
    hash.each {|room, capacity| @rooms[room]=Room.new(capacity)}
    #Hash.new(hash.each {|k,v| })
  end
  def name
    cap = []
    @name.split(" ").each {|word| cap << word[0].upcase + word[1..-1]}
    return cap.join(" ")
  end
  def rooms
    @rooms
  end
  def room_exists?(room)
    @rooms.each {|k,v| return true if room == k}
    false
  end
  def check_in(person,room)
    if room_exists?(room) && !@rooms[room].full?
        @rooms[room].add_occupant(person)
        print "check in successful"
    else
        print "sorry room is full"
    end
  end
  def has_vacancy?
    @rooms.each {|room, v| return true if !@rooms[room].full?}
    false
  end
  def list_rooms
    @rooms.each {|name,room| puts "#{room} : #{v.available_space}"}
  end

end
