# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  let(:station_1) { double(:station_1, zone: 1) }
  let(:station_2) { double(:station_2, zone: 2) }
  let(:station_3) { double(:station_3, zone: 3) }
  let(:station_4) { double(:station_4, zone: 4) }

  describe '#initialize' do
    it 'creates oystercard with balance of 0 by default' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'increases the balance' do
      expect(subject.top_up(10)).to eq(subject.balance)
    end

    it 'prevented if it will exceed the maximum balance' do
      expect { subject.top_up(described_class::MAXIMUM_BALANCE + 1) }
        .to raise_error 'Top Up above maximum'
    end
  end

  describe '#touch_in' do
    it 'fails in case of insufficient funds' do
      expect { subject.touch_in(station_1) }
        .to raise_error 'insufficient funds'
    end
    it 'records the entry station' do
      subject.top_up(11)
      subject.touch_in(station_1)
      expect(subject.journey_log.journeys) .not_to be_empty
    end
    it 'reduces balance by 6 when it follows a previous touch in' do
      subject.top_up(11)
      subject.touch_in(station_1)
      expect { subject.touch_in(station_3) }
        .to change { subject.balance }.by(-6)
    end
  end

  describe '#touch_out' do
    before do
      subject.top_up(20)
    end

    it 'reduces balance by 2 when it follows a touch in' do
      subject.touch_in(station_1)
      expect { subject.touch_out(station_2) }
        .to change { subject.balance }.by(-2)
    end

    it 'reduces balance by 6 if touching out for first time without touch in' do
      expect { subject.touch_out(station_2) }
        .to change { subject.balance }.by(-6)
    end

    it 'ends the most recent journey if it has a touch in' do
      subject.touch_in(station_1)
      expect(subject.journey_log.journeys.last).to receive(:end)
      subject.touch_out(station_2)
    end

    it 'creates a new journey if done for first time without touch in' do
      subject.touch_out(station_2)
      expect(subject.journey_log.journeys) .not_to be_empty
    end

    it 'creates a new journey if most recent journey has no touch in' do
      subject.touch_in(station_1)
      subject.touch_out(station_2)
      subject.touch_out(station_4)
      expect(subject.journey_log.journeys.length).to eq(2)
    end

    it 'works for successive journeys' do
      subject.touch_in(station_1)
      subject.touch_out(station_2)
      subject.touch_in(station_3)
      subject.touch_out(station_4)
      expect(subject.journey_log.journeys.length).to eq(2)
    end
  end
end
