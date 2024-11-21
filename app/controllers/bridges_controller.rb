# frozen_string_literal: true

class BridgesController < ApplicationController
  before_action :authenticate_user!
	before_action :authorize_admin!, only: [:upload_bridge, :send_upload_bridge, :compare_data, :comparison, :custom]
	before_action :authorize_bridge, only: [:update, :destroy, :print, :edit, :clone]

  after_action :cleanup_instance_variables, only: [:index, :edit, :new, :show, :print, :custom]

  include CsvConcern
  include UploadConcern

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
    @bridges = Bridge.all.pluck(:id, :name) # Adjust scope as needed, e.g., only published bridges
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
    @bridges = Bridge.where(published:true).pluck(:id, :name)
  end

	def index
		if params[:name].present? && (params[:minimum_length].blank? || params[:maximum_length].blank?)
			@bridges ||= Bridge.select(:id, :name, :published, :user_id, :slug).where('name ILIKE ? AND published = ?', "%#{params[:name]}%", true).order(created_at: :asc).page(params[:page]).per(8)
    end

    if params[:name].blank? && (params[:minimum_length].present? && params[:maximum_length].present?)
      @bridges ||= Bridge.select(:id, :name, :published, :user_id, :slug).where('lungime >= ? AND lungime <= ? AND published = ?', params[:minimum_length], params[:maximum_length], true).order(created_at: :asc).page(params[:page]).per(8)
    end

    if params[:name].blank? && (params[:minimum_length].blank? && params[:maximum_length].blank?)
      @bridges ||= Bridge.select(:id, :name, :published, :user_id, :slug).all.where(published: true).order(created_at: :asc).page(params[:page]).per(8)
    end

    if params[:name].present? && (params[:minimum_length].present? && params[:maximum_length].present?)
      @bridges ||= Bridge.select(:id, :name, :published, :lungime, :user_id, :slug).where('name ILIKE ? AND lungime >= ? AND lungime <= ? AND published = ?', 
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

  def csv
    require 'caxlsx'
    bridge = Bridge.friendly.find(params[:id])
    flaw = bridge.flaw
    package = Axlsx::Package.new
    workbook = package.workbook

    date_identificare_csv(bridge, workbook)
    c1_5(flaw, workbook)

    send_data package.to_stream.read,
              filename: "#{bridge.name}.xlsx",
              type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  end

	def print
		bridge = Bridge.friendly.find(params[:id])
		respond_to do |format|
      format.html do
        render template: 'bridges/spinner', locals: { bridge: bridge }
      end
  
      format.pdf do
        pdf_html = render_to_string(
          pdf: 'bridge_info',                # PDF name
          template: 'bridges/print',         # PDF template
          locals: { bridge: bridge },        # Bridge data
          encoding: 'UTF-8'                  # Ensure proper encoding
        )
  
        send_data(
          pdf_html,
          filename: 'bridge_info.pdf',
          type: 'application/pdf',
          disposition: 'inline'
        )
      end
    end
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
    @bridge = nil
    @show_separate = nil
    @ist_total_hash = nil
    @ist_c_hash = nil
    @ist_f_hash = nil
    @ist_f1_hash = nil
    @ist_f2_hash = nil
    @ist_f3_hash = nil
    @ist_f4_hash = nil
    @ist_f5_hash = nil
    @push_ist_f5 = nil
    @push_ist_f4 = nil
    @push_ist_f3 = nil
    @push_ist_f2 = nil
    @push_ist_f1 = nil
    @flaw_instance_ist_f_hash = nil
    @flaw_instance_ist_c_hash = nil
    @flaw_instance_ist_total_hash = nil
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
