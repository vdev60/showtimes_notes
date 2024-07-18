class NoteImportJob
  @queue_as= :note_import

  def self.perform(*args)
    ImportNotesService.new(Rails.root.join('db', 'mock_notes.json')).import
  end
end
