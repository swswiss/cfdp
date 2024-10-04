class InstanceBridgesController < ApplicationController
  before_action :set_bridge
  before_action :set_instance_bridge, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post, only: [:new, :update, :destroy]

  def index
    @instance_bridges = @bridge.instance_bridges
  end

  def show
  end

  def new
    @instance_bridge = @bridge.instance_bridges.build
    @instance_bridge.name = @bridge.name
  end

  def create
    @instance_bridge = @bridge.instance_bridges.build(instance_bridge_params)

    if @instance_bridge.save
      redirect_to [@bridge, @instance_bridge], notice: 'Instance Bridge was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @instance_bridge.update(instance_bridge_params)
      redirect_to [@bridge, @instance_bridge], notice: 'Instance Bridge was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @instance_bridge.destroy
    redirect_to bridge_instance_bridges_path(@bridge), notice: 'Instance Bridge was successfully destroyed.'
  end

  private

  def set_bridge
    @bridge = Bridge.friendly.find(params[:bridge_id])
  end

  def set_instance_bridge
    @instance_bridge = @bridge.instance_bridges.find(params[:id])
  end

  def authorize_post
    @bridge = Bridge.friendly.find(params[:bridge_id])
    if @bridge.user != current_user
			redirect_to bridges_path, notice: 'You have no access here!'
    end
  end

  def instance_bridge_params
    params.require(:instance_bridge).permit(:name, :description)
  end
end
