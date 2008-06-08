class ApacheVHostRailsMongrelClusterConf < ApacheVHost
  
  attr_accessor :mongrel_cluster_size, :mongrel_cluster_port
  
  def initialize
    self.template_file = 'apache_v_host_rails_mongrel_cluster_conf.erb'
  end
  
  def get_data_from_user(context)
    super
    get_mongrel_cluster_size if mongrel_cluster_size.nil?
    get_mongrel_cluster_port if mongrel_cluster_port.nil?
  end
    
  def get_mongrel_cluster_size
    @mongrel_cluster_size = ask("How many Mongrels in your cluster?").to_i
  end
  
  def get_mongrel_cluster_port
    @mongrel_cluster_port = ask("On what port will you start your mongrels?").to_i
  end
end