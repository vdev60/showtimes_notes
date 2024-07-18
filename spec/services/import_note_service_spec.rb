# spec/services/import_notes_service_spec.rb
require 'rails_helper'

RSpec.describe ImportNotesService do
  describe '#import' do
    let(:file_path) { Rails.root.join('db', 'mock_notes.json') }
    let(:service) { ImportNotesService.new(file_path) }

    before do
      Note.delete_all
    end

    it 'imports notes from the JSON file' do
      expect { service.import }.to change { Note.count }.by(2)

      note1 = Note.find_by(id: 1)
      note2 = Note.find_by(id: 2)

      expect(note1).not_to be_nil
      expect(note1.title).to eq('Sample Note 1')
      expect(note1.content).to eq('This is the content of sample note 1.')

      expect(note2).not_to be_nil
      expect(note2.title).to eq('Sample Note 2')
      expect(note2.content).to eq('This is the content of sample note 2.')
    end

    it 'does not duplicate existing notes' do
      expect { service.import }.to change { Note.count }.by(2)
      expect { service.import }.not_to change { Note.count }
    end
  end
end
