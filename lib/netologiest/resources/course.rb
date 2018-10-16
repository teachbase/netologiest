module Netologiest
  # Child class for Resource
  # describe rules for parsing Netology response
  class Course < Netologiest::Resource
    self.resource_name = 'courses'

    # Methods for parsing JSON response
    # it returns Array of Hash instances
    def handle_list(response)
      parse_json(response)
    end

    # it returns a Hash instance
    # it contains deep elements:
    # => blocks: [{lessons: [{questions: []}]]
    def handle_detail(response)
      parse_json(response)
    end

    private

    def parse_json(response)
      data = JSON.parse(response)
      return unless data.present? || data.any?

      data
    end
  end
end
