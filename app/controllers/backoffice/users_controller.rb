class Backoffice::UsersController < Backoffice::BaseController

  # GET /backoffice/users
  # GET /backoffice/users.json
  def index
    @users = User.all
    @moods = Mood.where(:value.exists => true)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.xls
    end
  end
end