if defined? ActiveRecord::Base
  require 'logger'

  ActiveRecord::Base.logger = Logger.new(STDOUT)
end
