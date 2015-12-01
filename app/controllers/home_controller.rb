class HomeController < ApplicationController
  def index
    puts User.all
    @users = User.all
  end
end
