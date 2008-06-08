#!/usr/bin/env ruby -wKU

require 'getoptlong'
require 'yaml'
Dir.glob(File.join('lib', '*.rb')).each { |f| require f }
Dir.glob(File.join('templates', '*.rb')).each { |f| require f }

def print_usage
  puts(<<-'END_USAGE')
  
  = OVERVIEW

    This script is used to export templated server conf files.
  
    When run with out options, it will guide you through a series 
    of questions, and then output files to the location you specify.
  

  = USAGE

    make_conf [OPTION]
  
    -h, --help:
      Shows this help message.
  
    -u, --usage:
      Shows this help message.
    
    -v, --version:
      Displays the version of this script
    
    -b, --batch [file]:
      This runs the script with the supplied batch file.
      The batch file is setup as a YAML file containing an entry for
      each conf file template to be batch output, and any configuration 
      options necessary to running that template.
      
    -c, --config:
      Allows the user to modify the default config file interactively.
    
  END_USAGE
end

version = '0.1'
default_config_file = File.join('config', 'default_config.yml')
default_config = File.exists?(default_config_file) ? YAML.load_file(default_config_file) : {}
opts = GetoptLong.new(
    [ "--help",             "-h",   GetoptLong::NO_ARGUMENT ],
    [ "--usage",            "-u",   GetoptLong::NO_ARGUMENT ],
    [ "--version",          "-v",   GetoptLong::NO_ARGUMENT ],
    [ "--batch",            "-b",   GetoptLong::REQUIRED_ARGUMENT],
    [ "--config",           "-c",   GetoptLong::NO_ARGUMENT ]
)

def get_selected_template
  available_templates = Dir.glob(File.join('templates', '*.erb')).collect { |t| t.gsub!(/templates\/|.erb/, '') }  
  selected_template = ask "Select a template from the list below:", false, available_templates
  selected_template.nil? ? get_selected_template : selected_template
end

unless ARGV.empty?
  opts.each do |opt, arg|
    case opt
    when '--version'
      puts "Version: #{version}"
    when '--help', '--usage'
      print_usage
    when '--batch'
      batch_file = YAML.load_file(arg)
      # batch_file.each do |config|
      #   template = eval("#{classify(config[:template])}.create_from_file(config)")
      #   GenerateConfFile.new()
      # end
    when '--config'
      
    end
  end
else
  # selected_template = eval("#{classify(get_selected_template)}.new")
  selected_template = constantize(classify(get_selected_template)).new
  GenerateConfFile.new(selected_template, default_config).save
end
