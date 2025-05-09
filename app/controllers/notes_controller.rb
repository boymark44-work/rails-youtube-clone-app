class NotesController < ApplicationController
    before_action :authenticate_user!

    def index
        @notes = current_user.received_notes.order(created_at: :desc)
    end
end