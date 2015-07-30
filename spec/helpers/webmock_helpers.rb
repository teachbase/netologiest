module NetologiestWebMock
  def mock_api
    auth_url = "#{Netologiest.config.api_url}/gettoken"
    url = "#{auth_url}?client_secret=#{Netologiest.config.api_key}"
    authorize_stub(url)
  end

  def authorize_stub(url)
    stub_request(:get, url)
      .to_return(
        headers: { 'Content-Type' => 'application/json' },
        status: 200,
        body: File.read("spec/fixtures/auth.json")
      )
  end

  def courses_stub
    token = "S3PBVG38O1209Y01X5LEK0PYH0MT3YDZ"
    url = Netologiest.config.api_url + "/courses?token=#{token}"
    stub_request(:get, url).to_return(
      headers: { 'Content-Type' => 'application/json' },
      status: 200,
      body: File.read("spec/fixtures/courses.json")
    )
  end

  def empty_course_stub(id)
    token = "S3PBVG38O1209Y01X5LEK0PYH0MT3YDZ"
    url = Netologiest.config.api_url + "/courses/#{id}?token=#{token}"
    stub_request(:get, url).to_return(
      headers: { 'Content-Type' => 'application/json' },
      status: 200,
      body: "[]"
    )
  end

  def detail_course_stub(id)
    token = "S3PBVG38O1209Y01X5LEK0PYH0MT3YDZ"
    url = Netologiest.config.api_url + "/courses/#{id}?token=#{token}"
    stub_request(:get, url).to_return(
      headers: { 'Content-Type' => 'application/json' },
      status: 200,
      body: File.read("spec/fixtures/course.json")
    )
  end

  def bad_token_stub(id)
    url = Netologiest.config.api_url + "/courses/#{id}?token=S3PBVG38O1209Y01X5LEK0PYH0MT3YDZ"
    stub_request(:get, url).to_return(
      headers: { 'Content-Type' => 'application/json' },
      status: 401,
      body: "Need token"
    )
  end

  def auth_failed_stub(url)
    stub_request(:get, url)
      .to_return(
        headers: { 'Content-Type' => 'application/json' },
        status: 401,
        body: "Need correct client_secret"
      )
  end

  def many_requests_stub(id)
    token = "S3PBVG38O1209Y01X5LEK0PYH0MT3YDZ"
    url = Netologiest.config.api_url + "/courses/#{id}?token=#{token}"
    stub_request(:get, url).to_return(
      {
        headers: { 'Content-Type' => 'application/json' },
        status: 401,
        body: "Need token"
      },
      headers: { 'Content-Type' => 'application/json' },
      status: 200,
      body: File.read("spec/fixtures/course.json")
    )
  end
end
