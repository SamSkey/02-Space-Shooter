extends KinematicBody2D

const speed := 600
signal player_died

func _ready():
	var game = get_parent()
	self.connect("player_died", game, "_on_Player_player_died")

func _physics_process(delta: float) -> void:
	var velocity := Vector2()


	if (Input.is_action_pressed("ui_left")):
		velocity.x = -speed
	if (Input.is_action_pressed("ui_right")):
		velocity.x = speed

	move_and_collide(velocity * delta)

func _unhandled_key_input(event: InputEventKey) -> void:
	if (event.is_action_pressed("shoot")):
		$laser.shoot()


func _on_hitboxplayer_body_entered(body):
	if (!self.is_queued_for_deletion() && body.is_in_group("asteroids")):
		emit_signal("player_died")
		
		queue_free()
