module Awp3
  module Command
    def exec_s(command)
      p command
      system(command)
    end
  end
end
