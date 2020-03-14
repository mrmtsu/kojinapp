class ItemsController < ApplicationController

  def index
    @items = Item.all
  end
  
  def new
    @parents = Category.all.order("id ASC").limit(13)
    #Categoriesテーブルの上から13個のレコードを取り出す
  end

end