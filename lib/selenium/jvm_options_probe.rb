if RUBY_PLATFORM =~ /windows/
  require 'win32-open3' 
else
  require "open3"
end

 
class JvmOptionsProbe
 
  def initialize
    @d32 = @d64 = @client = false

    if RUBY_PLATFORM =~ /windows/
      @help = `java -h`
      @d32 = (@help == `java -d32`) ? true : false
      @d64 = (@help == `java -d64`) ? true : false
      @client = (@help == `java -client`) ? true : false
    else
      @help = Open3.popen3("java -h")[2].readlines
      @d32 = (@help == Open3.popen3("java -d32")[2].readlines) ? true : false
      @d64 = (@help == Open3.popen3("java -d64")[2].readlines) ? true : false
      @client = (@help == Open3.popen3("java -client")[2].readlines) ? true : false
    end
  end
 
  def can_use_d32?
    @d32
  end
 
  def can_use_d64?
    @d64
  end
 
  def can_use_client?
    @client
  end
end

