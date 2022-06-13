extends Control

onready var building_info = $right/building_info;
onready var info = $right/info;
onready var money = $top_left/hori/money_hori/money;
onready var turn = $top_left/hori/turn_hori/turn;
onready var population = $top_left/hori/population_hori/population;
onready var housing = $top_left/hori/housing_hori/housing;

signal building_selected;
signal next_turn;

func _ready():
	pass
	

func _on_build_pressed():
	$buildings.show();


func _on_buildings_building_selected(id: String):
	emit_signal("building_selected", id);
	

func show_info_for_tile(x: float, y: float):
	hide_building_info();
	info.load_tile(x, y);
	info.visible = true;
	

func show_building_info_for_tid(tid: String):
	hide_info();
	building_info.load_tid(tid);
	building_info.visible = true;
	

func hide_info():
	info.visible = false;
	

func hide_building_info():
	building_info.visible = false;

func _on_next_turn_pressed():
	emit_signal("next_turn");
	

func update_ui():
	update_money();
	update_turn();
	update_population();
	update_housing();
	

func update_money():
	money.text = String(Tiles.CIV_DATA.money);
	

func update_turn():
	turn.text = String(Tiles.CIV_DATA.turn);
	

func update_population():
	population.text = String(Tiles.CIV_DATA.population);
	

func update_housing():
	housing.text = String(Tiles.CIV_DATA.housing);
	

func is_info_shown():
	return info.visible;
	
