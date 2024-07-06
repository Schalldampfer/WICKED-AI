/* GENERAL CONFIG */
WAI_DebugMode = false; // enable debug
WAI_SpawnPoints = false; // setting this to true will disable the dynamic mission spawning system and enable server owners to define their own mission spawn points in WAI\configs\spawnpoints.sqf.
WAI_Blacklist = true; // You can edit the blacklist per map in file WAI\configs\blacklist.sqf.
/* END GENERAL CONFIG */
	
/* AI CONFIG */
WAI_ShowCount = true; //this will show the AI count in the mission markers.
WAI_HasMoney = true; //If you have ZSC installed then setting this to true will place random amounts of coins in 50 coin increments in ai wallets.
WAI_MoneyMultiplier = 250; //This value is multiplied by 50 to set the max amount of ZSC coins in AI wallets. ex. 200 x 50 = 10000 max coins.
WAI_ClearBody = false; // instantly clear bodies
DZE_NPC_CleanUp_Time = 45; // time to clear bodies in minutes. Set to -1 to disable AI cleanup. Universal variable used by other mission systems.
WAI_CleanRoadKill = false; // clean bodies that are roadkills
WAI_RkDamageWeapon = 1; // percentage of chance a roadkill will destroy weapon AI is carrying
WAI_BanditCombatMode = "RED"; // combat mode of bandit AI
WAI_BanditBehaviour = "SAFE"; // behavior of bandit AI
WAI_HeroCombatmode = "YELLOW"; // combat mode of hero AI
WAI_HeroBehaviour = "SAFE"; // behavior of hero AI
WAI_ShareInfo = true; // AI share info on player position
WAI_ShareDist = 300; // distance from killed AI for AI to share your rough position
WAI_KillsGain = true; // add kill to bandit/human kill score
WAI_HumanityGain = true; // gain humanity for killing AI
WAI_AddHumanity = 50; // amount of humanity gained for killing a bandit AI - set to 0 to disable
WAI_RemoveHumanity = -50; // amount of humanity lost for killing a hero AI - set to 0 to disable
WAI_RewardVehGunner = true; // Allows the gunner or "effectiveCommander" of a vehicle to get humanity and kill rewards
WAI_KillFeed = true; // Sends personal messages when the player kills an AI - may not be good for network performance
WAI_Caching = true; // Disables and hides AI if there are no players near to reduce server stress.

WAI_SkillExtreme = [["aimingAccuracy",1.00],["aimingShake",1.00],["aimingSpeed",1.00],["endurance",1.00],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00]]; //,["general",1.00]
WAI_SkillHard = [["aimingAccuracy",0.25],["aimingShake",0.80],["aimingSpeed",0.80],["endurance",1.00],["spotDistance",0.80],["spotTime",0.80],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00]]; //,["general",1.00]
WAI_SkillMedium = [["aimingAccuracy",0.01],["aimingShake",0.01],["aimingSpeed",1.00],["endurance",1.00],["spotDistance",0.60],["spotTime",0.60],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00]]; //,["general",0.50]
WAI_SkillEasy = [["aimingAccuracy",0.01],["aimingShake",0.01],["aimingSpeed",0.50],["endurance",1.00],["spotDistance",0.50],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00]]; //,["general",0.20]
WAI_SkillRandom = [WAI_SkillExtreme,WAI_SkillHard,WAI_SkillHard,WAI_SkillHard,WAI_SkillHard,WAI_SkillMedium,WAI_SkillMedium,WAI_SkillMedium,WAI_SkillMedium,WAI_SkillEasy];

WAI_StaticUseWeapon = true; // Allows AI on static guns to have a loadout 	
WAI_StaticWeapons = ["DSHKM_Ins","DSHKM_Gue","KORD_high","M2StaticMG","BAF_L2A1_Tripod_W_NoDisassembly"]; // static guns
WAI_StaticSkills = true; // Allows you to set custom array for AI on static weapons. (true: On false: Off) 
WAI_StaticSkillArray = [["aimingAccuracy",0.01],["aimingShake",0.01],["aimingSpeed",0.25],["endurance",1.00],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",0.20],["commanding",1.00]]; //,["general",1.00]

// New AI Gear Assignment for 1.0.7. Random items are selected from the arrays listed below.
WAI_Gear0 = [1,2,1,1,.05]; // Number of food items from WAI_Food, Number of drinks from WAI_Drink, Number of medical items from WAI_Medical, Number of tools from WAI_ToolsAll, chance for "ItemDocument" - 0 to 1.
WAI_Gear1 = [2,1,1,1,.05]; // [Food,Drink,Medical,Tool,Document]
WAI_Gear2 = [1,1,3,3,.10];
WAI_GearRandom = [WAI_Gear0,WAI_Gear1,WAI_Gear2];
WAI_AIMags = [5,6]; // Number of magazines to give each AI [min,max]

// New for 1.0.7 - dog tags that can be traded for +/- humanity at hero and bandit vendors.
WAI_BanditDogtagChance	= .05; // Chance of a bandit having a dog tag in the gear. From 0 to 1. Default = .20 or 20%
WAI_HeroDogtagChance = .05; // Chance of a hero having a dog tag in the gear. From 0 to 1. Default = .20 or 20%

// AI Skins - Increased selection for 1.0.7
WAI_HeroSkin = ["SurvivorW2_DZ","SurvivorW3_DZ","OperatorW_DZ","GunnerW_DZ","Survivor2_DZ","Drake_Light_DZ","Soldier_Bodyguard_AA12_PMC_DZ","Soldier_Sniper_PMC_DZ","Soldier_TL_PMC_DZ","FR_OHara_DZ","FR_Rodriguez_DZ"];
WAI_BanditSkin = ["BanditW1_DZ","BanditW2_DZ","Tamika_DZ","Bandit1_DZ","Bandit2_DZ","Bandit3_DZ","Bandit4_DZ","Bandit5_DZ","GUE_Soldier_MG_DZ","GUE_Soldier_Crew_DZ","GUE_Soldier_CO_DZ","GUE_Soldier_2_DZ","TK_INS_Soldier_EP1_DZ","TK_INS_Soldier_EP2_DZ","TK_INS_Soldier_EP3_DZ","TK_Special_Forces_MG_EP1_DZ","Ins_Soldier_GL_DZ","Ins_Soldier_2_DZ"];
WAI_FirefighterSkin = ["Firefighter1_DZ","Firefighter2_DZ","Firefighter3_DZ","Firefighter4_DZ","Firefighter5_DZ","Firefighter_Officer1_DZ","Firefighter_Officer2_DZ"];
WAI_StalkerSkin = ["gsc_eco_stalker_mask_neutralW_DZ","gsc_eco_stalker_mask_fredW_DZ","gsc_eco_stalker_mask_dutyW_DZ","gsc_eco_stalker_mask_camoW_DZ"];
WAI_GhillieSkin = ["GhillieFull_Desert05_DZ","GhillieFull_Desert06_DZ","GhillieFull_Desert07_DZ","GhillieFull_Desert08_DZ","GhillieFull_Snow01_DZ","GhillieFull_Snow02_DZ","GhillieFull_Snow03_DZ","GhillieFull_Snow04_DZ","GhillieFull_Snow05_DZ","GhillieFull_Urban01_DZ","GhillieFull_Wood01_DZ","GhillieFull_Wood02_DZ","GhillieFull_Wood03_DZ","GhillieFull_Wood04_DZ","GhillieFull_Wood05_DZ","GhillieFull_Wood06_DZ","GhillieFull_Wood07_DZ","GhillieFull_Wood08_DZ","GhillieFull_Wood09_DZ","GhillieFull_Wood10_DZ","GhillieFull_Wood11_DZ","GhillieFull_Wood12_DZ","GhillieFull_Wood13_DZ","GhillieFull_Wood14_DZ","GhillieFull_Wood15_DZ","GhillieFull_Wood16_DZ"];
WAI_ApocalypticSkin = ["Apo_Rifleman_01_DZ","Apo_Rifleman_02_DZ","Apo_Rifleman_03_DZ","Apo_Rifleman_04_DZ","Apo_Rifleman_05_DZ","Apo_Rifleman_06_DZ"];
WAI_AcrSkin = ["CZ_Soldier805_DES_ACR_DZ","CZ_Soldier_805_Wdl_ACR_DZ","CZ_Soldier_Crew_Dst_ACR_DZ","CZ_Soldier_Officer_Wdl_ACR_DZ","CZ_Soldier_Recon_Wdl_ACR_DZ","CZ_Soldier_Spec1_Wdl_ACR_DZ","CZ_Soldier_Spec2_Wdl_ACR_DZ","CZ_Soldier_Spec3_Wdl_ACR_DZ","CZ_Soldier_Spec_Demo_Dst_ACR_DZ","CZ_Soldier_Sniper_ACR_DZ","CZ_Soldier_Light_Wdl_ACR_DZ"];
WAI_GruSkin = ["SG_GRU_TL_DZ","SG_GRU_Scout_DZ","SG_GRU_Sniper_DZ","SG_GRU_Spotter_DZ","SG_GRU_TL_W_DZ","SG_GRU_Scout_W_DZ","SG_GRU_Assaultman_W_DZ","SG_GRU_Medic_W_DZ","SG_GRU_TL_D_DZ","SG_GRU_Scout_D_DZ","SG_GRU_Marksman_D_DZ","SG_GRU_Operator_D_DZ","SG_GRU_MG_D_DZ"];
WAI_ScientistSkin = ["gsc_scientist1_DZ","gsc_scientist1_head_DZ","gsc_scientist2_DZ","gsc_scientist2_head_DZ"];
WAI_NacSoldier = ["Nac_Soldier_DZ","Nac_SoldierW_DZ"];
WAI_RockerSkin = ["Rocker1_DZ","Rocker2_DZ","Rocker3_DZ","Rocker4_DZ"];
WAI_AllSkin = [WAI_HeroSkin,WAI_HeroSkin,WAI_BanditSkin,WAI_BanditSkin,WAI_FirefighterSkin,WAI_AcrSkin,WAI_GruSkin,WAI_RockerSkin];
WAI_AddSkin = false; // adds unit skin to inventory on death. Should set to false if you have takeclothes installed.
/* END AI CONFIG */

/* WAI MISSIONS CONFIG */
WAI_AvoidMissions = 2000; // avoid spawning missions this close to other missions. If using auto claim, this number should be 2x WAI_AcAlertDistance.
WAI_AvoidSafezones = 1200; // avoid spawning missions this close to safezones
WAI_AvoidTown = 150; // avoid spawning missions this close to towns, *** doesn't function with infiSTAR enabled ***
WAI_AvoidRoad = 50; // avoid spawning missions this close to roads
WAI_AvoidWater = 50; // avoid spawning missions this close to water
WAI_AvoidPlayers = 1000; // avoid spawning missions this close to a player
WAI_AvoidPlots = 200; // avoid spawning missions near player plots
WAI_WaitForPlayer = true; // Wait until a player is within range of WAI_TimeoutDist to spawn the mission objects and AI. If using auto-claim make sure WAI_TimeoutDist and WAI_AcAlertDistance are the same. This is good for server performance but can be problematic on servers run on low end hardware.																																																																										   

WAI_Timer = [2,3]; // time (in minutes) between missions. Default: 5-15 minutes
WAI_Timeout = 30; // time (in minutes) each mission takes to timeout if inactive. Default: 30 minutes.
WAI_TimeoutDist = 1200; // if a player is this close to a mission then it won't timeout

WAI_CleanMissionTime = 45; // time in minutes after a mission is complete to clean mission buildings. Set to -1 to disable mission cleanup. Default: 30 minutes
WAI_CleanMissionCrate = false; // include the mission crates with the mission cleanup. If a player is within 50 meters of the crates the cleanup script will wait. Does not apply to missions that timeout.
WAI_CleanWhenClear = ["Road Block"]; // These mission names will get cleaned instantly overriding WAI_clean_mission_time

WAI_GodModeObj = true; // prevents mission objects from taking damage
WAI_VehFuel = [20,40]; // fuel inside mission spawned vehicles [min%,max%]
WAI_VehDam = [30,60]; // damage to spawn vehicles with [min%,max%]
WAI_KeepVeh = true; // save vehicles to database and keep them after restart. A player must get in to the vehicle for it to save.
WAI_GodModeVeh = true; // mission vehicles do not take damage until players enter them
WAI_VehKeys = "KeyinVehicle"; // Options: "KeyonAI", "KeyinVehicle", "KeyinCrate", "NoVehicleKey".
WAI_VehMessage = true; // Shows a warning message to the player when entering a mission vehicle

WAI_CrateSmoke = true; // pop smoke on crate when mission is finished during daytime
WAI_CrateFlare = true; // pop flare on crate when mission is finished during nighttime

WAI_PlayersOnline = 1; // number of players online before mission starts
WAI_KillPercent = 80; // percentage of AI players that must be killed at "crate" missions to be able to trigger completion
WAI_HighValueChance = 50; // chance in percent you find a high value item in the crate.
WAI_NumMags = [4,5]; // Number of magazines per weapon in the crate [min,max]

WAI_EnableMineField = false; // enable minefields to better defend missions
WAI_EnableStaticGuns = true; // Enables or disables static gun placements at missions that have them.
WAI_EnableParadrops = true; // Enables or disables paratrooper drops at missions that have them.
WAI_EnablePatrols = true; // Enables or disables armored vehicle patrols at missions that have them.
WAI_UseLaunchers = true; // add a rocket launcher to each spawned AI group
WAI_RemoveLauncher = false; // remove rocket launcher from AI on death

WAI_MessageType = "Radio"; // Options: "Radio", "DynamicText", "titleText"

WAI_HeroLimit = 3; // define how many hero missions can run at once
WAI_BanditLimit = 4; // define how many bandit missions can run at once

// Mission Arrays
// [mission name, chance to spawn] Chance to spawn is 0-1. Example - If you only want your mission to have a 25% chance to spawn enter .25
WAI_HeroMissions = [
	["patrol",0],
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
	["tankcolumn",1],
	["macdonald",1],
	["radioshack",1],
	["junkyard",1],
	["outpost",1],
	["presidents_mansion",1],
	["black_hawk_crash",1],
	["farmer",1],
	["firestation",1],
	["vehicle_drop",0],
	["castle_grayskull",1],
	["wuhan_lab",1],
	["apc",1]
];

WAI_BanditMissions	= [
	["patrol",0],
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
	["vehicle_drop",0],
	["castle_grayskull",1],
	["wuhan_lab",1],
	["apc",1]
];
/* END WAI MISSIONS CONFIG */

// Weapons
WAI_AK = ["AKM_DZ","AKS_DZ","AKS74U_DZ","AK74_DZ","AKS_74","AK107_DZ","AN94_DZ"];
WAI_RK95 = ["RK95_DZ"];
WAI_Groza = ["Groza1_DZ","Groza9_DZ","VSS_vintorez_DZE","VAL_DZ"];
WAI_Scar = ["SCAR_H_AK_DZ"];
WAI_Sniper = ["CZ550_DZ","M24_DZ","M24_DES_DZ","M40A3_DZ","SVD_DZ","WA2000_DZ","MSR_DZ","XM2010_DZ","M4SPR_DZE","M200_CheyTac_DZ","L115A3_DZ","L115A3_2_DZ","CZ750_DZ","RSASS_DZ","DMR_DZE"];
WAI_G36 = ["G36K_Camo_DZ","G36A_Camo_DZ","G36C_DZ","G36C_Camo_DZ"];
WAI_M4 = ["M4A1_DZ","M4A1_FL_DZ","M4A1_Rusty_DZ","M4A1_Camo_CCO_DZ","M4A3_DES_CCO_DZ"];
WAI_HK416 = ["HK416_DZ","HK416C_DZ"];
WAI_SteyrAug = ["SteyrAug_A3_Green_DZ","SteyrAug_A3_Black_DZ","SteyrAug_A3_Blue_DZ"];
WAI_HK53 = ["G3_DZ","HK53A3_DZ"];
WAI_MagpulPDR = ["PDR_DZ"];
WAI_Famas = ["Famas_DZ"];
WAI_ACR = ["ACR_WDL_DZ","ACR_BL_DZ","ACR_DES_DZ","ACR_SNOW_DZ"];
WAI_KAC = ["KAC_PDW_DZ"];
WAI_Tavor = ["CTAR21_DZ"];
WAI_Masada = ["Masada_DZ","Masada_BL_DZ"];
WAI_MK16 = ["MK16_DZ"];
WAI_XM8 = ["XM8_GREY_DZ","XM8_GREY_2_DZ","XM8_GREY_Compact_DZ","XM8_GREY_2_Compact_DZ"];
WAI_M14 = ["M14_DZ","M1A_SC16_BL_DZ"];
WAI_HK417 = ["HK417_DZ","HK417C_DZ"];
WAI_MK14 = ["MK14_DZ","M1A_SC16_TAN_DZ"];
WAI_MK17 = ["MK17_DZ"];
WAI_CZ805 = ["CZ805_A1_DZ","CZ805_A2_DZ"];
WAI_Shotgun = ["Crossbow_DZ","MR43_DZ","Remington870_FL_DZ","M1014_DZ","Saiga12K_DZ","AA12_DZ","USAS12_DZ"];
WAI_SVD = ["SVD_PSO1_DZ","SVD_DZ","SVU_PSO1_DZ"];
WAI_Mosin = ["Mosin_DZ","Winchester1866_DZ","LeeEnfield_DZ"];
WAI_M16 = ["M16A2_DZ","M16A2_Rusty_DZ","M16A4_DZ","M16A4_FL_DZ"];
WAI_SA58 = ["SA58_DZ","SA58_RIS_FL_DZ","Sa58V_DZ","Sa58V_Camo_CCO_DZ"];
WAI_L85 = ["L85A2_DZ","L85A2_FL_DZ","L86A2_LSW_DZ"];
WAI_Pistol = ["APS_DZ","G18_DZ","M93R_DZ","Mac10_DZ","PDW_DZ","TEC9_DZ","Sa61_DZ","BrowningHP_DZ","CZ75P_DZ","CZ75D_DZ","CZ75SP_DZ","DesertEagle_DZ","DesertEagle_Modern_DZ","DesertEagle_Silver_DZ","G17_FL_DZ","M9_DZ","M9_Camo_DZ","M1911_DZ","M1911_2_DZ","Kimber_M1911_DZ","Makarov_DZ","MK22_DZ","MK22_2_DZ","P38_DZ","P99_Black_DZ","P99_Green_DZ","P99_Silver_DZ","P226_DZ","P226_Silver_DZ","PPK_DZ","Revolver_DZ","Colt_Anaconda_DZ","Colt_Bull_DZ","Colt_Python_DZ","Colt_Revolver_DZ","Ruger_MK2_DZ","Tokarew_TT33_DZ","USP_DZ"];
WAI_SMG = ["Sten_MK_DZ","M31_DZ","MAT49_DZ","TMP_DZ","MP5_DZ","MP5SD","UMP_DZ","MP7_FL_DZ","Bizon_DZ","Scorpion_Evo3_DZ","KAC_PDW_DZ","Kriss_DZ","P90_DZ"];
WAI_LMG = ["L110A1_DZ","M60A4_EP1_DZE","M240_DZ","M249_DZ","M249_EP1_DZ","Mk43_DZ","Mk48_DZ","PKM_DZ","UK59_DZ","MG36_DZ","MG36_Camo_DZ","RPK_DZ","RPK74_DZ"];
WAI_TWS = ["ACR_WDL_TWS_DZ","BAF_L85A2_RIS_TWS_DZ"];
WAI_RandomWeapon = [WAI_AK,WAI_AK,WAI_AK,WAI_RK95,WAI_Groza,WAI_Scar,WAI_Sniper,WAI_G36,WAI_M4,WAI_HK416,WAI_SteyrAug,WAI_HK53,WAI_MagpulPDR,WAI_Famas,WAI_ACR,WAI_KAC,WAI_Tavor,WAI_Masada,WAI_MK16,WAI_XM8,WAI_M14,WAI_HK417,WAI_MK14,WAI_MK17,WAI_CZ805,WAI_Shotgun,WAI_Shotgun,WAI_Shotgun,WAI_SVD,WAI_Mosin,WAI_Mosin,WAI_M16,WAI_M16,WAI_SA58,WAI_L85,WAI_SMG,WAI_SMG,WAI_LMG];

WAI_Silenced		= ["Scorpion_Evo3_CCO_SD_DZ","Bizon_SD_DZ","Kriss_SD_DZ","MP5_SD_DZ","MP7_SD_DZ","P90_SD_DZ","TMP_SD_DZ","UMP_SD_DZ"];
WAI_RifleGood		= ["CZ805_A1_GL_DZ","CZ805_A2_SD_DZ","CZ805_B_GL_DZ","G36C_Camo_Holo_SD_DZ","Groza9_DZ","L86A2_LSW_DZ","M1A_SC2_BL_DZ","M4A1_Camo_Holo_GL_DZ","M4A3_ACOG_GL_DZ","M4A3_Camo_ACOG_DZ","MK16_BL_GL_ACOG_DZ","MK16_BL_Holo_SD_DZ","MK16_BL_GL_CCO_SD_DZ","MK17_BL_GL_ACOG_DZ","MK17_BL_CCO_SD_DZ","MK17_BL_GL_Holo_SD_DZ","Sa58V_Camo_ACOG_DZ"];
WAI_RifleRare		= ["ACR_WDL_NV_DZ","ACR_BL_NV_DZ","ACR_DES_NV_DZ","ACR_SNOW_NV_DZ","M4SPR_DZE","CZ750_DZ","L115A3_DZ","L115A3_2_DZ","MSR_DZ","MSR_SD_DZ","XM2010_DZ","XM2010_SD_DZ","MK14_Sniper_DZ","M21A5_DZ","M21A5_SD_DZ","DMR_DZE","M1A_SC16_BL_Sniper_DZ","M1A_SC16_TAN_Sniper_DZ","M1A_SC2_BL_Sniper_DZ","WA2000_DZ","RSASS_DZ","RSASS_SD_DZ","VSS_vintorez_DZE","Groza9_GL_Sniper_DZ","Groza9_Sniper_SD_DZ","Groza1_Sniper_DZ","Groza1_Sniper_SD_DZ","M200_CheyTac_DZ","MK17_Sniper_SD_DZ","MK17_Sniper_DZ","SVU_PSO1_DZ","BAF_L110A1_Aim_DZE","Mk48_DES_CCO_DZ"];
WAI_RifleDelux		= ["AKS_Gold_DZ","AKS_Silver_DZ","SVD_Gold_DZ","DesertEagle_Gold_DZ","Revolver_Gold_DZ","Colt_Anaconda_Gold_DZ","Anzio_20_DZ","BAF_AS50_scoped_DZ","Barrett_MRAD_Sniper_DZ","KSVK_DZE","m107_DZ","M110_NV_DZ","M200_CheyTac_SD_DZ","MSR_NV_DZ","MSR_NV_SD_DZ","XM2010_NV_DZ","XM2010_NV_SD_DZ","M249_m145_EP1_DZE","MK43_M145_DZ","m240_scoped_EP1_DZE"];
WAI_LauncherCheap	= ["RPG7V","M136","RPG18","SMAW","MAAWS","Strela"];
WAI_LauncherDelux	= ["M47Launcher_EP1","BAF_NLAW_Launcher","Stinger","Igla"];

// Launchers
WAI_LaunchersAT = ["RPG18","M136"];
WAI_LaunchersAA = ["Strela"];

// Backpacks
WAI_Packs = ["Patrol_Pack_DZE1","GymBag_Camo_DZE1","GymBag_Green_DZE1","Czech_Vest_Pouch_DZE1","Assault_Pack_DZE1","TerminalPack_DZE1","TinyPack_DZE1","ALICE_Pack_DZE1","TK_Assault_Pack_DZE1","School_Bag_DZE1","CompactPack_DZE1","British_ACU_DZE1","GunBag_DZE1","PartyPack_DZE1","NightPack_DZE1","SurvivorPack_DZE1","AirwavesPack_DZE1","CzechBackpack_DZE1","CzechBackpack_Camping_DZE1","CzechBackpack_OD_DZE1","CzechBackpack_DES_DZE1","CzechBackpack_3DES_DZE1","CzechBackpack_WDL_DZE1","CzechBackpack_MAR_DZE1","CzechBackpack_DMAR_DZE1","CzechBackpack_UCP_DZE1","CzechBackpack_6DES_DZE1","CzechBackpack_TAK_DZE1","CzechBackpack_NVG_DZE1","CzechBackpack_BLK_DZE1","CzechBackpack_DPM_DZE1","CzechBackpack_FIN_DZE1","CzechBackpack_MTC_DZE1","CzechBackpack_NOR_DZE1","CzechBackpack_WIN_DZE1","CzechBackpack_ATC_DZE1","CzechBackpack_MTL_DZE1","CzechBackpack_FTN_DZE1","WandererBackpack_DZE1","LegendBackpack_DZE1","CoyoteBackpack_DZE1","CoyoteBackpackDes_DZE1","CoyoteBackpackWdl_DZE1","CoyoteBackpack_Camping_DZE1","LargeGunBag_DZE1"];
WAI_PacksUpgraded = ["Patrol_Pack_DZE2","GymBag_Camo_DZE2","GymBag_Green_DZE2","Czech_Vest_Pouch_DZE2","Assault_Pack_DZE2","TerminalPack_DZE2","TinyPack_DZE2","ALICE_Pack_DZE2","TK_Assault_Pack_DZE2","School_Bag_DZE2","CompactPack_DZE2","British_ACU_DZE2","GunBag_DZE2","PartyPack_DZE2","NightPack_DZE2","SurvivorPack_DZE2","AirwavesPack_DZE2","CzechBackpack_DZE2","CzechBackpack_Camping_DZE2","CzechBackpack_OD_DZE2","CzechBackpack_DES_DZE2","CzechBackpack_3DES_DZE2","CzechBackpack_WDL_DZE2","CzechBackpack_MAR_DZE2","CzechBackpack_DMAR_DZE2","CzechBackpack_UCP_DZE2","CzechBackpack_6DES_DZE2","CzechBackpack_TAK_DZE2","CzechBackpack_NVG_DZE2","CzechBackpack_BLK_DZE2","CzechBackpack_DPM_DZE2","CzechBackpack_FIN_DZE2","CzechBackpack_MTC_DZE2","CzechBackpack_NOR_DZE2","CzechBackpack_WIN_DZE2","CzechBackpack_ATC_DZE2","CzechBackpack_MTL_DZE2","CzechBackpack_FTN_DZE2","WandererBackpack_DZE2","LegendBackpack_DZE2","CoyoteBackpack_DZE2","CoyoteBackpackDes_DZE2","CoyoteBackpackWdl_DZE2","CoyoteBackpack_Camping_DZE2","LargeGunBag_DZE2"];
WAI_PacksLg = ["LegendBackpack_DZE1","CoyoteBackpack_DZE1","CoyoteBackpackDes_DZE1","CoyoteBackpackWdl_DZE1","CoyoteBackpack_Camping_DZE1","LargeGunBag_DZE1","LegendBackpack_DZE2","CoyoteBackpack_DZE2","CoyoteBackpackDes_DZE2","CoyoteBackpackWdl_DZE2","CoyoteBackpack_Camping_DZE2","LargeGunBag_DZE2"];
WAI_PacksAll = ["Patrol_Pack_DZE1","GymBag_Camo_DZE1","GymBag_Green_DZE1","Czech_Vest_Pouch_DZE1","Assault_Pack_DZE1","TerminalPack_DZE1","TinyPack_DZE1","ALICE_Pack_DZE1","TK_Assault_Pack_DZE1","School_Bag_DZE1","CompactPack_DZE1","British_ACU_DZE1","GunBag_DZE1","PartyPack_DZE1","NightPack_DZE1","SurvivorPack_DZE1","AirwavesPack_DZE1","CzechBackpack_DZE1","CzechBackpack_Camping_DZE1","CzechBackpack_OD_DZE1","CzechBackpack_DES_DZE1","CzechBackpack_3DES_DZE1","CzechBackpack_WDL_DZE1","CzechBackpack_MAR_DZE1","CzechBackpack_DMAR_DZE1","CzechBackpack_UCP_DZE1","CzechBackpack_6DES_DZE1","CzechBackpack_TAK_DZE1","CzechBackpack_NVG_DZE1","CzechBackpack_BLK_DZE1","CzechBackpack_DPM_DZE1","CzechBackpack_FIN_DZE1","CzechBackpack_MTC_DZE1","CzechBackpack_NOR_DZE1","CzechBackpack_WIN_DZE1","CzechBackpack_ATC_DZE1","CzechBackpack_MTL_DZE1","CzechBackpack_FTN_DZE1","WandererBackpack_DZE1","LegendBackpack_DZE1","CoyoteBackpack_DZE1","CoyoteBackpackDes_DZE1","CoyoteBackpackWdl_DZE1","CoyoteBackpack_Camping_DZE1","LargeGunBag_DZE1"];

// Vehicles
WAI_ArmedVeh = ["HMMWV_M998A2_SOV_DES_EP1_DZE","HMMWV_M1151_M2_CZ_DES_EP1_DZE","HMMWV_GPK_M2_WINTER_DZE","HMMWV_M1114_AGS_ACR_DZE","HMMWV_M1114_DSHKM_ACR_DZE","HMMWV_Armored_DZE","HMMWV_Winter_Armored_DZE","HMMWV_M2_DZE","ArmoredSUV_PMC_DZE","BTR40_MG_TK_GUE_EP1_DZE","GAZ_Vodnik_DZE","LandRover_Special_CZ_EP1_DZE","LandRover_MG_TK_EP1_DZE","UAZ_MG_TK_EP1_DZE","UAZ_MG_CDF_DZE","UAZ_MG_INS_DZE","UAZ_MG_WINTER_DZE","UAZ_AGS30_RU_DZE","UAZ_AGS30_CDF_DZE","UAZ_AGS30_INS_DZE","UAZ_AGS30_TK_EP1_DZE","UAZ_AGS30_WINTER_DZE","Offroad_DSHKM_Gue_DZE","BAF_Jackal2_L2A1_D_DZE","BAF_Jackal2_L2A1_W_DZE","BAF_Jackal2_GMG_D_DZE","BAF_Jackal2_GMG_W_DZE"];
WAI_UnarmedTrackedVeh = ["M113Ambul_TK_EP1_DZE1","M113Ambul_UN_EP1_DZE1","BMP2_Ambul_CDF_DZE","BMP2_Ambul_Winter_DZE","BMP2_Ambul_INS_DZE"];
WAI_APC = ["LAV25_HQ_DZE","M113_UN_EP1_DZE","M113_TK_EP1_DZE","BRDM2_HQ_WINTER_DZE","BRDM2_WINTER_DZE","BRDM2_RUST_DZE","BRDM2_TK_EP1_DZE","BMP2_HQ_INS_DZE","BMP2_HQ_CDF_DZE","BMP2_HQ_TK_EP1_DZE","BRDM2_Desert_ACR_DZE","BTR60_TK_EP1_DZE","BTR90_HQ_DZE","BTR60_Gue_DZE","BRDM2_HQ_RUST_DZE","BRDM2_CDF_DZE","BRDM2_HQ_CDF_DZE","BRDM2_TK_GUE_EP1_DZE","GAZ_Vodnik_HMG_DZE","Dingo_WDL_ACR_DZE","Dingo_DST_ACR_DZE","Dingo_GL_Wdl_ACR_DZE","Dingo_GL_DST_ACR_DZE"];
WAI_ArmedHeli = ["AN2_M134_DZE","AN2_VICKER_DZE","AW159_Lynx_BAF_DZE","Ka60_GL_PMC_DZE","pook_transport_CDF_DZE","pook_transport_DZE","pook_gunship_CDF_DZE","pook_gunship_DZE","pook_gunship_m134_DZE","pook_gunship_CDF_m134_DZE","CH_47F_EP1_DES_DZE","CH_47F_EP1_GREY_DZE","CH_47F_EP1_Black_DZE","CH_47F_EP1_DZE","UH60M_EP1_DZE","MH60S_DZE","AH6J_EP1_DZE","UH1Y_DZE","UH1H_WINTER_DZE","UH1H_SAR_DZE","UH1H_BLACK_DZE","UH1H_GREY_DZE","UH1H_DES_DZE","UH1H_WD_DZE","UH1H_CDF_DZE","UH1H_2_DZE","UH1H_DZE","Mi17_WINTER_DZE","Mi17_BLACK_DZE","Mi17_BLUE_DZE","Mi17_GREEN_DZE","Mi17_DES_DZE","Mi171Sh_CZ_EP1_DZE","Mi17_CDF_DZE","Mi17_UN_CDF_EP1_DZE","Mi17_TK_EP1_DZE","Mi17_DZE"];
WAI_CivilHeli = ["Mi17_Civilian_DZ","Mi17_medevac_CDF_DZ","Mi17_medevac_Ins_DZ","Mi17_medevac_RU_DZ","MH6J_DZ","AH6X_DZ","CH53_DZE","UH60M_MEV_EP1_DZ","BAF_Merlin_DZE","pook_medevac_CIV_DZE","pook_H13_civ_DZE","pook_H13_civ_white_DZE","pook_H13_civ_slate_DZE","pook_H13_civ_black_DZE","pook_H13_civ_yellow_DZE","MTVR_Bird_DZE"];
WAI_MilUnarmed = ["GAZ_Vodnik_MedEvac_DZE","BTR40_TK_GUE_EP1_DZE","BTR40_TK_INS_EP1_DZE","HMMWV_Ambulance_DZE","HMMWV_Ambulance_CZ_DES_EP1_DZE","HMMWV_WINTER_DZ","HMMWV_DES_EP1_DZE","HMMWV_DZ","HMMWV_M1035_DES_EP1_DZE"];
WAI_CargoTruck = ["Ikarus_DZE","Ikarus_TK_CIV_EP1_DZE","Ikarus_White_DZE","Ikarus_Armored_DZE","KamazOpen_DZE","Kamaz_DZE","KamazRepair_DZE","KamazReammo_DZE","KamazOpen_Winter_DZE","Kamaz_Winter_DZE","KamazRepair_Winter_DZE","KamazReammo_Winter_DZE","MTVR_DZE","MTVR_DES_EP1_DZE","MtvrRepair_DZE","MtvrReammo_DZE","MTVR_Open_DZE","V3S_Civ_DZE","V3S_Open_TK_CIV_EP1_DZE","V3S_Open_TK_EP1_DZE","V3S_TK_EP1_DZE","V3S_RA_TK_GUE_EP1_DZE","V3S_Camper_DZE","Ural_INS_DZE","Ural_RUST_DZE","Ural_CDF_DZE","UralOpen_CDF_DZE","Ural_TK_CIV_EP1_DZE","Ural_UN_EP1_DZE","UralCivil_DZE","UralCivil2_DZE","UralSupply_TK_EP1_DZE","UralReammo_CDF_DZE","UralRepair_CDF_DZE","Ural_WINTER_DZE","UralOpen_WINTER_DZE","UralReammo_WINTER_DZE","UralRepair_WINTER_DZE","T810A_ACR_DZE","T810A_ACR_DES_DZE","T810A_ACR_OPEN_DZE","T810A_ACR_DES_OPEN_DZE","T810_ACR_REAMMO_DZE","T810_ACR_REAMMO_DES_DZE","T810_ACR_REPAIR_DZE","T810_ACR_REPAIR_DES_DZE"];
WAI_RefuelTruck = ["T810A_ACR_REFUEL_DES_DZE","T810A_ACR_REFUEL_DZE","UralRefuel_WINTER_DZ","UralRefuel_TK_EP1_DZ","V3S_Refuel_TK_GUE_EP1_DZ","MtvrRefuel_DZ","MtvrRefuel_DES_EP1_DZ","KamazRefuel_Winter_DZ","KamazRefuel_DZ"];
WAI_CivilVeh = ["Hummer_DZE","datsun1_civil_1_open_DZE","datsun1_green_open_DZE","datsun1_civil_2_covered_DZE","datsun1_red_covered_DZE","datsun1_civil_3_open_DZE","hilux1_civil_1_open_DZE","hilux1_civil_2_covered_DZE","Lada1_DZE","Lada2_DZE","Lada1_TK_CIV_EP1_DZE","Lada2_TK_CIV_EP1_DZE","LandRover_TK_CIV_EP1_DZE","S1203_TK_CIV_EP1_DZE","S1203_ambulance_EP1_DZE","VolhaLimo_TK_CIV_EP1_DZE","Volha_1_TK_CIV_EP1_DZE","Volha_2_TK_CIV_EP1_DZE","VWGolf_DZE","Skoda_DZE","SkodaBlue_DZE","SkodaRed_DZE","SkodaGreen_DZE","car_hatchback_DZE","car_hatchback_red_DZE","UAZ_Unarmed_TK_CIV_EP1_DZE","car_sedan_DZE","Octavia_ACR_DZE","Jeep_DZE","Mini_Cooper_DZE","ScrapAPC_DZE"];

WAI_PKVeh			= ["T810A_PKT_ACR_DZE","T810A_PKT_DES_ACR_DZE","Pickup_PK_GUE_DZE","Pickup_PK_INS_DZE","Pickup_PK_TK_GUE_EP1_DZE"];
WAI_SportCars		= ["Nissan_Orange_DZE","Nissan_Blue_DZE","Nissan_Mod_DZE","Nissan_Gold_DZE","Nissan_Green_DZE","Nissan_Black_DZE","Nissan_Pink_DZE","Nissan_Red_DZE","Nissan_Ruben_DZE","Nissan_V_DZE","Nissan_Yellow_DZE","SUV_TK_CIV_EP1_DZE","SUV_Camo","SUV_Blue","SUV_Green","SUV_Yellow","SUV_Red","SUV_White","SUV_Pink","SUV_Charcoal","SUV_Orange","SUV_Silver","SUV_Winter_Camo"];
WAI_SPAAG			= ["Ural_ZU23_INS","Ural_ZU23_Gue","Ural_ZU23_TK_GUE_EP1"];
WAI_SPG				= ["Offroad_SPG9_TK_GUE_EP1_DZE","Offroad_SPG9_Gue_DZE","UAZ_SPG9_INS_DZE","UAZ_SPG9_CDF_DZE","UAZ_SPG9_TK_DZE","UAZ_SPG_WINTER_DZE","LandRover_SPG9_TK_EP1_DZE"];
WAI_SuperVeh		= ["T34","T34_TK_EP1","T34_TK_GUE_EP1","BMP1_INS_CP","BVP1_TK_ACR","BVP1_TK_GUE_ACR","BTR90_DZE","LAV25_DZE"];

// Crates
WAI_CrateLg = ["DZ_AmmoBoxBigUS","DZ_AmmoBoxBigRU"];
WAI_CrateMd = ["DZ_AmmoBoxMedium1US","DZ_AmmoBoxMedium2US","DZ_AmmoBoxLong2RU","DZ_AmmoBoxLongGUE"];
WAI_CrateSm = ["DZ_AmmoBoxSmallUS","DZ_AmmoBoxFlatUS","DZ_AmmoBoxSmallRU","DZ_AmmoBoxSmallUN","DZ_AmmoBoxSmallGUE"];

local _bloodbag = ["bloodBagONEG","ItemBloodbag"] select dayz_classicBloodBagSystem;

// Loot Arrays
WAI_Chainsaws = ["ChainSaw","ChainSawB","ChainSawG","ChainSawP","ChainSawR"];
WAI_ToolsAll = ["ItemToolbox","ItemKeyKit","ItemCrowbar","ItemShovel","ItemFishingPole","ItemHatchet","ItemKnife","ItemMachete",format["Item%1Matchbox",round(random 4)+1],"ItemToolbox"];
WAI_ToolsBuildable = ["ItemCrowbar","ItemKnife","ItemPickaxe","ItemSledge","ItemShovel","Handsaw_DZE","Hammer_DZE"];
WAI_BaseAddons = ["garage_green_kit","garage_white_kit","garage_brown_kit","garage_grey_kit","ItemGenerator","ItemTent","ItemTentWinter","ItemDomeTent","ItemWinterDomeTent","ItemDesertTent","desert_net_kit","forest_net_kit","winter_net_kit","outhouse_kit","cook_tripod_kit","stoneoven_kit","commode_kit","wardrobe_kit","fridge_kit","washing_machine_kit","server_rack_kit","atm_kit","armchair_kit","sofa_kit","arcade_kit","vendmachine1_kit","vendmachine2_kit","storage_crate_kit","camo_storage_crate_kit","ItemTent","ItemTentWinter","ItemDomeTent","ItemWinterDomeTent","ItemDesertTent","ItemFireBarrel_kit","workbench_kit","advanced_workBench_kit","fuel_pump_kit","light_pole_kit","deer_stand_kit","rusty_gate_kit","stick_fence_kit","sun_shade_kit","park_bench_kit","ItemScaffoldingKit","notebook_kit","water_pump_kit","greenhouse_kit","bed_kit","table_kit","office_chair_kit","helipad_civil_kit","helipad_rescue_kit","helipad_army_kit","helipad_cross_kit","helipad_parkborder_kit","cctv_kit","storage_shed_kit","ItemStorageBarrel1_kit","ItemStorageBarrel2_kit","ItemStorageBarrel3_kit","ItemStorageBarrel4_kit","ItemStorageBarrel5_kit","ItemStorageBarrel6_kit","ItemStorageBarrel7_kit","ItemStorageBarrel8_kit","rabbit_hutch_kit","chicken_coop_kit","doghouse_kit","postbox_kit","wild_bee_hive_kit","cow_stable_kit","goat_stable_kit","sheep_stable_kit","boar_stable_kit","deer_stand_kit","sun_shade_kit","park_bench_kit","ItemScaffoldingKit"];
WAI_HighValue = ["ItemDogTagHero","ItemDogTagBandit","ItemRuby","ItemCitrine","ItemEmerald","ItemAmethyst","ItemSapphire","ItemObsidian","ItemTopaz","bulk_equip_scrapelectronicsFull","bulk_equip_floppywireFull","bulk_ItemC4ChargeFull","bulk_PipeBombFull"];
WAI_Food = ["bulk_FoodbaconCookedFull","FoodCanBakedBeans","FoodCanFrankBeans","FoodCanPasta","FoodCanSardines","FoodCanBeef","FoodCanPotatoes","FoodCanGriff","FoodCanBadguy","FoodCanBoneboy","FoodCanCorn","FoodCanCurgon","FoodCanDemon","FoodCanFraggleos","FoodCanHerpy","FoodCanDerpy","FoodCanOrlok","FoodCanPowell","FoodCanTylers","FoodCanUnlabeled","FoodCanRusUnlabeled","FoodCanRusStew","FoodCanRusPork","FoodCanRusPeas","FoodCanRusMilk","FoodCanRusCorn","FoodChipsSulahoops","FoodChipsMysticales","FoodChipsChocolate","FoodCandyChubby","FoodCandyAnders","FoodCandyLegacys","FoodCakeCremeCakeClean","FoodCandyMintception","FoodPistachio","FoodNutmix","FoodMRE","FoodbaconCooked","FoodbeefCooked","FoodchickenCooked","FoodGoatCooked","FoodmuttonCooked","FoodrabbitCooked","FishCookedTrout","FishCookedSeaBass","FishCookedTuna"];
WAI_Drink = ["bulk_ItemSodaCokeFull","bulk_ItemSodaPepsiFull","ItemSodaCoke","ItemSodaPepsi","ItemSodaMdew","ItemSodaMtngreen","ItemSodaR4z0r","ItemSodaClays","ItemSodaSmasht","ItemSodaDrwaste","ItemSodaFranka","ItemSodaLemonade","ItemSodaLirik","ItemSodaLvg","ItemSodaMzly","ItemSodaPeppsy","ItemSodaRabbit","ItemSodaSacrite","ItemSodaRocketFuel","ItemSodaGrapeDrink","ItemSherbet","ItemSodaRbull","ItemSodaOrangeSherbet","ItemWaterbottle","ItemWaterBottleSafe","ItemWaterBottleBoiled","ItemWaterBottleHerbal","ItemPlasticWaterBottleSafe","ItemPlasticWaterBottleBoiled","ItemPlasticWaterBottleHerbal"];
WAI_Ikea = ["plot_pole_kit","fuel_pump_kit","ItemComboLock","ItemVault","ItemTallSafe","wooden_shed_kit","wood_shack_kit","storage_shed_kit","ItemGunRackKit","ItemWoodCrateKit","woodfence_foundation_kit","woodfence_frame_kit","woodfence_1_kit","metalfence_foundation_kit","metalfence_frame_kit","metalfence_1_kit","woodfence_gate_foundation_kit","woodfence_gate_1_kit","ItemFireBarrel_kit","workbench_kit","wood_ramp_kit","metal_panel_kit","ItemCorrugated","barbed_gate_kit","light_pole_kit","rusty_gate_kit","stick_fence_kit","notebook_kit","water_pump_kit","greenhouse_kit","bed_kit","table_kit","office_chair_kit","concrete_barrier_kit","concrete_barrier_striped_kit","concrete_wall_kit","concrete_pipe_kit","dragonteeth_kit","dragonteeth_big_kit","simple_footbridge_kit","metal_container_1a_kit","metal_container_1b_kit","metal_container_1g_kit","metal_container_2d_kit","compost_barrel_empty_kit","compost_barrel_full_kit","boggle_kit","satellite_dish_kit","glass_floor_kit","glass_floor_half_kit","glass_floor_quarter_kit","metal_floor_kit","metal_floor_half_kit","metal_floor_quarter_kit","metal_floor4x_kit","metal_pillar_kit","half_cinder_wall_kit","half_cinder_wall_gap_kit","full_cinder_wall_kit","cinderwall_window_kit","cinderwall_window_locked_kit","cinder_door_frame_kit","cinder_door_kit","cinder_door_kit_locked","cinder_door_hatch_kit","cinder_door_hatch_kit_locked","cinder_garage_frame_kit","cinder_garage_kit","cinder_garage_kit_locked","cinder_garage_top_open_frame_kit","cinder_garage_top_open_kit","cinder_garage_top_open_kit_locked","cinder_gate_frame_kit","cinder_gate_kit","cinder_gate_kit_locked","cinder_bunker_kit","cinder_bunker_kit_locked","metal_drawbridge_kit","metal_drawbridge_kit_locked","elevatorstart_kit","elevatorstop_glass_kit","door_frame_kit","door_kit","door_locked_kit"];
WAI_Parts = ["equip_duct_tape","bulk_HandRoadFlareFull","PartEngine","PartEngine","PartFueltank","PartFueltank",["PartGeneric",2],["PartGeneric",2],["PartGeneric",3],["PartGeneric",4],["PartGlass",2],"PartVRotor",["PartWheel",2],["PartWheel",2],["PartWheel",2]];
WAI_Medical = ["ItemWaterbottle","ItemPlasticWaterBottle","ItemAntibiotic","ItemAntibiotic1","bloodTester","wholeBloodBagANEG","wholeBloodBagAPOS","wholeBloodBagBNEG","wholeBloodBagBPOS","wholeBloodBagABNEG","wholeBloodBagABNEG","wholeBloodBagABPOS","wholeBloodBagONEG","wholeBloodBagOPOS","ItemAntibacterialWipe","ItemAntibacterialWipe","ItemAntibacterialWipe","ItemEpinephrine","ItemHeatPack","ItemHeatPack","ItemMorphine","ItemMorphine","ItemPainkiller","ItemPainkiller1",["ItemBandage",3],["ItemBandage",2],"ItemBandage","equip_comfreyleafs",["emptyBloodBag",3],"transfusionKit",_bloodbag];
WAI_VehAmmo = ["pook_1300Rnd_762x51_M60","pook_250Rnd_762x51","2000Rnd_762x51_M134","2000Rnd_762x51_L94A1","60Rnd_762x54_DT","60Rnd_762x54_DT","100Rnd_762x54_PK","100Rnd_762x51_M240","200Rnd_762x51_M240","100Rnd_127x99_M2","100Rnd_127x99_M2","50Rnd_127x107_DSHKM","150Rnd_127x107_DSHKM","29Rnd_30mm_AGS30","48Rnd_40mm_MK19","3Rnd_GyroGrenade","pook_12Rnd_Grenade_Camel","PG9_AT","OG9_HE","150Rnd_30mmAP_2A42","150Rnd_30mmHE_2A42","210Rnd_25mm_M242_APDS","210Rnd_25mm_M242_HEI","500Rnd_TwinVickers","1470Rnd_127x108_YakB","750Rnd_M197_AH1","150Rnd_23mm_GSh23L","520Rnd_23mm_GSh23L","SmokeLauncherMag","60Rnd_CMFlareMagazine"];
WAI_HeliAmmo = ["PG9_AT","OG9_HE","40rnd_PG15V","2Rnd_Sidewinder_AH1Z","10Rnd_85mmAP","21Rnd_100mmHEAT_D10","23Rnd_125mmSABOT_T72","4Rnd_AT2_Mi24D","4Rnd_AT6_Mi24V","SmokeLauncherMag","60Rnd_CMFlareMagazine"];
WAI_Presidents = ["m240_nest_kit","ItemDocument","ItemDogTagHero","ItemDogTagBandit","equip_scrapelectronics","equip_floppywire","PipeBomb","TimeBomb","IRStrobe","BAF_L109A1_HE","HandGrenade_west","HandGrenade_east","SmokeShell","SmokeShellRed","SmokeShellGreen","SmokeShellYellow","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","FlareWhite_M203","FlareGreen_M203","FlareRed_M203","FlareYellow_M203","1Rnd_Smoke_M203","1Rnd_SmokeRed_M203","1Rnd_SmokeGreen_M203","1Rnd_SmokeYellow_M203","FlareWhite_GP25","FlareGreen_GP25","FlareRed_GP25","FlareYellow_GP25","1Rnd_SMOKE_GP25","1Rnd_SmokeRed_GP25","1Rnd_SmokeGreen_GP25","1Rnd_SmokeYellow_GP25","6Rnd_HE_M203","6Rnd_FlareWhite_M203","6Rnd_FlareGreen_M203","6Rnd_FlareRed_M203","6Rnd_FlareYellow_M203","6Rnd_Smoke_M203","6Rnd_SmokeRed_M203","6Rnd_SmokeGreen_M203","6Rnd_SmokeYellow_M203","20Rnd_B_AA12_HE"];
WAI_Gems = ["ItemRuby","ItemCitrine","ItemEmerald","ItemAmethyst","ItemSapphire","ItemObsidian","ItemTopaz"];
WAI_Hemp = ["PipeBomb","TimeBomb","equip_string","equip_rag","bulk_ItemKiloHempFull","bulk_ItemKiloHempFull","ItemKiloHemp","ItemKiloHemp","ItemKiloHemp",["ItemCanvas",3],["ItemCanvas",2],"ItemSandbag","FoodBioMeat","ItemZombieParts"];
WAI_Wood = ["ItemWoodFloor","ItemWoodFloor4x","ItemWoodFloorStairs","ItemTriangleWoodFloor","ItemWoodFloorHalf","ItemWoodFloorQuarter","ItemWoodStairs","ItemWoodStairsSupport","ItemWoodStairsRails","ItemWoodLadder","ItemWoodHandRail","ItemWoodPillar","ItemWoodWall","ItemTriangleWoodWall","ItemWoodWallThird","ItemWoodWallWindow","ItemWoodWallDoor","ItemWoodWallWithDoor","ItemWoodWallWithDoorLocked","ItemWoodWallGarageDoor","ItemWoodWallGarageDoorLocked","ItemWoodOpenTopGarageDoor","ItemWoodOpenTopGarageDoorLocked","ItemWoodWallLg","ItemWoodWallWindowLg","ItemWoodWallDoorLg","ItemWoodWallWithDoorLg","ItemWoodWallWithDoorLgLocked","ItemWoodGateFrame","ItemWoodGate","ItemWoodGateLocked","wooden_footbridge_kit","windbreak_kit","ItemMixOil",["PartPlywoodPack",ceil(random 12)],["ItemLog",ceil(random 5)],["ItemCanvas",3],"equip_wood_pallet","equip_crate","ItemWoodFloorHalf","ItemWoodFloorQuarter","ItemTriangleWoodFloor","ItemWoodStairs","ItemWoodLadder","ItemWoodHandRail","ItemWoodPillar","ItemWoodWall","ItemTriangleWoodWall","ItemWoodWallThird","ItemWoodWallLg","door_frame_kit","woodfence_foundation_kit","woodfence_frame_kit","woodfence_gate_foundation_kit","door_frame_kit","ItemWoodGateFrame","ItemWoodWallDoorLg","ItemWoodWallWindowLg","ItemWoodOpenTopGarageDoor","ItemWoodWallGarageDoor","ItemWoodWallDoor","ItemWoodWallWindow","woodfence_1_kit","wooden_shed_kit","wood_shack_kit","storage_shed_kit","ItemGunRackKit","StashSmall_kit"];
WAI_Misc = ["SearchLight_Static_kit","ItemLockbox","ItemLockbox","ItemLockboxWinter","StashSmall_kit","equip_duct_tape","ItemConcreteBlock","CementBag",["CinderBlocks",3],["CinderBlocks",2],"bulk_ItemLightBulbFull",["ItemCanvas",5],["equip_metal_sheet",5],["equip_floppywire",4],["equip_scrapelectronics",4],["ItemScrews",4],"equip_rope","ItemMixOil","bulk_ItemSandbag","bulk_ItemTankTrap","bulk_ItemWire",["MortarBucket",3],["MortarBucket",2],"bulk_PartGeneric",["ItemLog",2],"equip_metal_sheet","ItemRSJ","ItemMetalSheet","equip_2inch_metal_pipe","equip_1inch_metal_pipe","equip_tent_poles","bulk_ItemScrewsFull","bulk_equip_nailsFull"];
WAI_ToolsSniper	 = ["ItemCompass","Binocular","ItemMap","ItemWatch","ItemGPSBroken_DZE","ItemNVGBroken_DZE","ItemFlashlightRed","ItemSolder_DZE"];
WAI_AmmoCheap	 = ["bulk_17Rnd_9x19_glock17","60Rnd_762x39_AK47_Taped","30Rnd_556x45_Stanag","30Rnd_556x45_G36","30Rnd_556x45_Aug","30Rnd_762x39_AK47","30Rnd_762x39_RK95","30Rnd_545x39_AK","30Rnd_762x39_SA58","30Rnd_762x39_Groza1","20Rnd_9x39_Groza9","ACR_30Rnd_680x43","20Rnd_762x51_FNFAL","20Rnd_762x51_G3","20Rnd_762x51_HK417","20Rnd_762x51_B_SCAR","20Rnd_762x51_DMR","5Rnd_762x51_M24","5Rnd_17HMR","5Rnd_762x54_Mosin","10Rnd_303British","15Rnd_W1866_Slug","8Rnd_12Gauge_Buck","8Rnd_B_Saiga12_Pellets","20Rnd_B_AA12_Pellets","20Rnd_B_Usas12_Pellets","30Rnd_9x19_MP5","50Rnd_762x54_UK59"];
WAI_AmmoGood	 = ["60Rnd_545x39_AK_Taped","60Rnd_556x45_Stanag_Taped","20Rnd_762x51_RSASS","100Rnd_556x45_BetaCMag","200Rnd_556x45_M249","20Rnd_9x39_SP5_VSS","10Rnd_762x51_CZ750","10Rnd_762x54_SVD","6Rnd_762x51_WA2000","5Rnd_86x70_L115A1","5Rnd_408_CheyTac","5Rnd_762x67_XM2010","7Rnd_86x70_MSR","10Rnd_86x70_MRAD","5Rnd_127x108_KSVK","10Rnd_127x99_m107","5Rnd_127x99_as50_CP","3rnd_Anzio_20x102mm"];
WAI_AmmoSD		 = ["bulk_30Rnd_556x45_StanagSD","30Rnd_545x39_AKSD","60Rnd_545x39_AKSD_Taped","60Rnd_556x45_StanagSD_Taped","100Rnd_556x45_BetaCMagSD","ACR_30Rnd_680x43_SD","30Rnd_762x39_Groza1SD","20Rnd_9x39_Groza9SD","30Rnd_762x39_RK95SD","20Rnd_762x51_RSASS_SD","20Rnd_762x51_SB_SCAR","20Rnd_762x51_DMRSD","20Rnd_762x51_HK417SD","5Rnd_408_CheyTac_SD","5Rnd_762x67_XM2010_SD","7Rnd_86x70_MSR_SD","7Rnd_45ACP_1911SD","8Rnd_9x18_MakarovSD","8Rnd_9x19_MK22SD","15Rnd_10x22_p99_sd","17Rnd_9x19_glock17SD","18Rnd_9x19_PhantomSD","15Rnd_45ACP_USPSD","30Rnd_9x19_UZI_SD","20Rnd_9x18_APSSD","bulk_15Rnd_9x19_M9SD","bulk_30Rnd_9x19_MP5SD","33Rnd_45ACP_KRISSSD","40Rnd_46x30_sd_mp7","30Rnd_9x19_TMPSD","25Rnd_45ACP_UMPSD","50Rnd_57x28_P90SD","64Rnd_9x19_SD_Bizon"];
WAI_ItemsRandom = [WAI_Food, WAI_Food, WAI_Drink, WAI_Drink, WAI_Parts, WAI_Parts, WAI_Medical, WAI_Medical, WAI_AmmoCheap, WAI_VehAmmo, WAI_Ikea, WAI_Hemp, WAI_Wood, WAI_Wood, WAI_Misc];
WAI_StaticMG = ["GPMG_TriPod_GrenadeLauncher_Static_kit",/*"GPMG_TriPod_MG_Static_kit",*/"M2_MG_Static_kit","M2_TriPod_MG_Static_kit","DSHKM_MG_Static_kit","DSHKM_TriPod_MG_Static_kit","KORD_TriPod_MG_Static_kit","KORD_MG_Static_kit","L2A1_MG_Static_kit","L2A1_Tripod_MG_Static_kit"];
WAI_StaticGMG = ["GMG_Tripod_MG_Static_kit",/*"GMG_Tripod_GrenadeLauncher_Static_kit",*/"AGS30_GrenadeLauncher_Static_kit","MK19_TriPod_GrenadeLauncher_Static_kit"];
WAI_StaticHeavy = ["Metis_Launcher_Static_kit","SPG9_Launcher_Static_kit","Stinger_Tripod_Launcher_Static_kit","TOW_Tripod_Launcher_Static_kit","Rbs70_Launcher_Static_kit","Igla_AntiAir_Launcher_Static_kit","ZU23_AntiAir_Static_kit"];

/* AUTO-CLAIM CONFIG */
WAI_AutoClaim = true; // Turn on the auto-claim feature.
WAI_AcAlertDistance = 1000; // Distance from the mission that auto-claim uses to alert closest player
WAI_AcDelayTime = 20; // Time that the auto-claim waits until it declares a claim and places a marker - time in seconds
WAI_AcTimeout = 90; // If the claimer leaves the mission area he/she has this much time to return - time in seconds
/* END AUTO-CLAIM CONFIG */

/* STATIC MISSIONS CONFIG */
WAI_StaticMissions = true; // Enable static missions
WAI_RandomStatic = false; // This will pick randomly from the list below.
WAI_StaticLimit = 3; // if WAI_RandomStatic is true, then this is how many random missions will load on startup. if WAI_RandomStatic is false then all missions in the list below will load on startup.

// List the names of your static missions below. This should be the file name minus the .sqf
WAI_StaticList = [
	"static",
	"sector_c",
	"skalisty_island"
];
/* END STATIC MISSIONS CONFIG */

WAIconfigloaded = true;
