class ImportNotesService
  def initialize(file_path)
    @file_path = file_path
  end

  def import
    file = File.read(@file_path)
    notes_data = JSON.parse(file)
    notes_data.each do |note_data|
      note = Note.find_or_initialize_by(id: note_data['id'])
      note.title = note_data['title']
      note.content = note_data['content']
      note.save!
    end
  rescue StandardError => e
    Rails.logger.error("Failed to import notes: #{e.message}")
  end
end