require 'rails_helper'

RSpec.describe Note, type: :model do
  describe "validation" do
    it { is_expected.to validate_presence_of :title }

    it "is valid with valid attributes" do
      note = Note.new(title: "Title", content: "Content")
      expect(note).to be_valid
    end

    it "is not valid without title attribute" do
      note = Note.new(title: nil, content: "Content")
      expect(note).not_to be_valid
    end
  end

  describe "search by title or content" do
    let(:note1) { Note.create!(title: "First Note", content: "Some content") }
    let(:note2) { Note.create!(title: "Second Note", content: "Other content") }
    let(:note3) { Note.create!(title: "Another Note", content: "Different content including First") }
    let(:note4) { Note.create!(title: "Another Text", content: "Another Text") }

    it "returns notes matching the title" do
      expect(Note.search_by_title_or_content("First")).to include(note1, note3)
      expect(Note.search_by_title_or_content("First")).not_to include(note2)
    end

    it "returns notes matching the content" do
      expect(Note.search_by_title_or_content("content")).to include(note1, note2, note3)
      expect(Note.search_by_title_or_content("content")).not_to include(note4)
    end

    it "returns an empty array if no notes match" do
      expect(Note.search_by_title_or_content("none")).to be_empty
    end
  end
end
