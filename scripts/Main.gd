extends Node2D;

onready var map = $map;
onready var buildmap = $buildmap;
onready var selectmap = $selectmap;
onready var highlightmap = $highlightmap;
onready var camera = $camera;
onready var overlay = $hud/Overlay;

enum Mode {
	NORMAL,
	BUILDING,
}

const CAMERA_SPEED = 10;
const MAP_SIZE = Vector2(500,500);
const CAMERA_MAX = MAP_SIZE * Vector2(120, 104);

var mode = Mode.NORMAL;
var building_id = "campsite";
var cur_building_data = {};
var cur_building_valids = [];
var cur_building_upgrades = [];
var cur_valid = true;
var cur_upgrade = false;

onready var prev_build_cell = buildmap.world_to_map(get_global_mouse_position());
onready var prev_select_cell = buildmap.world_to_map(get_global_mouse_position());

func _ready():
	map.generate(Vector2(500, 500));
	overlay.update_ui();
	

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		camera.position.x += CAMERA_SPEED;
		clamp_camera();
	if Input.is_action_pressed("ui_left"):
		camera.position.x -= CAMERA_SPEED;
		clamp_camera();
	if Input.is_action_pressed("ui_up"):
		camera.position.y -= CAMERA_SPEED;
		clamp_camera();
	if Input.is_action_pressed("ui_down"):
		camera.position.y += CAMERA_SPEED;
		clamp_camera();
	

func clamp_camera():
	camera.position.x = clamp(camera.position.x, 120, CAMERA_MAX.x);
	camera.position.y = clamp(camera.position.y, 104, CAMERA_MAX.y);
	

func _input(event):
	if event is InputEventMouseMotion:
		if mode == Mode.BUILDING:
			var current_build_cell = buildmap.world_to_map(get_global_mouse_position());
			if current_build_cell != prev_build_cell:
				update_building(current_build_cell);
		if mode == Mode.NORMAL:
			var current_select_cell = selectmap.world_to_map(get_global_mouse_position());
			if current_select_cell != prev_select_cell:
				selectmap.clear();
				selectmap.set_cellv(current_select_cell, 0);
	

func update_building(cell: Vector2):
	buildmap.clear();
	buildmap.set_celln(cell, building_id);
	var highlighted_cell_id = map.get_celln(cell);
	var expensive = Tiles.TILES[building_id].get("base_price", 999) > Tiles.CIV_DATA.money;
	var valid_cell = Tiles.which_matches(highlighted_cell_id, cur_building_valids) != -1;
	var buildable_cell = !cur_building_data.get("requires_towncentre", true) || Tiles.CIV_DATA.buildable.has(cell);
	cur_valid = valid_cell && !expensive && buildable_cell;
	var upgrade_cell = Tiles.which_matches(highlighted_cell_id, cur_building_upgrades);
	if upgrade_cell != -1:
		cur_upgrade = Tiles.TILES[building_id].get("valid_upgrade", {}).get(cur_building_upgrades[upgrade_cell], 999) <= Tiles.CIV_DATA.money;
	else:
		cur_upgrade = false;
	buildmap.material.set_shader_param("upgrade", cur_upgrade);
	buildmap.material.set_shader_param("impossible", !cur_valid);
	prev_build_cell = cell;
	

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 && event.pressed:
			if mode == Mode.BUILDING && (cur_valid || cur_upgrade):
				place_tile(map.world_to_map(get_global_mouse_position()));
			elif mode == Mode.NORMAL:
				var cell = map.world_to_map(get_global_mouse_position());
				overlay.show_info_for_tile(cell.x, cell.y);
				highlightmap.clear();
				highlightmap.set_cellv(cell, 0);
	elif event is InputEventKey:
		if mode == Mode.BUILDING && event.scancode == KEY_ESCAPE:
			buildmap.clear();
			overlay.hide_building_info();
			mode = Mode.NORMAL;
		elif mode == Mode.NORMAL && event.scancode == KEY_ESCAPE:
			highlightmap.clear();
			overlay.hide_info();
	

func place_tile(position: Vector2):
	Tiles.CIV_DATA.money -= Tiles.TILES[building_id].get("base_price", 999);
	map.set_celln(position, building_id);
	Tiles.place_tile(position.x, position.y, building_id);
	overlay.update_ui();
	

func _on_Overlay_building_selected(id):
	mode = Mode.BUILDING;
	overlay.show_building_info_for_tid(id);
	selectmap.clear();
	cur_building_data = Tiles.TILES.get(id, {});
	cur_building_valids = cur_building_data.get("valid_new", []);
	cur_building_upgrades = cur_building_data.get("valid_upgrade", {}).keys();
	building_id = id;
	

func turn_end():
	Tiles.CIV_DATA.turn += 1;
	Tiles.calculate_happiness();
	Tiles.calculate_economy();
	Tiles.calculate_victory();
	overlay.update_ui();
	

func _on_Overlay_next_turn():
	turn_end();
	
