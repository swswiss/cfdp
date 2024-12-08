module CsvConcern
  extend ActiveSupport::Concern

  def date_identificare_csv(bridge, workbook)
    workbook.add_worksheet(name: "Date de identificare") do |sheet|
      # Add a row with a single value (to display in the merged cell)
      sheet.add_row ["I. Date de identificare a lucrării"]
      sheet.merge_cells("A1:H1")

      sheet.add_row [
        "1. Tipul lucrării de artă (pod, pasaj, viaduct)",
        nil, 
        bridge.tip_lucrare_arta, 
        nil, nil, nil, nil, nil 
      ]
      sheet.merge_cells("A2:B2")
      sheet.merge_cells("C2:H2")
      options = ["Pod", "Viaduct", "Pasaj"]
      sheet.add_data_validation('C2:H2', {
          type: :list,
          formula1: "\"#{options.join(',')}\"", # Join the options into a string
          showDropDown: true
        })

      sheet.add_row [
        "2. Obstacolul traversat",
        nil, 
        bridge.obstacol_traversat, 
        nil, nil, nil, nil, nil 
      ]
      sheet.merge_cells("A3:B3")
      sheet.merge_cells("C3:H3")

      sheet.add_row [
        "3. Localitatea cea mai apropiată",
        nil, 
        bridge.localitatea, 
        nil, nil, nil, nil, nil 
      ]
      sheet.merge_cells("A4:B4")
      sheet.merge_cells("C4:H4")

      sheet.add_row ["4. Categoria drumului pe care este amplasat (A, DN, DJ, DC)", nil, "Categoria", nil, "Nr dr. / Clasa Teh.", nil, "Poziția km"]
      sheet.add_row [nil, nil, bridge.categoria, nil, bridge.numar_drum, bridge.clasa, bridge.pozitia_km]
      sheet.merge_cells("A5:B6")
      sheet.merge_cells("C5:D5")
      sheet.merge_cells("E5:F5")
      sheet.merge_cells("G5:H5")
      sheet.merge_cells("C6:D6")
      sheet.merge_cells("G6:H6")
      options = ["A", "DN", "DJ", "DC"]
      sheet.add_data_validation('C6:D6', {
          type: :list,
          formula1: "\"#{options.join(',')}\"", # Join the options into a string
          showDropDown: true
        })
      options = ["I", "II", "III", "IV", "V"]
      sheet.add_data_validation('F6', {
          type: :list,
          formula1: "\"#{options.join(',')}\"", # Join the options into a string
          showDropDown: true
        })

      sheet.add_row [
        "5. Anul construcției, anii consolidării sau reabilitării",
        nil, 
        bridge.an_constructie, 
        nil, nil, nil, nil, nil 
      ]
      sheet.merge_cells("A7:B7")
      sheet.merge_cells("C7:H7")

      sheet.add_row [
        "6. Tipul podului",
        nil, 
        nil, 
        nil, nil, nil, nil, nil 
      ]
      sheet.merge_cells("A8:B8")
      sheet.merge_cells("C8:H8")

      sheet.add_row [
        "- după schema statică",
        nil, 
        bridge.schema_statica, 
        nil, nil, nil, nil, nil 
      ]
      sheet.merge_cells("A9:B9")
      sheet.merge_cells("C9:H9")

      sheet.add_row [
        "- după structura de rezistență",
        nil, 
        bridge.structura_rezistenta, 
        nil, nil, nil, nil, nil 
      ]
      sheet.merge_cells("A10:B10")
      sheet.merge_cells("C10:H10")

      sheet.add_row [
        "- după modul de execuție",
        nil, 
        bridge.mod_executie, 
        nil, nil, nil, nil, nil 
      ]
      sheet.merge_cells("A11:B11")
      sheet.merge_cells("C11:H11")

      sheet.add_row [
        "- oblicitate",
        nil, 
        bridge.oblicitate, 
        nil, nil, nil, nil, nil 
      ]
      sheet.merge_cells("A12:B12")
      sheet.merge_cells("C12:H12")

      sheet.add_row ["7. Materialul din care este alcătuită", nil, "Beton simplu", "Beton armat", "Beton precomprimat", "Metal", "Mixt", "Lemn"]
      sheet.merge_cells("A13:B13")

      sheet.add_row ["INFRASTRUCTURA", nil]
      sheet.merge_cells("A14:B14")
      sheet.merge_cells("C14:H14")

      sheet.add_row ["Culee", "Fundatii", bridge.culee_fundatie_simplu, bridge.culee_fundatie_armat, bridge.culee_fundatie_precomprimat, bridge.culee_fundatie_metal, bridge.culee_fundatie_lemn, bridge.culee_fundatie_mixt]
      sheet.add_row ["", "Elevatii", bridge.culee_elevatie_simplu, bridge.culee_elevatie_armat, bridge.culee_elevatie_precomprimat, bridge.culee_elevatie_metal, bridge.culee_elevatie_lemn, bridge.culee_elevatie_mixt]
      sheet.add_row ["Pile", "Fundatii", bridge.pile_fundatie_simplu, bridge.pile_fundatie_armat, bridge.pile_fundatie_precomprimat, bridge.pile_fundatie_metal, bridge.pile_fundatie_lemn, bridge.pile_fundatie_mixt]
      sheet.add_row ["", "Elevatii", bridge.pile_elevatie_simplu, bridge.pile_elevatie_armat, bridge.pile_elevatie_precomprimat, bridge.pile_elevatie_metal, bridge.pile_elevatie_lemn, bridge.pile_elevatie_mixt]


      sheet.add_row ["SUPRASTRUCTURA", nil]
      sheet.merge_cells("A19:B19")
      sheet.merge_cells("C19:H19")

      sheet.add_row ["Structura de rezistenta", bridge.structura_rezistenta_simplu, bridge.structura_rezistenta_armat, bridge.structura_rezistenta_precomprimat, bridge.structura_rezistenta_metal, bridge.structura_rezistenta_lemn, bridge.structura_rezistenta_mixt]
      sheet.merge_cells("A20:B20")

      sheet.add_row ["8. Lungimea podului (m)", "", bridge.lungime, "", "", "", ""]
      sheet.merge_cells("A21:B21")
      sheet.merge_cells("C21:H21")

      sheet.add_row ["- nunărul de deschideri", "", bridge.numar_deschideri, "", "", "", ""]
      sheet.merge_cells("A22:B22")
      sheet.merge_cells("C22:H22")

      sheet.add_row ["- lungimea fiecărei deschideri (m)", "", bridge.lungime_deschidere, "", "", "", ""]
      sheet.merge_cells("A23:B23")
      sheet.merge_cells("C23:H23")

      sheet.add_row [" 9. Lățimea podului - intre parapeți (m)", "", bridge.latime, "", "", "", ""]
      sheet.merge_cells("A24:B24")
      sheet.merge_cells("C24:H24")

      sheet.add_row ["- lățimea părții carosabile (m)", "", bridge.latime_carosabila, "", "", "", ""]
      sheet.merge_cells("A25:B25")
      sheet.merge_cells("C25:H25")

      sheet.add_row ["- lățimea trotuarelor (m)", "", bridge.latime_trotuar, "", "", "", ""]
      sheet.merge_cells("A26:B26")
      sheet.merge_cells("C26:H26")

      sheet.add_row ["- numărul de grinzi în scțiune transversală", "", bridge.numar_grinzi, "", "", "", ""]
      sheet.merge_cells("A27:B27")
      sheet.merge_cells("C27:H27")

      sheet.add_row ["- numărul de antretoaze", "", bridge.numar_antretoaze, "", "", "", ""]
      sheet.merge_cells("A28:B28")
      sheet.merge_cells("C28:H28")

      sheet.add_row ["10. Aparate de reazem(tip, materialul din care sunt construite, schema de amplasare)", "", bridge.aparate_reazem, "", "", "", ""]
      sheet.merge_cells("A29:B29")
      sheet.merge_cells("C29:H29")
      sheet.add_row ["11. Tip infrastructuri", "", bridge.tip_infrastructurii, "", "", "", ""]
      sheet.merge_cells("A30:B30")
      sheet.merge_cells("C30:H30")
      sheet.add_row ["12. Tip fundații", "", bridge.tip_fundatii, "", "", "", ""]
      sheet.merge_cells("A31:B31")
      sheet.merge_cells("C31:H31")
      sheet.add_row ["13. Tipul îmbrăcămintei pe pod", "", bridge.tip_imbracaminte, "", "", "", ""]
      sheet.merge_cells("A32:B32")
      sheet.merge_cells("C32:H32")
      sheet.add_row ["14. Rosturi tip____poziție___", "", bridge.rosturi_tip_pozitie, "", "", "", ""]
      sheet.merge_cells("A33:B33")
      sheet.merge_cells("C33:H33")
      sheet.add_row ["15. Parapeți pietonali", "", bridge.parapeti_pietonali, "", "", "", ""]
      sheet.merge_cells("A34:B34")
      sheet.merge_cells("C34:H34")
      sheet.add_row ["16. Parapeți de siguranță", "", bridge.parapeti_siguranta, "", "", "", ""]
      sheet.merge_cells("A35:B35")
      sheet.merge_cells("C35:H35")
      sheet.add_row ["17. Racordări cu terasamentele", "", bridge.racordari_terasamente, "", "", "", ""]
      sheet.merge_cells("A36:B36")
      sheet.merge_cells("C36:H36")
      sheet.add_row ["18. Apărări de mal", "", bridge.aparari_mal, "", "", "", ""]
      sheet.merge_cells("A37:B37")
      sheet.merge_cells("C37:H37")
      
    end
  end

  def clasa(flaw, workbook)
    bridge = flaw.bridge
    workbook.add_worksheet(name: "Clasa") do |sheet|
      bold_border_style = workbook.styles.add_style(
        border: {
          edges: [:left, :right, :top, :bottom], # Apply borders to all edges
          style: :thin,
          color: "000000"
        },
        bg_color: "C0C0C0",                      # Light gray background color
        alignment: { horizontal: :center }       # Center alignment
      )

      sheet.add_row ["Stabilirea clasei de stare tehnică a podului și a măsurilor recomandate"]
      sheet.merge_cells("A1:E1")
      sheet.merge_cells("A3:A4")
      sheet.merge_cells("B3:B4")
      sheet.merge_cells("C3:C4")

      sheet.merge_cells("A5:A6")
      sheet.merge_cells("B5:B6")
      sheet.merge_cells("C5:C6")

      sheet.merge_cells("A7:A8")
      sheet.merge_cells("B7:B8")
      sheet.merge_cells("C7:C8")

      sheet.merge_cells("A9:A10")
      sheet.merge_cells("B9:B10")
      sheet.merge_cells("C9:C10")

      sheet.merge_cells("A11:A12")
      sheet.merge_cells("B11:B12")
      sheet.merge_cells("C11:C12")

      sheet.merge_cells("A14:D14")

      sheet.merge_cells("A16:E16")
      sheet.merge_cells("A17:D17")
      sheet.merge_cells("E11:E12")

      sheet.add_row ["Nr. crt.", "Clasa stării tehnice",	"Valoarea indecelui de stare tehnică IST",	"Aprecieri generale asupra stării tehnice",	"Măsuri recomandate conform normativelor"]

      sheet.add_row ["1", "I", "81..100", "Stare foarte bună.", "- măsuri de îmbunătățire a \ncaracterisitcilor estetice;\n- lucrări de întreținere"]
      sheet.add_row [nil,nil,nil,nil,nil]
      sheet.add_row ["2", "II", "61..80", "Stare bună. ", "-- lucrări de întreínere;\n- reparații"]
      sheet.add_row [nil,nil,nil,"Materialul din care sunt alcătuite suprastructura și infrastructura\n prezintă un început de degradare cu defecte și degradăti vizibile",nil]

      sheet.add_row ["3", "III", "41..60", "Stare satisfăcătoare ", "- reparații;\n- reabilitări;\n- consolidări"]
      sheet.add_row ["", "", "", "Elementele constructive sunt într-o stare avansată de degradare", ""]

      sheet.add_row ["4", "IV", "21..40", "Stare nesatisfăcătoare ", "- reabilitare;\n- înlocuirea unor elemente"]
      sheet.add_row ["", "", "", "Elementele constructive sunt într-o stare avansată de degradare", ""]

      sheet.add_row ["5", "V", "sub 20", "Stare tehnică nesigură ", "- înlocuirea sau consolidarea structurii de\n rezistență afectată de degradare"]
      sheet.add_row ["", "", "", "Nu asigură condițiile minime de siguranță a circulației", ""]
      sheet.add_row [nil,nil,nil,nil,nil]

      sheet.add_row ["Clasa stării tehnice a podului este :",nil,nil,nil,bridge.clasa]
      sheet.add_row ["Aprecieri asupra stării tehnice :",nil,nil,nil,flaw.aprecierea_starii_tehnice]

      sheet.add_row ["Elementele constructive prezintă degradări vizibile pe zone întinse cu afectarea secțiunii transversale",nil,nil,nil,nil]
      sheet.add_row ["Măsuri recomandate :",nil,nil,nil,flaw.masuri_recomandate]


    end
  end

  def ist(flaw, workbook)
    bridge = flaw.bridge
    workbook.add_worksheet(name: "IST") do |sheet|
      bold_border_style = workbook.styles.add_style(
        border: {
          edges: [:left, :right, :top, :bottom], # Apply borders to all edges
          style: :thin,
          color: "000000"
        },
        bg_color: "C0C0C0",                      # Light gray background color
        alignment: { horizontal: :center }       # Center alignment
      )

      sheet.add_row ["Calculul Indicelui de stare tehnică"]
      sheet.merge_cells("A1:G1")
      sheet.merge_cells("B2:C2")
      sheet.merge_cells("B13:C13")
      sheet.merge_cells("D13:E13")
      sheet.merge_cells("F13:G13")
      
      sheet.merge_cells("D2:E2")
      sheet.merge_cells("F2:G2")

      sheet.merge_cells("F3:G5")
      sheet.merge_cells("F6:G7")
      sheet.merge_cells("F8:G10")
      sheet.merge_cells("F11:G12")

      sheet.add_row ["Nr. crt.", "Demunire Indice", nil,"Puncte",nil,"Total"]

      sheet.add_row ["1","Indicele de calitate al elementelor principale de rezistență ale suprastructurii", "C1 =", "2","puncte","C = ΣCi = \nC1 + C2 + C3 +\n C4 + C5 = "]
      sheet.add_row ["2","Indicele de calitate al elementelor de rezistență care susțin calea podului", "C2 =", "3","puncte",""]
      sheet.add_row ["3","Indicele de caliatate al elementelor infrastructurii, aparate de\n reazem, dispozitive de protecție la acțiuni seismice, sferturi de con sau aripi", "C3 =", "2","puncte",""]
      sheet.add_row ["4","Indicele de calitate al albiei, apărărilor de maluri, rampe de acces", "C4 =", "4","puncte",flaw.ist_c]
      sheet.add_row ["5","Indicele de calitate al căii podului și al elementelor aferente", "C5 =", "2","puncte",""]
      sheet.add_row ["6","Indicele de funcționalitate determinat în funcție\n de condițiile de desfășurare a traficului pe pod", "F1 =", "5","puncte","F = ΣFi = \nF1 + F2 + F3\n + F4 + F5 ="]
      sheet.add_row ["7","Indicele de funcționalitate determinat de clasa\n de încărcare a podului", "F2 =", "10","puncte",""]
      sheet.add_row ["8","Indicele de funcționalitate determinat de durata de exploatare a podului,\N care a trecut de la construcția sau de la ultima\N reparație capitală, și tipul podului", "F3 =", "3","puncte",""]
      sheet.add_row ["9","Indicele de funcționalitate determinat de modul de respectare la\n execuție a proiectului, neasigurarea condițiilor\n de efectuare a lucrărilor de întreținere și\n reparații, condiții de exploatare necorespunzătoare", "F4 =", "10","puncte",flaw.ist_f]
      sheet.add_row ["10","Indicele de funcționalitate determinat de ccalitatea lucrărilor de întreținere", "F5 =", "10","puncte",""]

      sheet.add_row ["","Indice de stare tehnică - IST=ΣCi+ΣFi =", "", flaw.ist_total,"Puncte",""]
    end
  end

  def f5(flaw, workbook)
    bridge = flaw.bridge
    workbook.add_worksheet(name: "F5") do |sheet|
      bold_border_style = workbook.styles.add_style(
        border: {
          edges: [:left, :right, :top, :bottom], # Apply borders to all edges
          style: :thin,
          color: "000000"
        },
        bg_color: "C0C0C0",                      # Light gray background color
        alignment: { horizontal: :center }       # Center alignment
      )

      sheet.add_row ["III. Notarea caracteristicilor de funcționalitate\nIndicile de funcționalitate F5\nDepunctarea se face în funcție de calitatea lucrărilor de întreținere curentă"]
      sheet.merge_cells("A1:C1")
      sheet.merge_cells("A7:B7")
      sheet.merge_cells("A8:B8")

      sheet.add_row ["Nr.crt", "Calitatea lucrărilor de întreținere", "Depunctare"]

      sheet.add_row ["1", "Buna (maxim 20% din lucrarile de intretinere nerealizate)", "1-2"]
      sheet.add_row ["2", "Satisfacatoare (maxim 50% din lucrarile de intretinere nerealizate)", "3-6"]
      sheet.add_row ["3", "Lipsa totala a lucrarilor de intretinere (peste 50% din lucrarile de intretinere nerealizate)", "7-9"]
      sheet.add_row [nil,nil,nil]

      sheet.add_row ["Depunctarea se face in functie de calitatea lucrarilor de întreținere curentă\nF5   (depunctare) =",nil,flaw.f5_depunct]
      sheet.add_row ["F5 =",nil,flaw.f5]
    end
  end

  def f4(flaw, workbook)
    bridge = flaw.bridge
    workbook.add_worksheet(name: "F4") do |sheet|
      bold_border_style = workbook.styles.add_style(
        border: {
          edges: [:left, :right, :top, :bottom], # Apply borders to all edges
          style: :thin,
          color: "000000"
        },
        bg_color: "C0C0C0",                      # Light gray background color
        alignment: { horizontal: :center }       # Center alignment
      )

      sheet.add_row ["III. Notarea caracteristicilor de funcționalitate\nIndicile de funcționalitate F4\nDepunctarea se face în funcție de modul de respectare la execuție a proiectului,\n neasigurarea condițiilor de efectuare a lucrărilor de întreținere\n și reparații, condiții de exploatare necorespunzătoare"]
      sheet.merge_cells("A1:C1")
      sheet.merge_cells("A9:A10")
      sheet.merge_cells("A12:B12")
      sheet.merge_cells("A13:B13")

      sheet.add_row ["Nr.crt.", "Denumire defect", "Depunctare"]

      sheet.add_row ["1", "Lipsa de estetica a incadrarii podului in mediul inconjurator", "3 – 4"]
      sheet.add_row ["2", "Lipsa marcajelor si/sau a indicatoarelor de semnalizare, lipsa panourilor de protectie\n la pasaje superioare peste cai ferate electrificate.", "2 – 3 "]
      sheet.add_row ["3", "Lipsa indicatoarelor de restrictie viteza, tonaj si gabarit.", "7 – 8"]
      sheet.add_row ["4", "Lipsa sau neufunctionarea dispozitivelor de intretinere (carucioare, platforme acces etc.),\n imposibilitatea accesului la elementele podurilor\n pentru inspectii, intretinere si reparatii.", "5 – 6"]
      sheet.add_row ["5", "Neasigurarea scurgerii apei, stagnarea apei pe pod, existenta\n unor straturi suplimentare a imbracamintii pe pod.", "2 – 5 "]
      sheet.add_row ["6", "Necorelarea amplasamentului podului cu drumul si traseul albiei, amplasarea in\n gabarit a unor elemente de constructie si/sau instalatii, restrictii de viteza.", "7 – 8"]

      sheet.add_row ["7", "Nerespectarea dimensiunilor la elementele de rezistenta ale suprastructurii.", "5 – 6"]
      sheet.add_row ["", "Rezemare incorecta a grinzilor pe infrastructura.", "8 – 9"]
      sheet.add_row [nil,nil,nil]
      sheet.add_row ["Depunctarea se face în funcție de modul de respectare la execuție a proiectului,\n neasigurarea condițiilor de efectuare a lucrărilor de întreținere și reparații,\n condiții de exploatare necorespunzătoare F4   (depunctare) = ",nil,flaw.f4_depunct]
      sheet.add_row ["F4 =",nil,flaw.f4]

    end
  end

  def f3(flaw, workbook)
    bridge = flaw.bridge
    workbook.add_worksheet(name: "F3") do |sheet|
      bold_border_style = workbook.styles.add_style(
        border: {
          edges: [:left, :right, :top, :bottom], # Apply borders to all edges
          style: :thin,
          color: "000000"
        },
        bg_color: "C0C0C0",                      # Light gray background color
        alignment: { horizontal: :center }       # Center alignment
      )

      options = ["Grinzi nituie", "Sudate", "Grinzi Matarov", "Grinzi Gerber","Alte categorii","Fasii cu goluri *","Fasii cu goluri cu suprabetonare","Grinzi tronsonate (tronsoane mici)","Grinzi pref. monobloc sigrinzi monolit","Lemn"]
      sheet.add_data_validation('E17:J17', {
          type: :list,
          formula1: "\"#{options.join(',')}\"", # Join the options into a string
          showDropDown: true
        })

        options = ["0–5",	"6-15","16-25","26-35",	"36-45",">45"]
      sheet.add_data_validation('E18:J18', {
          type: :list,
          formula1: "\"#{options.join(',')}\"", # Join the options into a string
          showDropDown: true
        })


      sheet.add_row ["III. Notarea caracteristicilor de funcționalitate\nIndicile de funcționalitate F3\nDepunctarea se face în funcție de durata de exploatare a podului, care a trecut de la construcția, sau de la ultimareparație capitală"]
      sheet.merge_cells("A1:J1")
      sheet.merge_cells("E2:J2")
      sheet.merge_cells("A2:A3")
      sheet.merge_cells("B2:B3")
      sheet.merge_cells("C2:C3")
      sheet.merge_cells("A6:A7")
      sheet.merge_cells("B6:B7")

      sheet.merge_cells("A8:A10")
      sheet.merge_cells("B8:B10")

      sheet.merge_cells("A11:A14")
      sheet.merge_cells("B11:B14")
      sheet.merge_cells("A17:C17")
      sheet.merge_cells("E17:J17")
      sheet.merge_cells("E18:J18")
      sheet.merge_cells("F19:H19")
      sheet.merge_cells("F20:H20")

      sheet.merge_cells("I19:J19")
      sheet.merge_cells("I20:J20")

      sheet.add_row ["Nr. crt.","Materialul din\n care este realizat\n podul","Tipul suprastructurii",nil,"Durata de exploatare a podului, care a trecut de la constructie\n sau de la ultima reparatie capitala"]
      sheet.add_row [nil,nil,nil,nil,"0–5",	"6-15","16-25","26-35",	"36-45",">45"]
      sheet.add_row ["","","","","1","2","3","4","5","6"]
      sheet.add_row ["0","1","2","3","4","5","6","7","8"]
      sheet.add_row ["1","Metal","Grinzi nituite","1","0",	"2",	"5",	"6",	"7",	"8"]
      sheet.add_row ["","","Sudate","2",	"0",	"5",	"6",	"7",	"8",	"9"]

      sheet.add_row ["2","Beton armat","Grinzi Matarov","3"	,"0",	"2"	,"4",	"7",	"8",	"9"]
      sheet.add_row [nil,nil,"Grinzi Gerber","4",	"2",	"4"	,"6",	"7",	"8",	"9"]
      sheet.add_row [nil,nil,"Alte categorii","5",	"0"	,"3",	"5",	"6",	"7",	"8"]

      sheet.add_row ["3","Beton\n  precomprimat","Fasii cu goluri *","6"	,"3",	"7",	"8",	"9",	"10",	"10"]
      sheet.add_row ["","","Grinzi tronsonate (tronsoane mici)","7",	"1",	"5",	"6",	"7",	"8",	"8"]
      sheet.add_row ["","","Grinzi pref. monobloc sigrinzi monolit","8",	"2",	"4",	"7",	"8",	"9",	"10"]
      sheet.add_row ["","","Grinzi pref. monobloc sigrinzi monolit","9"	,"0"	,"2"	,"5",	"7",	"8",	"9"]

      sheet.add_row ["4","Lemn","Lemn","10",	"5",	"7",	"9",	"10",	"10",	"10"]
      sheet.add_row [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]

      sheet.add_row ["Tipul Suprastructurii",nil,nil,nil,flaw.tipul_suprastructurii]
      sheet.add_row ["Durata de exploatare a podului, care a trecut de la constructie sau\n de la ultima reparatie capitala",nil,nil,nil,flaw.durata_exploatare]

      sheet.add_row [nil,nil,nil,nil,nil,"F3   (depunctare) = ",nil,nil,flaw.f3_depunct]
      sheet.add_row [nil,nil,nil,nil,nil,"F3 = ",nil,nil,flaw.f3]
    end
  end

  def f2(flaw, workbook)
    bridge = flaw.bridge
    workbook.add_worksheet(name: "F2") do |sheet|
      bold_border_style = workbook.styles.add_style(
        border: {
          edges: [:left, :right, :top, :bottom], # Apply borders to all edges
          style: :thin,
          color: "000000"
        },
        bg_color: "C0C0C0",                      # Light gray background color
        alignment: { horizontal: :center }       # Center alignment
      )


      sheet.add_row ["III. Notarea caracteristicilor de funcționalitate\nIndicile de funcționalitate F2\nDepunctarea se face în funcție de clasa de încărcare a podului și clasa tehnică"]
      sheet.merge_cells("A1:F1")
      sheet.merge_cells("A2:A3")
      sheet.merge_cells("B2:C3")
      sheet.merge_cells("D2:F2")
      sheet.merge_cells("B4:C4")

      sheet.merge_cells("D11:F11")
      sheet.merge_cells("D11:F11")
      sheet.merge_cells("D12:F12")
      sheet.merge_cells("C13:D13")
      sheet.merge_cells("E13:F13")
      sheet.merge_cells("E14:F14")

      sheet.add_row ["Nr. crt","Clasa tehnică a drumului, conf. Ordinului 1296/2017\NCategoria de drum - Număr minim/maxim de benzi de circulație",nil,"Clasa de încărcare pod"]
      sheet.add_row [nil,nil,nil,"LM1/E","I","II"]

      sheet.add_row ["0","1",nil,"2","3","4"]

      sheet.add_row ["1","I","Autostrăzi minimum 2 benzi/sens","0","10","10"]
      sheet.add_row ["2","II","Dr. expres şi dr. naţ. europene cu 4 benzi minimum 2 benzi/sens","0","9","10"]
      sheet.add_row ["3","III","Dr. naţ. europene, dr. naţ. principale şi dr. jud. 2 benzi","0","6","10"]
      sheet.add_row ["4","IV","Dr. naţ. principale, dr. naț. Secundare, dr. jud. și dr. com 2 benzi","0","3","8"]
      sheet.add_row ["5","V","Dr. naţ. secundare, dr. jud., dr. com și dr. vicinale 2 benzi","0","0","3"]
      sheet.add_row ["","","","","",""]

      sheet.add_row ["","","Clasa de încărcare                                        =",flaw.clasa_incarcare,"",""]
      sheet.add_row ["","","Clasa tehnică a drumului                                        =",bridge.clasa,"",""]
      sheet.add_row ["","","F2   (depunctare) = f (Clasa de încărcare, Categoria drumului)                      =",nil,flaw.f2_depunct,""]
      sheet.add_row ["","","","F2 =",flaw.f2,""]
    end
  end

  def f1(flaw, workbook)
    bridge = flaw.bridge
    workbook.add_worksheet(name: "F1") do |sheet|
      bold_border_style = workbook.styles.add_style(
        border: {
          edges: [:left, :right, :top, :bottom], # Apply borders to all edges
          style: :thin,
          color: "000000"
        },
        bg_color: "C0C0C0",                      # Light gray background color
        alignment: { horizontal: :center }       # Center alignment
      )


      sheet.add_row ["III. Notarea caracteristicilor de funcționalitate\nIndicile de funcționalitate F1\nDepunctarea se face în funcție de condițiile de desfășurare a traficului pe pod"]
      sheet.merge_cells("A1:L1")

      sheet.add_row ["Nr. crt.","Clasa tehnică a drumului,\n conf. Ordinului 1296/2017\nCategoria de drum - Număr\n minim/maxim de\n benzi de circulație",nil,"Lungimea podului (L) (m)"]
      sheet.merge_cells("A2:A6")
      sheet.merge_cells("B2:C6")
      sheet.merge_cells("D2:L2")
      sheet.merge_cells("D3:F3")
      sheet.merge_cells("G3:I3")
      sheet.merge_cells("J3:L3")
      sheet.merge_cells("D4:L4")
      sheet.merge_cells("D5:E5")
      sheet.merge_cells("F5:F6")
      sheet.merge_cells("G5:H5")
      sheet.merge_cells("I5:I6")
      sheet.merge_cells("J5:K5")
      sheet.merge_cells("L5:L6")
      sheet.merge_cells("A13:L13")
      sheet.merge_cells("A18:L18")
      sheet.merge_cells("I14:L14")
      sheet.merge_cells("A15:B15")
      sheet.merge_cells("C15:G15")
      sheet.merge_cells("I15:L15")

      sheet.merge_cells("A16:B16")
      sheet.merge_cells("C16:G16")
      sheet.merge_cells("I16:L16")

      sheet.merge_cells("A17:B17")
      sheet.merge_cells("C17:G17")
      sheet.merge_cells("I17:L17")
      sheet.merge_cells("A19:K19")
      sheet.merge_cells("A20:K20")
      sheet.add_row [nil, nil, nil, "L < 25 m",nil,nil, "L = 26 – 100",nil,nil, "L > 101 m"]
      sheet.add_row [nil, nil, nil, "Lăţimea părţii carosabile * (m)"]
      sheet.add_row [nil,nil,nil,"care corespunde cu\n lăţimea părţii\n carosabile a drumului",nil,"care nu corespunde cu\n lăţimea părţii\n carosabile a drumului","care corespunde cu\n lăţimea părţii\n carosabile a drumului",nil,"care nu corespunde\n cu lăţimea părţii\n carosabile a drumului","care corespunde\n cu lăţimea părţii\n carosabile a drumului",nil,"care nu corespunde\n cu lăţimea părţii\n carosabile a drumului"]
      sheet.add_row [nil,nil,nil,"cu *\n spaţiu de\n siguranţă","fără spaţiu\n de siguranţă",nil,"cu *\n spaţiu\n de siguranţă", "fără spaţiu\n de siguranţă",nil,"cu *\n spaţiu\n de siguranţă", "fără\n spaţiu\n de siguranţă"]

      sheet.add_row ["0","1",nil,"2","3","4","5","6","7","8","9","10"]
      sheet.add_row ["1","II","Autostrăzi\nminimum 2\nbenzi/sens ","0","7","8","0","8","9","0","9","10"]
      sheet.add_row ["2","III","Dr. expres şi\ndr. naţ.\neuropene cu 4 benzi\nminimum 2\nbenzi/sens  ","0","6","7","0","7","8","0","8","9"]
      sheet.add_row ["3","IV","Dr. naţ.\neuropene, dr.\nnaţ. principale şi\ndr. jud. \n2 benzi","0","4","5","0","5","6","0","6","7"]
      sheet.add_row ["4","V","Dr. naţ.\nprincipale, dr. naț. Secundare,\ndr. jud. și dr. com\n2 benzi","0","0","1","0","2","3","0","4","5"]
      sheet.add_row ["5","VI","Dr. naţ.\nsecundare,\ndr. jud., dr. com și dr. vicinale\n2 benzi","0","0","0","0","1","2","0","3","4"]
      sheet.add_row [" * lăţimea părţii carosabile şi a spaţiului de siguranţă banda de ghidare (bg) plus efectul optic (E0) sunt conform Ordinului 1296/2017"]
      sheet.add_row [nil,nil,nil,nil,nil,nil,nil,nil,"Corespunde cu Ordinul 1296/2017 ?"]
      options = ["DA", "NU", "DA, fără spațiu de siguranță"]
      sheet.add_data_validation('I15:L15', {
          type: :list,
          formula1: "\"#{options.join(',')}\"", # Join the options into a string
          showDropDown: true
        })
      sheet.add_row ["1",nil,"Lăţimea părţi carosabile                B     =",nil,nil,nil,nil,bridge.latime_carosabila,flaw.corespunde_ordinul]
      sheet.add_row ["2",nil,"Lungimea podului                         L     =",nil,nil,nil,nil,bridge.lungime,""]
      sheet.add_row ["3",nil,"Clasa tehnică a drumului              Ct   =",nil,nil,nil,nil,bridge.clasa,""]

      sheet.add_row [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
      sheet.add_row ["F1   (depunctare) = f (Lăţimea părţii carosabile, Lungimea podului, Categoria drumului)       =",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,flaw.f1_depunct]
      sheet.add_row ["F1 =",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, flaw.f1]
    end
  end

  def c1_5(flaw, workbook)
    workbook.add_worksheet(name: "C1-5") do |sheet|
      bold_border_style = workbook.styles.add_style(
        border: {
          edges: [:left, :right, :top, :bottom], # Apply borders to all edges
          style: :thin,
          color: "000000"
        },
        bg_color: "C0C0C0",                      # Light gray background color
        alignment: { horizontal: :center }       # Center alignment
      )


      sheet.add_row ["II. Notarea defectelor constatate în teren"]
      sheet.merge_cells("A1:H1")

      sheet.add_row ["Nr.crt.", "Denumirea defectului", "Limite de depunere", "Notare defecte",nil, nil, nil, nil, "Obs."]
      sheet.add_row ["Poz.", nil, nil, "C1(*)", "C2(*)", "C3(*)", "C4(*)", "C5(*)"]
      sheet.add_row ["catalog."]
      sheet.merge_cells("B2:B4")
      sheet.merge_cells("C2:C4")
      sheet.merge_cells("D2:H2")
      sheet.merge_cells("D3:D4")
      sheet.merge_cells("E3:E4")
      sheet.merge_cells("F3:F4")
      sheet.merge_cells("G3:G4")
      sheet.merge_cells("H3:H4")
      sheet.merge_cells("I2:I4")
      sheet.merge_cells("A10:A11")
      sheet.merge_cells("A27:A28")
      sheet.merge_cells("A29:A30")
      sheet.merge_cells("A31:A33") 
      sheet.merge_cells("D31:D33") 
      sheet.merge_cells("E31:E33") 
      sheet.merge_cells("F31:F33") 
      sheet.merge_cells("H31:H33") 
      sheet.merge_cells("I31:I33")
      sheet.merge_cells("A42:A43")
      sheet.merge_cells("A51:A59")
      sheet.merge_cells("B58:B59")
      sheet.merge_cells("A72:A73")
      sheet.merge_cells("B72:B73")
      sheet.merge_cells("D72:D73")
      sheet.merge_cells("E72:E73")
      sheet.merge_cells("F72:F73")
      sheet.merge_cells("G72:G73")
      sheet.merge_cells("H72:H73")

      sheet.merge_cells("A75:A76")
      sheet.merge_cells("B75:B76")
      sheet.merge_cells("D75:D76")
      sheet.merge_cells("E75:E76")
      sheet.merge_cells("F75:F76")
      sheet.merge_cells("G75:G76")
      sheet.merge_cells("H75:H76")

      sheet.merge_cells("A79:A81")
      sheet.merge_cells("B79:B81")

      sheet.merge_cells("A83:A84")
      sheet.merge_cells("F83:F84")
      sheet.merge_cells("G83:G84")
      sheet.merge_cells("H83:H84")

      sheet.merge_cells("A85:A86")
      sheet.merge_cells("B85:B86")
      sheet.merge_cells("D85:D86")
      sheet.merge_cells("E85:E86")
      sheet.merge_cells("F85:F86")
      sheet.merge_cells("G85:G86")
      sheet.merge_cells("H85:H86")

      sheet.merge_cells("A89:A90")
      sheet.merge_cells("D89:D90")
      sheet.merge_cells("E89:E90")
      sheet.merge_cells("F89:F90")
      sheet.merge_cells("H89:H90")

      sheet.merge_cells("A99:A100")
      sheet.merge_cells("B99:B100")
      sheet.merge_cells("C99:C100")
      sheet.merge_cells("D99:D100")
      sheet.merge_cells("E99:E100")
      sheet.merge_cells("F99:F100")
      sheet.merge_cells("G99:G100")
      sheet.merge_cells("H99:H100")

      sheet.merge_cells("A110:A114")
      sheet.merge_cells("B110:B114")
      sheet.merge_cells("D110:D114")
      sheet.merge_cells("E110:E114")
      sheet.merge_cells("F110:F114")
      sheet.merge_cells("G110:G114")
      sheet.merge_cells("H110:H114")

      sheet.merge_cells("A122:A126")
      sheet.merge_cells("B122:B126")
      sheet.merge_cells("D122:D126")
      sheet.merge_cells("E122:E126")
      sheet.merge_cells("F122:F126")
      sheet.merge_cells("G122:G126")
      sheet.merge_cells("H122:H126")

      sheet.merge_cells("A127:A129")
      sheet.merge_cells("B127:B129")
      sheet.merge_cells("D127:D129")
      sheet.merge_cells("E127:E129")
      sheet.merge_cells("F127:F129")
      sheet.merge_cells("G127:G129")
      sheet.merge_cells("H127:H129")

      sheet.merge_cells("A130:A131")
      sheet.merge_cells("D130:D131")
      sheet.merge_cells("E130:E131")
      sheet.merge_cells("F130:F131")
      sheet.merge_cells("G130:G131")
      sheet.merge_cells("H130:H131")

      sheet.merge_cells("A137:B137")
      sheet.merge_cells("A138:B138")
      sheet.merge_cells("A139:B139")
      sheet.merge_cells("A140:B140")
      sheet.merge_cells("A141:B141")
      sheet.merge_cells("C137:C138")
      sheet.merge_cells("D137:D138")
      sheet.merge_cells("E137:E138")
      sheet.merge_cells("F137:F138")
      sheet.merge_cells("G137:G138")
      sheet.merge_cells("H137:H138")
      sheet.merge_cells("D141:H141")
      

      sheet.add_row ["0", "1", "2", "3", "4", "5", "6", "7", "8"]

      sheet.add_row [
        "1", 
        "Absenta unor elemente structurale (antretoaze,rigidizari,\ncontravantuiri, etc.) din fazele de executie, proiectare sau exploatare.",
        "7 – 8 pentru C1\n5 – 6 pentru C2",
        flaw.c1_1,  
        flaw.c2_1   
      ], style: [nil, nil, nil, bold_border_style, bold_border_style]
      sheet.add_row [
        "2", 
        "Alinierea in plan rampa-pod necorespunzatoare, latime\n insuficienta a rambleului, acces dificil pe trotuarul podului.",
        "4-5",
        "",  
        "", 
        "",
        flaw.c4_2
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "3", 
        "Amplasarea incorecta a gratarelor gurilor de scurgere, lipsa\n acestora si/sau a tuburilor de prelungire, guri de scurgere\n infundate.",
        "3–5  Poduri din b.a 6-7\n Poduri din b.p sau\n metalice",
        "",  
        "", 
        "",
        "",
        flaw.c5_3
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "4", 
        "Aparate de reazem inglobate in praf si murdarie,\n functionarea necorespunzatoare a acestora.",
        "3–5",
        "",  
        "", 
        flaw.c3_4,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "5", 
        "Aripi sau sferturi de con afuiate, fisurate sau crapate (cazul\n aripilor din beton)",
        "4 - 5",
        "",  
        "", 
        flaw.c3_1_5,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "", 
        "Aripi deplasate fata de pozitia initiala, pierderea formei\n sferturilor de con.",
        "6",
        "",  
        "", 
        flaw.c3_2_5,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "6", 
        "Armaturi fara strat de acoperire.",
        "4-6",
        flaw.c1_6,  
        flaw.c2_6, 
        flaw.c1_7,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "7", 
        "Beton cu aspect friabil si/sau zone din beton exfoliat.",
        "6-Beton simplu \n 8-Beton armat+b. p.",
        flaw.c3_6,  
        flaw.c2_7, 
        flaw.c3_7,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "8", 
        "Beton degradat prin carbonatare, aparitia de stalactite si/sau\n draperii.",
        "7-Beton simplu\n 8-Beton armat+b.p.",
        flaw.c1_8,  
        flaw.c2_8, 
        flaw.c3_8,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "9", 
        "Beton degradat prin coroziune cu reducerea sectiunii elementului.",
        "7-8",
        flaw.c1_9,  
        flaw.c2_9, 
        flaw.c3_9,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "10", 
        "Bolti cu degradari avansate (crapaturi pe zone mari, aparitia\n de striviri).",
        "6-8",
        flaw.c1_10,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "11", 
        "Calea pe pod sau pe trotuare este degradata (suprafata cuciupituri, poroasa, incretita).",
        "2-Supraf. Locala\n3-Supraf.>3mp",
        "",  
        "", 
        "",
        "",
        flaw.c5_11
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "12", 
        "Coroziunea armaturii, pete de rugina si/sau fisuri sau\n crapaturi orientate pe directia acesteia.",
        "6-Beton armat\n8-Beton prec.",
        flaw.c1_12,  
        flaw.c2_12, 
        flaw.c3_12,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "13", 
        "Coroziunea avansata a stalpului metalic al parapetului in\n zona de contact cu betonul, fixarea necorespunzatoare a\n parapetului de siguranta si/sau numarul insuficient de\n suruburi de inadire.",
        "5",
        "",  
        "", 
        "",
        "",
        flaw.c5_13
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "14", 
        "Coroziunea fisuranta sub tensiune.",
        "6-7",
        flaw.c1_14,  
        flaw.c2_14, 
        flaw.c3_14,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "15", 
        "Coroziunea metalului in puncte, de profunzime si/sau intre\n piese.",
        "4-Pentru C1 si C2\n 2-Pentru C3",
        flaw.c1_15,  
        flaw.c2_15, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "16", 
        "Cumularea la un element al structurii a mai multor degradari\n (coroziune, crapaturi, striviri etc)",
        "8-9",
        flaw.c1_16,  
        flaw.c2_16, 
        flaw.c3_16,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "17", 
        "Defecte de suprafata ale fetei vazute (culoare neuniforma,\n pete de rugina, impuritati, pete de rugina, aspect prafuit,\n imperfectiuni geometrice, aspect macroporos, agregate\n la suprafata).",
        "4-Pentru C1 si C2\n 2-Pentru C3",
        flaw.c1_17,  
        flaw.c2_17, 
        flaw.c3_17,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "18", 
        "Deformatii locale ale pieselor datorita coroziunii",
        "5-6",
        flaw.c1_18,  
        flaw.c2_18, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "19", 
        "Deformatii mari (sageti) ale suprastructurii",
        "8-9",
        flaw.c1_19,  
        "",
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "20", 
        "Degradarea (betonului si/sau coroziunea armaturii)\n parapetului, dislocarea stalpului de prindere a parapetului,\n lipsa rostului in parapet.",
        "3-4",
        "",  
        "", 
        "",
        "",
        flaw.c5_20
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "21", 
        "Degradarea sau dislocarea bordurilor.",
        "2-3",
        "",  
        "", 
        "",
        "",
        flaw.c5_1_21
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "", 
        "Lipsa sau distrugerea placilor de acoperire a golurilor din\n trotuare..",
        "4-5",
        "",  
        "", 
        "",
        "",
        flaw.c5_2_21
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "22", 
        "Degradari ale malurilor si modificari de albie:- ruperea\n malurilor, modificarea in plan a traseului cursului apei;",
        "7-8",
        "",  
        "", 
        "",
        flaw.c4_1_22,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]
      sheet.add_row [
        "", 
        "Degradari ale malurilor si modificari de albie:- depuneri de\n material solid, prezenta unor obstacole.",
        "4-6",
        "",  
        "", 
        "",
        flaw.c4_2_22,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]

      sheet.add_row [
        "23", 
        "Degradarea (subspalarea, deformarea) sau distrugerea\n partiala sau totala a lucrarilor de: -       aparare;",
        "4-6",
        "",  
        "", 
        "",
        flaw.c4_1_23,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]
      sheet.add_row [
        "", 
        "Degradarea (subspalarea, deformarea) sau distrugerea\n partiala sau totala a lucrarilor de: -       dirijare;",
        "6-8",
        "",  
        "", 
        "",
        flaw.c4_2_23,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]
      sheet.add_row [
        "", 
        "Degradarea (subspalarea, deformarea) sau distrugerea partiala sau totala a lucrarilor de: -       praguri",
        "7-9",
        "",  
        "", 
        "",
        flaw.c4_3_23,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]

      sheet.add_row [
        "24", 
        "Denivelari ale cai pe pod: -       valuriri, refulari, fagase;",
        "4-6",
        "",  
        "", 
        "",
        "",
        flaw.c5_24
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "", 
        "Denivelari ale cai pe pod: -       praguri, gropi.",
        "7-8",
        "",  
        "", 
        "",
        "",
        "",
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "25", 
        "Deplasari ale infrastructurii fata de pozitia initiala (tasari,\n rotiri, deplasari, lunecari etc.) produse in majoritatea\n cazurilor de afuieri.",
        "7-8 Suprastr. static det.\n9-10 Suprastr.\n static nedet.",
        flaw.c3_25,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "26", 
        "Deplasari relative ale elementelor structurale (placile de\n beton fata de elemente metalice, la structurile mixte)",
        "6-7",
        "",  
        flaw.c2_26, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "27", 
        "Deplasari sau sageti permanente mari, vizibile, ale tablierului",
        "8-9",
        flaw.c1_27,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "28", 
        "Detasarea timpanului de bolta pe anumite zone",
        "7-8",
        flaw.c1_28,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "29", 
        "Deteriorarea aparatelor de reazem din neopren sau metalice",
        "5-6",
        "",  
        "", 
        flaw.c3_1_29,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "", 
        "Ruperea tachetilor, distrugerea placilor de plumb sau metalice",
        "7-8",
        "",  
        "", 
        flaw.c3_2_29,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "30", 
        "Dezaxari ale coloanelor de elevatiile realizate din stalpi in\n continuarea coloanelor.",
        "6-7",
        "",  
        "", 
        flaw.c3_1_30,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "", 
        "Masca chesonului nedemolata.",
        "4-5",
        "",  
        "", 
        flaw.c3_2_30,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "31", 
        "Distrugerea consolei trotuarului",
        "8-9",
        "",  
        flaw.c2_31, 
        flaw.c3_31,
        "",
        ""
      ], style: [nil, nil, nil, nil, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "32", 
        "Distrugerea suprastructurii (elemente rupte)",
        "9-10 Pentru C1\n 8-9 Pentru C2",
        flaw.c1_32,  
        flaw.c2_32, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "33", 
        "Distrugerea consolei trotuaruluiDislocarea unei margini din bancheta cuzinetilor",
        "7-6",
        "",  
        "", 
        flaw.c3_1_33,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "", 
        "Amenajarea necorespunzatoare a acesteia.",
        "6",
        "",  
        "", 
        flaw.c3_2_33,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "34", 
        "Elemente gresit pozitionate in structura, deplasari ale\n imbinarilor sau strangeri insuficiente ale mijloacelor de\n prindere.",
        "6-8",
        flaw.c1_34,  
        flaw.c2_34, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "35", 
        "Eroziunea betonului, prezenta unor zone pe suprafata\n elementului in care agregatele nu sunt inglobate in pasta de\n ciment.",
        "3-4 pentru C1 si  C2 cu\n supraf.<1m2 si pentru\n C3\n 5-6 pentru supraf.\n >1m2 la C1 si C2",
        flaw.c1_35,  
        flaw.c2_35, 
        flaw.c3_35,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "36", 
        "Fisuri din contractie (neorientate, scurte, superficiale),\n faiantarea betonului. Fisurile se refera numai la beton nu si la\n mortar sau tencuiala.",
        "Pentru suprafete:\n<1 m2 3-4\n >1 m2 5-6",
        flaw.c1_36,  
        flaw.c2_36, 
        flaw.c3_36,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]

      sheet.add_row [
        "37", 
        "Fisuri si/sau crapaturi ale betonului: >1 mm",
        "10",
        flaw.c1_1_37,  
        flaw.c2_1_37, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "", 
        "Fisuri si/sau crapaturi ale betonului:- long.: >0.2 mm",
        "8-9",
        flaw.c1_2_37,  
        flaw.c2_2_37, 
        flaw.c3_2_37,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "", 
        "Fisuri si/sau crapaturi ale betonului:- long.: <0.2 mm",
        "6-7",
        flaw.c1_3_37,  
        flaw.c2_3_37, 
        flaw.c3_3_37,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "", 
        "Fisuri si/sau crapaturi ale betonului:- trans.: >0.2 mm",
        "8-9",
        flaw.c1_4_37,  
        flaw.c2_4_37, 
        flaw.c3_4_37,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "", 
        " Fisuri si/sau crapaturi ale betonului:- trans.: <0.2 mm",
        "6-7",
        flaw.c1_5_37,  
        flaw.c2_5_37, 
        flaw.c3_5_37,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
     
      sheet.add_row [
        "", 
        "Fisuri si/sau crapaturi ale betonului: -inclinate: >0.2 mm",
        "8-9",
        flaw.c1_6_37,  
        flaw.c2_6_37, 
        flaw.c3_6_37,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "", 
        "Fisuri si/sau crapaturi ale betonului: -inclinate: <0.2 mm",
        "6-7",
        flaw.c1_7_37,  
        flaw.c2_7_37, 
        flaw.c3_7_37,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "", 
        "- fisuri transverale sau longitudinale precum si intre timpane si zidul intors la podurile boltite",
        "4-6 fara deplasari",
        flaw.c1_8_37,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "", 
        "",
        "7-8 cu deplasari",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "38", 
        "Fisuri sau crapaturi in imbracaminte (asfaltica sau din beton de ciment),\n faiantarea sau exfolierea acesteia.",
        "Pentru suprafete:\n<1 m2  3\n >1 m2  4 – 5",
        "",  
        "", 
        "",
        "",
        flaw.c5_38
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "39", 
        "Fisuri si/sau crapaturi la intradosul podurilor boltite din\n zidarie.",
        "4 – 6 fara deplasari\n 7 – 8 cu deplasari",
        flaw.c1_39,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "40", 
        "Fisuri, ruperi ale elementelor structurale si/sau ale\n elementelor de prindere (nituri, suruburi, conectori, sudura).",
        "<20%  5 – 6\n 20% - 50%  7 – 8\n >50% si sudura 9-10",
        flaw.c1_40,  
        flaw.c2_40, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "41", 
        "Flambajul barelor sau voalarea totala.",
        "8-9",
        flaw.c1_41,  
        flaw.c2_41, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "42", 
        "Parapet cu geometrie generala necorespunzatoare in plan\n vertical si/sau orizontal, sistem de protectie degradat (matuit,\n puncte de rugina, exfolieri etc.).",
        "2 – 3\n numai daca nu exista\n deformatii ale\n structurii de rezistenta",
        "",  
        "", 
        "",
        "",
        flaw.c5_42
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "43", 
        "Inclinarea pendulilor, neconcordanta cu temperatura ambianta.",
        "5-7",
        "",  
        "", 
        flaw.c3_43,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "44", 
        "Infiltratii, eflorescente.",
        "Pentru suprafete:\n < 5 m2   5 – 6\n > 5 m2     7",
        flaw.c1_44,  
        flaw.c2_44, 
        flaw.c3_44,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "45", 
        "Infiltratii vizibile la intrados, pete umede, eflorescente,\n stalactite la podurile boltite din zidarie.",
        "Pentru suprafete:\n < 5 m2   5 – 6\n  > 5 m2     7",
        flaw.c1_45,  
        flaw.c2_45, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "46", 
        "Neasigurarea pantei de scurgere a apelor pe pod.",
        "3-5",
        "",  
        "", 
        "",
        "",
        flaw.c5_46
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "47", 
        "Lipsa lucrarilor de aparare maluri si/sau pentru dirijarea a\n apelor sau necorelarea acestora cu ele unor constructii din\n aproprierea podului (poduri CF, canale etc.)",
        "4 – 6 (Pentru lipsa)\n 8 Daca exista tendinta de rupere\n a malurilor",
        "",  
        "", 
        "",
        flaw.c4_47,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]
      sheet.add_row [
        "48", 
        "Lipsa sau degradarea parapetului de siguranta si/sau a unor\n elemente din parapetul podului.",
        "4–6 (Ptr degradari)\n 7 (Pentru lipsa)",
        "",  
        "", 
        "",
        "",
        flaw.c5_48
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "49", 
        "Lipsa protectiei anticorozive sau degradarea celei existente\n (culoare neuniforma, matuiri, exfolieri, pete de rugina,\n scurgeri de oxidare de fier pe suprafata elementului).",
        "3-4",
        flaw.c1_49,  
        flaw.c2_49, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "50", 
        "Lipsa sau degradarea dispozitivului de acoperire a rostului, a dispozitivelor de colectare si evacuare a apei, a elementelor de etansare, infiltratii in zona rostului.",
        "4–6 (Pentru degradari)",
        "",  
        "", 
        "",
        "",
        flaw.c5_50
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "", 
        "Lipsa protectiei anticorozive sau degradarea celei existente\n (culoare neuniforma, matuiri, exfolieri, pete de rugina,\n scurgeri de oxidare de fier pe suprafata elementului).",
        "7-8 (Pentru lipsa)",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]

      sheet.add_row [
        "51", 
        "Lipsa sau degradarea etansarii dintre imbracaminte si\n celelalte elemente ale caii (borduri, guri de scurgere, parapete, rosturi etc.)\n prezenta apei sau a altor materiale in goluri de sub trotuar.",
        "4–5 (Pentru degradari)\n 6 (Pentru lipsa)",
        "",  
        "", 
        "",
        "",
        flaw.c5_51
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]

      sheet.add_row [
        "52", 
        "Lipsa sau iesirea din functiune a dispozitivelor de protectie la actiuni seismice.",
        "5-6 Pentru iesire din\n functiune si lipsa\n pentru zonele D, E",
        "",  
        "", 
        "",
        "",
        flaw.c3_52
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "", 
        "",
        "7 Pentru lipsa zonelor\n A, B, C",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "53", 
        "Lipsa sau degradarea lucrarilor de protectie a taluzurilor,\n scarilor de acces, casiurilor santurilor pereate de la piciorul\n taluzurilor, racordare defectuoasa, casiu cu bordura de pe\n culee.",
        "3-4 Pentru degradari\n 5 Pentru lipsa sau racordare\n defectuoasa",
        "",  
        "", 
        "",
        flaw.c4_53,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]
      sheet.add_row [
        "54", 
        "Modificarea exagerata a formei si proprietatilor fizico-\n mecanice ale betonului.",
        "8-9",
        flaw.c1_54,  
        "", 
        flaw.c3_54,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, bold_border_style, nil, nil]

      sheet.add_row [
        "55", 
        "Modificari ale regimului hidraulic, coborarea etiajului in\n zona podului, adancirea talvegului.\n Δh = adancire talveg",
        "4-5 pentru Δh<1 m la fundatii\n directe si Δh≤2 la\n fundatii indirecte",
        "",  
        "", 
        "",
        flaw.c4_1_55,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]
      sheet.add_row [
        "", 
        "",
        "6-7 pentru Δh=1÷2 m la fundatii\n directe si Δh=2÷4 la\n fundatii indirecte",
        "",  
        "", 
        "",
        flaw.c4_2_55,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]
      sheet.add_row [
        "", 
        "",
        "8-9 pentru Δh>2 m la\n fundatii directe si Δh>4 la\n fundatii indirecte",
        "",  
        "", 
        "",
        flaw.c4_3_55,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]

      sheet.add_row [
        "56", 
        "Neetanseitati intre elementele structurii sau intre piese ale\n elementelor structurale.",
        "5-6",
        flaw.c1_56,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]

      sheet.add_row [
        "57", 
        "Neprotejarea ancorajelor fascicolelor la elementele\n precomprimate.",
        "5-6",
        flaw.c1_1_57,  
        flaw.c2_1_57, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "",
        "Infiltratii de-a lugul armaturii pretensionate.", 
        "8",
        flaw.c1_2_57,  
        flaw.c2_2_57, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]

      sheet.add_row [
        "58", 
        "Pozitia incorecta a elementelor componente ale aparatelor de\n reazem.",
        "5-6 fara deplasari",
        "",  
        "", 
        flaw.c3_58,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "",
        "", 
        "7-8 cu deplasari ale\n suprastructurii",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]

      sheet.add_row [
        "59",
        "Prezenta vegetatiei pe elementele infrastructurii.", 
        "2-3",
        "",  
        "", 
        flaw.c3_59,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "60",
        "Prezenta vegetatiei pe elementele suprastructurii.", 
        "4-4",
        flaw.c1_60,  
        flaw.c2_60, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]

      sheet.add_row [
        "61",
        "Rampe de acces degradate: denivelari si degradari ale caii;", 
        "4-5",
        "",  
        "", 
        "",
        flaw.c4_1_61,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]
      sheet.add_row [
        "",
        "Rampe de acces degradate: tasari mari ale terasamentelor, alunecari laterale", 
        "6-7",
        "",  
        "", 
        "",
        flaw.c4_2_61,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]
      
      sheet.add_row [
        "62",
        "Reducerea pronuntata a sectiunii elementelor datorita\n coroziunii metalului (peste 10%).", 
        "8 – 9 pentru C2\n 10 pentru C1",
        flaw.c1_62,  
        flaw.c2_62, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "63",
        "Rosturi decolmatate (in cazul imbracamintilor din pavele sau\n din beton de ciment) uzura pavelelor (rotunjire, slefuire) sau\n a imbracamintii din beton de ciment.", 
        "3-4",
        "",  
        "", 
        "",
        "",
        flaw.c5_63
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]

      sheet.add_row [
        "64",
        "Rosturi de zidarie spalate de infiltratii.", 
        "4-5 pentru C3\n 6 pentru C1",
        flaw.c1_64,  
        "", 
        flaw.c3_64,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "65",
        "Dispozitive de acoperire a rosturilor de dilatatie grav\n deteriorate, blocarea deplasarii din zona rostului.", 
        "7-8",
        "",  
        "", 
        "",
        "",
        flaw.c5_65
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "66",
        "Dispozitive de acoperire a rosturilor necorespunzatoare, cu\n elemente de fixare, denivelate in plan orizontal si/sau\n vertical.", 
        "5-6",
        "",  
        "", 
        "",
        "",
        flaw.c5_66
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "67",
        "Segregarea betonului, cuiburi de pietris, caverne.", 
        "4 – 5 pentru C3\n 5 – 6 pentru C2\n 6 pentru C1",
        flaw.c1_67,  
        flaw.c2_67, 
        flaw.c3_67,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "68",
        "Solidarizari necorespunzatoare intre elementele prefabricate\n (infiltratii, fisuri, rosturi matate necorespunzator).", 
        "5-6 Rosturi matate\n necorespunzator\n 6 – 7 Infiltratii",
        flaw.c1_68,  
        flaw.c2_68, 
        flaw.c3_68,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "69",
        "Spatiul liber sub pod si/sau debuseu insuficient, amplasarea\n necorespunzatoare a instalatiilor suspendate pe pod, lipsa\n contrasinelor la pasajele superioare.", 
        "4-5 Spatiu liber\n (inclusiv gabaritelor) insuficient\n 6 Debuseu    insuficient, lipsa contrasine\n la pasaje superioare",
        "",  
        "", 
        "",
        flaw.c4_69,
        ""
      ], style: [nil, nil, nil, nil, nil, nil, bold_border_style, nil]
      sheet.add_row [
        "70",
        "Torsiunea elementelor structurale, neplaneitatea acestora sau elemente insuficiente de solidarizare.", 
        "7-8",
        flaw.c1_70,  
        flaw.c2_70, 
        flaw.c3_70,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "",
        "", 
        "",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "71",
        "Uzura zidariei sau betonului", 
        "4-6",
        flaw.c1_71,  
        "", 
        flaw.c3_71,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "72",
        "Zidarie degradata la suprafata, cu aspect prafos, friabila sau exfoliata.", 
        "3-4 pentru C3\n 5 pentru C1",
        flaw.c1_72,  
        "", 
        flaw.c3_72,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "73",
        "Zidarie avariata (degradari importante cu dislocari de\n moloane), care trebuie injectata sau camasuita.", 
        "8-9",
        "",  
        "", 
        flaw.c3_73,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "74",
        "Zone inaccesibile pentru control si intretinere „cutii de apa”\n si/sau praf.", 
        "5-6",
        flaw.c1_74,  
        flaw.c2_74, 
        flaw.c3_74,
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, bold_border_style, bold_border_style, nil, nil]
      sheet.add_row [
        "75",
        "Degradarea ursilor; crapaturi, atac biologic, (putrezire,\n ciuperci, paraziti etc.) reducerea sectiunii acestora.", 
        "Reducerea sectiune\n ≤ 20% - 4 – 6\n 20-50% - 7 – 8\n > 50% - 9 – 10",
        flaw.c1_75,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "76",
        "Deformatia exagerata verticala sau orizontala a ursilor si/sau\n pachetelor de ursi sau subursi.", 
        "6-8",
        flaw.c1_76,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "77",
        "Ursi suprapusi sau cu pene fara rost de aerisire sau cu pene\n care se misca in locasurile lor.", 
        "4-6",
        flaw.c1_77,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "78",
        "Degradarea injugurilor de ursi, solidarizarilor\n necorespunzatoare sau inexistente.", 
        "4-6",
        flaw.c1_78,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "79",
        "Coroziunea elementelor metalice de prindere (buloane,\n tiranti, scoabe etc.).", 
        "4-6 Pentru buloane\n si scoabe\n 7-8 pentru tiranti",
        flaw.c1_79,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]
      sheet.add_row [
        "80",
        "Degradarea dulapilor, lipsa montantilor, a diagonalelor sau\n cedarea imbinarilor, ruginirea cuielor de prindere in cazul\n grinzilor alcatuite din dulapi.", 
        "6-8",
        flaw.c1_80,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, bold_border_style, nil, nil, nil, nil]

      sheet.add_row [
        "81",
        "Degradarea podinei de rezistenta (mucegai, crapaturi, atac insecte etc.).", 
        "Pentru suprafete:",
        "",  
        flaw.c2_81, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "",
        "", 
        "≤ 30% - 4 – 6",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "",
        "", 
        "30-60% - 7 – 8",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "",
        "", 
        "> 60% - 9 – 10",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, bold_border_style, nil, nil, nil]

      sheet.add_row [
        "82",
        "Podina de rezistenta cu tendinta de ridicare, denivelata\n datorita uscarii lemnului sau prinderii necorespunzatoare.", 
        "3-5",
        "",  
        flaw.c2_82, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "83",
        "Elementele componente ale podinei de rezistenta lipsa sau\n fixate necorespunzarator.", 
        "4-6",
        "",  
        flaw.c2_83, 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, bold_border_style, nil, nil, nil]
      sheet.add_row [
        "84",
        "Ridicarea pilotilor", 
        "4",
        "",  
        "", 
        flaw.c3_84,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "85",
        "Degradarea biologica a elementelor din lemn (piloti, babe,\n dulapi de la culei si/sau aripi) cedarea ancorajelor.", 
        "4-6",
        "",  
        "", 
        flaw.c3_85,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "86",
        "Incovoieri mari ale babelor.", 
        "4-6",
        "",  
        "", 
        flaw.c3_86,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "87",
        "Palee instabila.", 
        "6-8",
        "",  
        "", 
        flaw.c3_87,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "88",
        "Lipsa sau degradarea spargheturilor (unde sunt necesare).", 
        "4-6",
        "",  
        "", 
        flaw.c3_88,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "89",
        "Lipsa sau degradarea contravantuirilor, contrafiselor sau\n moazelor.", 
        "5-7",
        "",  
        "", 
        flaw.c3_89,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]

      sheet.add_row [
        "90",
        "Degradarea pilotilor in zona de contact cu terenul sau a\n etiajului.", 
        "Reducerea sectiunii",
        "",  
        "", 
        flaw.c3_90,
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "",
        "", 
        "≤ 20% - 4 – 6",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "",
        "", 
        "20-50% - 7 – 8",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]
      sheet.add_row [
        "",
        "", 
        "> 50% - 9 – 10",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, bold_border_style, nil, nil]

      sheet.add_row [
        "91",
        "Lipsa sau degradarea podinei de uzura", 
        "Suprafata afectata",
        "",  
        "", 
        "",
        "",
        flaw.c5_91
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "",
        "", 
        "≤ 30% - 3 – 4",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "",
        "", 
        "> 30% - 5 – 6",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]

      sheet.add_row [
        "92",
        "Imbracaminte din asfalt: -       fisurata, crapata", 
        "3 – 4",
        "",  
        "", 
        "",
        "",
        flaw.c5_92
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "",
        "Imbracaminte din asfalt: -       cu denivelari", 
        "5 – 6",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]

      sheet.add_row [
        "93",
        "Desprinderea elementelor ce alcatuiesc podina de uzura\n ( lemnarie ecaristata sau semirotunda).", 
        "3-4",
        "",  
        "", 
        "",
        "",
        flaw.c5_93
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "94",
        "Degradarea sau lipsa longrinei apara-roata sau a longrinelor\n de trotuar.", 
        "3-4",
        "",  
        "", 
        "",
        "",
        flaw.c5_94
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "95",
        "Degradarea sau lipsa podinei de trotuar.", 
        "3-4",
        "",  
        "", 
        "",
        "",
        flaw.c5_95
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "96",
        "Lipsa sau degradarea mainii curente a parapetului sau umpluturii.", 
        "5-6",
        "",  
        "", 
        "",
        "",
        flaw.c5_96
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]
      sheet.add_row [
        "97",
        "Lipsa sau degradarea stalpilor parapetului, prinderea necorespunzatoare a acestora de elementele de sustinere.", 
        "3-5",
        "",  
        "", 
        "",
        "",
        flaw.c5_97
      ], style: [nil, nil, nil, nil, nil, nil, nil, bold_border_style]

      sheet.add_row [
        "C1(*) = Suprastructura – elemente principale de rezistenta.",
        "", 
        "Nr. de defecte N",
        flaw.nr_defecte_c1,  
        flaw.nr_defecte_c2, 
        flaw.nr_defecte_c3,
        flaw.nr_defecte_c4,
        flaw.nr_defecte_c5
      ], style: [nil, nil, nil, nil, nil, nil, nil, nil]
      sheet.add_row [
        "C2(*) = Elemente de rezistenta care sustin calea.",
        "", 
        "",
        "",  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, nil, nil, nil]

      sheet.add_row [
        "C3(*) = Infrastructuri, ap de reazem, disp. antiseismice, sferturi de con sau aripi.",
        "", 
        "Depunct. maxima Di",
        flaw.depunct_max_di_c1,  
        flaw.depunct_max_di_c2, 
        flaw.depunct_max_di_c3,
        flaw.depunct_max_di_c4,
        flaw.depunct_max_di_c5
      ], style: [nil, nil, nil, nil, nil, nil, nil, nil]
      sheet.add_row [
        "C4(*) = Albia, apar. de mal, rampe de acces, instal pozate sau suspendate pe pod.",
        "", 
        "Val. indice Ci=10-Di",
        flaw.val_indice_c1,  
        flaw.val_indice_c2, 
        flaw.val_indice_c3,
        flaw.val_indice_c4,
        flaw.val_indice_c5
      ], style: [nil, nil, nil, nil, nil, nil, nil, nil]
      sheet.add_row [
        "C5(*) = Calea podului, guri de scurgere, trotuare, parapete, rosturi",
        "", 
        "Indice total de calitate C",
        flaw.indice_total_calitate,  
        "", 
        "",
        "",
        ""
      ], style: [nil, nil, nil, nil, nil, nil, nil, nil]
      
    end
  end
end