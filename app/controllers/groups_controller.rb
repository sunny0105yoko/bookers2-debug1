class GroupsController < ApplicationController
  before_action :authenticate_user!#ユーザがログインしているかどうかを確認し、ログインしていない場合はユーザをログインページにリダイレクトする
  before_action :ensure_correct_user, only: [:edit, :update]#投稿者だけが編集できるように（現在のuser_idと投稿者のidが一致していないとはじく
  
  def index
    @book = Book.new
    @groups = Group.all
    @user = User.find(current_user.id)
  end

  def show
    @book_v = Book.new
    @group = Group.find(params[:id])
    #@user = User.find(params[:id])
  end
  
  def join #追記！
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to  groups_path
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
      @group.owner_id = current_user.id
      @group.users << current_user
      if @group.save
        redirect_to groups_path, method: :post
      else
        render 'new'
      end
  end

  def update
      if @group.update(group_params)
        redirect_to groups_path
      else
        render "edit"
      end
  end

  def edit
  end
  
  def destroy
    @group = Group.find(params[:id])
#current_userは、@group.usersから消されるという記述。
    @group.users.delete(current_user)
    redirect_to groups_path
  end
  
  private
  
    def group_params
      params.require(:group).permit(:name, :introduction, :group_image)
    end
  
    def ensure_correct_user
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id
        redirect_to groups_path
      end
    end
end
