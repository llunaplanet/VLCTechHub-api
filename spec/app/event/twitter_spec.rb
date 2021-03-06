require 'spec_helper'

describe VLCTechHub::Event::Twitter do
  let(:event) do
    {
      'title' => 'a title',
      'date' => DateTime.new(2001,12,01),
      'hashtag' => '#awesome',
      'slug' => 'a-title'
    }
  end
  let(:twitter_api) { double(:twitter_api, credentials: {a: 'b'}) }
  let(:subject) { described_class.new(twitter_api) }

  describe '#tweet' do
    it 'sends a tweet with date, hashtag and title' do
      expect(twitter_api).to receive(:update)
        .with(string_that_includes(['a title', '#awesome', '01/12/2001']))

      subject.new_event(event)
    end

    it 'sends a link back to vlctechhub' do
      expect(twitter_api).to receive(:update)
        .with(string_that_includes(['http://vlctechhub.org/events/a-title']))

      subject.new_event(event)
    end

    xit 'supports long title' do
    end
  end

  describe '#tweet_today_events' do
    it 'sends tweets with time and title' do
      expect(twitter_api).to receive(:update)
        .with(string_that_includes(['Hoy', 'a title', '#awesome', '01:00', 'http://vlctechhub.org/events/a-title']))

      subject.today([event])
    end
  end
end
