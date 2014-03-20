class HomeController < FrontController
  skip_before_filter :authenticate_user!

  def index
    @user = User.new
  end # End of Index
end