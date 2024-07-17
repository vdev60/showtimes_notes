# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Notes", type: :request do
  let(:valid_attributes) do
    {
      title: "Title",
      content: "Content"
    }
  end

  let(:invalid_attributes) do
    {
      title: nil,
      content: "Content"
    }
  end

  describe "POST /api/v1/notes" do
    context "with valid params" do
      it "creates a new note" do
        expect { post api_v1_notes_path, params: { note: valid_attributes }, as: :json }.to change(Note, :count).by(1)
      end

      it "renders a JSON response" do
        post api_v1_notes_path, params: { note: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid params" do
      it "does not create a new Note" do
        expect do
          post api_v1_notes_path,
               params: { note: invalid_attributes }, as: :json
        end.to change(Note, :count).by(0)
      end

      it "renders a JSON response with errors" do
        post api_v1_notes_path,
             params: { note: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
