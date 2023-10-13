extends Line2D

var queue : Array
@export var MAX_LENGTH : int


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position = Vector2()
	print("line", get_parent().global_position)
	var pos = get_parent().global_position
	
	queue.push_front(pos)
	if queue.size() > MAX_LENGTH:
		queue.pop_back()
		
	clear_points()
	
	for point in queue:
		add_point(point)
