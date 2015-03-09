
@playlist_path = "/media/bruce/CLIP128/Music"

dir = Dir.chdir(@playlist_path) do
  Dir.glob("*")
end

class RhythmboxPlaylist
  attr_accessor :top_level_directory, :file_library
    
  def initialize(music_file_path="/media/bruce/CLIP128/Music")
    @top_level_directory = music_file_path
  end

  def build_file_library
    @file_library = []  
  end

end
