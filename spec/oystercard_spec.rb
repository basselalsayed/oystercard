require 'oystercard'

describe Oystercard do
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

  it "can reduce balance by a specified amount" do
    subject.top_up(11)
    expect(subject.deduct(10)) .to eq(subject.balance)
  end


end
