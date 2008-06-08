require 'erb'
require 'lib/utilities'
include Utilities

class ConfTemplate
  
  attr_reader :template_file, :compiled_template
  
  TEMPLATES_DIR = File.join(File.dirname(__FILE__), '..', 'templates')
  
  class << self
    def load_from_file(config={})
      new().load_config(config)
    end
  end
  
  def load_config(config={})
    config.each { |k, v| instance_variable_set("@#{k}", v) }
  end
  
  def get_data_from_user(context)
  end
  
  def output_conf_file
    ERB.new(File.open(template_file).read).result(binding) unless template_file.nil?
  end
    
  def template_file=(filename)
    file = File.join(TEMPLATES_DIR, filename)
    
    if File.exists?(file)
      @template_file = file
    else
      raise TemplateNotFound
    end
  end
end