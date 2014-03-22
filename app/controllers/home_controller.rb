class HomeController < FrontController
  skip_before_filter :authenticate_user!

  def index
    if current_user
      redirect_to moods_path
    else
      @user = User.new
    end
  end # End of Index
end