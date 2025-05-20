class Authors::NotesController < ApplicationController 
  before_action :authenticate_author!

  def index 
    @notes = Note.where(recipient: current_author).includes(:sender).order(created_at: :desc)
  end
end 