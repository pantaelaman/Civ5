extends Control

onready var building_info = $right/building_info;
onready var info = $right/info;
onready var money = $left/top_left/hori/money_hori/money;
onready var turn = $left/top_left/hori/turn_hori/turn;
onready var population = $left/top_left/hori/population_hori/population;
onready var housing = $left/top_left/hori/housing_hori/housing;
onready var economy = $left/city_info/vert/economy_hori/economy_value;
onready var victory = $left/city_info/vert/victory_hori/victory_progress;
onready var happiness = $left/city_info/vert/happiness_hori/happiness_progress;
onready var employment = $left/city_info/vert/employment_hori/employment_progress;
onready var homelessness = $left/city_info/vert/homelessness_hori/homelessness_progress;
onready var advancement = $left/city_info/vert/advancement_hori/advancement_value;
onready var city_info = $left/city_info;

signal building_selected;
signal next_turn;

func _ready():
	pass
	

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$buildings.hide();
		get_tree().set_input_as_handled();
	

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
	update_victory();
	update_economy();
	update_employment();
	update_homelessness();
	update_advancement();
	if info.visible:
		info.load_tile(info.prev_x, info.prev_y);
	

func update_money():
	money.text = String(Tiles.CIV_DATA.money);
	

func update_turn():
	turn.text = String(Tiles.CIV_DATA.turn);
	

func update_population():
	population.text = String(Tiles.CIV_DATA.population);
	

func update_housing():
	housing.text = String(Tiles.CIV_DATA.housing);
	

func update_victory():
	victory.value = Tiles.CIV_DATA.victory;
	

func update_economy():
	economy.text = String(Tiles.CIV_DATA.economy);
	

func update_happiness():
	happiness.value = String(Tiles.CIV_DATA.happiness);
	

func update_employment():
	employment.value = (Tiles.CIV_DATA.employed / Tiles.CIV_DATA.population) * 100;
	

func update_homelessness():
	homelessness.value = (max(Tiles.CIV_DATA.population - Tiles.CIV_DATA.housing, 0) / Tiles.CIV_DATA.population) * 100;

func update_advancement():
	advancement.text = String(Tiles.CIV_DATA.advancement);

func is_info_shown():
	return info.visible;
	

func _on_info_pressed():
	city_info.visible = !city_info.visible;
	

func show_bottom_warning():
	$bottom.visible = true;
	

func hide_bottom_warning():
	$bottom.visible = false;
	

func _on_help_pressed():
	$help.visible = !$help.visible;
	
