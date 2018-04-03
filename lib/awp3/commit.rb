module Awp3
  class Commit
    MESSAGES_LIST = ['work on', 'change', 'modify', 'update', 'change to', 'fix', 'repair', 'refactor']
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
      "GIT_AUTHOR_DATE='#{date}' GIT_COMMITTER_DATE='#{date}' git commit -m '#{message}'"
    end

    def files_names_for_commit
      file = files.first
      File.basename(file, File.extname(file)).gsub(/\-|_/, " ").split.first
    end
  end
end
