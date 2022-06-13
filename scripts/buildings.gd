extends Popup

signal building_selected;

const Building = preload("res://scenes/components/Building.tscn");

func _ready():
	var grid = $bg/center/scroller/grid;
	for building in Tiles.BUILDINGS:
		var building_obj = Building.instance();
		building_obj.id = building;
		building_obj.connect("pressed", self, "_on_building_selected");
		grid.add_child(building_obj);
	

func _on_building_selected(id: String):
	emit_signal("building_selected", id);
	self.hide();
	
