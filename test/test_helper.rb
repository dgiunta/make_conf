[
  'test/unit',
  'yaml',
  Dir.glob("../lib/*.rb"), 
  Dir.glob("../templates/*.rb")
].flatten.each { |f| require f }
