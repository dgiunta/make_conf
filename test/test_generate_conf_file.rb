require "test_helper"

class TestGenerateConfFile < Test::Unit::TestCase
  
  def setup
    @conf_file = GenerateConfFile.new(MockTemplate.new)
  end
  
  def test_get_output_file_location
    assert_nil(@conf_file.output_file_dir)
    
    @conf_file.get_output_file_dir
    assert_not_nil(@conf_file.output_file_dir)
  end
  
  def test_get_output_file_name
    @conf_file.output_file_dir = '.'
    assert_nil(@conf_file.output_file_name)
    @conf_file.get_output_file_name
    assert_not_nil(@conf_file.output_file_name)
  end
end

class MockTemplate
  
  def initialize
    @app_name = 'test'
  end
  
  def output_conf_file(context)
  end
  
  def get_data_from_user(context)
    context.output_file_name = "#{@app_name}.conf"
  end
  
  def get_binding
    binding
  end
  
  def compiled_template
  end
end