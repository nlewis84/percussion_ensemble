require_relative "percussion_ensembles/version"
require_relative "percussion_ensembles/CLI"
require_relative "percussion_ensembles/scraper"
require_relative "percussion_ensembles/ensemble"
require_relative "percussion_ensembles/composer"

require 'nokogiri'
require 'open-uri'
require 'pry'
require 'colorize'

# Remove these two lines if you can't get Watir to work
require 'webdrivers'
require 'watir'

module PercussionEnsembles
  class Error < StandardError; end
  # Your code goes here...
end
