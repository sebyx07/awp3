module Awp3
  class Grabber
    attr_accessor :start_interval, :end_interval, :max_commits

    def initialize(start_interval, end_interval, max_commits)
      @start_interval = eval(start_interval).to_datetime
      @end_interval = eval(end_interval).to_datetime
      if max_commits == 'max'
        @max_commits = 'max'
      else
        @max_commits = max_commits.to_i
      end
      _validate
    end

    def grab_files
      @grab_files ||= `git diff --name-only`.split("\n")
    end

    def grab
      interval = split_interval_in_parts
      grabs = []
      index = 0
      file_partitions = _file_partitions
      interval.each do |_interval|
        grabs.push({files: file_partitions[index], time: _interval})
        index += 1
      end
      grabs
    end

    def split_interval_in_parts
      return @interval if @interval
      diff = ((end_interval - start_interval) * 24 * 60 * 60).to_i
      split_into = grab_files.size
      if max_commits.is_a? Integer
        split_into = max_commits
      end

      split_diff = diff / split_into

      current = start_interval

      arr = [current]
      while current + split_diff.seconds < end_interval
        current += split_diff.seconds
        arr << current
      end
      arr = _remove_middle_time(arr)
      @interval = _random_time(arr, split_diff)
    end

    private
    def _validate
      [:start_interval, :end_interval].each do |m|
        unless send(m).is_a? DateTime
          raise "#{m} is not valid time"
        end
      end

      if start_interval > end_interval
        raise 'Start is > than end'
      end
    end

    def _remove_middle_time(arr)
      if arr.size > 2
        arr.delete_at(arr.size / 2)
      end
      arr
    end

    def _random_time(arr, split_diff)
      split_diff *= 0.5
      arr.each_with_index do |_el, i|
        if i == arr.size - 1
          next
        end

        time = rand((split_diff * - 1).. split_diff)
        arr[i] = arr[i] + time.seconds
      end
    end

    def _file_partitions
      size = (grab_files.size / split_interval_in_parts.size)
      if size <= 0
        size = 1
      end
      arr = grab_files.each_slice(size).to_a
      rev = grab_files.reverse
      last_file = arr[split_interval_in_parts.size - 1].last
      i = 0
      last_arr = []
      while rev[i] != last_file
        last_arr << rev[i]
        i += 1
      end
      arr[split_interval_in_parts.size - 1] += last_arr
      arr[0..split_interval_in_parts.size]
    end
  end
end
