# frozen_string_literal: true

require_relative "rails/version"

module GeonamesRails

  class Error < StandardError; end

  if defined?(Rails)
    #puts 'Requiring geonames/rails/railtie'
    require 'geonames_rails/railtie'
  end

end
