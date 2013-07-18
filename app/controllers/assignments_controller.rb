class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :set_org

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
    @all_users = User.all.map{|u| u.name}
    @all_groups = Group.all.map{|u| u.name}
  end

  # POST /assignments
  # POST /assignments.json
  def create
      if current_user.admin? || (current_user.supervisor && @organization.users.include?(current_user))
    @assignment = Assignment.new(assignment_params)
    @assignment.organization = @organization

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to organization_assignments_path(@organization), notice: 'Assignment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assignment }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
      else
          redirect_to dashboard_path, :notice => "You can't do that."
      end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
      if current_user.admin? || (current_user.supervisor && @organization.users.include?(current_user))
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to organization_assignments_url(@organization) }
      format.json { head :no_content }
    end
      else
          redirect_to dashboard_path, :notice => "You can't do that."
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    def set_org
        @organization = Organization.find(params[:organization_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:user_name, :group_name)
    end
end
