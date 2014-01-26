module CI
  class Build

    def self.complete(data)
      new(data).complete
    end

    def initialize(data)
      @data = data
    end

    def complete
      @data.merge(passed_count: passed_count, status: status)
    end

    private

    def passed_count
      @data[:total_count] - @data[:failed_count] - @data[:pending_count]
    end

    def status
      @data[:failed_count] > 0 ? 'failed' : 'passed'
    end

  end
end
