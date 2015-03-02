#this removes weird file characters for maximum portability when syncing files between Windows and Linux

#first replace all invalid characters with a valid character
#next check and make sure the file name length isn't too long (Windows Vista limits to 255 chars for file path+name)

#invalid = /~|#|%|&|*|{|}|\|:|<|>|?|\/|\||=|;|,/
invalid_str = /~|#|%|&|\*|{|}|:|<|>|\?|\/|\\|\||=|;|,|!|(\.\.\.)/  #this string includes forward slashes as invalid
a="2bb#bbb%bbb;b#/bba;"
a2="sp#e:ci!lfil,e.txt..."
a_long = "Itzhak Perlman_ violin_ Oscar Peterson_ piano_ Herb Ellis_ guitar_ Ray Brown_ bass_ Grady Tate_ drums - Side By Side (mp3).cue"
current_path=Array.new(2)
current_path[0] = "/home/bruce/mp3a_12-14-11/*"
current_path[1] = "/home/bruce/flaca_12-14-11/*"
@err_msg=[]
MAX_RECURSE = 10
def shorten_filename(filedir_str)
#shortens file name if length > 50
#Note: filedir_str typically ends up being an entire directory path + file name - so have to isolate file name first
  short_str = ""
  str_end = ""
  file_str = filedir_str.split(/\//)
  if file_str.last.length >= 50
    str_end = file_str.last[file_str.last.length-3..file_str.last.length]
    short_str=file_str[0,file_str.length-1].join("/")+"/"+file_str.last[0,40]
    if (str_end=="cue"||str_end=="m3u"||str_end=="log"||str_end=="mp3")
      short_str = short_str + "." + str_end
    elsif (str_end=="lac")
      short_str = short_str + "." + "flac"
      puts filedir_str+"**\n"
    end
  else
    short_str = filedir_str
  end
  return short_str
end
def no_invalid_char(param_str)
  #gets rid of invalid characters in a file or directory string
  invalid_str2 = /~|#|%|&|\*|{|}|:|<|>|\?|\\|\||=|;|,|!|(\.\.\.)/  #forward slashes are valid
  valid_str = param_str
  pos = 0
  while (pos!=nil)
    pos = invalid_str2=~valid_str
    valid_str = valid_str.sub(invalid_str2,'_')
  end
  return  valid_str 
end

def valid_filedir_name(fdname_array, depth_count)
  #replace invalid file or directory names with valid ones
  #don't do recursion beyond depth_count
  fdname_array.each do |fd|
    if File.file?(fd)
      valid_fd = no_invalid_char(fd)
      valid_fd = shorten_filename(valid_fd) #shorten file name if too long
      File.rename(fd, valid_fd)  
    elsif File.directory?(fd)
      valid_fd = no_invalid_char(fd)
      File.rename(fd,valid_fd)
      newdir = valid_fd+"/*"
      if (depth_count+1<MAX_RECURSE)
        valid_filedir_name(Dir.glob(newdir),depth_count+1)
      else
        @err_msg.push("Can't exceed max depth count")
        puts "Depth count exceed err"
        0
      end
    else
      @err_msg.push("Unknown error - not file or dir")
      0  #following ruby convention return 0
    end #end checking if file or dir
  end #end fdnamearray.each
end

#c=Dir.glob("/home/bruce/Desktop/testruby/*")
#c.each do |f|
  #puts f
#  puts File.basename(f)
#end

#b=no_invalid_char(a2)
#puts b

#valid_filedir_name(Dir.glob("/home/bruce/Desktop/testruby/*"),0)

#b=a_long[a_long.length-3..a_long.length-1]+"*"+a_long.length.to_s

#puts a_long
#puts shorten_filename(a_long)
# if(a_long=~/Itzhak/)
#  puts "yes"
# else 
#  puts "no"
# end

#c = current_path[0].split(/\//)
#b=c[0,c.length-1].join("/")+"/"+c.last
#puts b

valid_filedir_name(Dir.glob(current_path[1]),0)

