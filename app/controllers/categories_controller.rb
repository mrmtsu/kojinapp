class CategoriesController < ApplicationController

  # def index
  #   @categories = Category.where(params[:id])
  #   @category_children1 = Category.where(parent_id: 1)
  #   @category_children2 = Category.where(parent_id: 2)
  #   @category_children3 = Category.where(parent_id: 3)
  #   @category_children4 = Category.where(parent_id: 4)
  #   @category_children5 = Category.where(parent_id: 5)
  #   @category_children6 = Category.where(parent_id: 6)
  #   @category_children7 = Category.where(parent_id: 7)
  #   @category_children8 = Category.where(parent_id: 8)
  #   @category_children9 = Category.where(parent_id: 9)
  #   @category_children10 = Category.where(parent_id: 10)
  #   @category_children11 = Category.where(parent_id: 11)
  #   @category_children12 = Category.where(parent_id: 12)
  #   @category_children13 = Category.where(parent_id: 13)
  #   @parents = Category.all.order("id ASC").limit(1)
  #   @parent = Category.where(ancestry: nil)
  #   @child_categories = Category.where(ancestry: params[:keyword])
  #   @children = Category.find_by(name: @parents.name)
  #   @categories = Category.eager_load(children: :children).where(parent_id: nil)
     
  # end

  def new
    @children = Category.find(params[:parent_id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def search
    respond_to do |format|
      format.html
      format.json do
       @children = Category.find(params[:parent_id]).children
       #親ボックスのidから子ボックスのidの配列を作成してインスタンス変数で定義
      end
    end
  end

end
