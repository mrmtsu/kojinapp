class MapsController < ApplicationController
  before_action :set_map, only: [:show, :edit, :update, :destroy]
  before_action :set_topic, only: [:index, :new, :edit, :create, :destroy]
  # GET /topics/:topic_id/maps
  # GET /maps.json
  def index
    @maps = @topic.maps.all
  end

  # GET /topics/:topic_id/maps/:id
  # GET /maps/1.json
  def show
  end

  # GET /topics/:topic_id/maps/new
  def new
    @map = Map.new
  end

  # GET /topics/:topic_id/maps/:id/edit
  def edit
  end

  # POST /topics/:topic_id/maps
  # POST /maps.json
  def create
    @map = @topic.maps.new(map_params)
    respond_to do |format|
      if @map.save
        format.html { redirect_to  topic_map_path(post_id: @map.topic_id,id: @map.id), notice: 'Map was successfully created.' } #:topic_idと:idを2つの引数でそれぞれ指定
        format.json { render :show, status: :created, location: topic_map_path(topic_id: @map.topic_id,id: @map.id) }
      else
        format.html { render :new }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/:topic_id/maps/:id
  # PATCH/PUT /maps/1.json
  def update
    respond_to do |format|
      if @map.update(map_params)
        format.html { redirect_to topic_map_path(post_id: @map.topic_id,id: @map.id), notice: 'Map was successfully updated.' }
        format.json { render :show, status: :ok, location: topic_map_path(post_id: @map.topic_id,id: @map.id) }
      else
        format.html { render :edit }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /topics/:topic_id/maps/:id
  # DELETE /maps/1.json
  def destroy
    @map.destroy
    respond_to do |format|
      format.html { redirect_to topic_maps_path(post_id: @topic.id), notice: 'Map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_map
    @map = Map.find(params[:id])
  end

  def set_topic
    @topic = Post.find_by(id: params[:post_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def map_params
    params.require(:map).permit(:address,:latitude,:longitude,:post_id)
  end
end