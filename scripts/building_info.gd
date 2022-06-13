extends PanelContainer

const Benefit = preload("res://scenes/components/Benefit.tscn");

onready var tile_title = $vert/head_hori/label;
onready var tile_texture = $vert/head_hori/tile_cont/texture;
onready var benefits = $vert/benefits_hori/benefits_vert;
onready var price = $vert/price_hori/price_value;

func load_tid(tid: String):
	close_benefits();
	tile_texture.texture = Tiles.TEXTURES[tid];
	tile_title.text = Tiles.get_title(tid);
	for benefit in Tiles.TILES[tid].get("benefits", []):
		var benefit_node = Benefit.instance();
		benefit_node.benefit = benefit;
		benefits.add_child(benefit_node);
	price.text = String(Tiles.TILES[tid].get("base_price", 999));
	

func close_benefits():
	for i in benefits.get_children():
		benefits.remove_child(i);
		i.queue_free();
	
