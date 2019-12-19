require 'oystercard'

describe Oystercard do
  let(:entry_station1) { double(:station) }
  let(:exit_station1) { double(:station) }
  let(:entry_station2) { double(:station) }
  let(:exit_station2) { double(:station) }

  describe '#initialize' do
    it 'creates oystercard with balance of 0 by default' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'increases the balance' do
      expect(subject.top_up(10)) .to eq(subject.balance)
    end

    it "prevented if it will exceed the maximum balance" do
      expect { subject.top_up(described_class::MAXIMUM_BALANCE + 1) } .to raise_error "Top Up above maximum"
    end
  end

  describe '#touch_in' do
    it "fails in case of insufficient funds" do
      expect { subject.touch_in(entry_station1) } .to raise_error "insufficient funds"
    end
    it "records the entry station" do
      subject.top_up(11)
      subject.touch_in(entry_station1)
      expect(subject.history_of_journeys) .not_to be_empty
    end
    it "reduces balance by 6 when it follows a previous touch in" do
      subject.top_up(11)
      subject.touch_in(entry_station1)
      expect { subject.touch_in(entry_station2)} .to change {subject.balance }.by(-6)
    end
  end

  describe '#touch_out' do
    it "reduces balance by 2 when it follows a touch in" do
      subject.top_up(11)
      subject.touch_in(entry_station1)
      expect { subject.touch_out(exit_station1)} .to change {subject.balance }.by(-2)
    end

    it "reduces balance by 6 when it follows a touch out" do
      subject.top_up(11)
      subject.touch_in(entry_station1)
      subject.touch_out(exit_station1)
      expect { subject.touch_out(exit_station2)} .to change {subject.balance }.by(-6)
    end

    it "ends the most recent journey if it has a touch in" do
      subject.top_up(11)
      subject.touch_in(entry_station1)
      expect(subject.history_of_journeys.last).to receive(:end)
      subject.touch_out(exit_station1)
    end

    it "creates a new journey if done for first time without touch in" do
      subject.top_up(11)
      subject.touch_out(exit_station1)
      expect(subject.history_of_journeys) .not_to be_empty
    end

    it "creates a new journey if most recent journey does not have a touch in" do
      subject.top_up(11)
      subject.touch_in(entry_station1)
      subject.touch_out(exit_station1)
      subject.touch_out(exit_station2)
      expect(subject.history_of_journeys.length) .to eq(2)
    end

    it "works for successive journeys" do
      subject.top_up(11)
      subject.touch_in(entry_station1)
      subject.touch_out(exit_station1)
      subject.touch_in(entry_station2)
      subject.touch_out(exit_station2)
      expect(subject.history_of_journeys.length) .to eq(2)
    end
  end
end
