require 'spec_helper'

RSpec.describe Awp3::Grabber do
  before(:all) do
    @start = '3.hours.ago'
    @end = 'Time.now'
    @grabber = Awp3::Grabber.new(@start, @end, 'max')
  end

  it 'valid' do

  end
end
