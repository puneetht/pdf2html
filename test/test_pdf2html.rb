require 'test/unit'
require File.join(File.dirname(File.dirname(__FILE__)),"lib/pdf2html")

class TestPdf2Html < Test::Unit::TestCase
  def setup
    Pdf2Html::Pdf2Html.set_binary_path
  end
  
  def cleanup
    File.delete('testfiles/outfile.html') if File.exists?('testfiles/outfile.html')
  end
  
  def teardown
    File.delete('testfiles/outfile.html') if File.exists?('testfiles/outfile.html')
  end
  
  def test_success
    Pdf2Html::Pdf2Html.pdf2html("testfiles/infile.pdf","testfiles/outfile.html","-q -noframes -i -c")
    assert File.exists?("testfiles/outfile.html")
  end
  
  def test_failure_missing_file
    assert_raises Exceptions::Pdf2HtmlException do
      Pdf2Html::Pdf2Html.pdf2html("testfiles/nonexistent.pdf","testfiles/notthere.html")
    end
    assert !File.exists?('testfiles/notthere.html')
  end
  
  def test_failure_bad_extension
    assert_raises Exceptions::Pdf2HtmlException do
      Pdf2Html::Pdf2Html.pdf2html("testfiles/input.html", "testfiles/output.html")
    end
    assert !File.exists?("testfiles/output.html")
  end
  
  
end
