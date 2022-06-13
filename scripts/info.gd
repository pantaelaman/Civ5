extends PanelContainer;

onready var tile_title = $vert/head_hori/label;
onready var tile_texture = $vert/head_hori/tile_cont/texture;
onready var beauty_value = $vert/beauty_hori/beauty_value;
onready var economy_value = $vert/economy_hori/economy_value;

func load_tile(x: float, y: float):
	var tile = Tiles.MAP_DATA[x][y];
	if Tiles.PSEUDOS.has(tile.id):
		tile_texture.texture = Tiles.TEXTURES[Tiles.PSEUDOS[tile.id][randi() % len(Tiles.PSEUDOS[tile.id])]];
	else:
		tile_texture.texture = Tiles.TEXTURES[tile.id];
	tile_title.text = Tiles.get_title(tile.id);
	beauty_value.text = String(tile.beauty)
	
