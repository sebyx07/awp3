module Awp3
  class Grabber
    FIELDS = [:start_interval, :end_interval, :max_commits]
    attr_reader *FIELDS

    def initialize(start_interval, end_interval, max_commits)
      @start_interval = eval(start_interval).to_datetime
      @end_interval = eval(end_interval).to_datetime
      unless max_commits == 'max'
        @max_commits = max_commits.to_i
      end
      _validate
    end

    def grab_files
    end

    private
    def _validate
      [:start_interval, :end_interval].each do |m|
        unless send(m).is_a? DateTime
          raise "#{m} is not valid time"
        end
      end
    end
  end
end
