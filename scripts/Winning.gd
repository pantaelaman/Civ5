extends Control

func _ready():
	$VBoxContainer/turns.text = "You won the game in " + String(Tiles.CIV_DATA.turn) + "!";
	

func _on_Retry_pressed():
	get_tree().change_scene("res://scenes/Loading.tscn");
	
