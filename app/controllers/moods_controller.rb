class MoodsController < FrontController
  
  def index
    @moods = current_user.moods
  end # End of Index
end