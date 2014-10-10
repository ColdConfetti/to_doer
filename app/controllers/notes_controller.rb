class NotesController < ApplicationController

  def index
    unless user_signed_in?
      flash.now[:notice] = "You are currently signed in as a guest. Login or sign up to save your notes."
    end
    create_guest_user unless guest_user || user_signed_in?
    @notes = Note.where({user_id: current_or_guest_user.id, complete: false}).order("CASE WHEN Due is null THEN 1 else 0 END, Due")
    @note = Note.new
  end

  def complete
    @notes = Note.where({user_id: current_or_guest_user.id, complete: true})
  end

  def create
    formatted_date = params[:note][:due].gsub(/(\d+)\/(\d+)\/(\d+)/,"\\3-\\1-\\2")
    to_save = Note.new({user_id: current_or_guest_user.id, content: params[:note][:content], complete: false, due: formatted_date})
    if to_save.content != ""
      to_save.save
      redirect_to notes_path
    else
      flash[:alert] = "Your to-do item must contain some content!"
      redirect_to notes_path
    end
  end

  def edit
  end

  def update
    @note = Note.find(params[:id])
    respond_to do |format|
      if !@note.update_attributes(person_params)
        flash[:alert] = "The note could not be updated."
        redirect_to request.referer
      end
      format.js { render :action => "index", :formats => [:html] }
    end
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
    render complete_notes_path
  end

  private

    def person_params
      params.required(:note).permit(:user_id, :content, :complete, :due)
    end
end