extends Control

var loader;
var wait_frames;
var time_max = 100;
var current_scene;

func _ready():
	var root = get_tree().get_root();
	current_scene = root.get_child(root.get_child_count() - 1);

var times = 0;

func _process(_delta):
	if times < 1:
		times += 1;
		return;
	
	get_tree().change_scene("res://scenes/Main.tscn");
	
