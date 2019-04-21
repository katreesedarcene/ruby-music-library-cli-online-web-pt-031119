class Song 
  
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []
  def initialize(name, artist = nil, genre = nil)
    @name = name 
   self.artist = artist if artist
    self.genre = genre if genre
  end 
  def self.all 
    @@all
  end
  def self.destroy_all
    self.all.clear
  end 
  def save
    self.class.all << self
  end
  def self.create(name) 
    song = new(name)
    song.save
    song
  end
 def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end


  def genre=(genre)
    @genre = genre 
    genre.songs << self if !genre.songs.include?(self)
    
  end
  def self.find_by_name(name)
     all.detect{ |s| s.name == name } 
  end
  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end
  def self.new_from_filename(filename)
    artist, song, genre = filename.split(" - ")
    song_artist = Artist.find_or_create_by_name(artist)
    genre = genre.gsub(".mp3","")
  end
end