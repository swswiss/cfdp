class BridgesController < ApplicationController
  before_action :authenticate_user!
	before_action :authorize_admin!, only: [:upload_bridge, :send_upload_bridge]
	before_action :authorize_bridge, only: [:update, :destroy]

	def index
		@bridges = Bridge.all.where(published: true)
	end

	def new
		@bridge = current_user.bridges.build
	end

	def edit
		@bridge = Bridge.friendly.find(params[:id])
	end

	def upload_bridge
	end

	def send_upload_bridge
		require 'csv'
    if params[:csv_file].present?
      csv_file = params[:csv_file]

      begin
        CSV.foreach(csv_file.path, headers: true) do |row|
          #Bridge.create!(name: row['name'], author: row['author'], status: row['status'])
        end
        flash[:notice] = "CSV uploaded successfully!"
      rescue StandardError => e
        flash[:alert] = "Error processing the CSV file: #{e.message}"
      end
    else
      flash[:alert] = "No file uploaded."
    end

    redirect_to bridges_path
  end

	def your_bridges
		if current_user.admin?
			@bridges = Bridge.all.order(created_at: :asc)
		else
			@bridges = current_user.bridges.order(created_at: :asc)
		end
		# if admin display all bridges
	end

	def show
		@bridge = Bridge.friendly.find(params[:id])
    @instance_bridges = @bridge.instance_bridges
		@hash_data = @instance_bridges.group("DATE(created_at)").count
	end

	def update
		@bridge = Bridge.friendly.find(params[:id])
		
		if @bridge.update(bridge_params)
			redirect_to edit_bridge_path(@bridge), notice: 'Bridge was successfully updated.'
		else
		end
	end

	def create
		@bridge = Bridge.new(bridge_params.merge(user: current_user))

		if @bridge.save
			redirect_to bridge_path(@bridge), notice: 'Bridge was successfully created.'
		else
		end
	end

	def destroy
    @bridge = Bridge.friendly.find(params[:id])
    @bridge.destroy

    respond_to do |format|
      format.turbo_stream do
        flash[:success] = "Bridge successfully deleted."
        render turbo_stream: [turbo_stream.remove("bridge-row-#{@bridge.id}"),
				turbo_stream.update( "flash", partial: "layouts/flash")]
			
      end
      format.html { redirect_to bridges_path, notice: "Bridge was successfully deleted." }
    end
  end

	private

	def authorize_bridge
    @bridge = Bridge.friendly.find(params[:id])
    if @bridge.user != current_user
			if current_user.admin?
				true
			else
				redirect_to bridges_path, notice: 'You have no access here!'
			end
		else
			true
    end
  end

	def authorize_admin!
    redirect_to root_path, alert: 'You are not authorized to access this page.' unless current_user&.admin?
  end

	def bridge_params
		params.require(:bridge).permit(:name, :slug)
	end
end
