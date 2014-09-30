class NotesController < ApplicationController
  def index
    @notes = Note.where({user_id: current_or_guest_user.id})
  end
end
