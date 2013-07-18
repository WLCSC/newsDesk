class WelcomeController < ApplicationController
    skip_before_filter :check_for_user
  def index
      if current_user
          redirect_to dashboard_path
      end
  end
end
