extends Node;

const BENEFITS_TEXTURES = {
	"rock": preload("res://assets/Icons/resource_iron.png"),
	"forest": preload("res://assets/Icons/resource_lumber.png"),
	"food": preload("res://assets/Icons/resource_wheat.png"),
	"housing": preload("res://assets/Icons/structure_house.png"),
	"economy": preload("res://assets/Icons/pouch_add.png"),
	"advancement": preload("res://assets/Icons/award.png"),
	"victory": preload("res://assets/Icons/exploding.png"),
	"hex": preload("res://assets/Icons/hexagon_tile.png"),
};

const TILES = {
	"towncentre_lvl1": {
		"type": "building",
		"beauty": 2,
		"title": "Town Centre",
		"base_price": 20,
		"valid_new": ["#earth&!#rocky"],
		"valid_upgrade": {},
		"requires_towncentre": false,
		"benefits": [
			{
				"type": "natural",
				"resource": "housing",
				"count": 5,
			},
			{
				"type": "natural",
				"resource": "economy",
				"count": 2,
			},
			{
				"type": "towncentre",
				"count": 5,
			},
		],
	},
	"campsite": {
		"type": "building",
		"beauty": 1,
		"title": "Campsite",
		"base_price": 5,
		"valid_new": ["#earth&!#rocky"],
		"valid_upgrade": {},
		"benefits": [
			{
				"type": "natural",
				"resource": "housing",
				"count": 2,
			},
		],
	},
	"lumbermill": {
		"type": "building",
		"title": "Lumbermill",
		"base_price": 10,
		"valid_new": ["#earth", "#paved"],
		"benefits": [
			{
				"type": "tile",
				"id": "#forested&!#rocky",
				"heavy_boost": 2,
				"count": 2,
				"resource": "economy",
				"icon": "forest",
			},
		],
	},
	"small_house": {
		"type": "building",
		"title": "Small House",
		"base_price": 20,
		"valid_new": ["#earth&!#rocky"],
		"valid_upgrade": {
			"campsite": 16,
			"#paved": 18,
		},
		"benefits": [
			{
				"type": "natural",
				"resource": "housing",
				"count": 4,
			}
		],
	},
	"house": {
		"type": "building",
		"title": "House",
		"base_price": 45,
		"valid_new": ["#earth", "#paved"],
		"valid_upgrade": {
			"campsite": 40,
			"small_house": 30,
			"#paved": 42,
		},
	},
	"small_shop": {
		"type": "building",
		"title": "Small Shop",
	},
	"large_building": {
		"type": "building",
		"title": "Large Building",
	},
	"old_building": {
		"type": "building",
		"title": "Old Building",
	},
	"petrol": {
		"type": "building",
		"title": "Gas Station",
	},
	"grass": {
		"type": "terrain",
		"beauty": 0,
		"tags": ["#earth"],
	},
	"stone": {
		"type": "terrain",
		"beauty": -1,
		"tags": ["#paved"],
	},
	"red_rock": {
		"type": "terrain",
		"beauty": 0,
		"tags": ["#paved"],
	},
	"grass_rocky": {
		"type": "terrain",
		"inherits": "grass",
		"beauty": 1,
		"tags": ["#rocky"],
	},
	"grass_rocky_heavy": {
		"type": "terrain",
		"inherits": "grass",
		"beauty": 2,
		"tags": ["#rocky", "#heavy"],
	},
	"grass_deciduous": {
		"type": "terrain",
		"inherits": "grass",
		"beauty": 3,
		"tags": ["#forested"],
	},
	"grass_deciduous_heavy": {
		"type": "terrain",
		"inherits": "grass",
		"beauty": 4,
		"tags": ["#forested", "#heavy"],
	},
	"grass_conifers": {
		"type": "terrain",
		"inherits": "grass",
		"beauty": 4,
		"tags": ["#forested"],
	},
	"grass_conifers_heavy": {
		"type": "terrain",
		"inherits": "grass",
		"beauty": 5,
		"tags": ["#forested", "#heavy"],
	},
	"dirt": {
		"type": "terrain",
		"beauty": -1,
		"tags": ["#earth"],
	},
	"dirt_rocky": {
		"type": "terrain",
		"inherits": "dirt",
		"beauty": 0,
		"tags": ["#rocky"],
	},
	"dirt_rocky_heavy": {
		"type": "terrain",
		"inherits": "dirt",
		"beauty": 1,
		"tags": ["#rocky", "#heavy"],
	},
	"dirt_rocky_deciduous": {
		"type": "terrain",
		"inherits": "dirt_rocky",
		"beauty": 2,
		"tags": ["#forested"],
	},
	"dirt_deciduous": {
		"type": "terrain",
		"inherits": "dirt",
		"beauty": 1,
		"tags": ["#forested"],
	},
	"dirt_deciduous_heavy": {
		"type": "terrain",
		"inherits": "dirt",
		"beauty": 2,
		"tags": ["#forested", "#heavy"],
	},
	"dirt_conifers": {
		"type": "terrain",
		"inherits": "dirt",
		"beauty": 1,
		"tags": ["#forested"],
	},
	"dirt_conifers_heavy": {
		"type": "terrain",
		"inherits": "dirt",
		"beauty": 2,
		"tags": ["#forested", "#heavy"],
	},
	"sand": {
		"type": "terrain",
		"beauty": 1,
		"tags": ["#sandy"],
	},
	"sand_rocky": {
		"type": "terrain",
		"inherits": "sand",
		"beauty": 2,
		"tags": ["#rocky"],
	},
	"sand_rocky_heavy": {
		"type": "terrain",
		"inherits": "sand",
		"beauty": 3,
		"tags": ["#rocky", "#heavy"],
	},
	"sand_rocky_cacti": {
		"type": "terrain",
		"inherits": "sand",
		"beauty": 2,
		"tags": ["#rocky", "#cacti"],
	},
	"sand_cacti": {
		"type": "terrain",
		"pseudo": true,
		"inherits": "sand",
		"beauty": 1,
		"tags": ["#cacti"],
	},
	"sand_cacti_1": {
		"variant": "sand_cacti",
	},
	"sand_cacti_2": {
		"variant": "sand_cacti",
	},
	"sand_cacti_3": {
		"variant": "sand_cacti",
	},
	"sand_cacti_heavy": {
		"type": "terrain",
		"inherits": "sand",
		"beauty": 2,
		"tags": ["#cacti", "#heavy"],
	},
	"snow": {
		"type": "terrain",
		"beauty": 1,
		"tags": ["#earth", "#snowy"],
	},
	"snow_rocky": {
		"type": "terrain",
		"inherits": "snow",
		"beauty": 2,
		"tags": ["#rocky"],
	},
	"snow_rocky_heavy": {
		"type": "terrain",
		"inherits": "snow",
		"beauty": 3,
		"tags": ["#rocky", "#heavy"],
	},
	"snow_conifers": {
		"type": "terrain",
		"inherits": "snow",
		"beauty": 4,
		"tags": ["#forested"],
	},
	"snow_conifers_heavy": {
		"type": "terrain",
		"inherits": "snow",
		"beauty": 6,
		"tags": ["#forested", "#heavy"],
	},
};

var TEXTURES = {};

var VARIANTS = {};
var PSEUDOS = {};
var TILE_REGISTRY = [];
var BUILDINGS = [];
var TERRAIN = [];
var TAGS = {};

var CIV_DATA = {
	"money": 20,
	"turn": 1,
	"population": 2,
	"housing": 0,
	"beauty": 0,
	"improvement": 0,
	"economy": 0,
	"happiness": 100,
	"victory": 0,
	"victory_bonus": 0,
	"buildable": [],
};

var MAP_DATA = [];
var ECONOMIES = {};
var VICTORIES = {};

onready var tset = preload("res://assets/Tiles/Tiles.tres");

func _ready():
	print("Loading tiles and tags");
	var init = TILES.get("grass")
	for tile_tid in TILES.keys():
		var tile = TILES[tile_tid];
		var variant = tile.get("variant");
		var pseudo = tile.get("pseudo", false);
		var type = tile.get("type", "other");
		if variant == null:
			match type:
				"building": BUILDINGS.append(tile_tid);
				"terrain": TERRAIN.append(tile_tid);
		else:
			VARIANTS[tile_tid] = variant;
			if PSEUDOS.has(variant):
				PSEUDOS[variant].append(tile_tid);
			else:
				PSEUDOS[variant] = [tile_tid];
		if !pseudo:
			TEXTURES[tile_tid] = tset.tile_get_texture(tset.find_tile_by_name(tile_tid));
		var inheritance = tile.get("inherits");
		var tags = [];
		if inheritance:
			tags.append_array(TILES.get(inheritance, {}).get("tags", []));
		tags.append_array(tile.get("tags", []));
		for tag in tags:
			if TAGS.has(tag):
				TAGS[tag].append(tile_tid);
			else:
				TAGS[tag] = [tile_tid];
	TILE_REGISTRY = TILES.keys();
	

func intersect_arrays(arr1, arr2):
	var result = [];
	for item_idx in range(len(arr1)):
		if arr2.has(arr1[item_idx]):
			result.append(arr1[item_idx]);
	return result;
	

# There are two types of tile identifiers:
# True IDs are just pure names of tiles
# Tags are things that tiles or groups inherit, preceded by a #
# Tags can be combined with & symbols
func resolve_id(id) -> Array:
	var matching = [];
	if id is String:
		var id_segments = id.split("&", false);
		for id_segment in id_segments:
			if id_segment.begins_with("#"):
				var tag_tids = TAGS.get(id_segment, []);
				if !matching.empty():
					matching = intersect_arrays(matching, tag_tids);
				else:
					matching = tag_tids;
			elif id_segment.begins_with("!"):
				var uneliminated = TILE_REGISTRY;
				var to_be_elims = resolve_id(id_segment.substr(1));
				for to_be_elim in to_be_elims:
					uneliminated.remove(uneliminated.find(to_be_elim));
				if !matching.empty():
					matching = intersect_arrays(matching, uneliminated);
				else:
					matching = uneliminated;
			else:
				return [id_segment];
	elif id is Array:
		for id_option in id:
			matching.append_array(resolve_id(id_option));
	return matching;
	

func which_matches(tid, ids: Array):
	for id_idx in range(len(ids)):
		var id = ids[id_idx];
		var tids = resolve_id(id);
		if tids.find(tid) != -1:
			return id_idx;
	return -1;
	

func varify(tid) -> String:
	return VARIANTS.get(tid, tid);
	

func get_neighbours(point: Vector2) -> Array:
	if (int(point.y) % 2 == 0):
		return [
			Vector2(point.x - 1, point.y - 1),
			Vector2(point.x, point.y - 1),
			Vector2(point.x + 1, point.y),
			Vector2(point.x, point.y + 1),
			Vector2(point.x - 1, point.y + 1),
			Vector2(point.x - 1, point.y),
		];
	else:
		return [
			Vector2(point.x,  point.y - 1),
			Vector2(point.x + 1, point.y - 1),
			Vector2(point.x + 1, point.y),
			Vector2(point.x + 1, point.y + 1),
			Vector2(point.x, point.y + 1),
			Vector2(point.x - 1, point.y),
		];
	

var width = 500;
var height = 500;

func propagate_beauty():
	width = len(MAP_DATA);
	for row in len(MAP_DATA):
		height = len(MAP_DATA[row]);
		for col in height:
			calculate_tile_beauty(row, col);
	

func local_propagate_beauty(x: float, y: float):
	var neighbours = calculate_tile_beauty(x, y);
	for neighbour in neighbours:
		calculate_tile_beauty(neighbour.x, neighbour.y);
	

func calculate_tile_beauty(x: float, y: float):
	var neighbours = get_valid_neighbours(x, y);
	var neighbour_tids = [];
	for neighbour in neighbours:
		neighbour_tids.append(varify(MAP_DATA[neighbour.x][neighbour.y].id));
	var beauty = TILES[varify(MAP_DATA[x][y].id)].get("beauty", 0);
	for neighbour_tid in neighbour_tids:
		beauty += TILES[neighbour_tid].get("beauty", 0);
	MAP_DATA[x][y].beauty = beauty;
	return neighbours;
	

func calculate_happiness():
	var total_beauty = 0;
	for tile in CIV_DATA.buildable:
		total_beauty += MAP_DATA[tile.x][tile.y].get("beauty", 0);
	CIV_DATA.beauty = pow(total_beauty, (5 * len(CIV_DATA.buildable)) / total_beauty);
	var happiness_partial = ((CIV_DATA.beauty * CIV_DATA.improvement * CIV_DATA.economy) - CIV_DATA.population + CIV_DATA.housing) / 10;
	CIV_DATA.happiness = 1000 / (1 + exp(-happiness_partial));
	print("Happiness: " + String(CIV_DATA.happiness));
	CIV_DATA.population += round((CIV_DATA.happiness * sqrt(len(CIV_DATA.buildable))) / 10000);
	

func calculate_economy():
	var total_economy = 0;
	for economy_pos in ECONOMIES.keys():
		var economy = ECONOMIES[economy_pos];
		if economy.type == "basic":
			total_economy += economy.count;
		elif economy.type == "tile":
			var possibles = resolve_id(economy.id);
			for neighbour in get_valid_neighbours(economy_pos.x, economy_pos.y):
				var neighbour_tid = MAP_DATA[neighbour.x][neighbour.y].id;
				if possibles.has(neighbour_tid):
					if TILES[neighbour_tid].get("tags", []).has("#heavy"):
						total_economy += economy.count * economy.heavy_boost;
					else:
						total_economy += economy.count;
	CIV_DATA.economy = total_economy;
	CIV_DATA.money += CIV_DATA.economy;
	 

func calculate_victory():
	var victory_total = CIV_DATA.victory_bonus;
	victory_total += CIV_DATA.economy / 1000;
	victory_total += min(CIV_DATA.population, CIV_DATA.housing);
	victory_total += CIV_DATA.population - CIV_DATA.housing;
	for victory_pos in VICTORIES:
		var victory = VICTORIES[victory_pos];
		if victory.type == "tile":
			var possibles = resolve_id(victory.id);
			for neighbour in get_valid_neighbours(victory_pos.x, victory_pos.y):
				var neighbour_tid = MAP_DATA[neighbour.x][neighbour.y].id;
				if possibles.has(neighbour_tid):
					if TILES[neighbour_tid].get("tags", []).has("#heavy"):
						victory_total += victory.count * victory.heavy_boost;
					else:
						victory_total += victory.count;
	CIV_DATA.victory = victory_total;
	print("Victory: " + String(CIV_DATA.victory));
	if CIV_DATA.victory > 1000:
		print("Winner!");
	

func place_tile(x: float, y: float, tid):
	MAP_DATA[x][y].id = tid;
	local_propagate_beauty(x, y);
	resolve_benefits(x, y);
	

func get_valid_neighbours(x: float, y: float) -> Array:
	var ufilt_neighbours = get_neighbours(Vector2(x, y));
	var neighbours = [];
	for neighbour in ufilt_neighbours:
		if !(neighbour.x < 0 || neighbour.y < 0 || neighbour.x >= width || neighbour.y >= height):
			neighbours.append(neighbour);
	return neighbours;
	

func get_title(tid: String) -> String:
	var building = TILES.get(varify(tid), {});
	var type = building.get("type", "other");
	if type == "building":
		return building.get("title", "Building");
	elif type == "terrain":
		return "Terrain";
	else:
		return "Other";
	

func resolve_benefits(x: float, y: float):
	print(Vector2(x, y));
	var stid = varify(MAP_DATA[x][y].id);
	var benefits = TILES[stid].get("benefits", []);
	for benefit in benefits:
		if benefit.type == "natural":
			if benefit.resource == "victory":
				CIV_DATA["victory_bonus"] += benefit.count;
			elif benefit.resource != "economy":
				print(benefit.resource);
				CIV_DATA[benefit.resource] += benefit.count;
			else:
				ECONOMIES[Vector2(x, y)] = {
					"type": "basic",
					"count": benefit.get("count", 1),
				};
		elif benefit.type == "towncentre":
			for member in get_points_in_radius(x, y, benefit.count):
				if !CIV_DATA.buildable.has(member):
					CIV_DATA.buildable.append(member);
		elif benefit.type == "tile":
			if benefit.resource == "victory":
				VICTORIES[Vector2(x, y)] = {
					"type": "tile",
					"id": benefit.id,
					"heavy_boost": benefit.get("heavy_boost", 1),
					"count": benefit.get("count", 1),
				};
			elif benefit.resource != "economy":
				var boost = 0;
				var possibles = resolve_id(benefit.id);
				for neighbour in get_valid_neighbours(x, y):
					var neighbour_stid = varify(MAP_DATA[neighbour.x][neighbour.y].id);
					if possibles.has(neighbour_stid):
						if TILES[neighbour_stid].get("tags", []).has("#heavy"):
							boost += benefit.count * benefit.get("heavy_boost", 1);
						else:
							boost += benefit.count;
				CIV_DATA[benefit.resource] += boost;
			else:
				ECONOMIES[Vector2(x, y)] = {
					"type": "tile",
					"id": benefit.id,
					"heavy_boost": benefit.get("heavy_boost", 1),
					"count": benefit.get("count", 1),
				};
	

func get_points_in_radius(x: float, y: float, r: int) -> Array:
	var points = [];
	var origin = Vector2(x, y);
	for i in range(-r, r + 1):
		for j in range(-r + max(0, i), r + min(0, i) + 1):
			points.append(origin + transform_to_zigzag(Vector2(j, i - j)));
	return points;
	

func transform_to_normal(point: Vector2) -> Vector2:
	return Vector2(point.x + (2 * floor(point.y / 2)), point.y);
	

func transform_to_zigzag(point: Vector2) -> Vector2:
	return Vector2(point.x + (floor(point.y / 2)), point.y);
	
