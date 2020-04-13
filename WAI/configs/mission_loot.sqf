// This file contains loot array definitions per mission
// Array format [long guns, tools, items, pistols, backpacks] - Either a number or a custom array.
// First array is for Hero missions, second is for bandit missions. Change the values to preferences.
// [[Hero Loot Array],
//	[Bandit Loot Array]]

diag_log "WAI: Loading Mission Loot table";

/***** Easy Missions *****/
Loot_UralAttack = [
	[0,6,20,0,1], // Hero
	[0,6,20,0,1] // Bandit
];
Loot_Farmer1 = [
	[0,[5,crate_tools_buildable],[20,crate_items_maintains],0,0], // Hero
	[0,[5,crate_tools_buildable],[20,crate_items_maintains],0,0] // Bandit
];
Loot_Farmer2 = [
	["hilux1_civil_1_open_DZE","hilux1_civil_2_covered_DZE","hilux1_civil_3_open_DZE","tractorOld"], // Hero
	["datsun1_civil_1_open_DZE","datsun1_civil_2_covered_DZE","datsun1_civil_3_open_DZE","Tractor"] // Bandit
];
Loot_Outpost = [
	[6,0,[14,crate_ammo_cheap],0,1], // Hero
	[6,0,[14,crate_ammo_cheap],0,1] // Bandit
];
Loot_ScoutPatrol1 = [
	[6,0,10,3,2], // Hero
	[6,0,10,3,2] // Bandit
];
Loot_ScoutPatrol2 = [
	civil_vehicles, // Hero
	military_unarmed // Bandit
];
Loot_SlaughterHouse = [
	[[2,crate_weapons_buildables + ai_wep_pistol],0,[16,crate_items_food + crate_items_chainbullets],0,[1,crate_backpacks_large]], // Hero
	[[2,crate_weapons_buildables + ai_wep_pistol],0,[16,crate_items_food + crate_items_chainbullets],0,[1,crate_backpacks_large]] // Bandit
];
Loot_BHC = [ // Black Hawk Crash
	[6,0,8,3,0], // Hero
	[6,0,8,3,0] // Bandit
];

/***** Medium Missions *****/
Loot_AbandonedTrader1 = [
	[0,5,[25,crate_items_skin+crate_items_food],4,2], // Hero
	[0,5,[25,crate_items_skin+crate_items_food],4,2] // Bandit
];
Loot_AbandonedTrader2 = [
	cargo_trucks, // Hero
	refuel_trucks // Bandit
];
Loot_ArmedVehicle1 = [
	[0,0,[18,crate_items_chainbullets],0,2], // Hero
	[0,0,[18,crate_items_chainbullets],0,2] // Bandit
];
Loot_ArmedVehicle2 = [
	armed_vehicle, // Hero
	improved_vehicles + armed_vehicle // Bandit
];
Loot_DrugBust1 = [
	[0,0,[14,crate_items_crop_raider],10,2], // Hero
	[0,0,[14,crate_items_crop_raider],10,2] // Bandit
];
Loot_DrugBust2 = [
	civil_vehicles, // Hero
	civil_vehicles // Bandit
];
Loot_Junkyard = [
	[[4,ai_wep_special_rare + ai_wep_special_good + ai_wep_special_cheap],2,[8,crate_items_high_value + crate_items_vehicle_repair],0,3], // Hero
	[[4,ai_wep_special_rare + ai_wep_special_good + ai_wep_special_cheap],2,[8,crate_items_high_value + crate_items_vehicle_repair],0,3] // Bandit
];
Loot_Junkyard1 = [
	cargo_trucks, // Hero
	military_unarmed // Bandit
];
Loot_Junkyard2 = [
	civil_vehicles, // Hero
	civil_vehicles // Bandit
];
Loot_Patrol = [
	[[6,ai_wep_special_good + ai_wep_special_cheap],2,[4,["ItemBriefcase100oz"]],2,2], // Hero
	[[6,ai_wep_special_good + ai_wep_special_cheap],2,[4,["ItemBriefcase100oz"]],2,2] // Bandit
];
Loot_VehicleDrop = [
	[2,0,[3,crate_items_high_value],0,0], // Hero
	[2,0,[3,crate_items_high_value],0,0] // Bandit
];
Loot_VehicleDrop2 = [
	improved_vehicles + armed_vehicle, // Hero
	armed_vehicle // Bandit
];
Loot_WeaponCache = [
	[[6,ai_wep_special_good + ai_wep_special_rare],0,[14,crate_ammo_good + crate_ammo_cheap],[1,ai_wep_special_delux + ai_launcher_special_delux],0], // Hero
	[[6,ai_wep_special_good + ai_wep_special_rare],0,[14,crate_ammo_good + crate_ammo_cheap],[1,ai_wep_special_delux + ai_launcher_special_delux],0] // Bandit
];
Loot_Mayors = [
	[4,0,[20,crate_items_president],4,2], // Hero
	[4,0,[20,crate_items_president],4,2] // Bandit
];
Loot_MediCamp = [
	[0,2,[25,crate_items_medical],0,2], // Hero
	[0,2,[25,crate_items_medical],0,2] // Bandit
];

/***** Hard Missions *****/
Loot_Base = [
	[[8,ai_wep_special_good + ai_launcher_special_cheap],2,0,[3,ai_wep_special_rare + ai_launcher_special_cheap],[4,crate_backpacks_large]], // Hero
	[[8,ai_wep_special_good + ai_launcher_special_cheap],2,0,[3,ai_wep_special_rare + ai_launcher_special_cheap],[4,crate_backpacks_large]] // Bandit
];
Loot_CannibalCave = [
	[[3,ai_wep_special_cheap + ai_wep_special_good],0,[2,crate_items_gems],0,4], // Hero
	[[3,ai_wep_special_cheap + ai_wep_special_good],0,[2,crate_items_gems],0,4] // Bandit
];
Loot_CapturedMV22 = [
	[4,4,[20,crate_items_medical + crate_items_skin],0,1], // Hero
	[4,4,[20,crate_items_medical + crate_items_skin],0,1] // Bandit
];
Loot_CropRaider = [
	[6,5,[20,crate_items_crop_raider],6,3], // Hero
	[6,5,[20,crate_items_crop_raider],6,3] // Bandit
];
Loot_DronePilot1 = [
	[[2,ai_wep_special_rare + ai_wep_special_good],[8,crate_tools_sniper],[3,crate_items_high_value],4,2], // Hero
	[[2,ai_wep_special_rare + ai_wep_special_good],[8,crate_tools_sniper],[3,crate_items_high_value],4,2] // Bandit
];
Loot_DronePilot2 = [
	["Ka137_MG_PMC","Ka137_PMC","Pchela1T","Pchela1T_CDF","AH6X_DZ","MQ9PredatorB"], // Hero
	["Ka137_MG_PMC","Ka137_PMC","Pchela1T","Pchela1T_CDF","AH6X_DZ","MQ9PredatorB"] // Bandit
];
Loot_IkeaConvoy = [
	[[1,crate_weapons_buildables],[4,crate_tools_buildable],[24,crate_items_buildables],0,[1,crate_backpacks_large]], // Hero
	[[1,crate_weapons_buildables],[4,crate_tools_buildable],[24,crate_items_buildables],0,[1,crate_backpacks_large]] // Bandit
];
Loot_IkeaConvoy1 = [
	cargo_trucks, // Hero
	cargo_trucks // Bandit
];
Loot_IkeaConvoy2 = [
	military_unarmed, // Hero
	civil_chopper // Bandit
];
Loot_IkeaConvoy3 = [
	civil_vehicles, // Hero
	civil_vehicles // Bandit
];
Loot_LumberJack = [
	[[1,crate_weapons_buildables],[3,crate_tools_buildable],[30,crate_items_wood],0,[2,crate_backpacks_large]], // Hero
	[[1,crate_weapons_buildables],[3,crate_tools_buildable],[30,crate_items_wood],0,[2,crate_backpacks_large]] // Bandit
];
Loot_MacDonald = [
	[0,5,[12,crate_items_crop_raider],[1,ai_wep_special_rare + ai_launcher_special_cheap],2], // Hero
	[0,5,[12,crate_items_crop_raider],[1,ai_wep_special_rare + ai_launcher_special_cheap],2] // Bandit
];
Loot_Radioshack = [
	[0,[3,ai_wep_special_rare + ai_wep_special_cheap],[3,crate_items_high_value + crate_items_gems],0,0], // Hero
	[0,[3,ai_wep_special_rare + ai_wep_special_cheap],[3,crate_items_high_value + crate_items_gems],0,0] // Bandit
];
Loot_Extraction1 = [
	[[6,ai_wep_sniper + ai_wep_special_good + ai_wep_special_cheap],[4,crate_tools_sniper],[10,crate_items_sniper],0,2], // Hero
	[[6,ai_wep_sniper + ai_wep_special_good + ai_wep_special_cheap],[4,crate_tools_sniper],[10,crate_items_sniper],0,2] // Bandit
];
Loot_Extraction2 = [
	armed_chopper, // Hero
	armed_chopper // Bandit
];
Loot_Presidents = [
	[[6,ai_wep_special_good + ai_wep_special_cheap],0,[20,crate_items_president],[1,ai_wep_special_rare],2], // Hero
	[[6,ai_wep_special_good + ai_wep_special_cheap],0,[20,crate_items_president],[1,ai_wep_special_rare],2] // Bandit
];
Loot_Firestation1 = [ // Fire Station Crate 1
	[0,0,[10,crate_items_buildables],0,2], // Hero
	[0,0,[10,crate_items_vehicle_repair],0,[2,crate_backpacks_large]] // Bandit
];
Loot_Firestation2 = [ // Fire Station Crate 2
	[[6,ai_wep_special_good + ai_wep_special_cheap],5,[8,crate_items_sniper],[1,ai_wep_special_cheap + ai_launcher_special_delux],0], // Hero
	[[6,ai_wep_special_good + ai_wep_special_cheap],[3,crate_tools_sniper],8,[1,ai_launcher_special_cheap + ai_wep_special_delux],0] // Bandit
];
Loot_Firestation3 = [
	refuel_trucks, // Hero
	refuel_trucks // Bandit
];

/***** Extreme Missions *****/
Loot_ArmyBase1 = [
	[[5,ai_wep_special_good],0,[16,crate_ammo_good + crate_items_sniper],[1,ai_wep_special_rare + ai_wep_special_delux],[1,crate_backpacks_large]], // Hero
	[[5,ai_wep_special_good],0,[16,crate_ammo_good + crate_items_sniper],[1,ai_wep_special_rare + ai_wep_special_delux],[1,crate_backpacks_large]] // Bandit
];
Loot_ArmyBase2 = [
	super_vehicles, // Hero
	super_vehicles // Bandit
];
Loot_GemTower = [
	[[1,ai_wep_special_good],[1,crate_tools_sniper],[4,crate_items_gems],[1,ai_wep_special_delux + ai_launcher_special_delux],[1,crate_backpacks_large]], // Hero
	[[1,ai_wep_special_good],[1,crate_tools_sniper],[4,crate_items_gems],[1,ai_wep_special_delux + ai_launcher_special_delux],[1,crate_backpacks_large]] // Bandit
];
Loot_TankColumn1 = [
	[[4,ai_wep_special_good],0,[10,crate_items_chainbullets + crate_items_sniper],[2,ai_wep_special_rare],1], // Hero
	[[4,ai_wep_special_good],0,[10,crate_items_chainbullets + crate_items_sniper],[2,ai_wep_special_rare],1] // Bandit
];
Loot_TankColumn2 = [
	super_vehicles, // Hero
	super_vehicles // Bandit
];
