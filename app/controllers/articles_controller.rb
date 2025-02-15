class ArticlesController < ApplicationController
  # 如果有用户登录验证需求，可启用以下回调
  # before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  def index
    # includes(:user, :category, :tag) 可减少 N+1 查询
    @articles = Article.includes(:user, :category, :tag).all
    render json: @articles
  end

  # GET /articles/:id
  def show
    render json: @article
  end

  # GET /articles/new
  def new
    @article = Article.new
    render json: @article
  end

  # GET /articles/:id/edit
  def edit
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    # 如果使用 Devise，可以关联当前登录用户
    # @article.user = current_user

    if @article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/:id
  def update
    if @article.update(article_params)
      render json: @article, status: :ok
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  def destroy
    @article.destroy
    head :no_content
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  # 更新 strong parameters，允许 :tag_id 参数
  def article_params
    params.require(:article).permit(:title, :content, :published_at, :user_id, :category_id, :tag_id)
  end
end
