class Admin::AuthorNotesController < Admin::BaseController
  before_action :set_author   

  def new 
    @note = Note.new 
  end

  def create 
    @note = current_user.sent_notes.build(note_params)
    @note.recipient_id = @author.id
    @note.recipient_type = "Author"
    
    if @note.save 
      Notification.create!(
         recipient: @author,
         notifiable: @note,
         read: false, 
         message: "You received a note from admin."
      )
      redirect_to admin_authors_path, notice: "Note sent to #{@author.email}"
    else 
      render :new 
    end
  end

  private  

  def set_author
    @author = Author.find(params[:author_id])
  end

  def note_params
    params.require(:note).permit(:body)
  end
end