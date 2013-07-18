class GenerateController < ApplicationController
    skip_before_filter :check_for_user, :only => ['show']
  def index
  end

  def show
      @organizations = Organization.where(:id => params[:gen][:organization_ids])
      @posts = []
      @posts_by_org = {}
      @organizations.each do |o|
          p = o.posts.where(:approved => true).where('start <= ? AND end >= ?', Date.today, Date.today)
          @posts << p.all
          @posts_by_org[o] = p
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
