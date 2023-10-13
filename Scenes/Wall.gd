extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var curve = $Path2D.curve
	var polygon = curve.get_baked_points()
	print(polygon.size())
	$CollisionPoly.polygon = polygon
	$Line2D.points = polygon
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
