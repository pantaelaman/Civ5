extends Control

export var id: String = "campsite";

signal pressed;

func _ready():
	$vert/texture.texture = Tiles.TEXTURES[id];
	$vert/label.text = Tiles.get_title(id);
	

func _on_pressed():
	emit_signal("pressed", id);
