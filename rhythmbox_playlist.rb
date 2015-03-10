class RhythmboxPlaylist
  attr_accessor :top_level_directory, :file_library
    
  def initialize(music_file_path="/media/bruce/CLIP128/Music")
    @top_level_directory = music_file_path
    @file_library = []
  end

  def build_file_library(new_path = "")
    case path_type(new_path)
    when "file"
      @file_library << new_path
    when "directory"
      paths = Dir.glob(new_path+"/*")
      paths.each do |path|
        build_file_library(path)
      end
    else
      raise "Error in build file library"
    end
  end

  def save_to_playlist(playlist_type="m3u")

  end

  private

  def path_type(path)
    if File.file?(path)
      return "file"
    elsif File.directory?(path)
      return "directory"
    else
      return "other"
    end
  end

end
