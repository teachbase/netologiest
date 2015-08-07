require "spec_helper"

describe Netologiest::Lesson do
  describe "valid access token" do
    before(:each) do
      mock_api
      lesson_token_stub(931, 2268)
    end

    it "return token" do
      lesson = described_class.new(931, 2268)
      expect(lesson.video_token)
        .to eq "26C1WYAIWT3LRX12W8H4DTA9FRF3NLH9"
      expect(lesson.lesson_token_expire)
        .to eq 600
    end

    it "return iframe url with token" do
      url = described_class.video_url(931, 2268)
      expected = "#{Netologiest.config.api_url}/courses/931/lessons/2268/"
      expected += "iframe?token=26C1WYAIWT3LRX12W8H4DTA9FRF3NLH9"
      expect(url).to eq expected
    end
  end
end