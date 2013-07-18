class DashboardController < ApplicationController
  def index
      @organizations = current_user.organizations
      @posts = current_user.posts.where("end >= ?", Date.today)
  end
end
