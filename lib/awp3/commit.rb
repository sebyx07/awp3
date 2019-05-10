module Awp3
  class Commit
    MESSAGES_LIST = %w[fix change update].freeze
    attr_reader :files, :date, :message, :commit_message

    def initialize(files, date, commit_message = '')
      @files = files
      @date = date
      @message = build_message
      @commit_message = commit_message.present? ? " #{commit_message}" : nil
    end

    def commit
      {
        git_add: "git add #{files.join(' ')}",
        git_commit: generate_commit_message
      }
    end

    def build_message
      message = MESSAGES_LIST.sample

      full_message_chance = rand(1..10)
      return message if full_message_chance < 3

      add_file_name_to_message(message)
    end

    def add_file_name_to_message(message)
      number_of_names_from_file = rand(2..5)
      file_name = files_names_for_commit.split(/_|-/).first(number_of_names_from_file).join(' ')
      message + " #{file_name}"
    end

    def commit!
      _commit = commit
      p _commit[:git_add]
      `#{_commit[:git_add]}`
      p `#{_commit[:git_commit]}`
    end

    def add_new!
      p add = 'git add .'
      `#{add}`
      p `GIT_AUTHOR_DATE='#{date}' GIT_COMMITTER_DATE='#{date}' git commit -m 'update'`
    end

    private

    def generate_commit_message
      "GIT_AUTHOR_DATE='#{date}' GIT_COMMITTER_DATE='#{date}' git commit -m '#{message}#{commit_message}'"
    end

    def files_names_for_commit
      file = files.first
      File.basename(file, File.extname(file))
    end
  end
end
