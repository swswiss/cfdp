class AddNewFieldsToInstanceBridge < ActiveRecord::Migration[7.2]
  def change
    add_column :instance_bridges, :tip_lucrare_arta, :string
	  add_column :instance_bridges, :obstacol_traversat, :string
	  add_column :instance_bridges, :localitatea, :string
	  add_column :instance_bridges, :categoria, :string
	  add_column :instance_bridges, :numar_drum, :string
	  add_column :instance_bridges, :clasa, :string
	  add_column :instance_bridges, :pozitia_km, :string
	  add_column :instance_bridges, :an_constructie, :string
	  add_column :instance_bridges, :schema_statica, :string
	  add_column :instance_bridges, :structura_rezistenta, :string
	  add_column :instance_bridges, :mod_executie, :string
	  add_column :instance_bridges, :oblicitate, :string
	  add_column :instance_bridges, :culee_fundatie_simplu, :string
	  add_column :instance_bridges, :culee_fundatie_armat, :string
	  add_column :instance_bridges, :culee_fundatie_precomprimat, :string
	  add_column :instance_bridges, :culee_fundatie_metal, :string
	  add_column :instance_bridges, :culee_fundatie_lemn, :string
	  add_column :instance_bridges, :culee_fundatie_mixt, :string
	  add_column :instance_bridges, :culee_elevatie_simplu, :string
	  add_column :instance_bridges, :culee_elevatie_armat, :string
	  add_column :instance_bridges, :culee_elevatie_precomprimat, :string
	  add_column :instance_bridges, :culee_elevatie_metal, :string
	  add_column :instance_bridges, :culee_elevatie_lemn, :string
	  add_column :instance_bridges, :culee_elevatie_mixt, :string
	  add_column :instance_bridges, :pile_fundatie_simplu, :string
	  add_column :instance_bridges, :pile_fundatie_armat, :string
	  add_column :instance_bridges, :pile_fundatie_precomprimat, :string
	  add_column :instance_bridges, :pile_fundatie_metal, :string
	  add_column :instance_bridges, :pile_fundatie_lemn, :string
	  add_column :instance_bridges, :pile_fundatie_mixt, :string
	  add_column :instance_bridges, :pile_elevatie_simplu, :string
	  add_column :instance_bridges, :pile_elevatie_armat, :string
	  add_column :instance_bridges, :pile_elevatie_precomprimat, :string
	  add_column :instance_bridges, :pile_elevatie_metal, :string
	  add_column :instance_bridges, :pile_elevatie_lemn, :string
	  add_column :instance_bridges, :pile_elevatie_mixt, :string
	  add_column :instance_bridges, :structura_rezistenta_simplu, :string
	  add_column :instance_bridges, :structura_rezistenta_armat, :string
	  add_column :instance_bridges, :structura_rezistenta_precomprimat, :string
	  add_column :instance_bridges, :structura_rezistenta_metal, :string
	  add_column :instance_bridges, :structura_rezistenta_lemn, :string
	  add_column :instance_bridges, :structura_rezistenta_mixt, :string
	  add_column :instance_bridges, :lungime, :string
	  add_column :instance_bridges, :numar_deschideri, :string
	  add_column :instance_bridges, :lungime_deschidere, :string
	  add_column :instance_bridges, :latime, :string
	  add_column :instance_bridges, :latime_carosabila, :string
	  add_column :instance_bridges, :latime_trotuar, :string
	  add_column :instance_bridges, :numar_grinzi, :string
	  add_column :instance_bridges, :numar_antretoaze, :string
	  add_column :instance_bridges, :aparate_reazem, :string
	  add_column :instance_bridges, :tip_infrastructurii, :string
	  add_column :instance_bridges, :tip_fundatii, :string
	  add_column :instance_bridges, :tip_imbracaminte, :string
	  add_column :instance_bridges, :rosturi_tip_pozitie, :string
	  add_column :instance_bridges, :parapeti_pietonali, :string
	  add_column :instance_bridges, :parapeti_siguranta, :string
	  add_column :instance_bridges, :racordari_terasamente, :string
	  add_column :instance_bridges, :aparari_mal, :string
  end
end