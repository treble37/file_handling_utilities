
@playlist_path = "/media/bruce/CLIP128/Music"

dir = Dir.chdir(@playlist_path) do
  Dir.glob("*")
end

class RhythmboxPlaylist
  def initialize

  end
end
