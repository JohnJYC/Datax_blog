class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /categories
  def index
    @categories = Category.all
    render json: @categories
  end

  # GET /categories/:id
  def show
    render json: @category
  end

  # POST /categories
  def create
    # 如果前端传入了 category[:id]，先尝试更新对应记录
    if params[:category][:id].present?
      @category = Category.find_by(id: params[:category][:id])
      if @category
        if @category.update(category_params)
          render json: @category, status: :ok and return
        else
          render json: @category.errors, status: :unprocessable_entity and return
        end
      end
    end

    # 未传入 id 或未找到匹配记录，则创建新记录
    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/:id
  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/:id
  def destroy
    @category.destroy
    head :no_content
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
