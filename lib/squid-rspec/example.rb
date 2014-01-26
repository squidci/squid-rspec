module Squid
  class Example

    def self.convert(example)
      new(example).convert
    end

    def initialize(example)
      @example = example
    end

    def convert
      {
        test_group:  type,
        description: description,
        started_at:  result[:started_at],
        finished_at: result[:finished_at],
        runtime:     result[:run_time]
      }
    end

    private

    def type
      @example.metadata[:type].to_s
    end

    def result
      @example.metadata[:execution_result]
    end

    def description
      metadata = @example.metadata
      description = [@example.description]

      while example_group = metadata[:example_group]
        description.unshift example_group[:description]
        metadata = example_group
      end

      description.join('<<<|>>>')
    end

  end
end
