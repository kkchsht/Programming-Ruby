# Sample code from Programing Ruby, page 62
  class WordIndex
    def initialize
      @index = {}
    end
    def add_to_index(obj, *phrases)
      phrases.each do |phrase|
        phrase.scan(/\w[-\w']+/) do |word|   # extract each word
          word.downcase!
          @index[word] = [] if @index[word].nil?
          @index[word].push(obj)
        end
      end
    end
    def lookup(word)
      @index[word.downcase]
    end
  end
class Song
  include Comparable
  @@plays = 0
  attr_reader :name, :artist, :duration
  attr_writer :duration
  def initialize(name, artist, duration)
    @name     = name
    @artist   = artist
    @duration = duration
    @plays    = 0
  end
  def to_s
    "Song: #@name--#@artist (#@duration)"
  end
  def name
    @name
  end
  def artist
    @artist
  end
  def duration
    @duration
  end
  def duration=(new_duration)
    @duration = new_duration
  end
  def duration_in_minutes
    @duration/60.0   # force floating point
  end
  def duration_in_minutes=(new_duration)
    @duration = (new_duration*60).to_i
  end
  def play
    @plays  += 1   # same as @plays = @plays + 1
    @@plays += 1
    "This  song: #@plays plays. Total #@@plays plays."
  end
  def record
    "Recording..."
  end
  def inspect
    self.to_s
  end
  def <=>(other)
    self.duration <=> other.duration
  end
end
class SongList
  def initialize
    @songs = Array.new
    @index = WordIndex.new
  end
  def append(song)
    @songs.push(song)
    @index.add_to_index(song, song.name, song.artist)
    self
  end
  def delete_first
    @songs.shift
  end
  def delete_last
    @songs.pop
  end
  def [](index)
    @songs[index]
  end
  def with_title(title)
    for i in 0...@songs.length
      return @songs[i] if title == @songs[i].name
    end
    return nil
  end
  def with_title(title)
    @songs.find {|song| title == song.name }
  end
  def lookup(word)
    @index.lookup(word)
  end
  def create_search(name, params)
    # ...
  end
end  
song_file = DATA
songs = SongList.new
song_file.each do |line|
  file, length, name, title = line.chomp.split(/\s*\|\s*/)
  name.squeeze!(" ")
  mins, secs = length.scan(/\d+/)
  songs.append(Song.new(title, name, mins.to_i*60+secs.to_i))
end
puts songs.lookup("Fats")
puts songs.lookup("ain't")
puts songs.lookup("RED")
puts songs.lookup("WoRlD")
__END__
/jazz/j00132.mp3  | 3:45 | Fats     Waller     | Ain't Misbehavin'
/jazz/j00319.mp3  | 2:58 | Louis    Armstrong  | Wonderful World
/bgrass/bg0732.mp3| 4:09 | Strength in Numbers | Texas Red
