class Admin::AuthorsController < Admin::BaseController
  def index
    @authors = Author  
      .includes(:blogs)
      .order(created_at: :desc)
      .page(params[:page])
      .per(10)
  end
end