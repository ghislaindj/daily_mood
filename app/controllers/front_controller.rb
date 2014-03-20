class FrontController < ApplicationController
  before_filter :authenticate_user!

end