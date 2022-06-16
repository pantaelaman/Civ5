extends Control

export var benefit = {
	"type": "tile",
	"icon": "forest",
	"resource": "economy",
	"count": 2,
};

const SCALE = Vector2(0.4, 0.4);
const MIN_SIZE = Vector2(64 * SCALE.x, 64 * SCALE.y);

const FONT = preload("res://assets/PrebuiltFonts/MediumFont.tres");

onready var root = $hori;

func _ready():
	if benefit.type == "natural":
		var label = Label.new();
		label.add_font_override("font", FONT);
		label.text = String(benefit.count);
		label.align = Label.ALIGN_CENTER;
		label.valign = Label.VALIGN_CENTER;
		var resource = TextureRect.new();
		resource.texture = Tiles.BENEFITS_TEXTURES[benefit.resource];
		root.add_child(label);
		root.add_child(scale_texrect(resource));
	elif benefit.type == "towncentre":
		var label = Label.new();
		label.add_font_override("font", FONT);
		label.text = String(benefit.count);
		label.align = Label.ALIGN_CENTER;
		label.valign = Label.VALIGN_CENTER;
		var resource = TextureRect.new();
		resource.texture = Tiles.BENEFITS_TEXTURES["hex"];
		root.add_child(label);
		root.add_child(scale_texrect(resource));
	elif benefit.type == "tile":
		var label = Label.new();
		label.add_font_override("font", FONT);
		label.text = String(benefit.count);
		label.align = Label.ALIGN_CENTER;
		label.valign = Label.VALIGN_CENTER;
		var icon = TextureRect.new();
		icon.texture = Tiles.BENEFITS_TEXTURES[benefit.icon];
		var resource = TextureRect.new();
		resource.texture = Tiles.BENEFITS_TEXTURES[benefit.resource];
		root.add_child(scale_texrect(icon));
		root.add_child(label);
		root.add_child(scale_texrect(resource));
	else:
		for cosmetic in benefit.cosmetic:
			if cosmetic.type == "icon":
				var icon = TextureRect.new();
				icon.texture = Tiles.BENEFITS_TEXTURES[cosmetic.icon];
				root.add_child(scale_texrect(icon));
			elif cosmetic.type == "count":
				var label = Label.new();
				label.add_font_override("font", FONT);
				label.text = String(cosmetic.count);
				label.align = Label.ALIGN_CENTER;
				label.valign = Label.VALIGN_CENTER;
				root.add_child(label);
	

func scale_texrect(texrect: TextureRect) -> Control:
	var control = Control.new();
	control.rect_min_size = MIN_SIZE;
	texrect.rect_scale = SCALE;
	control.add_child(texrect);
	return control;
	
