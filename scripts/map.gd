extends TileMap

const feature_tree = {
	"cold": {
		"": {
			"lavish": {
				"rocky": "snow_rocky",
				"normal": "snow_conifers_heavy",
			},
			"fertile": {
				"rocky": "snow_rocky",
				"normal": "snow_conifers",
			},
			"infertile": {
				"rocky": "snow_rocky_heavy",
				"normal": "snow"
			},
		},
	},
	"normal": {
		"wet": {
			"lavish": {
				"rocky": "grass_rocky",
				"normal": "grass_deciduous_heavy",
			},
			"fertile": {
				"rocky": "grass_rocky",
				"normal": "grass_deciduous",
			},
			"infertile": {
				"rocky": "grass_rocky_heavy",
				"normal": "grass",
			},
		},
		"normal": {
			"lavish": {
				"rocky": "grass_rocky",
				"normal": "grass_deciduous_heavy",
			},
			"fertile": {
				"rocky": "grass_rocky",
				"normal": "grass_deciduous",
			},
			"infertile": {
				"rocky": "grass_rocky_heavy",
				"normal": "grass",
			},
		},
		"arid": {
			"lavish": {
				"rocky": "grass_rocky",
				"normal": "grass_conifers_heavy",
			},
			"fertile": {
				"rocky": "grass_rocky",
				"normal": "grass_conifers",
			},
			"infertile": {
				"rocky": "dirt_rocky_deciduous",
				"normal": "grass",
			},
		},
	},
	"hot": {
		"wet": {
			"lavish": {
				"rocky": "grass_rocky",
				"normal": "grass",
			},
			"fertile": {
				"rocky": "dirt_rocky",
				"normal": "grass",
			},
			"infertile": {
				"rocky": "dirt_rocky_heavy",
				"normal": "dirt",
			}
		},
		"normal": {
			"lavish": {
				"rocky": "dirt_rocky",
				"normal": "dirt",
			},
			"fertile": {
				"rocky": "dirt_rocky",
				"normal": "dirt",
			},
			"infertile": {
				"rocky": "dirt_rocky_heavy",
				"normal": "sand",
			},
		},
		"arid": {
			"lavish": {
				"rocky": "sand_rocky_cacti",
				"normal": "sand_cacti_heavy",
			},
			"fertile": {
				"rocky": "sand_rocky",
				"normal": ["sand_cacti_1", "sand_cacti_2", "sand_cacti_3"],
			},
			"infertile": {
				"rocky": "sand_rocky_heavy",
				"normal": "sand",
			},
		},
	},
};

const type_thresholds = {
	"temperature": {
		"cold": -.2,
		"normal": .2,
		"hot": 1,
	},
	"wetness": {
		"wet": -.2,
		"normal": .2,
		"arid": 1,
	},
	"fertility": {
		"infertile": 0,
		"fertile": .37,
		"lavish": 1,
	},
	"rockiness": {
		"normal": .53,
		"rocky": 1,
	},
}

var minimum = 0;
var maximum = 0;

func threshold_by(num, thresholds):
	for key in thresholds.keys():
		var threshold = thresholds[key];
		if num < minimum:
			minimum = num;
		if num > maximum:
			maximum = num;
		if num <= threshold:
			return key;
	return "";
	

const OCTAVES = 3;
const PERIOD = 15.0;
const PERSISTENCE = 0.5;

func generate(size: Vector2):
	clear();
	Tiles.MAP_DATA = [];
	randomize();
	
	var temperature_noise = OpenSimplexNoise.new();
	temperature_noise.seed = randi(); 
	temperature_noise.octaves = OCTAVES;
	temperature_noise.period = PERIOD;
	temperature_noise.persistence = PERSISTENCE;
	
	var wetness_noise = OpenSimplexNoise.new();
	wetness_noise.seed = randi(); 
	wetness_noise.octaves = OCTAVES;
	wetness_noise.period = PERIOD;
	wetness_noise.persistence = PERSISTENCE;
	
	var fertility_noise = OpenSimplexNoise.new();
	fertility_noise.seed = randi(); 
	fertility_noise.octaves = OCTAVES;
	fertility_noise.period = PERIOD;
	fertility_noise.persistence = PERSISTENCE;
	
	var rockiness_noise = OpenSimplexNoise.new();
	rockiness_noise.seed = randi(); 
	rockiness_noise.octaves = OCTAVES;
	rockiness_noise.period = PERIOD;
	rockiness_noise.persistence = PERSISTENCE;
	
	minimum = temperature_noise.get_noise_2d(0, 0);
	maximum = minimum;
	
	var temperature_dist = [0, 0, 0];
	var wetness_dist = [0, 0, 0];
	var fertility_dist = [0, 0, 0];
	var rockiness_dist = [0, 0];
	
	for i in range(0, size.x):
		Tiles.MAP_DATA.append([]);
		for j in range(0, size.y):
			var temperature = temperature_noise.get_noise_2d(i, j);
			var wetness = wetness_noise.get_noise_2d(i, j);
			var fertility = fertility_noise.get_noise_2d(i, j);
			var rockiness = rockiness_noise.get_noise_2d(i, j);
			
			var temp_type = threshold_by(temperature, type_thresholds.temperature);
			var wet_type = threshold_by(wetness, type_thresholds.wetness);
			var fert_type = threshold_by(fertility, type_thresholds.fertility);
			var rock_type = threshold_by(rockiness, type_thresholds.rockiness);
			
			match temp_type:
				"cold": temperature_dist[0] += 1;
				"normal": temperature_dist[1] += 1;
				"hot": temperature_dist[2] += 1;
			match wet_type:
				"wet": wetness_dist[0] += 1;
				"normal": wetness_dist[1] += 1;
				"arid": wetness_dist[2] += 1;
			match fert_type:
				"infertile": fertility_dist[0] += 1;
				"fertile": fertility_dist[1] += 1;
				"lavish": fertility_dist[2] += 1;
			match rock_type:
				"normal": rockiness_dist[0] += 1;
				"rocky": rockiness_dist[1] += 1;
			
			var wet_tree = feature_tree.get(temp_type, feature_tree.get("", {}));
			var fert_tree = wet_tree.get(wet_type, wet_tree.get("", {}));
			var rock_tree = fert_tree.get(fert_type, fert_tree.get("", {}));
			var id = rock_tree.get(rock_type, rock_tree.get("", {}));
			
			if id is Array:
				var tile_id = id[randi() % len(id)];
				Tiles.MAP_DATA[i].append({"id": Tiles.varify(tile_id)});
				set_celln(Vector2(i, j), tile_id);
			else:
				Tiles.MAP_DATA[i].append({"id": Tiles.varify(id)});
				set_celln(Vector2(i, j), id);
	
	var sum = temperature_dist[0] + temperature_dist[1] + temperature_dist[2];
	
	print("Temperature: " + String(temperature_dist));
	print("Wetness: " + String(wetness_dist));
	print("Fertility: " + String(fertility_dist));
	print("Rockiness: " + String(rockiness_dist));
	print("Minimum: " + String(minimum));
	print("Maximum: " + String(maximum));
	
	Tiles.propagate_beauty();
	

func set_celln(position: Vector2, tile: String, flip_x: bool = false, flip_y: bool = false, transpose: bool = false, autotile_coord: Vector2 = Vector2(0,0)):
	var tile_idx = tile_set.find_tile_by_name(tile);
	if tile_idx == -1:
		print("Could not find tile '" + tile + "'");
	set_cellv(position, tile_idx, flip_x, flip_y, transpose, autotile_coord);
	

func get_celln(position: Vector2) -> String:
	return tile_set.tile_get_name(get_cellv(position));
	
