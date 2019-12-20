/* GENERAL CONFIG */

wai_debug_mode		 = false; // enable debug
wai_user_spawnpoints = false; // setting this to true will disable the dynamic mission spawning system and enable server owners to define their own mission spawn points in WAI\configs\spawnpoints.sqf.
wai_use_blacklist	 = true; // You can edit the blacklist per map in file WAI\configs\blacklist.sqf.

/* END GENERAL CONFIG */
	
/* AI CONFIG */
ai_multiplier		 = 1; // To increase the number of ai per mission use a larger number. Be careful. Tons of ai affect server performance.
ai_show_count		 = true; //this will show the ai count in the mission markers.
ai_hasMoney			 = true; //If you have ZSC installed then setting this to true will place random amounts of coins in 50 coin increments in ai wallets.
ai_moneyMultiplier	 = 100; //This value is multiplied by 50 to set the max amount of ZSC coins in AI wallets. ex. 200x50=10000 max coins.
ai_clear_body		 = false; // instantly clear bodies
ai_cleanup_time		 = 30; // time to clear bodies in minutes. Set to -1 to disable AI cleanup.
ai_clean_roadkill	 = false; // clean bodies that are roadkills
ai_rk_damageweapon	 = 0; // percentage of chance a roadkill will destroy weapon AI is carrying
ai_bandit_combatmode = "RED"; // combat mode of bandit AI
ai_bandit_behaviour	 = "COMBAT"; // behavior of bandit AI
ai_hero_combatmode	 = "RED"; // combat mode of hero AI
ai_hero_behaviour	 = "COMBAT"; // behavior of hero AI
ai_share_info		 = true; // AI share info on player position
ai_share_distance	 = 500; // distance from killed AI for AI to share your rough position
ai_kills_gain		 = true; // add kill to bandit/human kill score
ai_humanity_gain	 = true; // gain humanity for killing AI
ai_add_humanity		 = 50; // amount of humanity gained for killing a bandit AI
ai_remove_humanity	 = 50; // amount of humanity lost for killing a hero AI
ai_reward_veh_gunner = true; // Allows the gunner or "effectiveCommander" of a vehicle to get humanity and kill rewards
ai_killfeed			 = true; // Sends personal messages when the player kills an ai - may not be good for network performance

ai_skill_extreme	 = [["aimingAccuracy",1.00],["aimingShake",1.00],["aimingSpeed",1.00],["endurance",1.00],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];	// Extreme
ai_skill_hard		 = [["aimingAccuracy",0.90],["aimingShake",0.85],["aimingSpeed",0.90],["endurance",0.80],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];	// Hard
ai_skill_medium		 = [["aimingAccuracy",0.50],["aimingShake",0.75],["aimingSpeed",0.60],["endurance",0.70],["spotDistance",1.00],["spotTime",0.75],["courage",0.80],["reloadSpeed",0.80],["commanding",0.70],["general",0.70]];	// Medium
ai_skill_easy		 = [["aimingAccuracy",0.30],["aimingShake",0.40],["aimingSpeed",0.30],["endurance",0.50],["spotDistance",1.00],["spotTime",0.50],["courage",0.70],["reloadSpeed",0.70],["commanding",0.50],["general",0.50]];	// Easy
ai_skill_random		 = [ai_skill_extreme,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_easy];

ai_static_useweapon	 = false; // Allows AI on static guns to have a loadout 	
ai_static_weapons	 = ["DSHKM_Ins","DSHKM_Gue","KORD_high","M2StaticMG","BAF_L2A1_Minitripod_W_NoDisassembly","BAF_L2A1_Tripod_W_NoDisassembly"]; // static guns
ai_static_skills	 = false; // Allows you to set custom array for AI on static weapons. (true: On false: Off) 
ai_static_array		 = [["aimingAccuracy",0.20],["aimingShake",0.50],["aimingSpeed",0.50],["endurance",1.00],["spotDistance",1.00],["spotTime",0.75],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];

ai_gear0			 = [["ItemBandage","ItemHeatPack"],["ItemCrowbar"]];
ai_gear1			 = [["ItemBandage","FoodPistachio","ItemSodaPepsi"],["ItemRadio"]];
ai_gear2			 = [["ItemBandage"],["ItemToolbox","ItemKeyKit"]];
ai_gear3			 = [["HandGrenade_west","FoodCanFrankBeans","ItemWaterbottle"],["ItemCompass","ItemCrowbar"]];
ai_gear4			 = [["HandGrenade_east","ItemBandage","HandChemBlue","ItemAntibacterialWipe"],["ItemMachete","ItemGPS"]];
ai_gear_random		 = [ai_gear0,ai_gear0,ai_gear0,ai_gear1,ai_gear1,ai_gear2,ai_gear2,ai_gear3,ai_gear4];

// Weapons
ai_wep_g36			 = ["G36C_DZ","G36A_Camo_DZ","G36K_Camo_DZ","m8_carbine","m8_compact","m8_sharpshooter"];
ai_wep_m16			 = ["M16A2_DZ","M16A4_DZ","M16A4_CCO_DZ","M16A4_FL_DZ"];
ai_wep_m4			 = ["M4A1_DZ","M4A1_FL_DZ","M4A1_MFL_DZ","M4A1_CCO_DZ","M4A1_Holo_DZ"];
ai_wep_scar			 = ["FNFAL_DZ","SCAR_L_CQC","SCAR_L_CQC_CCO_SD","SCAR_L_CQC_Holo","SCAR_L_STD_HOLO","SCAR_L_STD_Mk4CQT","SCAR_H_CQC_CCO"];
ai_wep_sa58			 = ["AA12_PMC","SA58_DZ","SA58_RIS_FL_DZ","SA58_CCO_DZ","SA58_ACOG_DZ","evo_sd_ACR","CZ805_A1_ACR"];
ai_wep_l85			 = ["L85A2_DZ","L85A2_FL_DZ","L85A2_Holo_DZ","L85A2_ACOG_DZ","BAF_L85A2_RIS_SUSAT"];
ai_wep_ak 			 = ["AKS74U_DZ","AKS74U_Kobra_DZ","AK_47_S","AKM_DZ","AK74_DZ","AK74_Kobra_DZ","AK_107_CP","AKS_74_NSPU"];
ai_wep_machine		 = ["M8_SAW","M60A4_EP1_DZE","MG36_camo","MG36","BAF_L86A2_ACOG","L110A1_DZ","L110A1_CCO_DZ","L110A1_Holo_DZ","M249_DZ","M249_CCO_DZ","M249_Holo_DZ","M240_DZ","Mk48_DZ","Mk48_CCO_DZ","Mk48_Holo_DZ","RPK_DZ","RPK_Kobra_DZ","RPK_PSO1_DZ","UK59_DZ","PKM_DZ","BAF_L7A2_GPMG_Small"];
ai_wep_pistol		 = ["M9_DZ","G17_DZ","G17_FL_DZ","Makarov_DZ","Revolver_DZ","M1911_DZ","CZ_75_SP_01_PHANTOM"];
ai_wep_sniper		 = ["M14_DZ","CZ550_DZ","M24_DZ","M24_des_EP1","M40A3_DZ","SVD_DZ","SVD_des_EP1","L115A3_DZ","M4SPR_DZE","CZ_750_S1_ACR","CZ805_B_GL_ACR"];
ai_wep_weak			 = ["Sa61_EP1","PDW_DZ","UZI_SD_EP1","MP5_DZ","Bizon_DZ","MR43_DZ","Winchester1866_DZ","Remington870_DZ","M1014_DZ","Saiga12K","LeeEnfield_DZ","Mosin_DZ","RedRyder","Crossbow_DZ"];
ai_wep_tws			 = ["AKS_74_GOSHAWK","BAF_AS50_TWS","BAF_L85A2_RIS_TWS_DZ","M249_TWS_EP1_Small","m107_TWS_EP1_Small","m8_tws","m8_tws_sd","SCAR_L_STD_EGLM_TWS","SCAR_H_STD_TWS_SD","M110_TWS_EP1"];
ai_wep_assault	= ai_wep_g36 + ai_wep_m16 + ai_wep_m4 + ai_wep_scar + ai_wep_sa58 + ai_wep_l85 + ai_wep_ak;

// Random Weapons	 // By default, most of the mission crates and ai spawn weapons out of the group below. You can remove any weapon array entries from the list if you don't wish to include them.
ai_wep_random		 = [ai_wep_g36,ai_wep_m16,ai_wep_m16,ai_wep_m4,ai_wep_scar,ai_wep_sa58,ai_wep_l85,ai_wep_ak,ai_wep_ak,ai_wep_ak,ai_wep_machine,ai_wep_sniper];

ai_wep_launchers_AT	 = ["MAAWS","RPG18","M136"];
ai_wep_launchers_AA	 = ["Strela","Igla","Stinger"];

ai_packs			 = ["DZ_Czech_Vest_Pouch","DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_GunBag_EP1","DZ_CivilBackpack_EP1","DZ_Backpack_EP1","DZ_LargeGunBag_EP1"];
ai_hero_skin		 = ["Survivor2_DZ","Survivor3_DZ","SurvivorW2_DZ","SurvivorW3_DZ","Haris_Press_EP1_DZ","Soldier_Bodyguard_AA12_PMC_DZ"];
ai_bandit_skin		 = ["BanditW1_DZ","BanditW2_DZ","Bandit1_DZ","Bandit2_DZ","GUE_Soldier_MG_DZ","GUE_Soldier_Crew_DZ","GUE_Soldier_CO_DZ","GUE_Soldier_2_DZ","TK_INS_Soldier_EP1_DZ","Ins_Soldier_GL_DZ","Ins_Soldier_2_DZ"];
ai_special_skin		 = ["Functionary1_EP1_DZ","TK_Commander_EP1_DZ"];
ai_all_skin			 = [ai_hero_skin,ai_hero_skin,ai_bandit_skin,ai_bandit_skin,ai_special_skin];
ai_add_skin			 = false; // adds unit skin to inventory on death. Should set to false if you have takeclothes installed.

/* END AI CONFIG */

/* WAI MISSIONS CONFIG */
wai_mission_system		= true; // use built in mission system

wai_mission_markers		= ["maze","SEair","aiIsland","NEAF","SWAF","CMB"]; // List of DZMS mission markers to check
wai_avoid_samespot		= true; // Checks to see that a selected mission spawn point has not been used already - 200m check.
wai_avoid_missions		= 2000; // avoid spawning missions this close to other missions, these are defined in wai_mission_markers
wai_avoid_safezones		= 1000; // avoid spawning missions this close to safezones
wai_avoid_town			= 50; // avoid spawning missions this close to towns, *** doesn't function with infiSTAR enabled ***
wai_avoid_road			= 0; // avoid spawning missions this close to roads
wai_avoid_water			= 20; // avoid spawning missions this close to water
wai_avoid_players 		= 1500; // avoid spawning missions this close to a player
wai_avoid_plots			= DZE_PlotPole select 1; // avoid spawning missions near player plots

wai_mission_timer		= [2,7]; // time between missions. Default: 5-15 minutes
wai_mission_timeout		= [20,30]; // time each mission takes to timeout if inactive. Default: 15-30 minutes
wai_timeout_distance	= 1000; // if a player is this close to a mission then it won't timeout

wai_clean_mission_time	= 30; // time in minutes after a mission is complete to clean mission buildings. Set to -1 to disable mission cleanup. Default: 30 minutes
wai_clean_mission_crate	= false; // include the mission crates with the mission cleanup. If a player is within 75 meters of the crates the cleanup script will wait. Does not apply to missions that timeout.
wai_clean_when_clear	= ["Road Block","C130 Crash"]; // These mission names will get cleaned instantly overriding wai_clean_mission_time

wai_godmode_objects		= false; // prevents mission objects from taking damage
wai_mission_fuel		= [15,30]; // fuel inside mission spawned vehicles [min%,max%]
wai_vehicle_damage		= [30,50]; // damages to spawn vehicles with [min%,max%]
wai_keep_vehicles		= true; // save vehicles to database and keep them after restart
wai_godmode_vehicles	= true; // mission vehicles do not take damage until players enter them
wai_vehicle_keys		= "NoVehicleKey"; // Options: "KeyonAI", "KeyinVehicle", "KeyinCrate", "NoVehicleKey".
wai_vehicle_message		= true; // Shows a warning message to the player when entering a mission vehicle

wai_crates_smoke		= true; // pop smoke on crate when mission is finished during daytime
wai_crates_flares		= true; // pop flare on crate when mission is finished during nighttime

wai_players_online		= 1; // number of players online before mission starts
wai_server_fps			= 5; // missions only starts if server FPS is over wai_server_fps

wai_kill_percent		= 50; // percentage of AI players that must be killed at "crate" missions to be able to trigger completion

wai_high_value			= true; // enable the possibility of finding a high value item (defined below crate_items_high_value) inside a crate
wai_high_value_chance	= 20; // chance in percent you find above mentioned item
wai_num_mags 			= (3 + round(random 3)); // Number of magazines per weapon in the crate
wai_minimum_loot		= 0.8 + (random 0.2); // Number between .01 and 1. 1 = 100% loot based on loot definitions. To disable the feature set value less than or equal to 0 and you will automatically get 100% loot;

wai_enable_minefield	= false; // enable minefields to better defend missions
wai_enable_static_guns	= true; // Enables or disables static gun placements at missions that have them.
wai_enable_paradrops	= true; // Enables or disables paratrooper drops at missions that have them.
wai_enable_patrols		= true; // Enables or disables armored vehicle patrols at missions that have them.
wai_use_launchers		= true; // add a rocket launcher to each spawned AI group
wai_remove_launcher		= true; // remove rocket launcher from AI on death
wai_mission_announce	= "Radio"; // Options: "Radio", "DynamicText", "titleText"
wai_hero_limit			= 3; // define how many hero missions can run at once
wai_bandit_limit		= 3; // define how many bandit missions can run at once

// Mission Arrays
// [mission name, chance to spawn] Chance to spawn is 0-1. Example - If you only want your mission to have a 25% chance to spawn enter .25
wai_hero_missions = [
	["patrol",1],
	["black_hawk_crash",1],
	["armed_vehicle",1],
	["base",1],
	["captured_mv22",1],
	["scout_patrol",1],
	["ikea_convoy",1],
	["medi_camp",1],
	["broken_down_ural",1],
	["sniper_extraction",1],
	["mayors_mansion",1],
	["weapon_cache",1],
	["gem_tower",1],
	["cannibal_cave",1],
	["crop_raider",1],
	["drone_pilot",1],
	["slaughter_house",1],
	["drugbust",1],
	["armybase",1],
	["abandoned_trader",1],
	["lumberjack",1],
	["presidents_mansion",1],
	["tankcolumn",1],
	["macdonald",1],
	["radioshack",1],
	["junkyard",1],
	["outpost",1],
	["farmer",1],
	["firestation",1],
	["vehicle_drop",1]
];

wai_bandit_missions	= [
	["patrol",1],
	["black_hawk_crash",1],
	["armed_vehicle",1],
	["base",1],
	["captured_mv22",1],
	["scout_patrol",1],
	["ikea_convoy",1],
	["medi_camp",1],
	["broken_down_ural",1],
	["sniper_extraction",1],
	["mayors_mansion",1],
	["weapon_cache",1],
	["gem_tower",1],
	["cannibal_cave",1],
	["crop_raider",1],
	["drone_pilot",1],
	["slaughter_house",1],
	["drugbust",1],
	["armybase",1],
	["abandoned_trader",1],
	["lumberjack",1],
	["presidents_mansion",1],
	["tankcolumn",1],
	["macdonald",1],
	["radioshack",1],
	["junkyard",1],
	["outpost",1],
	["farmer",1],
	["firestation",1],
	["vehicle_drop",1]
];

// Vehicle arrays
pk_vehicle					= ["Pickup_PK_GUE_DZE","Pickup_PK_INS_DZE","Pickup_PK_TK_GUE_EP1_DZE"];
armed_vehicle 				= ["T810A_MG_ACR","T810A_Des_MG_ACR","LandRover_MG_TK_EP1_DZE","Offroad_DSHKM_Gue_DZE","BAF_Jackal2_GMG_D","BAF_Jackal2_L2A1_D","HMMWV_Armored_DZ","HMMWV_M2_DZ","HMMWV_MK19","HMMWV_M1151_M2_DES_EP1","HMMWV_M1151_M2_CZ_DES_EP1","M1114_AGS_ACR","M1114_DSK_ACR","UAZ_MG_TK_EP1_DZE","UAZ_AGS30_CDF","ArmoredSUV_PMC_DZE","BTR40_MG_TK_INS_EP1","BTR40_MG_TK_GUE_EP1","GAZ_Vodnik"];
armed_chopper 				= ["pook_H13_transport_TAK","pook_H13_transport_PMC","pook_H13_gunship_INS","pook_H13_gunship_PMC","AH6J_EP1","AH6J_EP1_DZE","UH1H_DZE","UH1H_2_DZE","UH1Y_DZE","MH60S_DZE","UH60M_EP1_DZE","Mi17_DZE","Mi17_TK_EP1_DZE","Mi17_UN_CDF_EP1_DZE","Mi17_CDF_DZE","Mi171Sh_CZ_EP1_DZ","CH_47F_EP1_DZE","CH_47F_BAF","Ka60_GL_PMC","CYBP_Camel_us","CYBP_Camel_rus"];
civil_chopper 				= ["pook_H13_civ","pook_H13_civ_ru_black","pook_H13_civ_ru_slate","pook_H13_medevac_CIV","AH6X_DZ","MH6J_DZ","BAF_Merlin_DZE","Mi17_Civilian_DZ","Mi17_medevac_CDF_DZ","Mi17_medevac_Ins_DZ","Mi17_medevac_RU_DZ","UH60M_MEV_EP1_DZ","CH53_DZE","MV22_DZ"];
military_unarmed 			= ["M113Ambul_TK_EP1","BMP2_Ambul_CDF","GAZ_Vodnik_MedEvac","HMMWV_Ambulance","HMMWV_Ambulance_CZ_DES_EP1","HMMWV_DES_EP1","HMMWV_DZ","HMMWV_M1035_DES_EP1","LandRover_CZ_EP1","UAZ_CDF","UAZ_INS","UAZ_RU","UAZ_Unarmed_TK_EP1","UAZ_Unarmed_UN_EP1","BTR40_TK_GUE_EP1","SUV_UN_EP1"];
cargo_trucks 				= ["Kamaz_DZE","KamazOpen_DZE","MTVR","MTVR_DES_EP1","Ural_CDF","Ural_TK_CIV_EP1","Ural_UN_EP1","UralCivil_DZE","UralCivil2_DZE","V3S_Civ","V3S_Open_TK_CIV_EP1","V3S_Open_TK_EP1","V3S_TK_EP1_DZE","V3S_RA_TK_GUE_EP1_DZE"];
refuel_trucks				= ["KamazRefuel_DZ","MtvrRefuel_DES_EP1_DZ","UralRefuel_TK_EP1_DZ","V3S_Refuel_TK_GUE_EP1_DZ","Ikarus","Ikarus_TK_CIV_EP1"];
civil_vehicles 				= ["Octavia_ACR","hilux1_civil_1_open_DZE","hilux1_civil_2_covered_DZE","hilux1_civil_3_open_DZE","car_hatchback","datsun1_civil_1_open_DZE","datsun1_civil_2_covered_DZE","datsun1_civil_3_open_DZE","UAZ_Unarmed_TK_CIV_EP1","LandRover_TK_CIV_EP1","SUV_Blue","SUV_Camo","SUV_Charcoal","SUV_Green","SUV_Orange","SUV_Pink","SUV_Red","SUV_Silver","SUV_TK_CIV_EP1","SUV_White","SUV_Yellow","car_sedan","Lada1","Lada2","Lada1_TK_CIV_EP1","Lada2_TK_CIV_EP1","S1203_TK_CIV_EP1","Skoda","SkodaBlue","SkodaRed","SkodaGreen","Volha_1_TK_CIV_EP1","Volha_2_TK_CIV_EP1","VolhaLimo_TK_CIV_EP1","VWGolf","S1203_ambulance_EP1"];
ai_armored_vehicles			= ["M113_TK_EP1","M113_PMC","BMP1_INS_CP","BTR60_Gue_CP","BTR60_TK_EP1","BRDM2_CDF","BRDM2_INS","BRDM2_Gue","BRDM2_TK_EP1","BRDM2_TK_GUE_EP1","BRDM2_ACR","BRDM2_Desert_ACR","M1126_ICV_M2_EP1","M1126_ICV_mk19_EP1","M1130_CV_EP1"];
ai_antiair_vehicles			= ["ZSU_INS","ZSU_CDF","ZSU_TK_EP1","ZSU_Gue_CP","HMMWV_Avenger","HMMWV_Avenger_DES_EP1"];
ai_armored_vehicles			= ["T34","T55_TK_GUE_EP1","BMP3","BAF_FV510_D","M6_EP1"];
spg9_vehicles				= ["Offroad_SPG9_TK_GUE_EP1","Offroad_SPG9_Gue","UAZ_SPG9_INS","LandRover_SPG9_TK_INS_EP1","LandRover_SPG9_TK_EP1"];
improved_vehicles			= ["T34_TK_GUE_EP1","BVP1_TK_GUE_ACR","BMP1_INS_CP","BVP1_TK_ACR","BVP1_TK_GUE_ACR","BRDM2_CDF","BRDM2_Gue","BRDM2_TK_EP1","BRDM2_TK_GUE_EP1","BRDM2_ATGM_CDF","BRDM2_ATGM_TK_EP1","GAZ_Vodnik_HMG","LAV25","AAV_cutscene","M1126_ICV_mk19_EP1","HMMWV_TOW_DES_EP1","Dingo_DST_ACR","Dingo_GL_DST_ACR","UAZ_SPG9_INS"];
super_vehicles				= ["T55_TK_EP1","T72_Gue","BMP2_ACR","BMP2_Des_ACR","BMP2_UN_EP1","BMP2_TK_EP1","BTR90","M1135_ATGMV_EP1","M1128_MGS_EP1","HMMWV_Avenger_DES_EP1","Ka52","Mi17_rockets_RU","MAZ_543_SCUD_TK_EP1"];

// Dynamic crate array
crates_large				= ["USVehicleBox_EP1","TKVehicleBox_EP1"];
crates_medium				= ["USBasicWeapons_EP1","USSpecialWeapons_EP1","TKSpecialWeapons_EP1","CZBasicWeapons_EP1","UNBasicWeapons_EP1"];
crates_small				= ["USOrdnanceBox_EP1","USLaunchers_EP1","USBasicWeapons_EP1","USBasicAmmunitionBox_EP1","UNBasicAmmunitionBox_EP1","TKOrdnanceBox_EP1","TKLaunchers_EP1","TKBasicAmmunitionBox_EP1","GuerillaCacheBox_EP1","GERBasicWeapons_EP1"];

// Crate Arrays
crate_weapons_buildables	= ["ChainSawB","ChainSawG","ChainSawP","ChainSawR"];
crate_tools					= ["ItemKeyKit","Binocular","ItemCompass","ItemCrowbar","ItemEtool","ItemFishingPole","ItemFlashlightRed","ItemHatchet","ItemKnife","ItemMachete","ItemMatchbox","ItemToolbox","NVGoggles"];
crate_tools_buildable		= ["ItemToolbox","ItemEtool","ItemCrowbar","ItemKnife","ItemShovel","ItemPickaxe","ItemSledge"];
crate_tools_sniper			= ["ItemCompass","Binocular_Vector","NVGoggles","ItemGPS","Laserdesignator","Mosin_BR_DZ"];

crate_items_misc			= ["ItemSilverBar","ItemSilverBar10oz","ItemBriefcaseS100oz","ItemBriefcaseS100oz","ItemGoldBar","ItemGoldBar","ItemGoldBar10oz","ItemGoldBar10oz","ItemBriefcase100oz"];
crate_items_high_value		= ["ItemBriefcase_Base","ItemBriefcase_Base","ItemBriefcase_Base",["ItemLockbox",4],"ItemVault","m240_nest_kit"];
crate_items_food			= ["bulk_ItemSodaCokeFull","bulk_ItemSodaPepsiFull","bulk_FoodbaconCookedFull","ItemWaterbottle",["FoodNutmix",3],["FoodPistachio",3],"FoodMRE","ItemSodaOrangeSherbet","ItemSodaRbull","ItemSodaR4z0r","ItemSodaMdew","FoodCanBakedBeans","FoodCanFrankBeans","FoodCanPasta","FoodCanSardines","FoodchickenCooked","FoodmuttonCooked","FoodrabbitCooked","FishCookedTrout","FishCookedTuna","FishCookedSeaBass"];
crate_items_buildables		= ["desert_net_kit","forest_net_kit","wood_shack_kit","half_cinder_wall_kit","metal_panel_kit","metal_panel_kit",["ItemCanvas",4],"ItemSandbagLarge",["CinderBlocks",3],["CinderBlocks",2],["CinderBlocks",2],["ItemLightBulb",3],"ItemLockbox","ItemComboLock","bulk_ItemSandbag","bulk_ItemTankTrap","bulk_ItemWire",["MortarBucket",4],["MortarBucket",3],["MortarBucket",2],"bulk_PartGeneric","bulk_PartGeneric",["PartPlankPack",5],["PartPlankPack",3],["PartPlywoodPack",3],["PartPlywoodPack",2],"equip_crate","equip_2inch_metal_pipe"];
crate_items_vehicle_repair	= ["PartEngine","PartEngine","PartFueltank","PartFueltank",["PartGeneric",2],["PartGeneric",2],["PartGeneric",3],["PartGeneric",4],["PartGlass",2],"PartVRotor",["PartWheel",2],["PartWheel",2],["PartWheel",2]];
crate_items_medical			= ["ItemWaterbottle","ItemWaterbottle","ItemAntibiotic","ItemBloodbag","ItemAntibacterialWipe","ItemAntibacterialWipe","ItemAntibacterialWipe","ItemEpinephrine","ItemHeatPack","ItemHeatPack","ItemMorphine","ItemMorphine","ItemPainkiller","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","equip_comfreyleafs","emptyBloodBag","transfusionKit"];
crate_items_chainbullets	= ["pook_1300Rnd_762x51_M60","pook_250Rnd_762x51","2000Rnd_762x51_M134","2000Rnd_762x51_M134","2000Rnd_762x51_L94A1","60Rnd_762x54_DT","60Rnd_762x54_DT","100Rnd_762x54_PK","100Rnd_762x54_PK","100Rnd_762x54_PK","200Rnd_762x51_M240","200Rnd_762x51_M240","200Rnd_762x51_M240","100Rnd_127x99_M2","100Rnd_127x99_M2","150Rnd_127x107_DSHKM","150Rnd_127x107_DSHKM","29Rnd_30mm_AGS30","48Rnd_40mm_MK19","3Rnd_GyroGrenade","pook_12Rnd_Grenade_Camel","PG9_AT","OG9_HE"];
crate_items_sniper			= [["5Rnd_17HMR",4],["5Rnd_17HMR",6],"10Rnd_9x39_SP5_VSS","5Rnd_86x70_L115A1","5Rnd_127x108_KSVK","10Rnd_127x99_m107","bulk_30Rnd_556x45_StanagSD",["5Rnd_762x51_M24",3],["5Rnd_762x51_M24",5],"20Rnd_762x51_DMR",["20Rnd_762x51_DMR",3],"10Rnd_762x54_SVD",["10Rnd_762x54_SVD",3],["5Rnd_762x54_Mosin",5],["5Rnd_762x54_Mosin",8],["1Rnd_HE_M203",3],["1Rnd_HE_GP25",3],"Attachment_Ghillie","Attachment_ACOG","Attachment_PSO1","Attachment_PSO1","Attachment_SCOPED","Attachment_SCOPED","Attachment_SCOPED","Attachment_GP25","Attachment_M203","Attachment_MFL","Attachment_MFL_Pist","Attachment_Sup545","Attachment_Sup556","Attachment_Sup9","Attachment_SupBizon","Attachment_SupMakarov","Laserbatteries"];
crate_items_president		= ["ItemBriefcase_Base","ItemBriefcase_Base","ItemBriefcase_Base"] + crate_items_food + crate_items_medical;
crate_items_gems			= ["ItemRuby","ItemCitrine","ItemEmerald","ItemAmethyst","ItemSapphire","ItemObsidian","ItemObsidian","ItemTopaz","ItemTopaz","ItemTopaz"];
crate_items_crop_raider		= ["ItemKiloHemp","ItemKiloHemp","ItemKiloHemp","ItemKiloHemp","ItemKiloHemp",["ItemCanvas",2],"ItemSandbag","FoodBioMeat"];
crate_items_wood			= [["ItemWoodFloorQuarter",4],"ItemWoodStairs",["ItemWoodLadder",2],["ItemWoodWallThird",3],"ItemWoodWallGarageDoor",["ItemWoodWallLg",2],"ItemWoodWallWithDoorLg",["PartPlankPack",12],["PartPlankPack",10],["PartPlankPack",10],["PartPlankPack",8],["PartPlankPack",8],["PartPlywoodPack",5],["PartPlywoodPack",4],["PartPlywoodPack",4],["PartPlywoodPack",3],["PartPlywoodPack",3],"ItemLog"];
crate_backpacks_all			= ["DZ_TerminalPack_EP1","DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_CompactPack_EP1","DZ_British_ACU","DZ_GunBag_EP1","DZ_CivilBackpack_EP1"];
crate_backpacks_large		= ["DZ_GunBag_EP1","DZ_Backpack_EP1","DZ_LargeGunBag_EP1","DZ_CivilBackpack_EP1"];

crate_items_maintains		= ["ItemLightBulb","MortarBucket",["MortarBucket",2],"PartGeneric",["PartGeneric",2],"PartPlankPack",["PartPlankPack",2],["PartPlankPack",3]];
crate_items_money			= crate_items_misc;
crate_items_skin			= ["Skin_Sniper1_DZ","Skin_Camo1_DZ","Skin_Soldier1_DZ","Skin_Survivor2_DZ","Skin_Rocket_DZ","Skin_RU_Policeman_DZ","Skin_Pilot_EP1_DZ","Skin_Haris_Press_EP1_DZ","Skin_Ins_Soldier_GL_DZ","Skin_GUE_Commander_DZ","Skin_Functionary1_EP1_DZ","Skin_Priest_DZ","Skin_Rocker1_DZ","Skin_Rocker2_DZ","Skin_Rocker3_DZ","Skin_Rocker4_DZ","Skin_Bandit1_DZ","Skin_Bandit2_DZ","Skin_GUE_Soldier_MG_DZ","Skin_GUE_Soldier_Sniper_DZ","Skin_GUE_Soldier_Crew_DZ","Skin_GUE_Soldier_CO_DZ","Skin_GUE_Soldier_2_DZ","Skin_BanditW1_DZ","Skin_BanditW2_DZ","Skin_SurvivorW3_DZ","Skin_SurvivorW2_DZ","Skin_SurvivorWpink_DZ","Skin_SurvivorWcombat_DZ","Skin_SurvivorWdesert_DZ","Skin_SurvivorWurban_DZ","Skin_TK_INS_Warlord_EP1_DZ",
							   "Skin_TK_INS_Soldier_EP1_DZ","Skin_CZ_Special_Forces_GL_DES_EP1_DZ","Skin_Drake_Light_DZ","Skin_Soldier_Bodyguard_AA12_PMC_DZ","Skin_FR_OHara_DZ","Skin_FR_Rodriguez_DZ","Skin_CZ_Soldier_Sniper_EP1_DZ","Skin_Graves_Light_DZ","Skin_Soldier_Sniper_PMC_DZ","Skin_Soldier_TL_PMC_DZ","Skin_TK_Special_Forces_MG_EP1_DZ","Skin_TK_Soldier_Sniper_EP1_DZ","Skin_TK_Commander_EP1_DZ","Skin_RU_Soldier_Crew_DZ","Skin_INS_Lopotev_DZ","Skin_INS_Soldier_AR_DZ","Skin_INS_Soldier_CO_DZ","Skin_INS_Bardak_DZ","Skin_INS_Worker2_DZ","Skin_USMC_Soldier_Officer_DZ","Skin_USMC_Soldier_MG_DZ","Skin_USMC_Soldier_Pilot_DZ","Skin_FR_TL_DZ","Skin_FR_R_DZ","Skin_FR_Marksman_DZ","Skin_FR_Assault_R_DZ","Skin_RU_Soldier_DZ",
							   "Skin_RU_Soldier_Officer_DZ","Skin_RUS_Soldier1_DZ","Skin_RUS_Commander_DZ","Skin_MVD_Soldier_DZ","Skin_Ins_Soldier_2_DZ","Skin_Ins_Commander_DZ","Skin_Ins_Soldier_Crew_DZ","Skin_CDF_Soldier_DZ","Skin_Assistant_DZ","Skin_Doctor_DZ","Skin_Worker1_DZ","Skin_Worker3_DZ","Skin_Worker4_DZ","Skin_TK_CIV_Takistani01_EP1_DZ","Skin_TK_CIV_Takistani03_EP1_DZ","Skin_TK_CIV_Takistani04_EP1_DZ","Skin_TK_CIV_Takistani06_EP1_DZ","Skin_TK_INS_Soldier_AR_EP1_DZ","Skin_TK_GUE_Soldier_EP1_DZ","Skin_CZ_Soldier_SL_DES_EP1_DZ","Skin_US_Soldier_EP1_DZ","Skin_UN_CDF_Soldier_EP1_DZ","Skin_UN_CDF_Soldier_Guard_EP1_DZ","Skin_GER_Soldier_TL_EP1_DZ","Skin_BAF_Soldier_Officer_MTP_DZ","Skin_BAF_Soldier_N_MTP_DZ","Skin_FR_Sapper_DZ"];
ai_wep_special_cheap		= ["G36K_Camo_DZ","SCAR_L_STD_Mk4CQT","SCAR_L_STD_EGLM_RCO","SCAR_H_CQC_CCO","SCAR_H_STD_EGLM_Spect","m8_holo_sd","BAF_L86A2_ACOG","L110A1_DZ","Mk48_DZ","UK59_DZ","M60A4_EP1_DZE","MG36","M79_EP1"];
ai_wep_special_good			= ["UZI_SD_EP1","SCAR_H_CQC_CCO_SD","FN_FAL_ANPVS4_DZE","AKS_74_NSPU","BAF_L85A2_RIS_CWS","VSS_vintorez_DZE","DMR_DZ","SCAR_H_LNG_Sniper","M4SPR_DZE","Mk13_EP1"];
ai_wep_special_rare			= ["AKS_GOLD","AKS_74_GOSHAWK","m8_tws","BAF_L85A2_RIS_TWS_DZ","SCAR_L_STD_EGLM_TWS","SCAR_H_LNG_Sniper_SD","Pecheneg_DZ","m240_scoped_EP1_DZE","M249_m145_EP1_DZE","M110_NVG_EP1","L115A3_DZ","L115A3_2_DZ","KSVK_DZE","m107_DZ","BAF_AS50_scoped_DZ","M32_EP1"];
ai_wep_special_delux		= ["SCAR_H_STD_TWS_SD","M249_TWS_EP1_Small","M110_TWS_EP1","BAF_AS50_TWS","m107_TWS_EP1","Anzio_20_DZ","LRTV_ACR"];
crate_ammo_cheap			= ["100Rnd_762x51_M240","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_762x39_AK47","30Rnd_762x39_AK47","30Rnd_545x39_AK","30Rnd_545x39_AK","30Rnd_545x39_AK","20Rnd_762x51_FNFAL","5Rnd_762x51_M24","5Rnd_17HMR","5Rnd_762x54_Mosin","10Rnd_303British","15Rnd_W1866_Slug","8Rnd_12Gauge_Buck","8Rnd_B_Saiga12_Pellets","30Rnd_9x19_MP5","6Rnd_45ACP","7Rnd_45ACP_1911","8Rnd_9x18_Makarov","15Rnd_9x19_M9","17Rnd_9x19_glock17","BAF_L109A1_HE","HandGrenade_west","HandGrenade_east","1Rnd_HE_M203","1Rnd_HE_GP25"];
crate_ammo_good				= ["20Rnd_762x51_B_SCAR","20Rnd_762x51_SB_SCAR","100Rnd_556x45_BetaCMag","200Rnd_556x45_M249","20Rnd_9x39_SP5_VSS","5Rnd_86x70_L115A1","5Rnd_127x108_KSVK","10Rnd_127x99_m107","3rnd_Anzio_20x102mm","30Rnd_9x19_UZI_SD","8Rnd_9x18_MakarovSD","bulk_15Rnd_9x19_M9SD","bulk_30Rnd_9x19_MP5SD","bulk_30Rnd_556x45_StanagSD","6Rnd_HE_M203","20Rnd_B_AA12_HE"];
ai_launcher_special_cheap	= ["RPG7V","M136","RPG18","SMAW","MAAWS","M47Launcher_EP1","Strela"];
ai_launcher_special_delux	= ["Javelin","MetisLauncher","BAF_NLAW_Launcher","Igla","Stinger"];

// Random Items				// By default, most of the mission crates spawn items out of the list of arrays below. You can remove or add any array entries in the list.
crate_items_random			= [crate_items_food,crate_items_vehicle_repair,crate_items_medical,crate_items_misc,crate_items_maintains,crate_items_maintains,crate_ammo_cheap];

/* END WAI MISSIONS CONFIG */

/* AUTO-CLAIM CONFIG */

use_wai_autoclaim			= true; // Turn on the auto-claim feature. You should increase wai_avoid_missions to more than the distance below
ac_alert_distance			= 1000; // Distance from the mission that auto-claim uses to alert closest player
ac_delay_time				= 30; // Time that the auto-claim waits until it declares a claim and places a marker - time in seconds
ac_timeout					= 180; // If the claimer leaves the mission area he/she has this much time to return - time in seconds

/* END AUTO-CLAIM CONFIG */

/* STATIC MISSIONS CONFIG */

wai_static_missions			= true; // use static mission file
wai_custom_per_world		= true;	// use a custom mission file per world

/* END STATIC MISSIONS CONFIG */

WAIconfigloaded = true;
