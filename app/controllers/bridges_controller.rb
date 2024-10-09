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
		require 'roo'
	
		if params[:csv_file].present?
			uploaded_file = params[:csv_file]
	
			begin
				spreadsheet = Roo::Spreadsheet.open(uploaded_file.tempfile.path)
				spreadsheet.sheets.each do |sheet_name|
					sheet = spreadsheet.sheet(sheet_name)
					puts "Processing sheet: #{sheet_name}"
	
					sheet.each_with_index do |row, index|
						next if index == 0

						name = row[0]
						author = row[1]
						status = row[2]
						# Bridge.create!(name: name, author: author, status: status)
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
	params.require(:bridge).permit(
	  :name, 
	  :slug,
	  :tip_lucrare_arta,
	  :obstacol_traversat,
	  :localitatea,
	  :categoria,
	  :numar_drum,
	  :clasa,
	  :pozitia_km,
	  :an_constructie,
	  :schema_statica,
	  :structura_rezistenta,
	  :mod_executie,
	  :oblicitate,
	  :culee_fundatie_simplu,
	  :culee_fundatie_armat,
	  :culee_fundatie_precomprimat,
	  :culee_fundatie_metal,
	  :culee_fundatie_lemn,
	  :culee_fundatie_mixt,
	  :culee_elevatie_simplu,
	  :culee_elevatie_armat,
	  :culee_elevatie_precomprimat,
	  :culee_elevatie_metal,
	  :culee_elevatie_lemn,
	  :culee_elevatie_mixt,
	  :pile_fundatie_simplu,
	  :pile_fundatie_armat,
	  :pile_fundatie_precomprimat,
	  :pile_fundatie_metal,
	  :pile_fundatie_lemn,
	  :pile_fundatie_mixt,
	  :pile_elevatie_simplu,
	  :pile_elevatie_armat,
	  :pile_elevatie_precomprimat,
	  :pile_elevatie_metal,
	  :pile_elevatie_lemn,
	  :pile_elevatie_mixt,
	  :structura_rezistenta_simplu,
	  :structura_rezistenta_armat,
	  :structura_rezistenta_precomprimat,
	  :structura_rezistenta_metal,
	  :structura_rezistenta_lemn,
	  :structura_rezistenta_mixt,
	  :lungime,
	  :numar_deschideri,
	  :lungime_deschidere,
	  :latime,
	  :latime_carosabila,
	  :latime_trotuar,
	  :numar_grinzi,
	  :numar_antretoaze,
	  :aparate_reazem,
	  :tip_infrastructurii,
	  :tip_fundatii,
	  :tip_imbracaminte,
	  :rosturi_tip_pozitie,
	  :parapeti_pietonali,
	  :parapeti_siguranta,
	  :racordari_terasamente,
	  :aparari_mal
	)
  end  
  
end
