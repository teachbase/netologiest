module Netologiest
  class Lesson < Netologiest::Resource
    self.resource_name = 'lessons'

    attr_reader :lesson_token, :lesson_token_expire,
                :course_id, :id, :iframe_url

    def initialize(course_id, lesson_id)
      authorize!
      @course_id = course_id
      @id = lesson_id
    end

    def self.video_url(course_id, lesson_id)
      lesson = new(course_id, lesson_id)
      lesson.video_token
      lesson.video_url
    end

    def video_token
      url = build_url(
        Netologiest::Course.resource_name,
        course_id,
        self.class.resource_name,
        id,
        'gettoken'
      )

      handle_lesson_token(get(url))
    end

    def video_url
      @iframe_url = build_url(
        Netologiest::Course.resource_name,
        course_id,
        self.class.resource_name,
        id,
        "iframe?token=#{lesson_token}"
      )
    end

    private

    def handle_lesson_token(response)
      data = JSON.parse(response)
      return if data.kind_of?(Hash) && data.empty?

      @lesson_token_expire = data["expires_in"]
      @lesson_token = data["access_token"]
    end
  end
end
