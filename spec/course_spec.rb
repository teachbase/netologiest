require "spec_helper"

describe Netologiest::Course do
  describe "valid response" do
    before(:each) do
      mock_api
      courses_stub
    end

    it "return list of courses" do
      courses = described_class.list
      expect(courses.count).to eq 11
      expect(courses.first["id"]).to eq "426"
    end

    it "return detail hash of course" do
      detail_course_stub(931)
      course = described_class.detail(931)
      expect(course["id"]).to eq 931
      expect(course["name"]).to eq "Контекстная реклама в Google AdWords"
      expect(course["blocks"].size).to eq 1
      expect(course["blocks"][0]["lessons"].size).to eq 11
    end

    it "return nil if course not found" do
      empty_course_stub(1)
      course = described_class.detail(1)
      expect(course).to be_nil
    end

    it "many authorize requests" do
      many_requests_stub(931)
      course = described_class.detail(931)
      expect(course["id"]).to eq 931
    end
  end

  describe "errors" do
    it "raise error if token is bad" do
      mock_api
      bad_token_stub(1)
      expect { described_class.detail(1) }
        .to raise_error(Netologiest::Unauthorized, /Need token/)
    end

    it "raise error if secret key is bad" do
      auth_url = "#{Netologiest.config.api_url}/gettoken"
      url = "#{auth_url}?client_secret=#{Netologiest.config.api_key}"
      auth_failed_stub(url)
      expect { described_class.detail(931) }
        .to raise_error(Netologiest::Unauthorized, /Need correct client_secret/)
    end
  end
end
