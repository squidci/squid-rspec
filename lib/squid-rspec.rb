module Squid

  def self.build_id_variable=(var)
    @build_id_variable = var
  end

  def self.build_id_variable
    @build_id_variable || 'SQUID_BUILD_ID'
  end

end

require_relative 'squid-rspec/formatter'
