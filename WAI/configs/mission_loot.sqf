// This file contains loot array definitions per mission
// Array format [long guns, tools, items, pistols, backpacks] - Either a number or a custom array.
// First array is for Hero missions, second is for bandit missions. Change the values to preferences.
// [[Hero Loot Array],
//	[Bandit Loot Array]]

/***** Easy Missions *****/
Loot_UralAttack = [
	[4,8,36,3,1], // Hero
	[4,8,36,3,1] // Bandit
];
Loot_Farmer1 = [
	[6,5,[40,crate_items_medical],3,1], // Hero
	[6,5,[40,crate_items_medical],3,1] // Bandit
];
Loot_Farmer2 = [
	["hilux1_civil_1_open_DZE","hilux1_civil_2_covered_DZE","hilux1_civil_3_open_DZE","tractorOld"], // Hero
	["datsun1_civil_1_open_DZE","datsun1_civil_2_covered_DZE","datsun1_civil_3_open_DZE","Tractor"] // Bandit
];
Loot_Outpost = [
	[6,4,40,2,1], // Hero
	[6,4,40,2,1] // Bandit
];
Loot_ScoutPatrol1 = [
	[4,8,36,2,1], // Hero
	[4,8,36,2,1] // Bandit
];
Loot_ScoutPatrol2 = [
	civil_vehicles, // Hero
	military_unarmed // Bandit
];
Loot_SlaughterHouse = [
	[6,5,[6,crate_items_chainbullets],2,1], // Hero
	[6,5,[6,crate_items_chainbullets],2,1] // Bandit
];
Loot_BHC = [ // Black Hawk Crash
	[5,5,10,3,1], // Hero
	[5,5,10,3,1] // Bandit
];

/***** Medium Missions *****/
Loot_AbandonedTrader1 = [
	[8,5,15,3,1], // Hero
	[8,5,15,3,1] // Bandit
];
Loot_AbandonedTrader2 = [
	cargo_trucks, // Hero
	refuel_trucks // Bandit
];
Loot_ArmedVehicle1 = [
	[0,0,[25,crate_items_chainbullets],0,1], // Hero
	[0,0,[25,crate_items_chainbullets],0,1] // Bandit
];
Loot_ArmedVehicle2 = [
	armed_vehicle, // Hero
	armed_vehicle // Bandit
];
Loot_DrugBust1 = [
	[5,5,[10,crate_items_crop_raider],3,1], // Hero
	[5,5,[10,crate_items_crop_raider],3,1] // Bandit
];
Loot_DrugBust2 = [
	civil_vehicles, // Hero
	civil_vehicles // Bandit
];
Loot_Junkyard = [
	[14,5,1,3,1], // Hero
	[14,5,1,3,1] // Bandit
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
	[3,0,[2,["ItemBriefcase100oz"]],0,1], // Hero
	[3,0,[2,["ItemBriefcase100oz"]],0,1] // Bandit
];
Loot_VehicleDrop = [
	[0,0,[2,["ItemBriefcase100oz"]],0,0], // Hero
	[0,0,[2,["ItemBriefcase100oz"]],0,0] // Bandit
];
Loot_VehicleDrop2 = [
	improved_vehicles, // Hero
	improved_vehicles // Bandit
];
Loot_WeaponCache = [
	[10,4,0,3,1], // Hero
	[10,4,0,3,1] // Bandit
];
Loot_Mayors = [
	[10,5,[4,crate_items_high_value],3,[2,crate_backpacks_large]], // Hero
	[10,5,[4,crate_items_high_value],3,[2,crate_backpacks_large]] // Bandit
];
Loot_MediCamp = [
	[0,0,[70,crate_items_medical],3,1], // Hero
	[0,0,[70,crate_items_medical],3,1] // Bandit
];

/***** Hard Missions *****/
Loot_Base = [
	[[16,ai_wep_sniper],[8,crate_tools_sniper],[3,crate_items_high_value],3,[4,crate_backpacks_large]], // Hero
	[[16,ai_wep_sniper],[8,crate_tools_sniper],[3,crate_items_high_value],3,[4,crate_backpacks_large]] // Bandit
];
Loot_CannibalCave = [
	[10,8,[2,crate_items_high_value],3,[2,crate_backpacks_large]], // Hero
	[10,8,[2,crate_items_high_value],3,[2,crate_backpacks_large]] // Bandit
];
Loot_CapturedMV22 = [
	[0,0,[80,crate_items_medical],3,1], // Hero
	[0,0,[80,crate_items_medical],3,1] // Bandit
];
Loot_CropRaider = [
	[6,5,[15,crate_items_crop_raider],3,3], // Hero
	[6,5,[15,crate_items_crop_raider],3,3] // Bandit
];
Loot_DronePilot1 = [
	[14,[8,crate_tools_sniper],[2,crate_items_high_value],3,[2,crate_backpacks_large]], // Hero
	[14,[8,crate_tools_sniper],[2,crate_items_high_value],3,[2,crate_backpacks_large]] // Bandit
];
Loot_DronePilot2 = [
	["Ka137_MG_PMC","Ka137_PMC","Pchela1T","Pchela1T_CDF","AH6X_DZ","MQ9PredatorB"], // Hero
	["Ka137_MG_PMC","Ka137_PMC","Pchela1T","Pchela1T_CDF","AH6X_DZ","MQ9PredatorB"] // Bandit
];
Loot_IkeaConvoy = [
	[[1,crate_weapons_buildables],[4,crate_tools_buildable],[30,crate_items_buildables],3,4], // Hero
	[[1,crate_weapons_buildables],[4,crate_tools_buildable],[30,crate_items_buildables],3,4] // Bandit
];
Loot_IkeaConvoy1 = [
	cargo_trucks, // Hero
	cargo_trucks // Bandit
];
Loot_IkeaConvoy2 = [
	military_unarmed, // Hero
	military_unarmed // Bandit
];
Loot_IkeaConvoy3 = [
	civil_vehicles, // Hero
	civil_vehicles // Bandit
];
Loot_LumberJack = [
	[6,[8,crate_tools_sniper],[15,crate_items_wood],3,[4,crate_backpacks_large]], // Hero
	[6,[8,crate_tools_sniper],[15,crate_items_wood],3,[4,crate_backpacks_large]] // Bandit
];
Loot_MacDonald = [
	[9,5,[15,crate_items_crop_raider],3,2], // Hero
	[9,5,[15,crate_items_crop_raider],3,2] // Bandit
];
Loot_Radioshack = [
	[10,5,30,3,2], // Hero
	[10,5,30,3,2] // Bandit
];
Loot_Extraction1 = [
	[[10,ai_wep_sniper],[4,crate_tools_sniper],[4,crate_items_sniper],3,2], // Hero
	[[10,ai_wep_sniper],[4,crate_tools_sniper],[4,crate_items_sniper],3,2] // Bandit
];
Loot_Extraction2 = [
	armed_chopper, // Hero
	armed_chopper // Bandit
];
Loot_Presidents = [
	[0,0,[40,crate_items_president],0,1], // Hero
	[0,0,[40,crate_items_president],0,1] // Bandit
];
Loot_Firestation1 = [ // Fire Station Crate 1
	[0,0,[4,crate_items_high_value],0,1], // Hero
	[0,0,[4,crate_items_high_value],0,1] // Bandit
];
Loot_Firestation2 = [ // Fire Station Crate 2
	[[10,ai_wep_sniper],3,20,3,1], // Hero
	[[10,ai_wep_sniper],3,20,3,1] // Bandit
];
Loot_Firestation3 = [
	refuel_trucks, // Hero
	refuel_trucks // Bandit
];

/***** Extreme Missions *****/
Loot_ArmyBase1 = [
	[10,5,10,3,2], // Hero
	[10,5,10,3,2] // Bandit
];
Loot_ArmyBase2 = [
	super_vehicles, // Hero
	super_vehicles // Bandit
];
Loot_GemTower = [
	[8,5,[4,crate_items_gems],3,2], // Hero
	[8,5,[4,crate_items_gems],3,2] // Bandit
];
Loot_TankColumn1 = [
	[12,5,30,3,2], // Hero
	[12,5,30,3,2] // Bandit
];
Loot_TankColumn2 = [
	super_vehicles, // Hero
	super_vehicles // Bandit
];
