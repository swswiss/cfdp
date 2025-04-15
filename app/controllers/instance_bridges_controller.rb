# frozen_string_literal: true

class InstanceBridgesController < ApplicationController
  before_action :set_bridge
  before_action :set_instance_bridge, only: [:show, :edit, :update, :destroy, :destroy_avatar]
  before_action :authorize_bridge, only: [:new, :update, :destroy, :edit, :destroy_avatar, :show_photos, :upload_photos]
  before_action :authorize_superadmin!, only: [:show_photos, :upload_photos, :destroy_avatar]

  after_action :cleanup_instance_variables, only: [:index, :edit, :new, :show, :print]

  def index
    #@instance_bridges = @bridge.instance_bridges
  end

  def show
  end

  def new
    @instance_bridge = @bridge.instance_bridges.build
    @instance_bridge.build_flaw_instance
  end

  def create
    instance_bridge = @bridge.instance_bridges.build(instance_bridge_params)

    if instance_bridge.save
      name = instance_bridge.name

      suma_c1 = calculate_sum_c1 instance_bridge
      suma_c2 = calculate_sum_c2 instance_bridge
      suma_c3 = calculate_sum_c3 instance_bridge
      suma_c4 = calculate_sum_c4 instance_bridge
      suma_c5 = calculate_sum_c5 instance_bridge

      max_c1 = max_c1_columns instance_bridge
      max_c2 = max_c2_columns instance_bridge
      max_c3 = max_c3_columns instance_bridge
      max_c4 = max_c4_columns instance_bridge
      max_c5 = max_c5_columns instance_bridge

      val_indice_1 = 10 - max_c1
      val_indice_2 = 10 - max_c2
      val_indice_3 = 10 - max_c3
      val_indice_4 = 10 - max_c4
      val_indice_5 = 10 - max_c5

      f1_depunct, f1 = calcul_f1 instance_bridge
      f2_depunct, f2 = calcul_f2 instance_bridge
      f3_depunct, f3 = calcul_f3 instance_bridge
      f4 = calcul_f4 instance_bridge
      f5 = calcul_f5 instance_bridge
      suma_c = suma_c instance_bridge
      suma_f = suma_f instance_bridge
      suma_ist = suma_ist instance_bridge
      aprecierea_starii_tehnice, masuri_recomandate = calcul_masuri instance_bridge

      instance_bridge.flaw_instance.update(nr_defecte_c1: suma_c1, nr_defecte_c2: suma_c2, nr_defecte_c3: suma_c3, nr_defecte_c4: suma_c4, nr_defecte_c5: suma_c5)
      instance_bridge.flaw_instance.update(depunct_max_di_c1: max_c1, depunct_max_di_c2: max_c2, depunct_max_di_c3: max_c3, depunct_max_di_c4: max_c4, depunct_max_di_c5: max_c5)
      instance_bridge.flaw_instance.update(val_indice_c1: val_indice_1, val_indice_c2: val_indice_2, val_indice_c3: val_indice_3, val_indice_c4: val_indice_4, val_indice_c5: val_indice_5)
      instance_bridge.flaw_instance.update(indice_total_calitate: val_indice_1 + val_indice_2 + val_indice_3 + val_indice_4 + val_indice_5)
      instance_bridge.flaw_instance.update(f1_depunct: f1_depunct, f1: f1)
      instance_bridge.flaw_instance.update(f2_depunct: f2_depunct, f2: f2)
      instance_bridge.flaw_instance.update(f3_depunct: f3_depunct, f3: f3)
      instance_bridge.flaw_instance.update(f4: f4)
      instance_bridge.flaw_instance.update(f5: f5)
      instance_bridge.flaw_instance.update(ist_c: suma_c, ist_f: suma_f)
      instance_bridge.flaw_instance.update(ist_total: suma_ist)
      instance_bridge.flaw_instance.update(aprecierea_starii_tehnice: aprecierea_starii_tehnice, masuri_recomandate: masuri_recomandate)



      ActivityLog.log_activity(current_user, ActivityLog::ActionTypes::CREATED_INSTANCE_BRIDGE, instance_bridge, name)
      redirect_to bridge_path(@bridge), notice: 'Instance Bridge was successfully created.'
    else
      render :new
    end
  end

  def edit
    @instance_bridge = InstanceBridge.find(params[:id])
    @instance_bridge.build_flaw_instance unless @instance_bridge.flaw_instance
  end

  def update
    if @instance_bridge.update(instance_bridge_params)
      name = @instance_bridge.name

      
      suma_c1 = calculate_sum_c1 @instance_bridge
      suma_c2 = calculate_sum_c2 @instance_bridge
      suma_c3 = calculate_sum_c3 @instance_bridge
      suma_c4 = calculate_sum_c4 @instance_bridge
      suma_c5 = calculate_sum_c5 @instance_bridge

      max_c1 = max_c1_columns @instance_bridge
      max_c2 = max_c2_columns @instance_bridge
      max_c3 = max_c3_columns @instance_bridge
      max_c4 = max_c4_columns @instance_bridge
      max_c5 = max_c5_columns @instance_bridge

      val_indice_1 = 10 - max_c1
      val_indice_2 = 10 - max_c2
      val_indice_3 = 10 - max_c3
      val_indice_4 = 10 - max_c4
      val_indice_5 = 10 - max_c5

      f1_depunct, f1 = calcul_f1 @instance_bridge
      f2_depunct, f2 = calcul_f2 @instance_bridge
      f3_depunct, f3 = calcul_f3 @instance_bridge
      f4 = calcul_f4 @instance_bridge
      f5 = calcul_f5 @instance_bridge
      suma_c = suma_c @instance_bridge
      suma_f = suma_f @instance_bridge
      suma_ist = suma_ist @instance_bridge
      aprecierea_starii_tehnice, masuri_recomandate = calcul_masuri @instance_bridge

      @instance_bridge.flaw_instance.update(nr_defecte_c1: suma_c1, nr_defecte_c2: suma_c2, nr_defecte_c3: suma_c3, nr_defecte_c4: suma_c4, nr_defecte_c5: suma_c5)
      @instance_bridge.flaw_instance.update(depunct_max_di_c1: max_c1, depunct_max_di_c2: max_c2, depunct_max_di_c3: max_c3, depunct_max_di_c4: max_c4, depunct_max_di_c5: max_c5)
      @instance_bridge.flaw_instance.update(val_indice_c1: val_indice_1, val_indice_c2: val_indice_2, val_indice_c3: val_indice_3, val_indice_c4: val_indice_4, val_indice_c5: val_indice_5)
      @instance_bridge.flaw_instance.update(indice_total_calitate: val_indice_1 + val_indice_2 + val_indice_3 + val_indice_4 + val_indice_5)
      @instance_bridge.flaw_instance.update(f1_depunct: f1_depunct, f1: f1)
      @instance_bridge.flaw_instance.update(f2_depunct: f2_depunct, f2: f2)
      @instance_bridge.flaw_instance.update(f3_depunct: f3_depunct, f3: f3)
      @instance_bridge.flaw_instance.update(f4: f4)
      @instance_bridge.flaw_instance.update(f5: f5)
      @instance_bridge.flaw_instance.update(ist_c: suma_c, ist_f: suma_f)
      @instance_bridge.flaw_instance.update(ist_total: suma_ist)
      @instance_bridge.flaw_instance.update(aprecierea_starii_tehnice: aprecierea_starii_tehnice, masuri_recomandate: masuri_recomandate)


      ActivityLog.log_activity(current_user, ActivityLog::ActionTypes::UPDATED_INSTANCE_BRIDGE, @instance_bridge, name)
      redirect_to bridge_path(@bridge), notice: 'Instance Bridge was successfully updated.'
    else
      #redirect_to new_bridge_path, notice: @bridge.errors.full_messages.join(",")
      render :edit
    end
  end

  def destroy
    name = @instance_bridge.name
    @instance_bridge.destroy
    ActivityLog.log_activity(current_user, ActivityLog::ActionTypes::DESTROY_INSTANCE_BRIDGE, @instance_bridge, name)
    respond_to do |format|
      format.turbo_stream do
        flash[:success] = "Instance Bridge successfully deleted."
        render turbo_stream: [turbo_stream.remove("instance-bridge-row-#{@instance_bridge.id}"),
        turbo_stream.update( "flash", partial: "layouts/flash")]
      end
      format.html { redirect_to bridges_path, notice: "Instance Bridge was successfully deleted." }
    end
  end

  def print
		instance_bridge = InstanceBridge.find(params[:id])
		pdf_html = render_to_string(
			pdf: 'bridge_info',          
			template: 'instance_bridges/print',    
			locals: { bridge: instance_bridge },
      encoding: 'UTF-8'  
		)
	
		send_data(
			pdf_html, 
			filename: 'bridge_info.pdf', 
			type: 'application/pdf', 
			disposition: 'inline'  
		)
	end

  def show_photos
    @bridge = Bridge.friendly.find(params[:bridge_id])
    @instance_bridge = InstanceBridge.find(params[:id])
  end

  def upload_photos
    @bridge = Bridge.friendly.find(params[:bridge_id])
    @instance_bridge = InstanceBridge.find(params[:id])

    if @instance_bridge.avatars.all.size + params[:instance_bridge][:avatars].size >= 15
      flash.now[:alert] = "You exceeded the maximum number of photos (15)."

      render turbo_stream: turbo_stream.update(
        "flash",
        partial: "layouts/flash"
      )
      return
    end
    if params[:instance_bridge][:avatars].present?
      params[:instance_bridge][:avatars].each do |image|
        next if image.blank?
        
        @instance_bridge.avatars.attach(
          io: image,
          filename: image.original_filename,
          content_type: image.content_type,
          metadata: {
            uploader: current_user&.email,
            instance_bridge: @instance_bridge.name,
          }
        )
      end
    end
  
    respond_to do |format|
      format.turbo_stream do
        # Turbo Stream will append new avatars to the avatar list
        flash[:success] = "Photos uploaded successfully."
        render turbo_stream: [turbo_stream.append("avatars-list", 
                                                 html: render_avatar(@instance_bridge.avatars.last)),
        turbo_stream.update( "flash", partial: "layouts/flash")]
      end
      format.html do
        redirect_to show_photos_bridge_instance_bridge_path(@bridge, @instance_bridge), notice: "Photos uploaded successfully."
      end
    end
  end

  def render_avatar(avatar_url)
    "<div id='avatars-list'>
      <div class='mx-auto max-w-4xl px-4 sm:px-6 lg:max-w-7xl lg:px-8'>
        <div class='grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 xl:gap-x-8'>
          <div id='avatar-#{avatar_url.id}' class='group relative' data-controller='zoom'>
            <img src='#{rails_blob_path(avatar_url, only_path: true)}'
                 alt='Avatar Image'
                 class='aspect-square w-full rounded-lg bg-gray-200 object-cover transition-transform duration-300 group-hover:opacity-75 xl:aspect-7/8'
                 data-zoom-target='image' data-action='click->zoom#toggle'>
            <div class='mt-4 flex items-center justify-between'>
              <form action='#{destroy_avatar_bridge_instance_bridge_path(@bridge, @instance_bridge, avatar_url: avatar_url)}'
                    method='POST' data-turbo-stream='true'>
                <button type='submit' class='bg-indigo-500 text-white rounded-full p-1 hover:bg-red-700'>
                  <svg class='w-2 h-2' xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20' stroke='currentColor'>
                    <path stroke-linecap='round' stroke-linejoin='round' stroke-width='4' d='M6 6L14 14M6 14L14 6'/>
                  </svg>
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>".html_safe
  end
  

  def destroy_avatar
    avatar = @instance_bridge.avatars.all.find(params[:avatar_url])
    avatar.destroy

    respond_to do |format|
      format.turbo_stream do
        flash[:success] = "Avatar deleted successfully."
        render turbo_stream: [
          turbo_stream.remove("avatar-#{avatar.id}"),
          turbo_stream.update("flash", partial: "layouts/flash")
        ]
      end
      format.html { redirect_to show_photos_bridge_instance_bridge_path(@bridge, @instance_bridge), notice: "Avatar deleted successfully." }
    end
  end

  private

  def calcul_masuri instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    clasa = instance_bridge.clasa
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

  def suma_ist instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    suma = flaw_instance.ist_c.to_i + flaw_instance.ist_f.to_i
    suma
  end

  def suma_c instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    suma = flaw_instance.val_indice_c1.to_i + flaw_instance.val_indice_c2.to_i + flaw_instance.val_indice_c3.to_i + flaw_instance.val_indice_c4.to_i + flaw_instance.val_indice_c5.to_i
    suma
  end

  def suma_f instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    suma = flaw_instance.f1.to_i + flaw_instance.f2.to_i + flaw_instance.f3.to_i + flaw_instance.f4.to_i + flaw_instance.f5.to_i
    suma
  end

  def calcul_f5 instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    f5_depunct = flaw_instance.f5_depunct
    10-f5_depunct.to_i
  end

  def calcul_f4 instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    f4_depunct = flaw_instance.f4_depunct
    10-f4_depunct.to_i
  end

  def calcul_f3 instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    tipul_suprastructurii = flaw_instance.tipul_suprastructurii
    durata_exploatare = flaw_instance.durata_exploatare
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
    if tipul_suprastructurii == "Alte categorii"
      if durata_exploatare == "0-5"
        f3_depunct = 0
        f3 = 10
      end
      if durata_exploatare == "6-15"
        f3_depunct = 3
        f3 = 7
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
    [f3_depunct, f3]
  end

  def calcul_f2 instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    clasa_incarcare = flaw_instance.clasa_incarcare
    clasa = instance_bridge.clasa
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

  def calcul_f1 instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    corespunde_cu_ordinul = flaw_instance.corespunde_ordinul
    clasa = instance_bridge.clasa
    lungime = instance_bridge.lungime
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

	def calculate_sum_c1 instance_bridge
		flaw_instance = instance_bridge.flaw_instance
		c1_columns = FlawInstance.column_names.select { |column| column.start_with?('c1_') }
		sum = c1_columns.map { |col| flaw_instance.send(col).to_i }.sum
		sum
	end

  def calculate_sum_c2 instance_bridge
		flaw_instance = instance_bridge.flaw_instance
		c2_columns = FlawInstance.column_names.select { |column| column.start_with?('c2_') }
		sum = c2_columns.map { |col| flaw_instance.send(col).to_i }.sum
		sum
	end

  def calculate_sum_c3 instance_bridge
		flaw_instance = instance_bridge.flaw_instance
		c3_columns = FlawInstance.column_names.select { |column| column.start_with?('c3_') }
		sum = c3_columns.map { |col| flaw_instance.send(col).to_i }.sum
		sum
	end

  def calculate_sum_c4 instance_bridge
		flaw_instance = instance_bridge.flaw_instance
		c4_columns = FlawInstance.column_names.select { |column| column.start_with?('c4_') }
		sum = c4_columns.map { |col| flaw_instance.send(col).to_i }.sum
		sum
	end

  def calculate_sum_c5 instance_bridge
		flaw_instance = instance_bridge.flaw_instance
		c5_columns = FlawInstance.column_names.select { |column| column.start_with?('c5_') }
		sum = c5_columns.map { |col| flaw_instance.send(col).to_i }.sum
		sum
	end

  def max_c1_columns instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    c1_columns = FlawInstance.column_names.select { |column| column.start_with?('c1_') }
    max_value = c1_columns.map { |col| flaw_instance.send(col).to_i }.max
    max_value
  end

  def max_c2_columns instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    c2_columns = FlawInstance.column_names.select { |column| column.start_with?('c2_') }
    max_value = c2_columns.map { |col| flaw_instance.send(col).to_i }.max
    max_value
  end

  def max_c3_columns instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    c3_columns = FlawInstance.column_names.select { |column| column.start_with?('c3_') }
    max_value = c3_columns.map { |col| flaw_instance.send(col).to_i }.max
    max_value
  end

  def max_c4_columns instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    c4_columns = FlawInstance.column_names.select { |column| column.start_with?('c4_') }
    max_value = c4_columns.map { |col| flaw_instance.send(col).to_i }.max
    max_value
  end

  def max_c5_columns instance_bridge
    flaw_instance = instance_bridge.flaw_instance
    c5_columns = FlawInstance.column_names.select { |column| column.start_with?('c5_') }
    max_value = c5_columns.map { |col| flaw_instance.send(col).to_i }.max
    max_value
  end

  def set_bridge
    @bridge = Bridge.friendly.find(params[:bridge_id])
  end

  def set_instance_bridge
    @instance_bridge = @bridge.instance_bridges.find(params[:id])
  end

  def authorize_bridge
    @bridge = Bridge.friendly.find(params[:bridge_id])
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
    @instance_bridges = nil
    @instance_bridge = nil
    @bridge = nil
  end

  def authorize_superadmin!
    redirect_to root_path, alert: 'You are not authorized to access this page.' unless (current_user&.super_admin?)
  end

  def instance_bridge_params
    params.require(:instance_bridge).permit(
	  :name, 
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
	  :aparari_mal,
    avatars: [],
    flaw_instance_attributes: [
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
