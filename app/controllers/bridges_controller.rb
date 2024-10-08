class BridgesController < ApplicationController
  before_action :authenticate_user!
	before_action :authorize_admin!, only: [:upload_bridge, :send_upload_bridge]
	before_action :authorize_bridge, only: [:update, :destroy, :print]

	def index
		if params[:name].present?
			@bridges = Bridge.where('name LIKE ? AND published = ?', "%#{params[:name]}%", true).order(created_at: :asc).page(params[:page]).per(8)
		else
			@bridges = Bridge.all.where(published: true).order(created_at: :asc).page(params[:page]).per(8)
		end
	end

	def new
		@bridge = current_user.bridges.build
	end

	def print
		@bridge = Bridge.friendly.find(params[:id])
		pdf_html = render_to_string(
			pdf: 'bridge_info',          
			template: 'bridges/print',    
			locals: { bridge: @bridge }  
		)
	
		send_data(
			pdf_html, 
			filename: 'bridge_info.pdf', 
			type: 'application/pdf', 
			disposition: 'inline'  
		)
	end

	def edit
		@bridge = Bridge.friendly.find(params[:id])
	end

	def upload_bridge
	end

	def send_upload_bridge
		require 'roo' # For handling .xlsx files
	
		if params[:csv_file].present?
			uploaded_file = params[:csv_file] # You're getting the .xlsx file in csv_file param
	
			begin
				# Open the .xlsx file using roo
				spreadsheet = Roo::Spreadsheet.open(uploaded_file.tempfile.path)
				binding.pry
				# Loop through each sheet in the file
				spreadsheet.sheets.each do |sheet_name|
					sheet = spreadsheet.sheet(sheet_name) # Access the sheet by name
					puts "Processing sheet: #{sheet_name}" # Optional debug line
	
					# Process each row in the sheet
					binding.pry
					sheet.each_with_index do |row, index|
						next if index == 0 # Optionally skip the header row
						binding.pry
						# Assuming first column is 'name', second is 'author', third is 'status'
						name = row[0]
						author = row[1]
						status = row[2]
	
						# Create the bridge record or just preview the data
						# Bridge.create!(name: name, author: author, status: status)
	
						# For debugging: binding.pry to inspect row data if needed
						# binding.pry
					end
				end
	
				flash[:notice] = "XLSX uploaded and processed successfully, all sheets included!"
			rescue StandardError => e
				flash[:alert] = "Error processing the XLSX file: #{e.message}"
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
		name = @bridge.name
		begin
			if @bridge.update(bridge_params)
				ActivityLog.log_activity(current_user, ActivityLog::ActionTypes::UPDATED_BRIDGE, @bridge, name)
				redirect_to edit_bridge_path(@bridge), notice: 'Bridge was successfully updated.'
			else
				redirect_to new_bridge_path(@bridge), notice: @bridge.errors.full_messages.join(",")
			end
		rescue
			redirect_to edit_bridge_path(@bridge), notice: "Something went wrong."
		end
	end

	def create
		@bridge = Bridge.new(bridge_params.merge(user: current_user))

		if @bridge.save
			name = @bridge.name
			ActivityLog.log_activity(current_user, ActivityLog::ActionTypes::CREATED_BRIDGE, @bridge, name)
			redirect_to bridge_path(@bridge), notice: 'Bridge was successfully created.'
		else
			redirect_to new_bridge_path, notice: @bridge.errors.full_messages.join(",")
		end
	end

	def destroy
    @bridge = Bridge.friendly.find(params[:id])
		name = @bridge.name
    @bridge.destroy
		ActivityLog.log_activity(current_user, ActivityLog::ActionTypes::DESTROY_BRIDGE, @bridge, name)

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
