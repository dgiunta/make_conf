class ApacheVHostPhpConf < ApacheVHost
  
  def initialize
    self.template_file = 'apache_v_host_php_conf.erb'
  end
end