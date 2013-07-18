class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    # GET /posts
    # GET /posts.json
    def index
        @organization = Organization.find(params[:organization_id]) if params[:organization_id]
        if @organization
            @posts = @organization.posts
        else
            @posts = Post.where(:approved => true).where('start <= ? AND end >= ?', Date.today, Date.today)
        end
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
    end

    # GET /posts/new
    def new
        @post = Post.new
        @organization = Organization.find(params[:organization_id])
        redirect_to dashboard_path, :alert => "You can't do that." unless @organization.users.include?(current_user)
    end

    # GET /posts/1/edit
    def edit
    end

    # POST /posts
    # POST /posts.json
    def create
        @organization = Organization.find(params[:organization_id])
        redirect_to dashboard_path, :alert => "You can't do that." unless @organization.users.include?(current_user)
        @post = Post.new(post_params)
        @post.organization = @organization
        @post.user = current_user
        @post.approved = false unless current_user.admin? || current_user.supervisor

        respond_to do |format|
            if @post.save
                format.html { redirect_to @post, notice: 'Post was successfully created.' }
                format.json { render action: 'show', status: :created, location: @post }
            else
                format.html { render action: 'new' }
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    def update
        @organization = Organization.find(params[:organization_id]) if params[:organization_id]
        redirect_to dashboard_path, :alert => "You can't do that." unless @organization.users.include?(current_user)
        @post.approved = false unless current_user.supervisor
        respond_to do |format|
            if @post.update(post_params)
                format.html { redirect_to @post, notice: 'Post was successfully updated.' }
                format.js {}
                format.json { head :no_content }
            else
                format.html { render action: 'edit' }
                format.js {}
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
        @org = @post.organization
        redirect_to dashboard_path, :alert => "You can't do that." unless @org.users.include?(current_user) || current_user.admin?
        @post.destroy
        respond_to do |format|
            format.html { redirect_to @org }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
        @post = Post.find(params[:id])
        @organization = Organization.find(params[:organization_id]) if params[:organization_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
        if current_user.supervisor || current_user.admin?
            params.require(:post).permit(:title, :data, :approved, :start, :end)
        else
            params.require(:post).permit(:title, :data, :start, :end)
        end
    end
end
