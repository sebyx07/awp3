module Awp3
  module Command
    def exec_s(command, show_output: false)
      p command

      if show_output
        print "\n"
        result = `#{command}`
        result.split("\n").each do |row|
          next if row.blank? || row == "\n"

          print "#{row.strip}\n"
        end
      end

      `#{command}`
    end
  end
end
