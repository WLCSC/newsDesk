class GenerateController < ApplicationController
    skip_before_action :check_for_user
    before_action :build_collection, :except => [:index]

  def index
  end

  def rss
      render 'rss', :format => 'atom', :layout => false
  end

  def flyer
  end

  def show
      
      case params[:format]
      when 'rss'
          render :format => 'atom', :layout => false
            when 'print'
      else
      end
  end

  private 

  def build_collection
    @organizations = Organization.where(:id => params[:gen][:organization_ids])
      @posts = []
      @posts_by_org = {}
      @organizations.each do |o|
          p = o.posts.where(:approved => true).where('start <= ? AND end >= ?', Date.today, Date.today)
          @posts << p.all
          @posts_by_org[o] = p
      end
      @posts.flatten!
  end
end
