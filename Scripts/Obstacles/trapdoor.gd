extends Node2D
var is_inside: bool = false
var open: bool = false
@export var basecdown = 0.3
var cdown = 0.0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_inside = true
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_inside = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cdown > 0.0:
		cdown -= delta	
	
	if is_inside and GameManager.is_interacting and cdown <= 0.0:
		if open:		# Is open, is closing
			open = false
			$Sprite2D.frame = 1
			$".".show_behind_parent = true
			$CollisionShape2D.disabled = true
			cdown = basecdown
		
		else:			# Is closed, is opening
			open = true
			$Sprite2D.frame = 0
			$".".show_behind_parent = false
			$CollisionShape2D.disabled = false
			cdown = basecdown
	
	pass
