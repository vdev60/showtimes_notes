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
end
