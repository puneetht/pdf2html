
module OsFunctions
  
  # universal-darwin9.0 shows up for RUBY_PLATFORM on os X leopard with the bundled ruby. 
  # Installing ruby in different manners may give a different result, so beware.
  # Examine the ruby platform yourself. If you see other values please comment
  # in the snippet on dzone and I will add them.

  def is_mac?
    RUBY_PLATFORM.downcase.include?("darwin")
  end

  def is_windows?
     RUBY_PLATFORM.downcase.include?("mswin")
  end

  def is_linux?
     RUBY_PLATFORM.downcase.include?("linux")
  end
  
  module_function :is_mac? , :is_windows?, :is_linux?
end

module Exceptions
  class Pdf2HtmlException < RuntimeError; end
end

module Pdf2Html
 
  class Pdf2Html
      @@binary = "pdftohtml_linux"
      @@binary_dir = File.join(File.dirname(File.dirname(__FILE__)),"bin")
      @@binary_path = File.join(@@binary_dir,@@binary)
      
      def self.set_binary_path
        if OsFunctions::is_mac?
          @@binary = "pdftohtml_macos"
        elsif OsFunctions::is_linux?
          @@binary == "pdftohtml_linux"
        else
          raise "This ruby packge only works on mac and on linux"
        end
         @@binary_path = File.join(@@binary_dir,@@binary)
      end
      
      def self.pdf2html(infile,outfile,params=nil)
        ### recommended params for rbuilder is "-q -noframes -i -c"
        cmd = @@binary_path + " "
        cmd += "#{params} " if !params.nil?
        cmd += "#{infile} #{outfile}"
        
        raise Exceptions::Pdf2HtmlException.new("#{infile} does not exist") if !File.exists?(infile) || File.extname(infile) != ".pdf"
        
        begin 
          `#{cmd}`
          while !$?.exited?
            sleep 0.01
          end
        
          exit_status = $?.exitstatus
          puts "Exit status #{exit_status}"
          raise Exceptions::Pdf2HtmlException.new("Pdf2Html exited with non-zero exit-status") if exit_status != 0 
        rescue Exception => exception
          raise Exceptions::Pdf2HtmlException.new("Unknown error occured: #{exception.message}")
        end
      end
  end
end