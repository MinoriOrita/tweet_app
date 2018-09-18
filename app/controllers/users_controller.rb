class UsersController < ApplicationController
  def index
    @users=User.all
  end
  def show
    @user = User.find_by(id: params[:id])
  end
  def new
    @user=User.new
  end
  def create
    @user=User.new(name:params[:name],email:params[:email],password:[:password])
  if @user.save
    flash[:notice]="新規登録しました"
    session[:user_id]=@user.id
    redirect_to("/users/#{@user.id}")
  else
    render("/users/new")
  end
  end
  def edit
    @user=User.find_by(id:params[:id])
  end
  def update
    @user=User.find_by(id:params[:id])
    @user.name=params[:name]
    @user.email=params[:email]
  if @user.save
    flash[:notice]="ユーザー情報を編集しました"
    redirect_to("/users/#{@user.id}")
  else
    render("/users/edit")
  end
  end
  def login_form
  end
  def login
    @user=User.find_by(password:params[:password],email:params[:email])
   if @user
     session[:user_id]=@user.id
     flash[:notice]="ログインしました"
     redirect_to("/posts/index")
   else
     @error_message="メールアドレスまたはパスワードが間違っています"
     @email=params[:email]
     @password=params[:password]
     render("/users/login_form")
   end
  end
  def logout
    session[:user_id]=nil
    flash[:notice]="ログアウトしました"
    redirect_to("/login")
  end
end
