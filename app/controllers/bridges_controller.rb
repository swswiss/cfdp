# frozen_string_literal: true

class BridgesController < ApplicationController
  before_action :authenticate_user!
	before_action :authorize_admin!, only: [:upload_bridge, :send_upload_bridge, :compare_data, :comparison, :custom]
	before_action :authorize_bridge, only: [:update, :destroy, :print, :edit, :clone]

  after_action :cleanup_instance_variables, only: [:index]

  F1 = [
    [0, 7, 8, 0, 8, 9, 0, 9, 10],  # Row 1
    [0, 6, 7, 0, 7, 8, 0, 8, 9],   # Row 2
    [0, 4, 5, 0, 5, 6, 0, 6, 7],   # Row 3
    [0, 0, 1, 0, 2, 3, 0, 4, 5],   # Row 4
    [0, 0, 0, 0, 1, 2, 0, 3, 4]    # Row 5
  ]
  def compare_data
    bridge = Bridge.friendly.find(params[:id])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          params[:frame_id],
          partial: 'bridges/compare_data',
          locals: { bridge: bridge }
        )
      end
      format.html { render partial: 'bridges/compare_data', locals: { bridge: bridge } }
    end
  end
  
  def custom
    @bridges = Bridge.all.select(:id, :name) # Adjust scope as needed, e.g., only published bridges
    selected_bridge_ids = params[:bridge_ids]&.map(&:to_i)
    selected_options = params[:options]
    selected_bridges = Bridge.where(id: selected_bridge_ids)
    @show_separate = selected_options&.include?('separate')

    selected_options&.each do |option|
      @push = true

      if option == "ist_t"
        @push_ist_t = true
        @ist_total_hash = {}
        selected_bridges.each do |bridge|
          instance_bridges = bridge.instance_bridges.order(created_at: :asc)
          instance_bridges_names = [bridge.name] + instance_bridges.pluck(:name)
          bridge_ist_total = [bridge.created_at, bridge.flaw.ist_total]
          flaw_instance_ist_total = FlawInstance.where(instance_bridge: instance_bridges.pluck(:id)).order(:created_at).pluck(:created_at, :ist_total).to_h
          flaw_instance_ist_total[bridge_ist_total[0]] = bridge_ist_total[1] 
          flaw_instance_ist_total = flaw_instance_ist_total.sort_by { |date, value| date }
          flaw_instance_ist_total_hash = {}
          flaw_instance_ist_total.each_with_index do |(key, value), index|
            key = key.strftime("%Y-%m-%d")
            key = key + " " + instance_bridges_names[index]
            flaw_instance_ist_total_hash[key] = value
          end
          @ist_total_hash[bridge.name] = flaw_instance_ist_total_hash
        end
      end
      if option == "ist_c"
        @push_ist_c = true
        @ist_c_hash = {}
        selected_bridges.each do |bridge|
          instance_bridges = bridge.instance_bridges.order(created_at: :asc)
          instance_bridges_names = [bridge.name] + instance_bridges.pluck(:name)
          bridge_ist_c = [bridge.created_at, bridge.flaw.ist_c]
          flaw_instance_ist_c = FlawInstance.where(instance_bridge: instance_bridges.pluck(:id)).order(:created_at).pluck(:created_at, :ist_c).to_h
          flaw_instance_ist_c[bridge_ist_c[0]] = bridge_ist_c[1] 
          flaw_instance_ist_c = flaw_instance_ist_c.sort_by { |date, value| date }
          flaw_instance_ist_c_hash = {}
          flaw_instance_ist_c.each_with_index do |(key, value), index|
            key = key.strftime("%Y-%m-%d")
            key = key + " " + instance_bridges_names[index]
            flaw_instance_ist_c_hash[key] = value
          end
          @ist_c_hash[bridge.name] = flaw_instance_ist_c_hash
        end
      end
      if option == "ist_f"
        @push_ist_f = true
        @ist_f_hash = {}
        selected_bridges.each do |bridge|
          instance_bridges = bridge.instance_bridges.order(created_at: :asc)
          instance_bridges_names = [bridge.name] + instance_bridges.pluck(:name)
          bridge_ist_f = [bridge.created_at, bridge.flaw.ist_f]
          flaw_instance_ist_f = FlawInstance.where(instance_bridge: instance_bridges.pluck(:id)).order(:created_at).pluck(:created_at, :ist_f).to_h
          flaw_instance_ist_f[bridge_ist_f[0]] = bridge_ist_f[1] 
          flaw_instance_ist_f = flaw_instance_ist_f.sort_by { |date, value| date }
          flaw_instance_ist_f_hash = {}
          flaw_instance_ist_f.each_with_index do |(key, value), index|
            key = key.strftime("%Y-%m-%d")
            key = key + " " + instance_bridges_names[index]
            flaw_instance_ist_f_hash[key] = value
          end
          @ist_f_hash[bridge.name] = flaw_instance_ist_f_hash
        end
      end
      if option == "f1"
        @push_ist_f1 = true
        @ist_f1_hash = {}
        selected_bridges.each do |bridge|
          instance_bridges = bridge.instance_bridges.order(created_at: :asc)
          instance_bridges_names = [bridge.name] + instance_bridges.pluck(:name)
          bridge_ist_f1 = [bridge.created_at, bridge.flaw.f1]
          flaw_instance_ist_f1 = FlawInstance.where(instance_bridge: instance_bridges.pluck(:id)).order(:created_at).pluck(:created_at, :f1).to_h
          flaw_instance_ist_f1[bridge_ist_f1[0]] = bridge_ist_f1[1] 
          flaw_instance_ist_f1 = flaw_instance_ist_f1.sort_by { |date, value| date }
          flaw_instance_ist_f1_hash = {}
          flaw_instance_ist_f1.each_with_index do |(key, value), index|
            key = key.strftime("%Y-%m-%d")
            key = key + " " + instance_bridges_names[index]
            flaw_instance_ist_f1_hash[key] = value
          end
          @ist_f1_hash[bridge.name] = flaw_instance_ist_f1_hash
        end
      end
      if option == "f2"
        @push_ist_f2 = true
        @ist_f2_hash = {}
        selected_bridges.each do |bridge|
          instance_bridges = bridge.instance_bridges.order(created_at: :asc)
          instance_bridges_names = [bridge.name] + instance_bridges.pluck(:name)
          bridge_ist_f2 = [bridge.created_at, bridge.flaw.f2]
          flaw_instance_ist_f2 = FlawInstance.where(instance_bridge: instance_bridges.pluck(:id)).order(:created_at).pluck(:created_at, :f2).to_h
          flaw_instance_ist_f2[bridge_ist_f2[0]] = bridge_ist_f2[1] 
          flaw_instance_ist_f2 = flaw_instance_ist_f2.sort_by { |date, value| date }
          flaw_instance_ist_f2_hash = {}
          flaw_instance_ist_f2.each_with_index do |(key, value), index|
            key = key.strftime("%Y-%m-%d")
            key = key + " " + instance_bridges_names[index]
            flaw_instance_ist_f2_hash[key] = value
          end
          @ist_f2_hash[bridge.name] = flaw_instance_ist_f2_hash
        end
      end
      if option == "f3"
        @push_ist_f3 = true
        @ist_f3_hash = {}
        selected_bridges.each do |bridge|
          instance_bridges = bridge.instance_bridges.order(created_at: :asc)
          instance_bridges_names = [bridge.name] + instance_bridges.pluck(:name)
          bridge_ist_f3 = [bridge.created_at, bridge.flaw.f3]
          flaw_instance_ist_f3 = FlawInstance.where(instance_bridge: instance_bridges.pluck(:id)).order(:created_at).pluck(:created_at, :f3).to_h
          flaw_instance_ist_f3[bridge_ist_f3[0]] = bridge_ist_f3[1] 
          flaw_instance_ist_f3 = flaw_instance_ist_f3.sort_by { |date, value| date }
          flaw_instance_ist_f3_hash = {}
          flaw_instance_ist_f3.each_with_index do |(key, value), index|
            key = key.strftime("%Y-%m-%d")
            key = key + " " + instance_bridges_names[index]
            flaw_instance_ist_f3_hash[key] = value
          end
          @ist_f3_hash[bridge.name] = flaw_instance_ist_f3_hash
        end
      end
      if option == "f4"
        @push_ist_f4 = true
        @ist_f4_hash = {}
        selected_bridges.each do |bridge|
          instance_bridges = bridge.instance_bridges.order(created_at: :asc)
          instance_bridges_names = [bridge.name] + instance_bridges.pluck(:name)
          bridge_ist_f4 = [bridge.created_at, bridge.flaw.f4]
          flaw_instance_ist_f4 = FlawInstance.where(instance_bridge: instance_bridges.pluck(:id)).order(:created_at).pluck(:created_at, :f4).to_h
          flaw_instance_ist_f4[bridge_ist_f4[0]] = bridge_ist_f4[1] 
          flaw_instance_ist_f4 = flaw_instance_ist_f4.sort_by { |date, value| date }
          flaw_instance_ist_f4_hash = {}
          flaw_instance_ist_f4.each_with_index do |(key, value), index|
            key = key.strftime("%Y-%m-%d")
            key = key + " " + instance_bridges_names[index]
            flaw_instance_ist_f4_hash[key] = value
          end
          @ist_f4_hash[bridge.name] = flaw_instance_ist_f4_hash
        end
      end
      if option == "f5"
        @push_ist_f5 = true
        @ist_f5_hash = {}
        selected_bridges.each do |bridge|
          instance_bridges = bridge.instance_bridges.order(created_at: :asc)
          instance_bridges_names = [bridge.name] + instance_bridges.pluck(:name)
          bridge_ist_f5 = [bridge.created_at, bridge.flaw.f5]
          flaw_instance_ist_f5 = FlawInstance.where(instance_bridge: instance_bridges.pluck(:id)).order(:created_at).pluck(:created_at, :f5).to_h
          flaw_instance_ist_f5[bridge_ist_f5[0]] = bridge_ist_f5[1] 
          flaw_instance_ist_f5 = flaw_instance_ist_f5.sort_by { |date, value| date }
          flaw_instance_ist_f5_hash = {}
          flaw_instance_ist_f5.each_with_index do |(key, value), index|
            key = key.strftime("%Y-%m-%d")
            key = key + " " + instance_bridges_names[index]
            flaw_instance_ist_f5_hash[key] = value
          end
          @ist_f5_hash[bridge.name] = flaw_instance_ist_f5_hash
        end
      end
    end
  end


  def comparison
    @bridges = Bridge.all
  end

	def index
		if params[:name].present? && (params[:minimum_length].blank? || params[:maximum_length].blank?)
			@bridges ||= Bridge.where('name ILIKE ? AND published = ?', "%#{params[:name]}%", true).order(created_at: :asc).page(params[:page]).per(8)
    end

    if params[:name].blank? && (params[:minimum_length].present? && params[:maximum_length].present?)
      @bridges ||= Bridge.where('lungime >= ? AND lungime <= ? AND published = ?', params[:minimum_length], params[:maximum_length], true).order(created_at: :asc).page(params[:page]).per(8)
    end

    if params[:name].blank? && (params[:minimum_length].blank? && params[:maximum_length].blank?)
      @bridges ||= Bridge.all.where(published: true).order(created_at: :asc).page(params[:page]).per(8)
    end

    if params[:name].present? && (params[:minimum_length].present? && params[:maximum_length].present?)
      @bridges ||= Bridge.where('name ILIKE ? AND lungime >= ? AND lungime <= ? AND published = ?', 
                         "%#{params[:name]}%", params[:minimum_length], params[:maximum_length], true)
                 .order(created_at: :asc)
                 .page(params[:page])
                 .per(8)
    end
	end

	def new
    if current_user.bridges.count >= 3 && current_user.role == 'student'
      redirect_to bridges_path, alert: "You can only create up to 3 bridges."
    else
      @bridge = current_user.bridges.build
		  @bridge.build_flaw
    end
	end

	def print
		bridge = Bridge.friendly.find(params[:id])
		pdf_html = render_to_string(
			pdf: 'bridge_info',          
			template: 'bridges/print',    
			locals: { bridge: bridge },
      encoding: 'UTF-8'  
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
		@bridge.build_flaw unless @bridge.flaw 
	end

	def upload_bridge
	end

	def send_upload_bridge
		require 'roo'
	
		if params[:csv_file].present?
			uploaded_file = params[:csv_file]
      filename = uploaded_file.original_filename
      filename_without_extension = File.basename(filename, '.*') # Remove the extension
      filename_without_extension = filename_without_extension[0, 19] if filename_without_extension.length > 24

			begin
				spreadsheet = Roo::Spreadsheet.open(uploaded_file.tempfile.path)
				spreadsheet.sheets.each do |sheet_name|
					sheet = spreadsheet.sheet(sheet_name)
					puts "Processing sheet: #{sheet_name}"
          if sheet_name == "Date de identificare"
            @date_de_identificare = date_de_identificare sheet, filename_without_extension
          end
          if sheet_name == "C1-5"
            @date_c15 = date_c15 sheet
          end
          if sheet_name == "F1"
            @date_f1 = date_cf1 sheet
          end
          if sheet_name == "F2"
            @date_f2 = date_cf2 sheet
          end
          if sheet_name == "F3"
            @date_f3 = date_cf3 sheet
          end
          if sheet_name == "F4"
            @date_f4 = date_cf4 sheet
          end
          if sheet_name == "F5"
            @date_f5 = date_cf5 sheet
          end
          if sheet_name == "IST"
            @date_ist = date_ist sheet
          end
          if sheet_name == "Clasa"
            @date_clasa = date_clasa sheet
          end
				end
        bridge = Bridge.new(@date_de_identificare)
        bridge.user_id = current_user.id
        if bridge.save
          UserMailer.with(user: current_user).create_bridge(bridge).deliver_later if current_user.user_has_email_integration?
          flaw = Flaw.new(@date_c15.merge(@date_f1).merge(@date_f2).merge(@date_f3).merge(@date_f4).merge(@date_f5).merge(@date_ist).merge(@date_clasa))

          flaw.bridge_id = bridge.id
          if flaw.save
          else
            bridge.destroy
          end
        else
          flash[:notice] = "Something went bad. Please check the exitance of name."
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
		if current_user.admin? || current_user.super_admin?
			@bridges = Bridge.all.order(created_at: :asc)
		else
			@bridges = current_user.bridges.order(created_at: :asc)
		end
	end

  def clone
    instance_bridge = @bridge.instance_bridges.build

    instance_bridge.assign_attributes(
      @bridge.attributes.except('id', 'created_at', 'updated_at', 'some_other_column', 'name', 'user_id', 'slug', 'published', 'latitude', 'longitude')
    )
  
    if instance_bridge.save
      respond_to do |format|
        format.turbo_stream do
          flash[:success] = "Instance Bridge successfully cloned."
  
          # Build the HTML for the new row
          new_row_html = <<-HTML
            <tr id="instance-bridge-row-#{instance_bridge.id}" class="hover:bg-gray-50">
          <th class="flex gap-3 px-6 py-4 font-normal text-gray-900">
            
            <div class="text-sm">
              #{instance_bridge.name}
            </div>
          </th>
          <td class="px-6 py-4">
            #{instance_bridge.bridge.user.username}
          </td>
          <!-- aici trebe sa schimb in date-->
          <td class="px-6 py-4">
            #{ActionController::Base.helpers.time_ago_in_words(instance_bridge.created_at)}
          </td>
          
          <td class="px-6 py-4">
              <div class="flex justify-end gap-4">
                
              <a href="/bridges/#{@bridge.id}/instance_bridges/#{instance_bridge.id}/print" 
                     class="inline-flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="h-6 w-6" x-tooltip="tooltip">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M6.72 13.829c-.24.03-.48.062-.72.096m.72-.096a42.415 42.415 0 0 1 10.56 0m-10.56 0L6.34 18m10.94-4.171c.24.03.48.062.72.096m-.72-.096L17.66 18m0 0 .229 2.523a1.125 1.125 0 0 1-1.12 1.227H7.231c-.662 0-1.18-.568-1.12-1.227L6.34 18m11.318 0h1.091A2.25 2.25 0 0 0 21 15.75V9.456c0-1.081-.768-2.015-1.837-2.175a48.055 48.055 0 0 0-1.913-.247M6.34 18H5.25A2.25 2.25 0 0 1 3 15.75V9.456c0-1.081.768-2.015 1.837-2.175a48.041 48.041 0 0 1 1.913-.247m10.5 0a48.536 48.536 0 0 0-10.5 0m10.5 0V3.375c0-.621-.504-1.125-1.125-1.125h-8.25c-.621 0-1.125.504-1.125 1.125v3.659M18 10.5h.008v.008H18V10.5Zm-3 0h.008v.008H15V10.5Z" />
                    </svg>
                  </a>
               
                  <a href="/bridges/#{@bridge.id}/instance_bridges/#{instance_bridge.id}"
                     data-turbo-method="delete" 
                     data-turbo-confirm="Are you sure?" 
                     class="inline-flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="h-6 w-6" x-tooltip="tooltip">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                    </svg>
                  </a>
                  <a href="/bridges/#{@bridge.id}/instance_bridges/#{instance_bridge.id}/edit" 
                     class="inline-flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="h-6 w-6" x-tooltip="tooltip">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L6.832 19.82a4.5 4.5 0 01-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 011.13-1.897L16.863 4.487zm0 0L19.5 7.125" />
                    </svg>
                  </a>
             
              </div>
            </td>
        </tr>
          HTML
  
          # Use turbo_stream to append the new row
          render turbo_stream: [
            turbo_stream.append("instance-bridges-tbody", new_row_html),
            turbo_stream.update("flash", partial: "layouts/flash")
          ]
        end
        format.html { redirect_to bridges_path, notice: "Instance Bridge was successfully cloned." }
      end
    else
      flash[:error] = "Something went wrong while cloning the Instance Bridge."
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash")
        end
        format.html { redirect_to bridges_path, alert: "Failed to clone Instance Bridge." }
      end
    end
  end
  
  

	def show
		@bridge = Bridge.friendly.find(params[:id])
    @instance_bridges = @bridge.instance_bridges.order(created_at: :asc)
    instance_bridges_names = [@bridge.name] + @instance_bridges.pluck(:name)
    bridge_ist_c = [@bridge.created_at, @bridge.flaw.ist_c]
    bridge_ist_f = [@bridge.created_at, @bridge.flaw.ist_f]
    bridge_ist_total = [@bridge.created_at, @bridge.flaw.ist_total]
    flaw_instance_ist_c = FlawInstance.where(instance_bridge: @instance_bridges.pluck(:id)).order(:created_at).pluck(:created_at, :ist_c).to_h
    flaw_instance_ist_c[bridge_ist_c[0]] = bridge_ist_c[1] 
    flaw_instance_ist_c = flaw_instance_ist_c.sort_by { |date, value| date }
    flaw_instance_ist_f = FlawInstance.where(instance_bridge: @instance_bridges.pluck(:id)).order(:created_at).pluck(:created_at, :ist_f).to_h
    flaw_instance_ist_f[bridge_ist_f[0]] = bridge_ist_f[1] 
    flaw_instance_ist_f = flaw_instance_ist_f.sort_by { |date, value| date }
    flaw_instance_ist_total = FlawInstance.where(instance_bridge: @instance_bridges.pluck(:id)).order(:created_at).pluck(:created_at, :ist_total).to_h
    flaw_instance_ist_total[bridge_ist_total[0]] = bridge_ist_total[1] 
    flaw_instance_ist_total = flaw_instance_ist_total.sort_by { |date, value| date }

    @flaw_instance_ist_c_hash = {}
    @flaw_instance_ist_f_hash = {}
    @flaw_instance_ist_total_hash = {}

    flaw_instance_ist_c.each_with_index do |(key, value), index|
      key = key.strftime("%Y-%m-%d")
      key = key + " " + instance_bridges_names[index]
      @flaw_instance_ist_c_hash[key] = value
    end

    @flaw_instance_ist_f_hash = {}
    flaw_instance_ist_f.each_with_index do |(key, value), index|
      key = key.strftime("%Y-%m-%d")
      key = key + " " + instance_bridges_names[index]
      @flaw_instance_ist_f_hash[key] = value
    end

    @flaw_instance_ist_total_hash = {}
    flaw_instance_ist_total.each_with_index do |(key, value), index|
      key = key.strftime("%Y-%m-%d")
      key = key + " " + instance_bridges_names[index]
      @flaw_instance_ist_total_hash[key] = value
    end

	end

	def update
		bridge = Bridge.friendly.find(params[:id])
		name = bridge.name
		begin
			if bridge.update(bridge_params)
        name = bridge.name
        suma_c1 = calculate_sum_c1 bridge
        suma_c2 = calculate_sum_c2 bridge
        suma_c3 = calculate_sum_c3 bridge
        suma_c4 = calculate_sum_c4 bridge
        suma_c5 = calculate_sum_c5 bridge

        max_c1 = max_c1_columns bridge
        max_c2 = max_c2_columns bridge
        max_c3 = max_c3_columns bridge
        max_c4 = max_c4_columns bridge
        max_c5 = max_c5_columns bridge

        val_indice_1 = 10 - max_c1
        val_indice_2 = 10 - max_c2
        val_indice_3 = 10 - max_c3
        val_indice_4 = 10 - max_c4
        val_indice_5 = 10 - max_c5

        f1_depunct, f1 = calcul_f1 bridge
        f2_depunct, f2 = calcul_f2 bridge
        f3_depunct, f3 = calcul_f3 bridge
        f4 = calcul_f4 bridge
        f5 = calcul_f5 bridge
        suma_c = suma_c bridge
        suma_f = suma_f bridge
        suma_ist = suma_ist bridge
        aprecierea_starii_tehnice, masuri_recomandate = calcul_masuri bridge

        bridge.flaw.update(nr_defecte_c1: suma_c1, nr_defecte_c2: suma_c2, nr_defecte_c3: suma_c3, nr_defecte_c4: suma_c4, nr_defecte_c5: suma_c5)
        bridge.flaw.update(depunct_max_di_c1: max_c1, depunct_max_di_c2: max_c2, depunct_max_di_c3: max_c3, depunct_max_di_c4: max_c4, depunct_max_di_c5: max_c5)
        bridge.flaw.update(val_indice_c1: val_indice_1, val_indice_c2: val_indice_2, val_indice_c3: val_indice_3, val_indice_c4: val_indice_4, val_indice_c5: val_indice_5)
        bridge.flaw.update(indice_total_calitate: val_indice_1 + val_indice_2 + val_indice_3 + val_indice_4 + val_indice_5)
        bridge.flaw.update(f1_depunct: f1_depunct, f1: f1)
        bridge.flaw.update(f2_depunct: f2_depunct, f2: f2)
        bridge.flaw.update(f3_depunct: f3_depunct, f3: f3)
        bridge.flaw.update(f4: f4)
        bridge.flaw.update(f5: f5)
        bridge.flaw.update(ist_c: suma_c, ist_f: suma_f)
        bridge.flaw.update(ist_total: suma_ist)
        bridge.flaw.update(aprecierea_starii_tehnice: aprecierea_starii_tehnice, masuri_recomandate: masuri_recomandate)
        
				ActivityLog.log_activity(current_user, ActivityLog::ActionTypes::UPDATED_BRIDGE, bridge, name)
				redirect_to edit_bridge_path(bridge), notice: 'Bridge was successfully updated.'
			else
				redirect_to new_bridge_path(bridge), notice: bridge.errors.full_messages.join(",")
			end
		rescue
			redirect_to edit_bridge_path(bridge), notice: "Something went wrong."
		end
	end

	def create
		bridge = Bridge.new(bridge_params.merge(user: current_user))
		if bridge.save
			name = bridge.name
      suma_c1 = calculate_sum_c1 bridge
      suma_c2 = calculate_sum_c2 bridge
      suma_c3 = calculate_sum_c3 bridge
      suma_c4 = calculate_sum_c4 bridge
      suma_c5 = calculate_sum_c5 bridge

      max_c1 = max_c1_columns bridge
      max_c2 = max_c2_columns bridge
      max_c3 = max_c3_columns bridge
      max_c4 = max_c4_columns bridge
      max_c5 = max_c5_columns bridge

      val_indice_1 = 10 - max_c1
      val_indice_2 = 10 - max_c2
      val_indice_3 = 10 - max_c3
      val_indice_4 = 10 - max_c4
      val_indice_5 = 10 - max_c5

      f1_depunct, f1 = calcul_f1 bridge
      f2_depunct, f2 = calcul_f2 bridge
      f3_depunct, f3 = calcul_f3 bridge
      f4 = calcul_f4 bridge
      f5 = calcul_f5 bridge
      suma_c = suma_c bridge
      suma_f = suma_f bridge
      suma_ist = suma_ist bridge
      aprecierea_starii_tehnice, masuri_recomandate = calcul_masuri bridge

      bridge.flaw.update(nr_defecte_c1: suma_c1, nr_defecte_c2: suma_c2, nr_defecte_c3: suma_c3, nr_defecte_c4: suma_c4, nr_defecte_c5: suma_c5)
      bridge.flaw.update(depunct_max_di_c1: max_c1, depunct_max_di_c2: max_c2, depunct_max_di_c3: max_c3, depunct_max_di_c4: max_c4, depunct_max_di_c5: max_c5)
      bridge.flaw.update(val_indice_c1: val_indice_1, val_indice_c2: val_indice_2, val_indice_c3: val_indice_3, val_indice_c4: val_indice_4, val_indice_c5: val_indice_5)
      bridge.flaw.update(indice_total_calitate: val_indice_1 + val_indice_2 + val_indice_3 + val_indice_4 + val_indice_5)
      bridge.flaw.update(f1_depunct: f1_depunct, f1: f1)
      bridge.flaw.update(f2_depunct: f2_depunct, f2: f2)
      bridge.flaw.update(f3_depunct: f3_depunct, f3: f3)
      bridge.flaw.update(f4: f4)
      bridge.flaw.update(f5: f5)
      bridge.flaw.update(ist_c: suma_c, ist_f: suma_f)
      bridge.flaw.update(ist_total: suma_ist)
      bridge.flaw.update(aprecierea_starii_tehnice: aprecierea_starii_tehnice, masuri_recomandate: masuri_recomandate)

			ActivityLog.log_activity(current_user, ActivityLog::ActionTypes::CREATED_BRIDGE, bridge, name)
      UserMailer.with(user: current_user).create_bridge(bridge).deliver_later if current_user.user_has_email_integration?
			redirect_to bridge_path(bridge), notice: 'Bridge was successfully created.'
		else
			redirect_to new_bridge_path, notice: bridge.errors.full_messages.join(",")
		end
	end

	def destroy
    bridge = Bridge.friendly.find(params[:id])
		name = bridge.name
    bridge.destroy
		ActivityLog.log_activity(current_user, ActivityLog::ActionTypes::DESTROY_BRIDGE, bridge, name)

    respond_to do |format|
      format.turbo_stream do
        flash[:success] = "Bridge successfully deleted."
        render turbo_stream: [turbo_stream.remove("bridge-row-#{bridge.id}"),
				turbo_stream.update( "flash", partial: "layouts/flash")]
			
      end
      format.html { redirect_to bridges_path, notice: "Bridge was successfully deleted." }
    end
  end

	private

  def date_clasa sheet
    data = {}
    sheet.each_with_index do |row, index|
      next if index == 0
      data[:aprecierea_starii_tehnice] = row.last if index == 14
      data[:masuri_recomandate] = row.last if index == 16
    end
    data
  end

  def date_ist sheet
    data = {}
    sheet.each_with_index do |row, index|
      next if index == 0
      data[:ist_c] = row.last if index == 5
      data[:ist_c] = row.last if index == 10
      data[:ist_total] = row[3] if index == 12
    end
    data
  end

  def date_cf5 sheet
    data = {}
    sheet.each_with_index do |row, index|
      next if index == 0
      data[:f5_depunct] = row[2] if index == 6
      data[:f5] = row[2] if index == 7
    end
    data
  end

  def date_cf4 sheet
    data = {}
    sheet.each_with_index do |row, index|
      next if index == 0
      data[:f4_depunct] = row[2] if index == 11
      data[:f4] = row[2] if index == 12
    end
    data
  end

  def date_cf3 sheet
    data = {}
    sheet.each_with_index do |row, index|
      next if index == 0
      data[:tipul_suprastructurii] = row[4] if index == 16
      data[:durata_exploatare] = row[4] if index == 17
      data[:f3_depunct] = row[8] if index == 18
      data[:f3] = row[8] if index == 19
    end
    data
  end

  def date_cf2 sheet
    data = {}
    sheet.each_with_index do |row, index|
      next if index == 0
      data[:clasa_incarcare] = row[3] if index == 10
      data[:f2_depunct] = row[4] if index == 12
      data[:f2] = row[4] if index == 13
    end
    data
  end

  def date_cf1 sheet
    data = {}
    sheet.each_with_index do |row, index|
      next if index == 0
      data[:corespunde_ordinul] = row[8] if index == 14
      data[:f1_depunct] = row.last if index == 18
      data[:f1] = row.last if index == 19
    end
    data
  end

  def date_c15 sheet
    data = {}
    sheet.each_with_index do |row, index|
      next if index == 0
      data[:c1_1] = row[3] if index == 5
      data[:c2_1] = row[4] if index == 5
      data[:c4_2] = row[6] if index == 6
      data[:c5_3] = row[7] if index == 7
      data[:c3_4] = row[5] if index == 8
      if index > 8
        data[:c3_1_5] = row[5] if row[1]&.start_with?("Aripi sau sferturi ")
        data[:c3_2_5] = row[5] if row[1]&.start_with?("Aripi deplasate fata")

        data[:c1_6] = row[3] if row[1]&.start_with?("Armaturi fara strat de ")
        data[:c2_6] = row[4] if row[1]&.start_with?("Armaturi fara strat de ")
        data[:c1_7] = row[5] if row[1]&.start_with?("Armaturi fara strat de ")

        data[:c3_6] = row[3] if row[1]&.start_with?("Beton cu aspect friabil si/sa")
        data[:c2_7] = row[4] if row[1]&.start_with?("Beton cu aspect friabil si/sa")
        data[:c3_7] = row[5] if row[1]&.start_with?("Beton cu aspect friabil si/sa")

        data[:c1_8] = row[3] if row[1]&.start_with?("Beton degradat prin car")
        data[:c2_8] = row[4] if row[1]&.start_with?("Beton degradat prin car")
        data[:c3_8] = row[5] if row[1]&.start_with?("Beton degradat prin car")

        data[:c1_9] = row[3] if row[1]&.start_with?("Beton degradat prin coro")
        data[:c2_9] = row[4] if row[1]&.start_with?("Beton degradat prin coro")
        data[:c3_9] = row[5] if row[1]&.start_with?("Beton degradat prin coro")

        data[:c1_10] = row[3] if row[1]&.start_with?("Bolti cu degradari avans")
        data[:c5_11] = row[7] if row[1]&.start_with?("Calea pe pod sau pe tro")

        data[:c1_12] = row[3] if row[1]&.start_with?("Coroziunea armaturii, pete de r")
        data[:c2_12] = row[4] if row[1]&.start_with?("Coroziunea armaturii, pete de r")
        data[:c3_12] = row[5] if row[1]&.start_with?("Coroziunea armaturii, pete de r")

        data[:c5_13] = row[7] if row[1]&.start_with?("Coroziunea avansata a stalpulu")

        data[:c1_14] = row[3] if row[1]&.start_with?("Coroziunea fisuranta su")
        data[:c2_14] = row[4] if row[1]&.start_with?("Coroziunea fisuranta su")
        data[:c3_14] = row[5] if row[1]&.start_with?("Coroziunea fisuranta su")

        data[:c1_15] = row[3] if row[1]&.start_with?("Coroziunea metalului in puncte, ")
        data[:c2_15] = row[4] if row[1]&.start_with?("Coroziunea metalului in puncte, ")

        data[:c1_16] = row[3] if row[1]&.start_with?("Cumularea la un element al stru")
        data[:c2_16] = row[4] if row[1]&.start_with?("Cumularea la un element al stru")
        data[:c3_16] = row[5] if row[1]&.start_with?("Cumularea la un element al stru")

        data[:c1_17] = row[3] if row[1]&.start_with?("Defecte de suprafata ale ")
        data[:c2_17] = row[4] if row[1]&.start_with?("Defecte de suprafata ale ")
        data[:c3_17] = row[5] if row[1]&.start_with?("Defecte de suprafata ale ")

        data[:c1_18] = row[3] if row[1]&.start_with?("Deformatii locale ale pi")
        data[:c2_18] = row[4] if row[1]&.start_with?("Deformatii locale ale pi")

        data[:c1_19] = row[3] if row[1]&.start_with?("Deformatii mari (saget")
        data[:c5_20] = row[7] if row[1]&.start_with?("Degradarea (betonului si/s")

        data[:c5_1_21] = row[7] if row[1]&.start_with?("Degradarea sau disloca")
        data[:c5_2_21] = row[7] if row[1]&.start_with?("Lipsa sau distrugerea placilo")


        data[:c4_1_22] = row[6] if row[1]&.start_with?("Degradari ale malurilor si modifica")
        data[:c4_2_22] = row[6] if row[1]&.start_with?("Degradari ale malurilor si mo")
        data[:c4_1_23] = row[6] if row[1]&.start_with?("Degradarea (subspalarea, deformarea) sau distrugerea partiala sau totala a lucrarilor de:-       aparare;")
        data[:c4_2_23] = row[6] if row[1]&.start_with?("Degradarea (subspalarea, deformarea) sau distrugerea partiala sau totala a lucrarilor de:</span> -       dirijare;")
        data[:c4_3_23] = row[6] if row[1]&.start_with?("Degradarea (subspalarea, deformarea) sau distrugerea partiala sau totala a lucrarilor de:</span> -       praguri")
        ####
        data[:c5_24] = row[7] if row[1]&.start_with?("Denivelari ale cai pe pod: -       valuriri, refulari, fagase")
        ####
        data[:c3_25] = row[5] if row[1]&.start_with?("Deplasari ale infrastructurii")
        data[:c2_26] = row[4] if row[1]&.start_with?("Deplasari relative ale elementelo")
        data[:c1_27] = row[3] if row[1]&.start_with?("Deplasari sau sageti permanente mari,")
        data[:c1_28] = row[3] if row[1]&.start_with?("Detasarea timpanului de bolta pe anumite")
        data[:c3_1_29] = row[5] if row[1]&.start_with?("Deteriorarea aparatelor de reazem din neopr")
        data[:c3_2_29] = row[5] if row[1]&.start_with?("Ruperea tachetilor, distrugerea placilor de ")
        data[:c3_1_30] = row[5] if row[1]&.start_with?("Dezaxari ale coloanelor de elevatiile ")
        data[:c3_2_30] = row[5] if row[1]&.start_with?("Masca chesonului nedemola")
        data[:c2_31] = row[4] if row[1]&.start_with?("Distrugerea consolei trotuar")
        data[:c3_31] = row[5] if row[1]&.start_with?("Distrugerea consolei trotuar")
        data[:c1_32] = row[3] if row[1]&.start_with?("Distrugerea suprastructurii (elemen")
        data[:c2_32] = row[4] if row[1]&.start_with?("Distrugerea suprastructurii (elemen")
        data[:c3_1_33] = row[5] if row[1]&.start_with?("Dislocarea unei margini din banche")
        data[:c3_2_33] = row[6] if row[1]&.start_with?("Amenajarea necorespunzatoare a ace")
        data[:c1_34] = row[3] if row[1]&.start_with?("Elemente gresit pozitionate in structur")
        data[:c2_34] = row[4] if row[1]&.start_with?("Elemente gresit pozitionate in structur")
        
        data[:c1_35] = row[3] if row[1]&.start_with?("Eroziunea betonului, prezenta unor zon")
        data[:c2_35] = row[4] if row[1]&.start_with?("Eroziunea betonului, prezenta unor zon")
        data[:c3_35] = row[5] if row[1]&.start_with?("Eroziunea betonului, prezenta unor zon")

        data[:c1_36] = row[3] if row[1]&.start_with?("Fisuri din contractie (neorientate, scurte, su")
        data[:c2_36] = row[4] if row[1]&.start_with?("Fisuri din contractie (neorientate, scurte, su")
        data[:c3_36] = row[5] if row[1]&.start_with?("Fisuri din contractie (neorientate, scurte, su")

        data[:c1_1_37] = row[3] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonulu")
        data[:c2_1_37] = row[4] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonulu")

        data[:c1_2_37] = row[3] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului:- long.: >0.2 mm")
        data[:c2_2_37] = row[4] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului:- long.: >0.2 mm")
        data[:c3_2_37] = row[5] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului:- long.: >0.2 mm")

        data[:c1_3_37] = row[3] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului:- long.: <0.2 mm")
        data[:c2_3_37] = row[4] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului:- long.: <0.2 mm")
        data[:c3_3_37] = row[5] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului:- long.: <0.2 mm")

        data[:c1_4_37] = row[3] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului:- trans.: >0.2 mm")
        data[:c2_4_37] = row[4] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului:- trans.: >0.2 mm")
        data[:c3_4_37] = row[5] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului:- trans.: >0.2 mm")

        data[:c1_5_37] = row[3] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului:- trans.: <0.2 ")
        data[:c2_5_37] = row[4] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului:- trans.: <0.2 ")
        data[:c3_5_37] = row[5] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului:- trans.: <0.2 ")

        data[:c1_6_37] = row[3] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului: -inclinate: >0.2 mm")
        data[:c2_6_37] = row[4] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului: -inclinate: >0.2 mm")
        data[:c3_6_37] = row[5] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului: -inclinate: >0.2 mm")

        data[:c1_7_37] = row[3] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului: -inclinate: <0.2 mm")
        data[:c2_7_37] = row[4] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului: -inclinate: <0.2 mm")
        data[:c3_7_37] = row[5] if row[1]&.start_with?("Fisuri si/sau crapaturi ale betonului: -inclinate: <0.2 mm")

        data[:c1_8_37] = row[3] if row[1]&.start_with?("- fisuri transverale sau longitudinale precum si")

        data[:c5_38] = row[7] if row[1]&.start_with?("Fisuri sau crapaturi in imbracaminte")
        data[:c1_39] = row[3] if row[1]&.start_with?("Fisuri si/sau crapaturi la intradosul poduril")

        data[:c1_40] = row[3] if row[1]&.start_with?("Fisuri, ruperi ale elementelor structurale si/sau a")
        data[:c2_40] = row[4] if row[1]&.start_with?("Fisuri, ruperi ale elementelor structurale si/sau a")

        data[:c1_41] = row[3] if row[1]&.start_with?("Flambajul barelor sau voalarea tot")
        data[:c2_41] = row[4] if row[1]&.start_with?("Flambajul barelor sau voalarea tot")

        data[:c5_42] = row[7] if row[1]&.start_with?("Parapet cu geometrie generala necorespunzatoar")
        data[:c3_43] = row[5] if row[1]&.start_with?("Inclinarea pendulilor, neconcordanta cu temperatura amb")

        data[:c1_44] = row[3] if row[1]&.start_with?("Infiltratii, eflorescente")
        data[:c2_44] = row[4] if row[1]&.start_with?("Infiltratii, eflorescente")
        data[:c3_44] = row[5] if row[1]&.start_with?("Infiltratii, eflorescente")

        data[:c1_45] = row[3] if row[1]&.start_with?("<html>Infiltratii vizibile la intrados, pete umede, eflorescente, stalactite<b> la podurile bol")
        data[:c2_45] = row[4] if row[1]&.start_with?("<html>Infiltratii vizibile la intrados, pete umede, eflorescente, stalactite<b> la pod")

        data[:c5_46] = row[7] if row[1]&.start_with?("Neasigurarea pantei de scurgere a apelor pe")

        data[:c4_47] = row[6] if row[1]&.start_with?("Lipsa lucrarilor de aparare maluri si/sau pentru d")
        data[:c5_48] = row[7] if row[1]&.start_with?("Lipsa sau degradarea parapetului de siguranta si")
        data[:c1_49] = row[3] if row[1]&.start_with?("Lipsa protectiei anticorozive sau degradarea celei e")
        data[:c2_49] = row[4] if row[1]&.start_with?("Lipsa protectiei anticorozive sau degradarea celei e")
        data[:c5_50] = row[7] if row[1]&.start_with?("Lipsa sau degradarea dispozitivului de acoper")
        data[:c5_51] = row[7] if row[1]&.start_with?("Lipsa sau degradarea etansarii dintre imbracaminte")
        data[:c3_52] = row[5] if row[1]&.start_with?("Lipsa sau iesirea din functiune a dispozitive")
        data[:c4_53] = row[6] if row[1]&.start_with?("Lipsa sau degradarea lucrarilor de protectie a ")
        data[:c1_54] = row[3] if row[1]&.start_with?("Modificarea exagerata a formei si proprietatilor fi")
        data[:c3_54] = row[5] if row[1]&.start_with?("Modificarea exagerata a formei si proprietatilor fi")
        #####
        data[:c4_1_55] = row[6] if row[1]&.start_with?("Modificari ale regimului hidraulic, coborarea ")
        data[:c4_2_55] = row[6] if !row[2].is_a?(Numeric) && row[2]&.start_with?("6-7 pentru Δh=1÷2 m la fundatii directe si Δh=2÷4 la fundatii indirecte")
        data[:c4_3_55] = row[6] if !row[2].is_a?(Numeric) && row[2]&.start_with?("8-9 pentru Δh>2 m la fundatii directe si Δh>4 la fundatii indirecte")
        #####
        data[:c1_56] = row[3] if row[1]&.start_with?("Neetanseitati intre elementele structurii sau in")
        data[:c1_1_57] = row[3] if row[1]&.start_with?("Neprotejarea ancorajelor fascicolelor la elemente")
        data[:c2_1_57] = row[4] if row[1]&.start_with?("Neprotejarea ancorajelor fascicolelor la elemente")
        data[:c1_2_57] = row[3] if row[1]&.start_with?("Infiltratii de-a lugul armaturii pretensiona")
        data[:c2_2_57] = row[4] if row[1]&.start_with?("Infiltratii de-a lugul armaturii pretensiona")
        data[:c3_58] = row[5] if row[1]&.start_with?("Pozitia incorecta a elementelor componente")

        data[:c3_59] = row[5] if row[1]&.start_with?("Prezenta vegetatiei pe elementele infrastruc")
        data[:c1_60] = row[3] if row[1]&.start_with?("Prezenta vegetatiei pe elementele suprastruc")
        data[:c2_60] = row[4] if row[1]&.start_with?("Prezenta vegetatiei pe elementele suprastruc")
        data[:c4_1_61] = row[6] if row[1]&.start_with?("Rampe de acces degradate: denivelari si degradari ale")
        data[:c4_2_61] = row[6] if row[1]&.start_with?("Rampe de acces degradate: tasari mari ale terasamentelo")
        data[:c1_62] = row[3] if row[1]&.start_with?("Reducerea pronuntata a sectiunii elementelor datorita co")
        data[:c2_62] = row[4] if row[1]&.start_with?("Reducerea pronuntata a sectiunii elementelor datorita co")
        data[:c5_63] = row[7] if row[1]&.start_with?("Rosturi decolmatate (in cazul imbracamintilor din pavel")
        data[:c1_64] = row[3] if row[1]&.start_with?("Rosturi de zidarie spalate de infiltrat")
        data[:c3_64] = row[4] if row[1]&.start_with?("Rosturi de zidarie spalate de infiltrat")
        data[:c5_65] = row[7] if row[1]&.start_with?("Dispozitive de acoperire a rosturilor de dilatatie grav")
        data[:c5_66] = row[7] if row[1]&.start_with?("Dispozitive de acoperire a rosturilor necorespunzatoar")
        data[:c1_67] = row[3] if row[1]&.start_with?("Segregarea betonului, cuiburi de pietris, cav")
        data[:c2_67] = row[4] if row[1]&.start_with?("Segregarea betonului, cuiburi de pietris, cav")
        data[:c3_67] = row[5] if row[1]&.start_with?("Segregarea betonului, cuiburi de pietris, cav")
        data[:c1_68] = row[3] if row[1]&.start_with?("Solidarizari necorespunzatoare intre elementele p")
        data[:c2_68] = row[4] if row[1]&.start_with?("Solidarizari necorespunzatoare intre elementele p")
        data[:c3_68] = row[5] if row[1]&.start_with?("Solidarizari necorespunzatoare intre elementele p")
        data[:c4_69] = row[6] if row[1]&.start_with?("Spatiul liber sub pod si/sau debuseu insuficien")
        data[:c1_70] = row[3] if row[1]&.start_with?("Torsiunea elementelor structurale, neplaneit")
        data[:c2_70] = row[4] if row[1]&.start_with?("Torsiunea elementelor structurale, neplaneit")
        data[:c3_70] = row[5] if row[1]&.start_with?("Torsiunea elementelor structurale, neplaneit")
        data[:c1_71] = row[3] if row[1]&.start_with?("Uzura zidariei sau betonului")
        data[:c3_71] = row[5] if row[1]&.start_with?("Uzura zidariei sau betonului")
        data[:c1_72] = row[3] if row[1]&.start_with?("Zidarie degradata la suprafata, cu aspect prafos")
        data[:c3_72] = row[5] if row[1]&.start_with?("Zidarie degradata la suprafata, cu aspect prafos")
        data[:c3_73] = row[5] if row[1]&.start_with?("Zidarie avariata (degradari importante cu dislo")
        data[:c1_74] = row[3] if row[1]&.start_with?("Zone inaccesibile pentru control si intretinere ")
        data[:c2_74] = row[4] if row[1]&.start_with?("Zone inaccesibile pentru control si intretinere ")
        data[:c3_74] = row[5] if row[1]&.start_with?("Zone inaccesibile pentru control si intretinere ")
        data[:c1_75] = row[3] if row[1]&.start_with?("Degradarea ursilor; crapaturi, atac biologic, (putrez")
        data[:c1_76] = row[3] if row[1]&.start_with?("Deformatia exagerata verticala sau orizontala a ur")
        data[:c1_77] = row[3] if row[1]&.start_with?("Ursi suprapusi sau cu pene fara rost de aerisire sau cu")
        data[:c1_78] = row[3] if row[1]&.start_with?("Degradarea injugurilor de ursi, solidarizarilor neco")
        data[:c1_79] = row[3] if row[1]&.start_with?("Coroziunea elementelor metalice de prindere (bulo")
        data[:c1_80] = row[3] if row[1]&.start_with?("Degradarea dulapilor, lipsa montantilor, a diagona")
        data[:c2_81] = row[4] if row[1]&.start_with?("Degradarea podinei de rezistenta (mucegai, cr")
        data[:c2_82] = row[4] if row[1]&.start_with?("Podina de rezistenta cu tendinta de ridicare, d")
        data[:c2_83] = row[4] if row[1]&.start_with?("Elementele componente ale podinei de rezistenta lipsa ")
        data[:c3_84] = row[5] if row[1]&.start_with?("Ridicarea pilotilor")
        data[:c3_85] = row[5] if row[1]&.start_with?("Degradarea biologica a elementelor din lemn (piloti, b")
        data[:c3_86] = row[5] if row[1]&.start_with?("Incovoieri mari ale babelor")
        data[:c3_87] = row[5] if row[1]&.start_with?("Palee instabila.")
        data[:c3_88] = row[5] if row[1]&.start_with?("Lipsa sau degradarea spargheturilor (unde sunt ")
        data[:c3_89] = row[5] if row[1]&.start_with?("Lipsa sau degradarea contravantuirilor, contrafiselor ")
        data[:c3_90] = row[5] if row[1]&.start_with?("Degradarea pilotilor in zona de contact cu ")
        data[:c5_91] = row[7] if row[1]&.start_with?("Lipsa sau degradarea podinei de uzur")
        data[:c5_92] = row[7] if row[1]&.start_with?("Imbracaminte din asfalt: -       fisurata, crapata")
        data[:c5_93] = row[7] if row[1]&.start_with?("Desprinderea elementelor ce alcatuiesc podina de uzur")
        data[:c5_94] = row[7] if row[1]&.start_with?("Degradarea sau lipsa longrinei apara-roata sau")
        data[:c5_95] = row[7] if row[1]&.start_with?("Degradarea sau lipsa podinei de trotu")
        data[:c5_96] = row[7] if row[1]&.start_with?("Lipsa sau degradarea mainii curente a parapetului sau u")
        data[:c5_97] = row[7] if row[1]&.start_with?("Lipsa sau degradarea stalpilor parapetului, prinderea neco")
      end
    end
    data
  end

  def date_de_identificare sheet, filename_without_extension
    data = {}
    fields1 = {0=>:culee_fundatie_simplu, 1=>:culee_fundatie_armat, 2=>:culee_fundatie_precomprimat, 3=>:culee_fundatie_metal, 4=>:culee_fundatie_mixt, 5=>:culee_fundatie_lemn}
    fields2 = {0=>:culee_elevatie_simplu, 1=>:culee_elevatie_armat, 2=>:culee_elevatie_precomprimat, 3=>:culee_elevatie_metal, 4=>:culee_elevatie_mixt, 5=>:culee_elevatie_lemn}
    fields3 = {0=>:pile_fundatie_simplu, 1=>:pile_fundatie_armat, 2=>:pile_fundatie_precomprimat, 3=>:pile_fundatie_metal, 4=>:pile_fundatie_mixt, 5=>:pile_fundatie_lemn}
    fields4 = {0=>:pile_elevatie_simplu, 1=>:pile_elevatie_armat, 2=>:pile_elevatie_precomprimat, 3=>:pile_elevatie_metal, 4=>:pile_elevatie_mixt, 5=>:pile_elevatie_lemn}
    fields5 = {0=>:structura_rezistenta_simplu, 1=>:structura_rezistenta_armat, 2=>:structura_rezistenta_precomprimat, 3=>:structura_rezistenta_metal, 4=>:structura_rezistenta_mixt, 5=>:structura_rezistenta_lemn}

    sheet.each_with_index do |row, index|
      next if index == 0
      data[:tip_lucrare_arta] = row[2] if index == 1
      data[:obstacol_traversat] = row[2] if index == 2
      data[:localitatea] = row[2] if index == 3
      data[:categoria] = row[2] if index == 5
      data[:numar_drum] = row[4] if index == 5
      data[:clasa] = row[5] if index == 5
      data[:pozitia_km] = row[6] if index == 5
      data[:an_constructie] = row[2] if index == 6
      data[:schema_statica] = row[2] if index == 8
      data[:structura_rezistenta] = row[2] if index == 9
      data[:mod_executie] = row[2] if index == 10
      data[:oblicitate] = row[2] if index == 11
      if index == 14
        exist_value = row.last(6).each_with_index.find { |element, index| !element.nil? }&.last
        if exist_value.present?
          data[fields1[exist_value + 2]] = row[exist_value + 2]
        end
      end
      if index == 15
        exist_value = row.last(6).each_with_index.find { |element, index| !element.nil? }&.last
        if exist_value.present?
          data[fields2[exist_value + 2]] = row[exist_value]
        end
      end
      if index == 16
        exist_value = row.last(6).each_with_index.find { |element, index| !element.nil? }&.last
        if exist_value.present?
          data[fields3[exist_value + 2]] = row[exist_value]
        end
      end
      if index == 17
        exist_value = row.last(6).each_with_index.find { |element, index| !element.nil? }&.last
        if exist_value.present?
          data[fields4[exist_value + 2]] = row[exist_value]
        end
      end
      if index == 19
        exist_value = row.last(6).each_with_index.find { |element, index| !element.nil? }&.last
        if exist_value.present?
          data[fields5[exist_value + 2]] = row[exist_value]
        end
      end
      data[:lungime] = row[2] if index == 20
      data[:numar_deschideri] = row[2] if index == 21
      data[:lungime_deschidere] = row[2] if index == 22
      data[:latime] = row[2] if index == 23
      data[:latime_carosabila] = row[2] if index == 24
      data[:latime_trotuar] = row[2] if index == 25
      data[:numar_grinzi] = row[2] if index == 26
      data[:numar_antretoaze] = row[2] if index == 27

      data[:aparate_reazem] = row[2] if index == 28
      data[:tip_infrastructurii] = row[2] if index == 29
      data[:tip_fundatii] = row[2] if index == 30
      data[:tip_imbracaminte] = row[2] if index == 31
      data[:rosturi_tip_pozitie] = row[2] if index == 32
      data[:parapeti_pietonali] = row[2] if index == 33
      data[:parapeti_siguranta] = row[2] if index == 34
      data[:racordari_terasamente] = row[2] if index == 35
      data[:aparari_mal] = row[2] if index == 36
    end
    data[:name] = filename_without_extension
    data
  end

  def calcul_masuri bridge
    flaw = bridge.flaw
    clasa = bridge.clasa
    if clasa == "I"
      aprecierea_starii_tehnice = "Stare foarte buna"
      masuri_recomandate = "- măsuri de îmbunătățire a caracterisitcilor estetice; \n - lucrări de întreținere"
    end
    if clasa == "II"
      aprecierea_starii_tehnice = "Stare buna"
      masuri_recomandate = "- lucrări de întreínere;\n- reparații"
    end
    if clasa == "III"
      aprecierea_starii_tehnice = "Stare satisfăcătoare"
      masuri_recomandate = "- reparații;\r\n- reabilitări;\r\n- consolidări"
    end
    if clasa == "IV"
      aprecierea_starii_tehnice = "Stare nesatisfăcătoare"
      masuri_recomandate = "- reabilitare;\n- înlocuirea unor elemente"
    end
    if clasa == "V"
      aprecierea_starii_tehnice = "Stare tehnică nesigură"
      masuri_recomandate = "- înlocuirea sau consolidarea structurii de rezistență afectată de degradare"
    end
    [aprecierea_starii_tehnice, masuri_recomandate]
  end

  def suma_ist bridge
    flaw = bridge.flaw
    suma = flaw.ist_c.to_i + flaw.ist_f.to_i
    suma
  end

  def suma_c bridge
    flaw = bridge.flaw
    suma = flaw.val_indice_c1.to_i + flaw.val_indice_c2.to_i + flaw.val_indice_c3.to_i + flaw.val_indice_c4.to_i + flaw.val_indice_c5.to_i
    suma
  end

  def suma_f bridge
    flaw = bridge.flaw
    suma = flaw.f1.to_i + flaw.f2.to_i + flaw.f3.to_i + flaw.f4.to_i + flaw.f5.to_i
    suma
  end

  def calcul_f5 bridge
    flaw = bridge.flaw
    f5_depunct = flaw.f5_depunct
    10-f5_depunct.to_i
  end

  def calcul_f4 bridge
    flaw = bridge.flaw
    f4_depunct = flaw.f4_depunct
    10-f4_depunct.to_i
  end

  def calcul_f3 bridge
    flaw = bridge.flaw
    tipul_suprastructurii = flaw.tipul_suprastructurii
    durata_exploatare = flaw.durata_exploatare
    if tipul_suprastructurii == "Grinzi nituite"
      if durata_exploatare == "0-5"
        f3_depunct = 0
        f3 = 10
      end
      if durata_exploatare == "6-15"
        f3_depunct = 2
        f3 = 8
      end
      if durata_exploatare == "16-25"
        f3_depunct = 5
        f3 = 5
      end
      if durata_exploatare == "26-35"
        f3_depunct = 6
        f3 = 4
      end
      if durata_exploatare == "36-45"
        f3_depunct = 7
        f3 = 3
      end
      if durata_exploatare == ">45"
        f3_depunct = 8
        f3 = 2
      end
    end
    if tipul_suprastructurii == "Sudate"
      if durata_exploatare == "0-5"
        f3_depunct = 0
        f3 = 10
      end
      if durata_exploatare == "6-15"
        f3_depunct = 5
        f3 = 5
      end
      if durata_exploatare == "16-25"
        f3_depunct = 6
        f3 = 4
      end
      if durata_exploatare == "26-35"
        f3_depunct = 7
        f3 = 3
      end
      if durata_exploatare == "36-45"
        f3_depunct = 8
        f3 = 2
      end
      if durata_exploatare == ">45"
        f3_depunct = 9
        f3 = 1
      end
    end
    if tipul_suprastructurii == "Grinzi Matarov"
      if durata_exploatare == "0-5"
        f3_depunct = 0
        f3 = 10
      end
      if durata_exploatare == "6-15"
        f3_depunct = 2
        f3 = 8
      end
      if durata_exploatare == "16-25"
        f3_depunct = 4
        f3 = 6
      end
      if durata_exploatare == "26-35"
        f3_depunct = 7
        f3 = 3
      end
      if durata_exploatare == "36-45"
        f3_depunct = 8
        f3 = 2
      end
      if durata_exploatare == ">45"
        f3_depunct = 9
        f3 = 1
      end
    end
    if tipul_suprastructurii == "Grinzi Gerber"
      if durata_exploatare == "0-5"
        f3_depunct = 2
        f3 = 8
      end
      if durata_exploatare == "6-15"
        f3_depunct = 4
        f3 = 6
      end
      if durata_exploatare == "16-25"
        f3_depunct = 6
        f3 = 4
      end
      if durata_exploatare == "26-35"
        f3_depunct = 7
        f3 = 3
      end
      if durata_exploatare == "36-45"
        f3_depunct = 8
        f3 = 2
      end
      if durata_exploatare == ">45"
        f3_depunct = 9
        f3 = 1
      end
    end
    if tipul_suprastructurii == "Fasii cu goluri *"
      if durata_exploatare == "0-5"
        f3_depunct = 3
        f3 = 7
      end
      if durata_exploatare == "6-15"
        f3_depunct = 7
        f3 = 3
      end
      if durata_exploatare == "16-25"
        f3_depunct = 8
        f3 = 2
      end
      if durata_exploatare == "26-35"
        f3_depunct = 9
        f3 = 1
      end
      if durata_exploatare == "36-45"
        f3_depunct = 10
        f3 = 0
      end
      if durata_exploatare == ">45"
        f3_depunct = 10
        f3 = 0
      end
    end
    if tipul_suprastructurii == "Fasii cu goluri cu suprabetonare"
      if durata_exploatare == "0-5"
        f3_depunct = 1
        f3 = 9
      end
      if durata_exploatare == "6-15"
        f3_depunct = 5
        f3 = 5
      end
      if durata_exploatare == "16-25"
        f3_depunct = 6
        f3 = 4
      end
      if durata_exploatare == "26-35"
        f3_depunct = 7
        f3 = 3
      end
      if durata_exploatare == "36-45"
        f3_depunct = 8
        f3 = 2
      end
      if durata_exploatare == ">45"
        f3_depunct = 8
        f3 = 2
      end
    end
    if tipul_suprastructurii == "Grinzi tronsonate (tronsoane mici)"
      if durata_exploatare == "0-5"
        f3_depunct = 2
        f3 = 8
      end
      if durata_exploatare == "6-15"
        f3_depunct = 4
        f3 = 6
      end
      if durata_exploatare == "16-25"
        f3_depunct = 7
        f3 = 3
      end
      if durata_exploatare == "26-35"
        f3_depunct = 8
        f3 = 2
      end
      if durata_exploatare == "36-45"
        f3_depunct = 9
        f3 = 1
      end
      if durata_exploatare == ">45"
        f3_depunct = 10
        f3 = 0
      end
    end
    if tipul_suprastructurii == "Grinzi pref. monobloc sigrinzi monolit"
      if durata_exploatare == "0-5"
        f3_depunct = 0
        f3 = 10
      end
      if durata_exploatare == "6-15"
        f3_depunct = 2
        f3 = 8
      end
      if durata_exploatare == "16-25"
        f3_depunct = 5
        f3 = 5
      end
      if durata_exploatare == "26-35"
        f3_depunct = 7
        f3 = 3
      end
      if durata_exploatare == "36-45"
        f3_depunct = 8
        f3 = 2
      end
      if durata_exploatare == ">45"
        f3_depunct = 9
        f3 = 1
      end
    end
    if tipul_suprastructurii == "Lemn"
      if durata_exploatare == "0-5"
        f3_depunct = 5
        f3 = 5
      end
      if durata_exploatare == "6-15"
        f3_depunct = 7
        f3 = 3
      end
      if durata_exploatare == "16-25"
        f3_depunct = 9
        f3 = 1
      end
      if durata_exploatare == "26-35"
        f3_depunct = 10
        f3 = 0
      end
      if durata_exploatare == "36-45"
        f3_depunct = 10
        f3 = 0
      end
      if durata_exploatare == ">45"
        f3_depunct = 10
        f3 = 0
      end
    end
    [f3_depunct, f3]
  end

  def calcul_f2 bridge
    flaw = bridge.flaw
    clasa_incarcare = flaw.clasa_incarcare
    clasa = bridge.clasa
    if clasa_incarcare == "LM1" || clasa_incarcare == "E"
      f2_depunct = 0
      f2 = 10
    end
    if clasa_incarcare == "I"
      if clasa == "I"
        f2_depunct = 10
        f2 = 0
      end
      if clasa == "II"
        f2_depunct = 9
        f2 = 1
      end
      if clasa == "III"
        f2_depunct = 6
        f2 = 4
      end
      if clasa == "IV"
        f2_depunct = 3
        f2 = 7
      end
      if clasa == "V"
        f2_depunct = 0
        f2 = 10
      end
    end
    if clasa_incarcare == "II"
      if clasa == "I"
        f2_depunct = 10
        f2 = 0
      end
      if clasa == "II"
        f2_depunct = 10
        f2 = 0
      end
      if clasa == "III"
        f2_depunct = 10
        f2 = 0
      end
      if clasa == "IV"
        f2_depunct = 8
        f2 = 2
      end
      if clasa == "V"
        f2_depunct = 3
        f2 = 7
      end
    end
    [f2_depunct, f2]
  end

  def calcul_f1 bridge
    flaw = bridge.flaw
    corespunde_cu_ordinul = flaw.corespunde_ordinul
    clasa = bridge.clasa
    lungime = bridge.lungime
    if lungime.to_i <= 25
      if corespunde_cu_ordinul == "DA fara spatiu de siguranta"
        if clasa == "I"
          f1_depunct = 7
          f1 = 3
        end
        if clasa == "II"
          f1_depunct = 6
          f1 = 4
        end
        if clasa == "III"
          f1_depunct = 4
          f1 = 6
        end
        if clasa == "IV"
          f1_depunct = 0
          f1 = 10
        end
        if clasa == "V"
          f1_depunct = 0
          f1 = 10
        end
      end
      if corespunde_cu_ordinul == "DA"
        f1_depunct = 0
        f1 = 10
      end
      if corespunde_cu_ordinul == "NU"
        if clasa == "I"
          f1_depunct = 8
          f1 = 2
        end
        if clasa == "II"
          f1_depunct = 7
          f1 = 3
        end
        if clasa == "III"
          f1_depunct = 5
          f1 = 5
        end
        if clasa == "IV"
          f1_depunct = 1
          f1 = 9
        end
        if clasa == "V"
          f1_depunct = 0
          f1 = 10
        end
      end
    end

    if lungime.to_i >= 26 && lungime.to_i <= 100
      if corespunde_cu_ordinul == "DA fara spatiu de siguranta"
        if clasa == "I"
          f1_depunct = 8
          f1 = 2
        end
        if clasa == "II"
          f1_depunct = 7
          f1 = 3
        end
        if clasa == "III"
          f1_depunct = 5
          f1 = 5
        end
        if clasa == "IV"
          f1_depunct = 2
          f1 = 8
        end
        if clasa == "V"
          f1_depunct = 1
          f1 = 9
        end
      end
      if corespunde_cu_ordinul == "DA"
        f1_depunct = 0
        f1 = 10
      end
      if corespunde_cu_ordinul == "NU"
        if clasa == "I"
          f1_depunct = 9
          f1 = 1
        end
        if clasa == "II"
          f1_depunct = 8
          f1 = 2
        end
        if clasa == "III"
          f1_depunct = 6
          f1 = 4
        end
        if clasa == "IV"
          f1_depunct = 3
          f1 = 7
        end
        if clasa == "V"
          f1_depunct = 2
          f1 = 8
        end
      end
    end

    if lungime.to_i >= 101
      if corespunde_cu_ordinul == "DA fara spatiu de siguranta"
        if clasa == "I"
          f1_depunct = 9
          f1 = 1
        end
        if clasa == "II"
          f1_depunct = 8
          f1 = 2
        end
        if clasa == "III"
          f1_depunct = 6
          f1 = 4
        end
        if clasa == "IV"
          f1_depunct = 4
          f1 = 6
        end
        if clasa == "V"
          f1_depunct = 3
          f1 = 7
        end
      end
      if corespunde_cu_ordinul == "DA"
        f1_depunct = 0
        f1 = 10
      end
      if corespunde_cu_ordinul == "NU"
        if clasa == "I"
          f1_depunct = 10
          f1 = 0
        end
        if clasa == "II"
          f1_depunct = 9
          f1 = 1
        end
        if clasa == "III"
          f1_depunct = 7
          f1 = 3
        end
        if clasa == "IV"
          f1_depunct = 5
          f1 = 5
        end
        if clasa == "V"
          f1_depunct = 4
          f1 = 6
        end
      end
    end
    [f1_depunct, f1]
  end

	def calculate_sum_c1(bridge)
    flaw = bridge.flaw
    c1_columns = Flaw.column_names.select { |column| column&.start_with?('c1_') }
    count = c1_columns.count { |col| flaw.send(col).present? }
    count
  end
  

  def calculate_sum_c2 bridge
		flaw = bridge.flaw
		c2_columns = Flaw.column_names.select { |column| column&.start_with?('c2_') }
		count = c2_columns.count { |col| flaw.send(col).present? }
    count
	end

  def calculate_sum_c3 bridge
		flaw = bridge.flaw
		c3_columns = Flaw.column_names.select { |column| column&.start_with?('c3_') }
		count = c3_columns.count { |col| flaw.send(col).present? }
    count
	end

  def calculate_sum_c4 bridge
		flaw = bridge.flaw
		c4_columns = Flaw.column_names.select { |column| column&.start_with?('c4_') }
		count = c4_columns.count { |col| flaw.send(col).present? }
    count
	end

  def calculate_sum_c5 bridge
		flaw = bridge.flaw
		c5_columns = Flaw.column_names.select { |column| column&.start_with?('c5_') }
		count = c5_columns.count { |col| flaw.send(col).present? }
    count
	end

  def max_c1_columns bridge
    flaw = bridge.flaw
    c1_columns = Flaw.column_names.select { |column| column&.start_with?('c1_') }
    max_value = c1_columns.map { |col| flaw.send(col).to_i }.max
    max_value
  end

  def max_c2_columns bridge
    flaw = bridge.flaw
    c2_columns = Flaw.column_names.select { |column| column&.start_with?('c2_') }
    max_value = c2_columns.map { |col| flaw.send(col).to_i }.max
    max_value
  end

  def max_c3_columns bridge
    flaw = bridge.flaw
    c3_columns = Flaw.column_names.select { |column| column&.start_with?('c3_') }
    max_value = c3_columns.map { |col| flaw.send(col).to_i }.max
    max_value
  end

  def max_c4_columns bridge
    flaw = bridge.flaw
    c4_columns = Flaw.column_names.select { |column| column&.start_with?('c4_') }
    max_value = c4_columns.map { |col| flaw.send(col).to_i }.max
    max_value
  end

  def max_c5_columns bridge
    flaw = bridge.flaw
    c5_columns = Flaw.column_names.select { |column| column&.start_with?('c5_') }
    max_value = c5_columns.map { |col| flaw.send(col).to_i }.max
    max_value
  end

	def authorize_bridge
    @bridge = Bridge.friendly.find(params[:id])
    if @bridge.user != current_user
			if current_user.admin? || current_user.super_admin?
				true
			else
				redirect_to bridges_path, notice: 'You have no access here!'
			end
		else
			true
    end
  end

  def cleanup_instance_variables
    # Free memory after the view is rendered
    @bridges = nil
  end

	def authorize_admin!
    redirect_to root_path, alert: 'You are not authorized to access this page.' unless (current_user&.admin? || current_user&.super_admin?)
  end

  def bridge_params
	params.require(:bridge).permit(
	  :name, 
    :latitude,
    :longitude,
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
	  :aparari_mal, flaw_attributes: [
      :id,
		:c1_1,
		:c2_1,
		:c4_2,
		:c5_3,
		:c3_4,
		:c3_1_5,
		:c3_2_5,
		:c1_6, 
		:c2_6, 
		:c1_7, 
		:c3_6, 
		:c2_7, 
		:c3_7, 
		:c1_8, 
		:c2_8, 
		:c3_8, 
		:c1_9, 
		:c2_9, 
		:c3_9, 
		:c1_10, 
		:c5_11, 
		:c1_12, 
		:c2_12, 
		:c3_12, 
		:c5_13, 
		:c1_14, 
		:c2_14, 
		:c3_14, 
		:c1_15, 
		:c2_15, 
		:c1_16, 
		:c2_16, 
		:c3_16, 
		:c1_17, 
		:c2_17, 
		:c3_17, 
		:c1_18, 
		:c2_18, 
		:c1_19, 
		:c5_20, 
		:c5_1_21,
		:c5_2_21,
		:c4_1_22,
		:c4_2_22,
		:c4_1_23,
		:c4_2_23,
		:c4_3_23,
		:c5_24, 
		:c3_25, 
		:c2_26, 
		:c1_27, 
		:c1_28, 
		:c3_1_29,
		:c3_2_29,
		:c3_1_30,
		:c3_2_30,
		:c2_31, 
		:c3_31, 
		:c1_32, 
		:c2_32, 
		:c3_1_33,
		:c3_2_33,
		:c1_34, 
		:c2_34, 
		:c1_35, 
		:c2_35, 
		:c3_35, 
		:c1_36, 
		:c2_36, 
		:c3_36, 
		:c1_1_37,
		:c2_1_37,
		:c1_2_37,
		:c2_2_37,
		:c3_2_37,
		:c1_3_37,
		:c2_3_37,
		:c3_3_37,
		:c1_4_37,
		:c2_4_37,
		:c3_4_37,
		:c1_5_37,
		:c2_5_37,
		:c3_5_37,
		:c1_6_37,
		:c2_6_37,
		:c3_6_37,
		:c1_7_37,
		:c2_7_37,
		:c3_7_37,
		:c1_8_37,
		:c5_38, 
		:c1_39, 
		:c1_40, 
		:c2_40, 
		:c1_41, 
		:c2_41, 
		:c5_42, 
		:c3_43, 
		:c1_44, 
		:c2_44, 
		:c3_44, 
		:c1_45, 
		:c2_45, 
		:c5_46, 
		:c4_47, 
		:c5_48, 
		:c1_49, 
		:c2_49, 
		:c5_50,
		:c5_51,
		:c3_52, 
		:c4_53, 
		:c1_54, 
		:c3_54, 
		:c4_1_55,
		:c4_2_55,
		:c4_3_55,
		:c1_56, 
		:c1_1_57,
		:c2_1_57,
		:c1_2_57,
		:c2_2_57,
		:c3_58, 
		:c3_59, 
		:c1_60, 
		:c2_60, 
		:c4_1_61,
		:c4_2_61,
		:c1_62, 
		:c2_62, 
		:c5_63, 
		:c1_64, 
		:c3_64, 
		:c5_65, 
		:c5_66, 
		:c1_67, 
		:c2_67, 
		:c3_67, 
		:c1_68, 
		:c2_68, 
		:c3_68, 
		:c4_69, 
		:c1_70, 
		:c2_70, 
		:c3_70, 
		:c1_71, 
		:c3_71, 
		:c1_72, 
		:c3_72, 
		:c3_73, 
		:c1_74, 
		:c2_74, 
		:c3_74, 
		:c1_75, 
		:c1_76, 
		:c1_77, 
		:c1_78, 
		:c1_79, 
		:c1_80, 
		:c2_81, 
		:c2_82, 
		:c2_83, 
		:c3_84, 
		:c3_85, 
		:c3_86, 
		:c3_87, 
		:c3_88, 
		:c3_89, 
		:c3_90, 
		:c5_91, 
		:c5_92, 
		:c5_93, 
		:c5_94, 
		:c5_95, 
		:c5_96, 
		:c5_97,
		:nr_defecte_c1,
		:nr_defecte_c2,
		:nr_defecte_c3,
		:nr_defecte_c4,
		:nr_defecte_c5,
		:depunct_max_di_c1,
		:depunct_max_di_c2,
		:depunct_max_di_c3,
		:depunct_max_di_c4,
		:depunct_max_di_c5,
		:val_indice_c1,
		:val_indice_c2,
		:val_indice_c3,
		:val_indice_c4,
		:val_indice_c5,
		:indice_total_calitate,
    :aprecierea_starii_tehnice,
    :masuri_recomandate,
    :corespunde_ordinul, 
    :f1_depunct, 
    :f1, 
    :clasa_incarcare, 
    :f2, 
    :f2_depunct, 
     :tipul_suprastructurii, 
     :durata_exploatare, 
     :f3_depunct, 
     :f3, 
     :f4_depunct, 
     :f4, 
     :f5_depunct, 
     :f5, 
     :ist_c, 
     :ist_f, 
     :ist_total,
  ]
	)
  end  
  
end
