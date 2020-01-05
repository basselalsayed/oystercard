# frozen_string_literal: true

require 'journey_log'

describe JourneyLog do
  let(:entry_station) { double(:station1) }
  let(:exit_station) { double(:station2) }
  let(:subject) { described_class.new(Journey) }
  let(:most_recent_journey) { subject.journeys.last }

  describe '#initialize' do
    it 'initializes a journey log containing a Journey class parameter' do
      expect(subject.journey_class).to eq(Journey)
    end
    it 'initializes a journey log containing journeys' do
      expect(subject.journeys).to eq([])
    end
  end

  context 'needs an entry station' do
    before do
      subject.start(entry_station)
    end

    describe '#start' do
      it 'starts a new journey with an entry station' do
        expect(most_recent_journey).to be_an_instance_of(Journey)
      end
    end

    describe '#finish' do
      it 'add an exit station to current journey' do
        subject.finish(exit_station)
        expect(most_recent_journey.exit_station).to eq(exit_station)
      end
    end

    describe '#journeys' do
      it 'returns journeys' do
        subject.finish(exit_station)
        expect(subject.journeys.length).to eq(1)
      end
    end
  end
end
