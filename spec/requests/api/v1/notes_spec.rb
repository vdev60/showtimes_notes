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

  describe "PATCH /api/v1/notes/:id" do
    context "with valid params" do
      let(:new_attributes){
        {
          title: "new title",
          content: "new content"
        }
      }
      it "updates the existed note" do
        note = Note.create!(valid_attributes)
        patch api_v1_note_path(note),
              params: { note: invalid_attributes }, as: :json
        expect(note.attributes).to include(valid_attributes.stringify_keys)
      end

      it "renders a JSON response" do
        note = Note.create!(valid_attributes)
        patch api_v1_note_path(note), params: { note: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        note = Note.create!(valid_attributes)
        patch api_v1_note_path(note),
             params: { note: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "GET /api/v1/notes/:id" do
    it "renders a JSON responsee OK for the existed note" do
      note = Note.create!(valid_attributes)
      get api_v1_note_path(note)
      expect(response).to have_http_status(:ok)
    end

    it "renders a JSON responsee 404 for the not existed note" do
      note = Note.create!(valid_attributes)
      get api_v1_note_path(id: DateTime.now)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /api/v1/notes/:id" do
    it "destroys the note" do
      note = Note.create!(valid_attributes)
      expect {
        delete api_v1_note_path(note), as: :json
      }.to change(Note, :count).by(-1)
    end
  end

  describe "GET /api/v1/notes" do
    it "renders a successful response" do
      Note.create!(valid_attributes)
      get api_v1_notes_path, as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /api/v1/notes" do
    let!(:note1) { Note.create!(title: "First Note", content: "Some content") }
    let!(:note2) { Note.create!(title: "Second Note", content: "Other content") }
    let!(:note3) { Note.create!(title: "Another Note", content: "Different content including First") }

    context "without search query" do
      it "returns all notes" do
        get api_v1_notes_path, as: :json

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end

    context "with search query" do
      it "returns notes matching the title or content" do
        get api_v1_notes_path(query: "First"), as: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).map { |note| note["id"] }).to contain_exactly(note1.id, note3.id)
      end

      it "returns an empty array if no notes match" do
        get api_v1_notes_path(query: "None"), as: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to be_empty
      end
    end
  end
end
