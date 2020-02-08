// This file is not loaded unless the Origins mod is detected.

// Origins Weapons & Vehicles

//armed_vehicle 				= ["SUV_MG_Ori","ori_transit","ori_originsmod_pickupold"];
//armed_chopper 				= ["ORI_gunship_helicopter"];
//civil_chopper 				= ["ori_pragaCopter_yellow","ori_pragaCopter_green","vil_ori_autogyro"];
//cargo_trucks 				= ["ori_excavator","ori_titanic","ori_survivorBus","ori_vil_originsmod_truck_civ","ori_originsmod_pickupoldfuel","ori_vil_originsmod_lublin_truck"];
//civil_vehicles 				= ["ori_KaTransp","ori_maniac","ori_m3","ori_buchanka","ori_taviander","ori_ZAZ968M","ori_poldek_black","ori_poldek","ori_vil_lada_2105_rust","ori_ScrapBuggy","ori_scrapTank","ori_vil_originsmod_volvo_fl290","ori_p85_originsmod_cucv_pickup","ori_p85_originsmod_CUCV","ori_rth_originsmod_bathmobile"];
//improved_vehicles			= ["ori_dc3","ori_ScrapRaft","ori_smallRaft","ori_bigRaft","ori_submarine"]
//upgrades = ["ori_titanic","ori_survivorBus"];

armed_vehicle 				= armed_vehicle + ["ori_transit","ori_originsmod_pickupold"];
cargo_trucks 				= cargo_trucks + ["ori_excavator","ori_vil_originsmod_volvo_fl290","ori_vil_originsmod_truck_civ","ori_originsmod_pickupoldfuel","ori_vil_originsmod_lublin_truck"];
civil_chopper 				= civil_chopper + ["ori_pragaCopter_yellow","ori_pragaCopter_green","vil_ori_autogyro"];
improved_vehicles			= improved_vehicles + ["ORI_gunship_helicopter"];
civil_vehicles 				= civil_vehicles + ["ori_KaTransp","ori_maniac","ori_m3","ori_buchanka","ori_taviander","ori_ZAZ968M","ori_poldek_black","ori_poldek","ori_vil_lada_2105_rust","ori_p85_originsmod_cucv_pickup","ori_p85_originsmod_CUCV"];

ai_wep_or_assault	 = ["AEK_973s","AEK_971"];
ai_wep_pistol		 = ai_wep_pistol + ["RH_deagle"];

if (isClass (configFile >> "CfgWeapons" >> "swat")) then {
	armed_vehicle		 = armed_vehicle + ['UAZ_MG_Ori','Offroad_MG_Ori','LandRover_MG_Ori','Pickup_PK_Ori'];
	armed_chopper 		 = armed_chopper + ["Ka60c_Ori","MH60S_Ori","Mi17_Ori"];
	ai_wep_or_assault	 = ai_wep_or_assault + ['VSS_Ori','ori_ak_camo','RH_rk95','AAW_f88_A1','SteyrF88','type89','AKS_74U_BZT75C'];
	ai_wep_pistol		 = ai_wep_pistol + ['Ori_cz83','Ori_cz75','ori_autocrossbowH',"RH_Deagles","RH_Deagleg","RH_deagle"];
	ai_wep_sniper		 = ai_wep_sniper + ['ado_GM_762','ado_frf2','type64sp'];
	ai_wep_weak			 = ai_wep_weak + ['gms_mp40','Ori_PPS43','Ori_Sa48SMG','Ori_mossberg','ori_shotgun2','ori_vil_uzi_rozkl','ori_autocrossbow','mak_BZT75C'];
	//ai_special_skin	 = ["LastKing"];
	ai_bandit_skin		 = ai_bandit_skin + ["vil_bdu_hood_woman","ori_traider_1"];
	ai_hero_skin		 = ai_hero_skin + ["vil_bdu_cap_woman","vil_woman_cop","vil_stskin1","vil_stskin2","vil_stskin4","vil_stskin5","vil_stskin6"];
	ai_wep_special_cheap = ai_wep_special_cheap + ['mak_BZT75C','AKS_74U_BZT75C'];
	//ai_wep_special_good	 = ai_wep_special_good + ["RH_Deagles","RH_Deagleg"];
	ai_wep_special_rare	 = ai_wep_special_rare + ['swat','Planshet','dak_mak_wantRifle'];
	//ai_wep_special_delux = ai_wep_special_delux + [];
};

ai_wep_random		 = [ai_wep_g36,ai_wep_m16,ai_wep_m4,ai_wep_scar,ai_wep_sa58,ai_wep_l85,ai_wep_ak,ai_wep_machine,ai_wep_sniper,ai_wep_or_assault,ai_wep_or_assault,ai_wep_weak];

diag_log "WAI: Origins Config File Loaded";