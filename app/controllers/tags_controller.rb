class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /tags
  def index
    @tags = Tag.all
    render json: @tags
  end

  # GET /tags/:id
  def show
    render json: @tag
  end

  # POST /tags
  def create
    # 如果前端传入的参数中包含 id，则先尝试在数据库中查找对应记录
    if params[:tag][:id].present?
      @tag = Tag.find_by(id: params[:tag][:id])
      if @tag
        # 如果找到了，则更新该记录的属性
        if @tag.update(tag_params)
          render json: @tag, status: :ok and return
        else
          render json: @tag.errors, status: :unprocessable_entity and return
        end
      end
    end

    # 如果没有传 id 或未找到匹配记录，则创建新的 tag
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag, status: :created
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/:id
  def update
    if @tag.update(tag_params)
      render json: @tag, status: :ok
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/:id
  def destroy
    @tag.destroy
    head :no_content
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    # 这里只允许 name 字段更新。id 用于查找，不允许修改
    params.require(:tag).permit(:name)
  end
end
