class MoodsController < FrontController
  before_action :set_mood, only: [:update_from_email]
  skip_before_filter :authenticate_user!, only: [:update_from_email]

  def index
    @moods = current_user.moods.where(:value.exists => true)

    respond_to do |format|
      format.json
      format.html
    end
  end # End of Index

  def update_from_email
    respond_to do |format|
      if @mood.update(mood_params)
        if current_user && current_user != @mood.user
          sign_out current_user
          sign_in @mood.user
        elsif current_user.nil?
          sign_in @mood.user
        end
        format.html { redirect_to root_path, notice: "Your mood (#{@mood.human_value} has been saved !" }
      else
        format.html { redirect_to root_path(@mood), notice: 'Error: Your daily Mood has not been saved' }
      end
    end
  end

  private

  def set_mood
    @mood = Mood.where(token: mood_params[:token]).first
  end

  def mood_params
    if request.ip != "127.0.0.1"
      params["mood"]["ip"] = request.ip
    end
    params.permit(:value, :token, :ip)
  end
end