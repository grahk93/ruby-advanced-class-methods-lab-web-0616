require 'pry'
class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = Song.new
    song.save
    song
  end

  def self.new_by_name(name)
    song = self.create
    song.name= name 
    song
  end

  def self.create_by_name(name)
    song = self.new_by_name(name)
    song.save 
    song
  end

  def self.find_by_name(name)
    self.all.find do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      song = self.create_by_name(name)
    else
     song = self.find_by_name(name)
    end
    song
  end

  def self.alphabetical
    sorted = self.all.sort {|a,b| a.name.downcase <=> b.name.downcase}
    sorted.uniq
  end

  def self.new_from_filename(file)
    song = self.new_by_name(file)
    song_array = song.name.split("-")
    song.artist_name= song_array.first.chomp(" ")
    song.name= song_array.last.chomp(".mp3")
    song.name[0] = ''
    song
  end 

  def self.create_from_filename(file)
    song = self.new_from_filename(file)
    song.save 
    song
  end

  def self.destroy_all
    @@all = []
  end

end
