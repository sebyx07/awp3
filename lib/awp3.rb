require 'active_support/time'
Dir.entries("./lib/awp3").select {|f| !File.directory? f}.each { |f| require_relative("./awp3/#{f}")}

module Awp3
  # Your code goes here...
end
