require 'minitest/autorun'
require 'pry'
require_relative './rhythmbox_playlist'

class TestRhythmboxPlaylist < Minitest::Test
  
  def setup
    @top_level_dir = "test_files/Music"
    @playlist = RhythmboxPlaylist.new(@top_level_dir)
    @playlist.build_file_library(@top_level_dir)
  end

  def test_build_file_library
    assert_equal @playlist.file_library, ["Elisa & Andrea Guerra/Someday This Pain Will Be Useful to You (Soundtrack)/01.03 - Love Is Requited.txt", "Gary Nichols/Unknown/00 - Unbroken Ground.txt"].map { |m| @top_level_dir + "/" + m }
  end 
end
