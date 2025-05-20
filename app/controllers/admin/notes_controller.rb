# This is the dedicated notes_controller for regular users. 
class Admin::NotesController < Admin::BaseController
    before_action :set_user 

    def new 
        @note = Note.new  
    end

    def create  
        @note = current_user.sent_notes.build(note_params)
        @note.recipient = @user    

        if @note.save
            Notification.create(
                user: @user,
                notifiable: @note, 
                read: false, 
                message: "You received a note from admin."
            )
            redirect_to admin_users_path, notice: "Note sent to #{@user.email}"
        else 
            render :new 
        end
    end

    private   

    def set_user
        @user = User.find(params[:user_id])
    end

    def note_params
        params.require(:note).permit(:body)
    end
end