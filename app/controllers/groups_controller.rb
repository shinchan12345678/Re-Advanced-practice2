class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      @group.owner_user.group_members.create(group_id: @group.id)
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end

  private

  def group_params
    params.require(:group).permit(:group_name, :introduction, :image)
  end
end
