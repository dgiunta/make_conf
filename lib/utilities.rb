module Utilities
  
  # This method asks the user a question and returns the value of gets.chomp.rstrip.
  # Optionally, you add choices or examples to the method call that will get printed
  # along with the question. By default, the question is formatted as a 'one liner", 
  # meaning it will get printed along with any supplied choices on one line, and 
  # leave the cursor waiting for input at the end of that line.
  # 
  # USAGE:
  # ======
  # 
  # One-liner question (default):
  # @name = ask "What's your name?"
  # > What's your name? Bob <- question, and input stay on one line.
  # @name = 'Bob'
  # 
  # Multi-line question and response, no choices:
  # @name = ask "What's your name?", false
  # > What's your name?
  # > Bob <- User entered data
  # @name = 'Bob'
  # 
  # Multi-line question with choices (returns the selected choice or nil):
  # @favorite_color = ask "What's you're favorite color?", false, ['Red', 'Green', 'Yellow']
  # > What's your favorite color?
  # > 1. Red
  # > 2. Green
  # > 3. Yellow
  # > 2
  # @favorite_color = 'Green'
  # 
  # One-liner question with examples (returns whatever the user enters):
  # @favorite_color = ask "What's you're favorite color?", true, ['Red', 'Green', 'Yellow', 'etc.']
  # > What's your favorite color? (Red, Green, Yellow, etc.) Blue
  # @favorite_color = 'Blue'
  # 
  def ask(question, one_line=true, choices=[])
    unless choices.empty?
      if one_line
        print "#{question} (#{choices.join(', ')}) "
        gets.chomp.rstrip
      else
        puts question
        choices.each_with_index { |c, i| puts "#{i + 1}. #{c}" }
        choices[gets.chomp.rstrip.to_i - 1]
      end
    else
      one_line ? print("#{question} ") : puts(question)
      gets.chomp.rstrip
    end
  end
  
  # This method creates a yes/no question and returns true/false accordingly.
  def ask_boolean(question)
    yes? ask(question, true, ['y/n'])
  end
  
  # This method returns true if the input begins with a lowercase or uppercase 'y'.
  # Good for checking the output of "ask" for boolean questions.
  # 
  def yes?(input)
    input[/^(y|Y)/].to_s.downcase == 'y'
  end
  
  # Utility method for making a directory using the expanded version of the given path.
  # Also, converts spaces to underscores.
  # USAGE:
  # ======
  # 
  # create_directory('~/Desktop/blah') <= Creates a directory at /Users/<username>/Desktop/blah on OS X
  # 
  def create_directory(path)
    clean_path = File.expand_path(path.gsub(/ /, '_'))
    Dir.mkdir(clean_path)
    clean_path
  end
  
  # This method comes from the Rails Inflector code. Rails breaks this call up into a few other methods 
  # 
  # (camelize, etc.), but for brevety's sake, I've lumped them all into one method here.
  def classify(input)
    input.to_s.sub(/.*\./, '').gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
  end
  
  # This method comes from the Rails Inflector code.
  # 
  # Constantize tries to find a declared constant with the name specified
  # in the string. It raises a NameError when the name is not in CamelCase
  # or is not initialized.
  #
  # Examples
  #   "Module".constantize #=> Module
  #   "Class".constantize #=> Class
  def constantize(camel_cased_word)
    unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ camel_cased_word
      raise NameError, "#{camel_cased_word.inspect} is not a valid constant name!"
    end

    Object.module_eval("::#{$1}", __FILE__, __LINE__)
  end
  
end