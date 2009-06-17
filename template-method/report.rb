# An example by
# Stephen Caudill
# http://github.com/voxdolo

class Report
  attr_accessor :preamble, :before, :after, :prologue
  def initialize
    @subject = 'Monthly Report'
    @content = ['Things are going', 'Really, really good!']
  end
  def generate
    [:preamble,:head,:body,:prologue].map do |meth|
      send(meth)
    end.compact.join("\n")
  end
  def head
    "#{@subject}:"
  end
  def body
    [before, @content.map{ |line| output(line) }, after].join("\n")
  end
  def output(line)
    line
  end
end
 
class HTMLReport < Report
  def preamble
    '<html>'
  end
  def head
    "<head><title>#{@subject}</title></head>"
  end
  def before
    '<body>'
  end
  def output(line)
    "<p>#{line}</p>"
  end
  def after
    '</body>'
  end
  def prologue
    '</html>'
  end
end
 
if __FILE__ == $0
  require 'rubygems'
  require 'spec'
 
  Report.new.generate.should == "Monthly Report:\n\n" \
    "Things are going\n" \
    "Really, really good!\n"
 
  HTMLReport.new.generate.should == "<html>\n" \
    "<head><title>Monthly Report</title></head>\n" \
    "<body>\n" \
    "<p>Things are going</p>\n" \
    "<p>Really, really good!</p>\n" \
    "</body>\n" \
    "</html>" \
end

