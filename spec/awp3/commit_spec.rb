require 'spec_helper'

RSpec.describe Awp3::Commit do
  before(:all) do
    @date = Time.now.to_datetime
    @commit_obj = Awp3::Commit.new(%w(/aa/aa.rb /aa/bb.rb), @date)
    @commit = @commit_obj.commit
  end

  it ':git_add' do
    expect(@commit[:git_add]).to eq('git add /aa/aa.rb /aa/bb.rb')
  end

  it 'git_commit' do
    expect(@commit[:git_commit]).to eq("GIT_AUTHOR_DATE='#{@date}' GIT_COMMITTER_DATE='#{@date}' git commit -m '#{@commit_obj.message}'")
  end
end
