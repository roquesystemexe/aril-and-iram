extends Node

var music_toggled: bool = true;
var music_volume: float = 50.0;
var respawn_point: Vector2
var has_checkpoint := false
var dJump_enabled: bool = false;
var dash_enabled: bool = false;
var checkpoint_djump: bool = false;
var checkpoint_dash: bool = false;
var is_interacting: bool = false;
var collected_items: Array[String] = []

func register_item(id: String):
	if not collected_items.has(id):
		collected_items.append(id)

func is_item_collected(id: String) -> bool:
	return collected_items.has(id)
