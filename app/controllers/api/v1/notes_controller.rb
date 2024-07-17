class Api::V1::NotesController < ApplicationController
  def create
    @note = Note.new(note_params)

    if @note.save
      render json: @note, status: :created
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  private 

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
