module Awp3
  module Command
    def exec_s(command)
      p command
      `#{command}`
    end
  end
end