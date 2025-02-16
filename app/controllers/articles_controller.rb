class ArticlesController < ApplicationController
  # Optional: 如果需要用户登录验证，可以启用以下回调
  # before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  def index
    if params[:user_id].present?
      @articles = Article.includes(:user, :category, :tag).where(user_id: params[:user_id])
    else
      @articles = Article.includes(:user, :category, :tag).all
    end
    render json: @articles
  end

  def search
    if params[:q].present?
      search_term = "%#{params[:q].downcase}%"
      @articles = Article.where(
        "LOWER(title) LIKE ? OR LOWER(content) LIKE ?",
        search_term,
        search_term
      )
    else
      @articles = Article.all
    end
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
    # 如果使用 Devise，可关联当前登录用户，如：@article.user = current_user

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
