require 'journey_log'

describe JourneyLog do

let(:entry_station) { double(:station) }
let(:exit_station) { double(:station) }

  describe "#initialize" do
    it "initializes a journey log containing a Journey class parameter" do
      subject = described_class.new(Journey)
      expect(subject.journey_class).to eq(Journey)
    end 
    it "initializes a journey log containing a journeys" do
      subject = described_class.new(Journey)
      expect(subject.journeys).to eq([])
    end 
  end 

  describe "#start" do
    it "starts a new journey with an entry station" do
      subject = described_class.new(Journey)
      subject.start(entry_station)
      expect(subject.journeys.last).to be_an_instance_of(Journey)
    end 
  end 

  describe "#finish" do
    it "add an exit station to current journey" do
      subject = described_class.new(Journey)
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.journeys.length).to eq(1)
    end 
  end 

  describe "#journeys" do
    it "returns journeys" do
      subject = described_class.new(Journey)
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.journeys.length).to eq(1)
    end 
  end 

  
end