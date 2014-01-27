require 'rspec/core/formatters/base_formatter'

require_relative 'errors'
require_relative 'reporter'
require_relative 'example'
require_relative 'build'

module Squid
  class Formatter < RSpec::Core::Formatters::BaseFormatter

    def initialize(output)
      super

      @reporter = Reporter.new
      @started_at = DateTime.now
      @skip_reporting = false

      @build_id = ENV[Squid.build_id_variable]
      missing_build_id! unless @build_id

      report '/test-suite-started', started_at: @started_at
    end

    def example_started(example)
      report '/test-started', Example.convert(example)
    end

    def example_passed(example)
      report '/test-passed', Example.convert(example)
    end

    def example_failed(example)
      report '/test-failed', Example.convert(example)
    end

    def example_pending(example)
      report '/test-pending', Example.convert(example)
    end

    def dump_summary(duration, example_count, failure_count, pending_count)
      data = Build.complete(
        started_at:    @started_at,
        finished_at:   DateTime.now,
        duration:      duration,
        failed_count:  failure_count,
        pending_count: pending_count,
        total_count:   example_count
      )

      report '/test-suite-finished', data
    end

    private

    def report(path, data)
      return if @skip_reporting
      report! path, data.merge(build_id: @build_id)
    end

    def report!(path, data)
      @reporter.report path, data
    rescue ConnectionError
      unable_to_connect!
    end

    def unable_to_connect!
      skip_reporting!
      warn "WARNING: Squid-RSpec is skipping to report test results for the current build!\n" \
           "  Unable to connect to the Squid API.\n" \
           "  Please check the Squid server at #{Squid.endpoint.inspect}"
    end

    def missing_build_id!
      skip_reporting!
      warn "WARNING: Squid-RSpec is skipping to report test results for the current build!\n" \
           "  Missing the build-id environment variable.\n" \
           "  Please ensure #{Squid.build_id_variable.inspect} is set to the current build-id."
    end

    def skip_reporting!
      @skip_reporting = true
    end

  end
end
