extends Area2D

var direction: Vector2
const bulletSpeed: float = 400.0

# Called when the node enters the scene tree for the first time.
func setUp(pos: Vector2, dir: Vector2):
	position = pos + dir * 20
	direction = dir
	var tween = get_tree().create_tween()
	$AudioStreamPlayer2D.play()
	tween.tween_property($Sprite2D, "scale", Vector2(1.0,1.0), 0.1 ).from(Vector2.ZERO)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += delta * direction * bulletSpeed


func _on_body_entered(body: Node2D) -> void:
	if "hit" in body:
		body.hit()
	queue_free()
