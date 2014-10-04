class NotesController < ApplicationController

  def index
    unless user_signed_in?
      flash.now[:notice] = "You are currently signed in as a guest. Login or sign up to save your notes."
    end
    create_guest_user unless guest_user || user_signed_in?
    @notes = Note.where({user_id: current_or_guest_user.id, complete: false})
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
      format.js { render :action => "index", :formats => [:html] }
      # render notes_path
    end
    # render notes_path
  end

  def delete
  end

  private

    def person_params
      params.required(:note).permit(:user_id, :content, :complete)
    end
end