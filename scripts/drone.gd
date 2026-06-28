extends CharacterBody2D


var speed = 50.0
var direction: Vector2
var health = 3
var player: CharacterBody2D

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property($PointLight2D, "energy", 1.5, 0.1)
	tween.tween_property($PointLight2D, "energy", 0, 0.1)
	tween.tween_property($PointLight2D, "energy", 0, 0.3)
	tween.tween_property($PointLight2D, "energy", 1.5, 0.1)
	tween.tween_property($PointLight2D, "energy", 0, 0.1)
	tween.tween_property($PointLight2D, "energy", 0, 1.5)

func _physics_process(delta: float) -> void:
	if player:
		direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_slide()

func _on_explosion_detection_body_entered(_body: Node2D) -> void:
	explode()

func hit():
	health -= 1
	if health == 0:
		explode()

func _on_player_detection_body_entered(body: Node2D) -> void:
	player = body
	
func _on_player_detection_body_exited(_body: Node2D) -> void:
	player = null
	
func explode():
	speed = 0
	$AudioStreamPlayer2D.play()
	$Explosion.show()
	$AnimationPlayer.play("explode")
	$AnimatedSprite2D.hide()
	await $AnimationPlayer.animation_finished
	queue_free()
	for drone in get_tree().get_nodes_in_group("Drones"):
		if position.distance_to(drone.position) < 40:
			drone.explode()
