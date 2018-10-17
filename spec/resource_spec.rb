require "spec_helper"

describe Netologiest::Resource do
  before(:each) { mock_api }

  it "get authorization token automaticaly" do
    res = described_class.new
    expect(res.token).to eq "S3PBVG38O1209Y01X5LEK0PYH0MT3YDZ"
    expect(res.token_expire.to_s.empty?).not_to be_truthy
  end
end
