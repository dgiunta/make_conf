class GenerateConfFile
  require 'lib/utilities'
  include Utilities
  
  attr_accessor :template, :output_file_name, :output_file_dir
  
  def initialize(template, default_config={})
    default_config.each { |k, v| instance_variable_set("@#{k}", v) }
    @template = template
  end
    
  def save
    use_default_config?
    get_data_from_user
    
    create_directory(output_file_dir) unless File.exists?(output_file_dir)
    
    file = File.open(full_output_file_path, 'w')
    file.write(output_conf_file)
    file.close
    puts "File (#{output_file_name}) has been saved in the #{output_file_dir} directory."
  end
  
  def use_default_config?
    if @template_config
      if ask_boolean("Do you want to use the defaults for this template?")
        template.load_config(@template_config)
      end
    end
  end
  
  def get_data_from_user
    template.get_data_from_user(self)
    
    get_output_file_dir if output_file_dir.nil?
    get_output_file_name if output_file_name.nil?
  end
  
  def output_conf_file
    template.output_conf_file
  end
  
  def get_output_file_dir
    file_location = ask "Where should we save the generated conf files?"
    full_path = File.expand_path(file_location)
    
    @output_file_dir = if File.exists?(full_path)
      full_path
    else
      ask_boolean("That directory doesn't exist. Should we create it?") ? create_directory(full_path) : get_output_file_dir
    end
  end
  
  def get_output_file_name
    file_name = ask "What file name should we save this conf file with?"
    file_name.gsub!(/ /, '_')
    
    @output_file_name = unless File.exists?(File.join(output_file_dir, file_name))
      file_name
    else
      ask_boolean("File already exists. Overwrite this file?") ? file_name : get_output_file_name
    end
  end
  
  def full_output_file_path
    File.join(output_file_dir, output_file_name)
  end
  
end