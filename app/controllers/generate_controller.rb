class GenerateController < ApplicationController
    skip_before_filter :check_for_user, :only => ['show']
  def index
  end

  def show
      @organizations = Organization.where(:id => params[:gen][:organization_ids])
      @posts = []
      @organizations.each do |o|
          @posts << o.posts.where(:approved => true).where('start <= ? AND end >= ?', Date.today, Date.today).all
      end
      @posts.flatten!

      case params[:format]
      when 'rss'
          render :format => 'atom', :layout => false
            when 'print'
      else
      end
  end
end
