require "rails_helper"

RSpec.describe ErrorSerializer do
  describe ".serialize_json" do
    it "returns a JSON object with the correct error message" do
      error_object = double("error_object", status_code: 404, message: "Not found")
      error_serializer = ErrorSerializer.new(error_object)

      expect(error_serializer.serialize_json).to eq(
        {
          errors: [
            {
              status: 404,
              title: "Not found"
            }
          ]
        }
      ) 
    end
  end
end