require 'oystercard'

describe Oystercard do
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }


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

  it "can detect when oystercard has touched in" do
    subject.top_up(5)
    expect(subject.touch_in(entry_station)) .to eq true
  end

  it "can detect when you have touched out" do
    expect(subject.touch_out(exit_station)) .to eq false
  end

  it "fails to allow touch in if insufficient funds" do
    expect { subject.touch_in(entry_station) } .to raise_error "insufficient funds"
  end

  it "touch out reduced balance by minimum fare" do
    subject.top_up(11)
    subject.touch_in(entry_station)
    expect { subject.touch_out(exit_station)} .to change {subject.balance } .by(-Oystercard::MINIMUM_FARE)
  end

  it "records the entry station on touch in" do
    subject.top_up(11)
    subject.touch_in(entry_station)
    expect(subject.entry_station) .to eq(entry_station)
  end
  it "sets the entry station to nil on touch out" do
    subject.top_up(11)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.entry_station) .to eq(nil)
  end

  it "stores a history of multiple journey"
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.exit_station) .to eq(exit_station)

end
