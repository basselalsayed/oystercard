# frozen_string_literal: true

require 'journey'

describe Journey do
  let(:station_1) { double(:station_1, zone: 1) }
  let(:station_2) { double(:station_2, zone: 1) }
  let(:station_3) { double(:station_2, zone: 3) }
  let(:station_4) { double(:station_2, zone: 4) }
  let(:subject) { described_class.new(station_1) }

  describe '#initialize' do
    it 'creates an instance of journey with an entry station' do
      expect(subject.entry_station) .to eq(station_1)
    end
  end

  describe '#end' do
    it 'add exit station to end a journey' do
      subject.end(station_2)
      expect(subject.exit_station) .to eq(station_2)
    end
  end

  describe '#calc_fare' do
    it 'returns minimum fare + zone fare when entry and exit OK' do
      subject.end(station_3)
      expect(subject.calc_fare) .to eq(described_class::MINIMUM_FARE + 2)
    end
    it 'deducts £2 for a journey within the same zone' do 
      subject.end(station_2)
      expect(subject.calc_fare) .to eq(described_class::MINIMUM_FARE * 2)
    end
    it 'returns penaltyfare when entry or exit not OK' do
      expect(subject.calc_fare) .to eq described_class::PENALTY_FARE
    end
  end

  describe '#complete?' do
    it 'returns true when entry and exit OK' do
      subject.end(station_2)
      expect(subject.complete?) .to eq true
    end
    it 'returns false when entry or exit not OK' do
      expect(subject.complete?) .to eq false
    end
  end
end
