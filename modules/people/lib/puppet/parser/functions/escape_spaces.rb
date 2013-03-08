# escape slashes in a String
module Puppet::Parser::Functions
    newfunction(:escape_spaces, :type => :rvalue) do |args|
        args[0].gsub(/ /, '\\ ')
    end
end