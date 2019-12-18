require 'oystercard'
require 'journey'

describe Oystercard do
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }
  #let(:journey) { double(:journey), ::MINIMUM_FARE = 2 }


  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  # describe 'top_up' do
  #
  #   it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'can top up the balance' do
    expect(subject.top_up(10)) .to eq(subject.balance)
  end

  it "cannot top-up beyond maximum balance" do
    expect { subject.top_up(Oystercard::MAXIMUM_BALANCE + 1) } .to raise_error "Top Up above maximum"
  end

  it "fails to allow touch in if insufficient funds" do
    expect { subject.touch_in(entry_station) } .to raise_error "insufficient funds"
  end

  it "touch out reduces balance" do
    subject.top_up(11)
    subject.touch_in(entry_station)
    expect { subject.touch_out(exit_station)} .to change {subject.balance }
  end

  it "records the entry station on touch in" do
    subject.top_up(11)
    subject.touch_in(entry_station)
    expect(subject.history_of_journeys) .not_to be_empty
  end

  #it "records the exit station on touch out" do
  #  subject.top_up(11)
  #  subject.touch_in(entry_station)
  #  history_before = []
  #  history_before.append(subject.history_of_journeys.last)
  #  p history_before
  #  subject.touch_out(exit_station)
  #  p history_before
  #  expect(subject.history_of_journeys).not_to eq(history_before)
#  end

  it "records the exit station on touch out" do
    subject.top_up(11)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.history_of_journeys.last.complete?).to be true
  end


  it "stores a history of multiple journey" do
    subject.top_up(11)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.history_of_journeys.length) .to eq(2)
  end

end
