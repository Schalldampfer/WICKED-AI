// This file is not loaded unless the Origins mod is detected.

// Origins Weapons & Vehicles

waitUntil{!isNil "WAIconfigloaded"};
waitUntil {WAIconfigloaded};

ai_wep_or_assault	 = ["AEK_973s",'AEK_971'];

armed_vehicle 				= armed_vehicle + ["SUV_Special","SUV_MG_Ori","ori_transit","Ori_car_turrets","Ori_car_turrets2","ori_originsmod_pickupold"];
armed_chopper 				= armed_chopper + ["ORI_gunship_helicopter"];
civil_chopper 				= civil_chopper + ["ori_pragaCopter_yellow","ori_pragaCopter_green","vil_ori_autogyro"];
cargo_trucks 				= cargo_trucks + ["ori_excavator","ori_titanic","ori_survivorBus","ori_vil_originsmod_truck_civ","ori_vil_originsmod_lublin_truck"];
refuel_trucks				= refuel_trucks + ["ori_originsmod_pickupoldfuel"];
civil_vehicles 				= civil_vehicles + ["ori_KaTransp","ori_maniac","ori_m3","ori_buchanka","ori_taviander","ori_ZAZ968M","ori_poldek_black","ori_poldek","ori_vil_lada_2105_rust","ori_ScrapBuggy","ori_scrapTank","ori_vil_originsmod_volvo_fl290","ori_p85_originsmod_cucv_pickup","ori_p85_originsmod_CUCV","ori_rth_originsmod_bathmobile"];

ai_wep_pistol		 = ai_wep_pistol + ["RH_Deagles","RH_Deagleg","RH_deagle"];
ai_wep_random		 = [ai_wep_g36,ai_wep_m16,ai_wep_m16,ai_wep_m4,ai_wep_scar,ai_wep_sa58,ai_wep_l85,ai_wep_ak,ai_wep_ak,ai_wep_machine,ai_wep_sniper,ai_wep_or_assault];

diag_log "WAI: Origins Config File Loaded";