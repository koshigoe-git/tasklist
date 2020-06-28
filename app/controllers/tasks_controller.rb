class TasksController < ApplicationController
  #taskは他ユーザーに見られてはいけないので、必ずログイン要求をする
  #require_user_logged_inメソッドはapplication_controller.rbに記載
  before_action :require_user_logged_in
  
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    #現在のログインユーザーのタスクのみ全て表示
    @tasks = current_user.tasks.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
      #投稿の作成は user.tasks.build のように操作する
      #buildはTask.new(user: ユーザー名) と同じ処理
      #現在のuserが新しくTask作成する時の設定（新しいインスタンス生成）
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "Taskが正常に作成されました"
      redirect_to root_url
    else
      flash.now[:danger] = "Taskが作成されませんでした"
      render :new
    end

  end

  def edit
  end

  def update
    #idから更新したいTaskモデルのレコードを検索
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = "Taskは正常に更新されました"
      redirect_to root_url
    else
      flash.now[:danger] = "Taskが正常に更新されませんでした"
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  def set_task
    @task = Task.find(params[:id])
  end
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
