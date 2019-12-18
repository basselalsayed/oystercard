require 'journey'

describe Journey do
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe "#initialize" do
    it "creates an instance of journey with an entry station" do
      subject = Journey.new(entry_station)
      expect(subject.entry_station) .to eq(entry_station)
    end
  end

  describe "#end" do
    it "add exit station to end a journey" do
      subject = Journey.new(entry_station)
      subject.end(exit_station)
      expect(subject.exit_station) .to eq(exit_station)
    end
  end

  describe "#calc_fare" do
    it "returns minimum fare when entry and exit OK" do
      subject = Journey.new(entry_station)
      subject.end(exit_station)
      expect(subject.calc_fare) .to eq (described_class::MINIMUM_FARE)
    end
    it "returns penaltyfare when entry or exit not OK" do
      subject = Journey.new(entry_station)
      expect(subject.calc_fare) .to eq (described_class::PENALTY_FARE)
    end
  end

  describe "#complete?" do
    it "returns true when entry and exit OK" do
      subject = Journey.new(entry_station)
      subject.end(exit_station)
      expect(subject.complete?) .to eq (true)
    end
    it "returns false when entry or exit not OK" do
      subject = Journey.new(entry_station)
      expect(subject.complete?) .to eq (false)
    end
  end
end
