require 'spec_helper'

RSpec.describe Awp3::Grabber do
  before(:all) do
    @start = '3.hours.ago'
    @end = 'Time.now'
    @files = (1..100).map { |i| "file_#{i}"}
  end

  describe '#split_interval_in_parts' do
    it 'max' do
      @grabber = Awp3::Grabber.new(@start, @end, 'max')
      allow(@grabber).to receive(:grab_files).and_return(@files)
      parts = @grabber.split_interval_in_parts
      parts.each_with_index do |part, i|
        next if i == 0
        expect(part > parts[i - 1]).to be_truthy
      end

      expect(parts.size).to eq(100)
    end

    it '2' do
      @grabber = Awp3::Grabber.new(@start, @end, '2')
      allow(@grabber).to receive(:grab_files).and_return(@files)
      parts = @grabber.split_interval_in_parts
      parts.each_with_index do |part, i|
        next if i == 0
        expect(part > parts[i - 1]).to be_truthy
      end

      expect(parts.size).to eq(2)
    end
  end

  describe '#grab' do
    it 'max' do
      @grabber = Awp3::Grabber.new(@start, @end, 'max')
      allow(@grabber).to receive(:grab_files).and_return(@files)
      grabs = @grabber.grab
      expect(grabs.size).to eq(100)
    end

    it "count" do
      (2..100).to_a.reverse.each do |count|
        @grabber = Awp3::Grabber.new(@start, @end, count)
        allow(@grabber).to receive(:grab_files).and_return(@files)
        grabs = @grabber.grab
        expect(grabs.size).to eq(count)
        expect(grabs.last[:files].include?('file_100'))
      end
    end
  end
end
