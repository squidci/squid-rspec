module Squid

  def self.build_id_variable=(var)
    @build_id_variable = var
  end

  def self.build_id_variable
    @build_id_variable || 'SQUID_BUILD_ID'
  end

  def self.endpoint=(url)
    @endpoint = url
  end

  def self.endpoint
    @endpoint || 'http://localhost:9292/api'
  end

end

require_relative 'squid-rspec/formatter'
