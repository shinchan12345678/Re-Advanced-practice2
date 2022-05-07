class GroupsController < ApplicationController
  def new
    @group=Group.new()
  end

  def create
    @group=Group.new(group_params)
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
  end

  def index
  end

  def show
  end

  private

  def group_params
    params.require(:group).permit(:group_name,:introduction,:image)
  end

end
