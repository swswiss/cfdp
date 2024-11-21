module UploadConcern
  extend ActiveSupport::Concern

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
end