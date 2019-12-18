require 'station'

describe Station do

  it "is initialised with a zone" do
    subject = Station.new("Aldgate East", 2)
    expect(subject.zone) .to eq(2)
  end
  it "is initialised with a zone" do
    subject = Station.new("Aldgate East", 2)
    expect(subject.name) .to eq("Aldgate East")
  end


end
