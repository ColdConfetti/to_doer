class NotesController < ApplicationController

  def index
    create_guest_user unless guest_user
    @notes = Note.where({user_id: current_or_guest_user.id})
    @note = Note.new
  end

  def create
    Note.create({user_id: current_or_guest_user.id, content: params[:note][:content]})
    redirect_to notes_path
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

    def person_params
      params.required(:note).permit(:user_id, :content)
    end
end