class ApacheVHost < ConfTemplate
  
  attr_accessor :server_port, :url, :document_root, :app_name, :https
  
  def get_data_from_user(context)
    get_app_name if app_name.nil?
    get_url if url.nil?
    get_https if https.nil?
    get_server_port if server_port.nil?
    get_document_root if document_root.nil?

    context.output_file_name = "#{app_name}.conf"
  end
  
  def get_app_name
    @app_name = ask "What is your site named?"
  end
    
  def get_url
    @url = ask "What is the url for your site?"
  end
  
  def get_https
    @https = ask_boolean "Will this site use https?"
  end
  
  def get_server_port
    @server_port = ask "What port will your site be served from?", true, %w(80 81 82 etc.)
  end
  
  def get_document_root
    @document_root = clean_document_root(ask("Where on the server will you store the files for this site?", true, %w(/var/www/sites/)))
  end
  
  def clean_document_root(input)
    File.join(input.split(/\/|\\/))
  end
end