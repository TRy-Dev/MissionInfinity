extends Node

var weapons = {
	"pistol": preload("res://src/Actors/Weapons/Weapons/Pistol.tscn"),
	"shotgun": preload("res://src/Actors/Weapons/Weapons/Shotgun.tscn"),
	"rifle": preload("res://src/Actors/Weapons/Weapons/Rifle.tscn"),
	"machine_gun": preload("res://src/Actors/Weapons/Weapons/MachineGun.tscn"),
}

var unlocked_weapons = ["pistol"]

var weapons_to_unlock = ["shotgun", "rifle", "machine_gun"]

var start_weapon = null

func get_weapon(name):
	if name in weapons:
		return weapons[name]
	else:
		print("HEY! No such weapon %s " % name)

func get_weapon_list() -> Array:
	return weapons.keys()

func get_unlocked_weapons() -> Array:
	return unlocked_weapons

func unlock_next_weapon():
	if len(weapons_to_unlock) < 1:
		return
	var next = weapons_to_unlock.pop_front()
	unlock_weapon(next)

func unlock_weapon(name) -> void:
	if name in weapons:
		unlocked_weapons.append(name)

func set_start_weapon(idx):
	if idx < 0 or idx >= len(unlocked_weapons):
		print("HEY! Trying to set start weapon to idx: %s" % idx)
		return
	start_weapon = weapons[unlocked_weapons[idx]]
