class NotesController < ApplicationController

  def index
    create_guest_user unless guest_user
    @notes = Note.where({user_id: current_or_guest_user.id})
    @note = Note.new
  end

  def complete
    @notes = Note.where({user_id: current_or_guest_user.id, complete: true})
  end

  def create
    Note.create({user_id: current_or_guest_user.id, content: params[:note][:content], complete: false})
    redirect_to notes_path
  end

  def edit
  end

  def update
    @note = Note.find(params[:id])
    p @note.id
    respond_to do |format|
      if !@note.update_attributes(person_params)
        @error = 'Could not update name'
      end
      format.js
    end
    render notes_path
  end

  def delete
  end

  private

    def person_params
      params.required(:note).permit(:user_id, :content, :complete)
    end
end