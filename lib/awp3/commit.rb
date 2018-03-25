module Awp3
  class Commit
    MESSAGES_LIST = ['work on', 'change', 'modify this', 'update', 'change to']
    attr_reader :files, :date, :message

    def initialize(files, date)
      @files = files
      @date = date
      @message = MESSAGES_LIST.shuffle.first.concat(" #{files_names_for_commit}")
    end

    def commit
      {
        git_add: "git add #{files.join(' ')}",
        git_commit: generate_commit_message
      }
    end

    def commit!
      _commit = commit
      p `#{_commit[:git_add]}`
      p `#{_commit[:git_commit]}`
    end

    private

    def generate_commit_message
      "GIT_AUTHOR_DATE='#{date}' GIT_COMMITTER_DATE='#{date}' git commit -m '#{message}'"
    end

    def files_names_for_commit
      files.map {|f| File.basename(f, File.extname(f))}.join(' ')
    end
  end
end
