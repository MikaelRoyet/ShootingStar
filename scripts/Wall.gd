extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var curve = $Path2D.curve
	var occultPoly = $LightOccluder2D
	var polygon = curve.get_baked_points()
	var polyRoad = $PolygonRoadBG
	print(polygon.size())
	$CollisionPoly.polygon = polygon
	$Line2D.points = polygon
	occultPoly.get_occluder_polygon().polygon = polygon
	polyRoad.polygon = polygon
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
