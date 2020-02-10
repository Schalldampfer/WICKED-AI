// This file is not loaded unless the OverWatch mod is detected.

// OverWatch Weapons & Vehicles

ow_camel			 = ["CYBP_Camel_us","CYBP_Camel_rus","CYBP_Camel_civ"];
ow_patrol			 = ["Copcar","Copcarhw","Copcarswat","CVPI_Patrol","CVPI_Trooper_Patrol","CVPI_TrooperSL_Patrol","CVPI_NYPD_Patrol","CVPI_HighwaySL_Patrol","CVPI_UnmarkedB_Patrol","CVPI_UnmarkedG_Patrol","CVPI_LAPD_Patrol","CVPI_UnmarkedW_Patrol","CVPI_LAPDSL_Patrol","CVPI_NYPDSL_Patrol"];
ow_350z				 = ["350z","350z_red","350z_kiwi","350z_black","350z_silver","350z_green","350z_blue","350z_gold","350z_white","350z_pink","350z_mod","350z_ruben","350z_v","350z_city","350z_yellow"];
ow_civcar			 = ["Civcar","Civcarbu","civcarbl","Civcarre","Civcarge","Civcarwh","Civcarsl"];

civil_vehicles		 = civil_vehicles + ow_350z + ow_civcar;
crate_ammo_good		 = crate_ammo_good + ["FHQ_rem_7Rnd_338Lapua_MSR_NT","FHQ_rem_5Rnd_300Win_XM2010_NT","vil_10Rnd_762x54_SV","vil_20Rnd_9x39_SP6ns_OC","RH_20Rnd_762x51_SD_hk417","FHQ_rem_30Rnd_680x43_ACR"];
crate_ammo_cheap	 = crate_ammo_cheap + ["gms_k98_mag","panzergrenade","vil_10Rnd_762x39_SKS","FHQ_rem_30Rnd_680x43_ACR"];

ai_wep_special_cheap = ai_wep_special_cheap + ["FHQ_ACR_BLK_IRN","RH_hk416","RH_hk417"];
ai_wep_special_good	 = ai_wep_special_good + ["FHQ_ACR_BLK_IRN_SD_F","vil_9a91_c","vil_AK_74M_N","vil_Abakan_P29","vil_M76","vil_VSS_N","FHQ_ACR_BLK_HAMR","DDOPP_X26"];
ai_wep_special_rare	 = ai_wep_special_rare + ["FHQ_ACR_BLK_HAMR_SD_F","RH_hk417sd","USSR_cheytacM200","vil_M110","vil_PKM_N","vil_SR25","vil_SVDK","vil_SVU_A","vil_SV_98_69","FHQ_MSR_DESERT","DDOPP_X3","RH_Deagleg","RH_anacg"];
ai_wep_special_delux = ai_wep_special_delux + ["FHQ_ACR_BLK_TWS","FHQ_MSR_NV_DESERT","FHQ_MSR_NV_SD_DESERT","FHQ_XM2010_NV_DESERT","FHQ_XM2010_NV_SD_DESERT"];//["FHQ_MSR_TWS_DESERT","FHQ_XM2010_TWS_DESERT"];

ai_wep_ak = ai_wep_ak + ["vil_ak12","vil_PMI74S","vil_type88_1","vil_M70","vil_M70B","vil_M64","vil_ASH82","vil_AMD","vil_AMD63","vil_PMI","vil_PMIS","vil_MPi"];
ai_wep_sa58 = ai_wep_sa58 + ["vil_9a91_c"];
ai_wep_g36 = ai_wep_g36 + ["vil_HK33","vil_G3a3"];
ai_wep_m4 = ai_wep_m4 + ["FHQ_ACR_BLK_IRN"];
ai_wep_m16 = ai_wep_m16 + ["RH_m1s"];
ai_wep_scar = ai_wep_scar + ["RH_hk416","RH_hk417"];
ai_wep_l85 = ai_wep_l85 + ["vil_Galil","vil_uzi"];

ai_wep_assault		 = ai_wep_g36 + ai_wep_m16 + ai_wep_m4 + ai_wep_scar + ai_wep_sa58 + ai_wep_l85 + ai_wep_ak;
ai_wep_machine		 = ai_wep_machine + ["vil_Mg3","vil_RPK74M_P29","vil_RPK74M_N"];
ai_wep_sniper		 = ai_wep_sniper + ["RH_m21","vil_SV_98","vil_SVD_P21","vil_vsk94"];
ai_wep_owpistol		 = ai_wep_pistol + ["RH_anac","RH_bull","RH_deagle","RH_mk2","RH_python","RH_tt33"];
ai_wep_random		 = [ai_wep_g36,ai_wep_m16,ai_wep_m16,ai_wep_m4,ai_wep_scar,ai_wep_sa58,ai_wep_l85,ai_wep_ak,ai_wep_ak,ai_wep_ak,ai_wep_machine,ai_wep_sniper];
ai_wep_weak			 = ai_wep_weak + ["gms_k98_rg","vil_SKS"];

diag_log "WAI: Overpoch Config File Loaded";