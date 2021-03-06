class User::PostsController < User::Base
  def index
    @posts = Post.order(id: :desc)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @answer = Answer.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]
    if @post.save
      flash.notice = '質問を投稿しました。'
      redirect_to :user_posts
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  private
  def post_params
    params.require(:post).permit(
      :title, :content
    )
  end
end
